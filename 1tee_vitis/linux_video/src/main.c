#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <linux/videodev2.h>
#include <time.h>

#define WIDTH  1920
#define HEIGHT 1080
#define PORT   8080
#define NUM_BUFFERS 4

struct buffer { void *start; size_t length; };

int main() {
    int fd = open("/dev/video0", O_RDWR);
    if (fd < 0) { perror("open video"); return 1; }

    // Request MJPEG format (hardware-compressed on most webcams)
    struct v4l2_format fmt = {0};
    fmt.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    fmt.fmt.pix.width = WIDTH;
    fmt.fmt.pix.height = HEIGHT;
    fmt.fmt.pix.pixelformat = V4L2_PIX_FMT_MJPEG;
    if (ioctl(fd, VIDIOC_S_FMT, &fmt) < 0) {
        perror("MJPEG not supported, falling back to YUYV");
        fmt.fmt.pix.pixelformat = V4L2_PIX_FMT_YUYV;
        ioctl(fd, VIDIOC_S_FMT, &fmt);
    }

    // Use multiple buffers for smoother capture
    struct v4l2_requestbuffers req = {.count=NUM_BUFFERS, .type=V4L2_BUF_TYPE_VIDEO_CAPTURE, .memory=V4L2_MEMORY_MMAP};
    ioctl(fd, VIDIOC_REQBUFS, &req);

    struct buffer buffers[NUM_BUFFERS];
    for (int i = 0; i < NUM_BUFFERS; i++) {
        struct v4l2_buffer buf = {.type=V4L2_BUF_TYPE_VIDEO_CAPTURE, .memory=V4L2_MEMORY_MMAP, .index=i};
        ioctl(fd, VIDIOC_QUERYBUF, &buf);
        buffers[i].length = buf.length;
        buffers[i].start = mmap(NULL, buf.length, PROT_READ|PROT_WRITE, MAP_SHARED, fd, buf.m.offset);
        ioctl(fd, VIDIOC_QBUF, &buf);
    }

    enum v4l2_buf_type type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    ioctl(fd, VIDIOC_STREAMON, &type);

    // TCP server
    int srv = socket(AF_INET, SOCK_STREAM, 0);
    int opt = 1;
    setsockopt(srv, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));
    setsockopt(srv, IPPROTO_TCP, TCP_NODELAY, &opt, sizeof(opt));

    struct sockaddr_in addr = {.sin_family=AF_INET, .sin_addr.s_addr=INADDR_ANY, .sin_port=htons(PORT)};
    bind(srv, (struct sockaddr*)&addr, sizeof(addr));
    listen(srv, 5);
    printf("Server listening on port %d (MJPEG)\n", PORT);

    while (1) {
        int client = accept(srv, NULL, NULL);
        if (client < 0) continue;
        setsockopt(client, IPPROTO_TCP, TCP_NODELAY, &opt, sizeof(opt));
        printf("Client connected\n");

        int frames = 0;
        struct timespec start, now;
        clock_gettime(CLOCK_MONOTONIC, &start);

        while (1) {
            struct v4l2_buffer buf = {.type=V4L2_BUF_TYPE_VIDEO_CAPTURE, .memory=V4L2_MEMORY_MMAP};
            if (ioctl(fd, VIDIOC_DQBUF, &buf) < 0) break;

            uint32_t len = htonl(buf.bytesused);
            if (send(client, &len, 4, MSG_NOSIGNAL) <= 0 ||
                send(client, buffers[buf.index].start, buf.bytesused, MSG_NOSIGNAL) <= 0) {
                ioctl(fd, VIDIOC_QBUF, &buf);
                break;
            }
            ioctl(fd, VIDIOC_QBUF, &buf);

            frames++;
            clock_gettime(CLOCK_MONOTONIC, &now);
            double elapsed = (now.tv_sec - start.tv_sec) + (now.tv_nsec - start.tv_nsec) / 1e9;
            if (elapsed >= 5.0) {
                printf("Server: %.1f fps\n", frames / elapsed);
                frames = 0;
                start = now;
            }
        }
        printf("Client disconnected\n");
        close(client);
    }

    return 0;
}