#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dirent.h>
#include <fcntl.h>
#include <unistd.h>
#include <time.h>
#include <sys/mman.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <signal.h>
#include <linux/videodev2.h>

#include <elf.h>
#include "comm.h"

#define PORT 8080

#define CAM_WIDTH  640
#define CAM_HEIGHT 480
#define NUM_BUFFERS 4

struct buffer { void *start; size_t length; };

static int read_sysfs_string(const char *path, char *buf, size_t size) {
    int fd = open(path, O_RDONLY);
    if (fd < 0) return -1;
    ssize_t n = read(fd, buf, size - 1);
    close(fd);
    if (n < 0) return -1;
    if (n > 0 && buf[n - 1] == '\n') n--;
    buf[n] = '\0';
    return 0;
}

static int read_sysfs_hex(const char *path, uint64_t *val) {
    FILE *f = fopen(path, "r");
    if (!f) return -1;
    int ret = fscanf(f, "%llx", (unsigned long long *)val);
    fclose(f);
    return (ret == 1) ? 0 : -1;
}


static void trigger_interrupt(void) {
    system("devmem " INTR_ADDR " 32 1; devmem " INTR_ADDR " 32 0;");
}

static shared_ocm_t* map_ocm(void) {
    DIR *dir = opendir("/sys/class/uio/");
    if (!dir) { perror("opendir uio"); return NULL; }

    struct dirent *entry;
    char dev_name[64] = {0};

    while ((entry = readdir(dir)) != NULL) {
        if (entry->d_name[0] == '.') continue;
        char path[128], name[64];
        snprintf(path, sizeof(path), "/sys/class/uio/%s/name", entry->d_name);
        read_sysfs_string(path, name, sizeof(name));
        if (strncmp("ocm@", name, 4) == 0) {
            strncpy(dev_name, entry->d_name, sizeof(dev_name) - 1);
            break;
        }
    }
    closedir(dir);

    if (!dev_name[0]) {
        fprintf(stderr, "ERR: could not locate OCM uio device\n");
        return NULL;
    }
    printf("Found UIO device: /dev/%s\n", dev_name);

    char path[128];
    snprintf(path, sizeof(path), "/sys/class/uio/%s/maps/map0/size", dev_name);    
    unsigned long size;
    if (read_sysfs_hex(path, &size)) { perror("read uio size"); return NULL; }

    unsigned long addr;
    snprintf(path, sizeof(path), "/sys/class/uio/%s/maps/map0/addr", dev_name);
    if (read_sysfs_hex(path, &addr)) { perror("read addr"); return NULL; }

    printf("UIO %s: phys 0x%llx  size 0x%llx\n",
           dev_name, (unsigned long long)addr, (unsigned long long)size);

    snprintf(path, sizeof(path), "/dev/%s", dev_name);
    int fd = open(path, O_RDWR | O_SYNC);
    if (fd < 0) { perror("open uio device"); return NULL; }

    void *mapped = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, NULL);
    if (mapped == MAP_FAILED) { perror("mmap"); close(fd); return NULL; }

    return (shared_ocm_t*)mapped;
}

/* Read entire file into malloc'd buffer. Caller must free(). */
static uint8_t* read_file(const char *path, size_t *out_sz) {
    FILE *f = fopen(path, "rb");
    if (!f) { perror(path); return NULL; }
    fseek(f, 0, SEEK_END);
    *out_sz = ftell(f);
    fseek(f, 0, SEEK_SET);
    uint8_t *buf = malloc(*out_sz);
    if (!buf) { fclose(f); return NULL; }
    fread(buf, 1, *out_sz, f);
    fclose(f);
    return buf;
}

static void wait_ready(shared_ocm_t *ocm) {
    while (!ocm->ready) continue;
}

/* DRAM pointer mode: write ELF to DRAM via /dev/mem, pass address to firmware */
static int load_elf_dram(shared_ocm_t *ocm, const char *elf_path,
                         uint32_t dram_addr) {
    // wait_ready(ocm);
    size_t sz;
    uint8_t *buf = read_file(elf_path, &sz);
    if (!buf) return -1;

    /* Map DRAM region via /dev/mem */
    int memfd = open("/dev/mem", O_RDWR | O_SYNC);
    if (memfd < 0) { perror("/dev/mem"); free(buf); return -1; }

    /* Page-align the mapping */
    uint32_t page_sz = sysconf(_SC_PAGE_SIZE);
    uint32_t page_offset = dram_addr & (page_sz - 1);
    uint32_t map_base = dram_addr & ~(page_sz - 1);
    size_t map_len = sz + page_offset;

    void *mapped = mmap(NULL, map_len, PROT_READ | PROT_WRITE,
                        MAP_SHARED, memfd, map_base);
    close(memfd);
    if (mapped == MAP_FAILED) { perror("mmap dram"); free(buf); return -1; }

    memcpy((uint8_t*)mapped + page_offset, buf, sz);
    free(buf);

    printf("Wrote %zu bytes to DRAM @ 0x%08X\n", sz, dram_addr);

    /* Tell firmware where the ELF is */
    ocm->data[0] = dram_addr;
    ocm->data[1] = (uint32_t)sz;
    ocm->ready = false;
    ocm->command = CMD_LOAD_ELF_DRAM;
    trigger_interrupt();

    printf("Waiting for RISC-V to load ELF from DRAM...\n");
    wait_ready(ocm);
    printf("ELF loaded and running\n");

    munmap(mapped, map_len);
    return 0;
}

/*
 * Downsample YUYV to int8 grayscale for model input.
 * Extracts Y (luminance) channel and shifts to [-128, 127].
 */
static void preprocess_yuyv(const uint8_t *yuyv, int8_t *out,
                            int src_w, int src_h) {
    const float sx = (float)src_w / MODEL_WIDTH;
    const float sy = (float)src_h / MODEL_HEIGHT;
    for (int y = 0; y < MODEL_HEIGHT; y++) {
        for (int x = 0; x < MODEL_WIDTH; x++) {
            int si = ((int)(y * sy) * src_w + (int)(x * sx)) * 2;
            out[y * MODEL_WIDTH + x] = (int8_t)(yuyv[si] - 128);
        }
    }
}

static int open_camera(void) {
    int fd = open("/dev/video0", O_RDWR);
    if (fd < 0) { perror("open video"); return -1; }

    struct v4l2_format fmt = {0};
    fmt.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    fmt.fmt.pix.width = CAM_WIDTH;
    fmt.fmt.pix.height = CAM_HEIGHT;
    fmt.fmt.pix.pixelformat = V4L2_PIX_FMT_YUYV;
    if (ioctl(fd, VIDIOC_S_FMT, &fmt) < 0) {
        perror("VIDIOC_S_FMT");
        close(fd);
        return -1;
    }
    printf("Camera: %dx%d YUYV\n", fmt.fmt.pix.width, fmt.fmt.pix.height);
    return fd;
}

int main(int argc, char *argv[]) {
    const char *elf_path = "/tmp/ML_SSA.elf";
    const char *mode = "ocm";            /* default: original OCM mode */
    uint32_t dram_addr = 0x50000000;     /* default DRAM load address */

    /* Map OCM */
    shared_ocm_t *ocm = map_ocm();
    if (!ocm) return 1;

    /* Get pointer to ML data region in OCM */
    volatile ml_data_t *ml = (volatile ml_data_t*)ocm->data;

    /* Check if the correct SSA is already loaded and ready */
    if (ml->status == STATUS_READY && ml->model_id == MODEL_ID_PERSON_DETECT) {
        printf("SSA already loaded (model_id=0x%08X), skipping load\n",
               ml->model_id);
    } else {
        if (ml->status != STATUS_BUSY) {
            printf("SSA loaded but wrong model (got 0x%08X, want 0x%08X), reloading\n",
                   ml->model_id, MODEL_ID_PERSON_DETECT);
        }

        /* Load ML_SSA ELF */
        int rc;
        printf("DRAM address: 0x%08X\n", dram_addr);
        rc = load_elf_dram(ocm, elf_path, dram_addr);
        if (rc < 0) return 1;

        /* Wait for ML_SSA to signal ready */
        printf("Waiting for ML_SSA to initialize...\n");
        while (ml->status != STATUS_READY) continue;
    }
    printf("ML_SSA ready (model_id=0x%08X)\n", ml->model_id);

    /* Open camera */
    int cam_fd = open_camera();
    if (cam_fd < 0) return 1;

    /* Setup V4L2 mmap buffers */
    struct v4l2_requestbuffers req = {0};
    req.count = NUM_BUFFERS;
    req.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    req.memory = V4L2_MEMORY_MMAP;
    ioctl(cam_fd, VIDIOC_REQBUFS, &req);

    struct buffer buffers[NUM_BUFFERS];
    for (int i = 0; i < NUM_BUFFERS; i++) {
        struct v4l2_buffer buf = {0};
        buf.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
        buf.memory = V4L2_MEMORY_MMAP;
        buf.index = i;
        ioctl(cam_fd, VIDIOC_QUERYBUF, &buf);
        buffers[i].length = buf.length;
        buffers[i].start = mmap(NULL, buf.length, PROT_READ | PROT_WRITE,
                                MAP_SHARED, cam_fd, buf.m.offset);
        ioctl(cam_fd, VIDIOC_QBUF, &buf);
    }

    enum v4l2_buf_type type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    ioctl(cam_fd, VIDIOC_STREAMON, &type);

    /* TCP server setup */
    signal(SIGPIPE, SIG_IGN);
    int srv = socket(AF_INET, SOCK_STREAM, 0);
    int opt = 1;
    setsockopt(srv, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));

    struct sockaddr_in saddr = {0};
    saddr.sin_family = AF_INET;
    saddr.sin_addr.s_addr = INADDR_ANY;
    saddr.sin_port = htons(PORT);
    if (bind(srv, (struct sockaddr*)&saddr, sizeof(saddr)) < 0) {
        perror("bind"); return 1;
    }
    listen(srv, 2);
    printf("Streaming on port %d (waiting for client...)\n", PORT);

    /* Packet layout: [confidence(1) | person_score(1) | no_person_score(1) | reserved(1) | YUYV frame] */
    const size_t frame_sz = CAM_WIDTH * CAM_HEIGHT * 2;
    const size_t pkt_sz = 4 + frame_sz;
    uint8_t *packet = malloc(pkt_sz);
    if (!packet) { perror("malloc"); return 1; }

    int8_t preprocess_buf[MODEL_INPUT_SZ];

    while (1) {
        int client = accept(srv, NULL, NULL);
        if (client < 0) continue;
        setsockopt(client, IPPROTO_TCP, TCP_NODELAY, &opt, sizeof(opt));
        printf("Client connected\n");

        int frames = 0;
        struct timespec t_start, t_now;
        clock_gettime(CLOCK_MONOTONIC, &t_start);

        while (1) {
            /* Dequeue frame */
            struct v4l2_buffer buf = {0};
            buf.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
            buf.memory = V4L2_MEMORY_MMAP;
            if (ioctl(cam_fd, VIDIOC_DQBUF, &buf) < 0) {
                perror("VIDIOC_DQBUF");
                break;
            }

            uint8_t *frame = (uint8_t*)buffers[buf.index].start;

            /* Preprocess on ARM: YUYV -> int8 96x96 */
            struct timespec t1, t2, t3, t4;
            clock_gettime(CLOCK_MONOTONIC, &t1);
            preprocess_yuyv(frame, preprocess_buf, CAM_WIDTH, CAM_HEIGHT);
            clock_gettime(CLOCK_MONOTONIC, &t2);

            /* Send to ML_SSA via OCM */
            for (int i = 0; i < MODEL_INPUT_SZ; i++)
                ml->data[i] = preprocess_buf[i];
            ml->data_sz = MODEL_INPUT_SZ;
            ml->status = STATUS_BUSY;
            ml->command = CMD_INFER;

            /* Wait for inference result (timeout after 100ms) */
            struct timespec t_deadline;
            clock_gettime(CLOCK_MONOTONIC, &t_deadline);
            t_deadline.tv_nsec += 100000000L;
            if (t_deadline.tv_nsec >= 1000000000L) {
                t_deadline.tv_sec++;
                t_deadline.tv_nsec -= 1000000000L;
            }
            while (!(ml->status & STATUS_COMPLETE) && ml->status != STATUS_ERR) {
                struct timespec t_chk;
                clock_gettime(CLOCK_MONOTONIC, &t_chk);
                if (t_chk.tv_sec > t_deadline.tv_sec ||
                    (t_chk.tv_sec == t_deadline.tv_sec &&
                     t_chk.tv_nsec >= t_deadline.tv_nsec)) {
                    fprintf(stderr, "WARN: inference timeout (status=0x%02x), resending\n",
                            ml->status);
                    ml->status = STATUS_BUSY;
                    ml->command = CMD_INFER;
                    t_deadline = t_chk;
                    t_deadline.tv_nsec += 100000000L;
                    if (t_deadline.tv_nsec >= 1000000000L) {
                        t_deadline.tv_sec++;
                        t_deadline.tv_nsec -= 1000000000L;
                    }
                }
            }
            clock_gettime(CLOCK_MONOTONIC, &t3);

            /* Build packet */
            uint8_t confidence = 0;
            int8_t pscore = 0, npscore = 0;
            if (ml->status != STATUS_ERR) {
                confidence = ml->confidence;
                pscore = ml->person_score;
                npscore = ml->no_person_score;
            }
            packet[0] = confidence;
            packet[1] = (uint8_t)pscore;
            packet[2] = (uint8_t)npscore;
            packet[3] = 0;
            memcpy(&packet[4], frame, frame_sz);

            /* Send to client */
            if (send(client, packet, pkt_sz, MSG_NOSIGNAL) <= 0) {
                ioctl(cam_fd, VIDIOC_QBUF, &buf);
                break;
            }
            clock_gettime(CLOCK_MONOTONIC, &t4);

            double preproc_ms = (t2.tv_sec - t1.tv_sec) * 1000.0 +
                                (t2.tv_nsec - t1.tv_nsec) / 1e6;
            double infer_ms = (t3.tv_sec - t2.tv_sec) * 1000.0 +
                              (t3.tv_nsec - t2.tv_nsec) / 1e6;
            double send_ms = (t4.tv_sec - t3.tv_sec) * 1000.0 +
                             (t4.tv_nsec - t3.tv_nsec) / 1e6;

            /* Requeue frame */
            ioctl(cam_fd, VIDIOC_QBUF, &buf);

            frames++;
            clock_gettime(CLOCK_MONOTONIC, &t_now);
            double elapsed = (t_now.tv_sec - t_start.tv_sec) +
                             (t_now.tv_nsec - t_start.tv_nsec) / 1e9;
            if (elapsed >= 5.0) {
                printf("%.1f fps | preproc: %.1fms infer: %.1fms send: %.1fms | "
                       "confidence: %d%%  person: %d  no_person: %d\n",
                       frames / elapsed, preproc_ms, infer_ms, send_ms,
                       (int)confidence * 100 / 255, pscore, npscore);
                frames = 0;
                t_start = t_now;
            }
        }
        printf("Client disconnected\n");
        close(client);
    }

    free(packet);
    ioctl(cam_fd, VIDIOC_STREAMOFF, &type);
    for (int i = 0; i < NUM_BUFFERS; i++)
        munmap(buffers[i].start, buffers[i].length);
    close(cam_fd);
    close(srv);
    return 0;
}
