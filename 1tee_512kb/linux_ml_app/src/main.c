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
#include <linux/videodev2.h>

#include <elf.h>
#include "comm.h"

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
    FILE *f = fopen(path, "r");
    if (!f) { perror("read uio size"); return NULL; }
    unsigned long size;
    fscanf(f, "0x%lx", &size);
    fclose(f);

    snprintf(path, sizeof(path), "/dev/%s", dev_name);
    int fd = open(path, O_RDWR);
    if (fd < 0) { perror("open uio"); return NULL; }

    void *mapped = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
    if (mapped == MAP_FAILED) { perror("mmap uio"); return NULL; }

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

/* Original: copy entire ELF into OCM data[] (max ~200KB) */
static int load_elf(shared_ocm_t *ocm, const char *elf_path) {
    size_t sz;
    uint8_t *buf = read_file(elf_path, &sz);
    if (!buf) return -1;

    if (sz > sizeof(ocm->data)) {
        fprintf(stderr, "ELF too large for OCM (%zu > %zu). "
                "Use --dram or --chunked.\n", sz, sizeof(ocm->data));
        free(buf);
        return -1;
    }
    memcpy((void*)ocm->data, buf, sz);
    free(buf);
    printf("Loaded %zu bytes from %s into OCM\n", sz, elf_path);

    ocm->ready = false;
    ocm->command = CMD_LOAD_ELF;
    trigger_interrupt();

    printf("Waiting for RISC-V to load ELF...\n");
    wait_ready(ocm);
    printf("ELF loaded and running\n");
    return 0;
}

/* DRAM pointer mode: write ELF to DRAM via /dev/mem, pass address to firmware */
static int load_elf_dram(shared_ocm_t *ocm, const char *elf_path,
                         uint32_t dram_addr) {
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

/* Chunked mode: host parses ELF, sends PT_LOAD segments one at a time via OCM */
static int load_elf_chunked(shared_ocm_t *ocm, const char *elf_path) {
    size_t sz;
    uint8_t *buf = read_file(elf_path, &sz);
    if (!buf) return -1;

    Elf32_Ehdr *ehdr = (Elf32_Ehdr*)buf;
    if (memcmp(ehdr->e_ident, ELFMAG, SELFMAG) != 0) {
        fprintf(stderr, "Not a valid ELF file\n");
        free(buf);
        return -1;
    }

    Elf32_Phdr *phdrs = (Elf32_Phdr*)(buf + ehdr->e_phoff);
    size_t max_chunk = (50000 - 2) * sizeof(uint32_t); /* room for 2 header words */

    printf("Chunked load: %d program headers, entry=0x%08X\n",
           ehdr->e_phnum, ehdr->e_entry);

    for (int i = 0; i < ehdr->e_phnum; i++) {
        if (phdrs[i].p_type != PT_LOAD || phdrs[i].p_filesz == 0)
            continue;

        uint32_t dest = phdrs[i].p_paddr;
        uint32_t remaining = phdrs[i].p_filesz;
        uint32_t src_off = phdrs[i].p_offset;
        uint32_t dst_off = 0;

        printf("  seg %d: %u bytes -> 0x%08X\n", i, remaining, dest);

        while (remaining > 0) {
            uint32_t chunk = remaining > max_chunk ? max_chunk : remaining;

            ocm->data[0] = dest + dst_off;
            ocm->data[1] = chunk;
            memcpy((void*)&ocm->data[2], buf + src_off + dst_off, chunk);

            ocm->ready = false;
            ocm->command = CMD_LOAD_SEG;
            trigger_interrupt();
            wait_ready(ocm);

            dst_off += chunk;
            remaining -= chunk;
        }
    }

    /* All segments loaded — tell firmware to execute */
    ocm->data[0] = ehdr->e_entry;
    ocm->ready = false;
    ocm->command = CMD_EXEC;
    trigger_interrupt();

    printf("Waiting for RISC-V to start execution...\n");
    wait_ready(ocm);
    printf("ELF loaded (chunked) and running\n");

    free(buf);
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
    const char *elf_path = "/home/petalinux/test_app.elf";
    const char *mode = "ocm";            /* default: original OCM mode */
    uint32_t dram_addr = 0x50000000;     /* default DRAM load address */

    for (int i = 1; i < argc; i++) {
        if (strcmp(argv[i], "--dram") == 0) {
            mode = "dram";
            if (i + 1 < argc && argv[i+1][0] != '-') {
                dram_addr = strtoul(argv[++i], NULL, 0);
            }
        } else if (strcmp(argv[i], "--chunked") == 0) {
            mode = "chunked";
        } else {
            elf_path = argv[i];
        }
    }
    printf("Mode: %s, ELF: %s\n", mode, elf_path);

    /* Map OCM */
    shared_ocm_t *ocm = map_ocm();
    if (!ocm) return 1;

    /* Load ML_SSC ELF */
    int rc;
    if (strcmp(mode, "dram") == 0) {
        printf("DRAM address: 0x%08X\n", dram_addr);
        rc = load_elf_dram(ocm, elf_path, dram_addr);
    } else if (strcmp(mode, "chunked") == 0) {
        rc = load_elf_chunked(ocm, elf_path);
    } else {
        rc = load_elf(ocm, elf_path);
    }
    if (rc < 0) return 1;

    /* Get pointer to ML data region in OCM */
    volatile ml_data_t *ml = (volatile ml_data_t*)ocm->data;

    /* Wait for ML_SSC to signal ready */
    printf("Waiting for ML_SSC to initialize...\n");
    while (!ml->ready) continue;
    printf("ML_SSC ready\n");

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

    /* Inference loop */
    int8_t preprocess_buf[MODEL_INPUT_SZ];
    int frames = 0;
    struct timespec t_start, t_now;
    clock_gettime(CLOCK_MONOTONIC, &t_start);

    printf("Starting inference loop...\n");
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
        struct timespec t1, t2, t3;
        clock_gettime(CLOCK_MONOTONIC, &t1);
        preprocess_yuyv(frame, preprocess_buf, CAM_WIDTH, CAM_HEIGHT);
        clock_gettime(CLOCK_MONOTONIC, &t2);

        /* Send to ML_SSC via OCM */
        memcpy((void*)ml->data, preprocess_buf, MODEL_INPUT_SZ);
        ml->data_sz = MODEL_INPUT_SZ;
        ml->complete = false;
        ml->err = false;
        ml->command = CMD_INFER;

        /* Wait for inference result */
        while (!ml->complete) continue;
        clock_gettime(CLOCK_MONOTONIC, &t3);

        if (ml->err) {
            fprintf(stderr, "ML_SSC inference error\n");
        } else {
            double preproc_ms = (t2.tv_sec - t1.tv_sec) * 1000.0 +
                                (t2.tv_nsec - t1.tv_nsec) / 1e6;
            double infer_ms = (t3.tv_sec - t2.tv_sec) * 1000.0 +
                              (t3.tv_nsec - t2.tv_nsec) / 1e6;

            printf("preprocess: %.1fms  inference: %.1fms  "
                   "confidence: %d%%  person: %d  no_person: %d\n",
                   preproc_ms, infer_ms,
                   (int)ml->confidence * 100 / 255,
                   ml->person_score, ml->no_person_score);
        }

        /* Requeue frame */
        ioctl(cam_fd, VIDIOC_QBUF, &buf);

        frames++;
        clock_gettime(CLOCK_MONOTONIC, &t_now);
        double elapsed = (t_now.tv_sec - t_start.tv_sec) +
                         (t_now.tv_nsec - t_start.tv_nsec) / 1e9;
        if (elapsed >= 5.0) {
            printf("--- %.1f fps ---\n", frames / elapsed);
            frames = 0;
            t_start = t_now;
        }
    }

    ioctl(cam_fd, VIDIOC_STREAMOFF, &type);
    for (int i = 0; i < NUM_BUFFERS; i++)
        munmap(buffers[i].start, buffers[i].length);
    close(cam_fd);
    return 0;
}
