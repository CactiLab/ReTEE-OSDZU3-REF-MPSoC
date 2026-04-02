#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <cstring>
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

#include "tensorflow/lite/micro/micro_interpreter.h"
#include "tensorflow/lite/micro/micro_mutable_op_resolver.h"
#include "tensorflow/lite/schema/schema_generated.h"
#include "tensorflow/lite/micro/models/person_detect_model_data.h"

#include "tensorflow/lite/micro/kernels/conv.h"
#include "tensorflow/lite/micro/kernels/depthwise_conv.h"
#include "tensorflow/lite/micro/kernels/pooling.h"
#include "tensorflow/lite/micro/kernels/softmax.h"

#define PORT 8080

#define CAM_WIDTH  640
#define CAM_HEIGHT 480
#define NUM_BUFFERS 4

#define MODEL_WIDTH  96
#define MODEL_HEIGHT 96
#define MODEL_INPUT_SZ (MODEL_WIDTH * MODEL_HEIGHT)

constexpr int kTensorArenaSize = 136 * 1024;
alignas(16) static uint8_t tensor_arena[kTensorArenaSize];

struct buffer { void *start; size_t length; };

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

    struct v4l2_format fmt = {};
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
    (void)argc; (void)argv;

    /* ---- TFLM setup ---- */
    const tflite::Model* model = tflite::GetModel(g_person_detect_model_data);
    if (!model || model->version() != TFLITE_SCHEMA_VERSION) {
        fprintf(stderr, "Model error\n");
        return 1;
    }

    tflite::MicroMutableOpResolver<5> resolver;
    resolver.AddConv2D(tflite::Register_CONV_2D());
    resolver.AddDepthwiseConv2D(tflite::Register_DEPTHWISE_CONV_2D());
    resolver.AddReshape();
    resolver.AddSoftmax(tflite::Register_SOFTMAX_INT8());
    resolver.AddAveragePool2D(tflite::Register_AVERAGE_POOL_2D_INT8());

    tflite::MicroInterpreter interp(model, resolver, tensor_arena, kTensorArenaSize);
    if (interp.AllocateTensors() != kTfLiteOk) {
        fprintf(stderr, "AllocateTensors failed\n");
        return 1;
    }

    TfLiteTensor* input  = interp.input(0);
    TfLiteTensor* output = interp.output(0);
    if (!input || !output) {
        fprintf(stderr, "Tensor error\n");
        return 1;
    }
    printf("TFLM ready (Cortex-A inference)\n");

    /* ---- Camera ---- */
    int cam_fd = open_camera();
    if (cam_fd < 0) return 1;

    struct v4l2_requestbuffers req = {};
    req.count = NUM_BUFFERS;
    req.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    req.memory = V4L2_MEMORY_MMAP;
    ioctl(cam_fd, VIDIOC_REQBUFS, &req);

    struct buffer buffers[NUM_BUFFERS];
    for (int i = 0; i < NUM_BUFFERS; i++) {
        struct v4l2_buffer buf = {};
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

    /* ---- TCP server ---- */
    signal(SIGPIPE, SIG_IGN);
    int srv = socket(AF_INET, SOCK_STREAM, 0);
    int opt = 1;
    setsockopt(srv, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));

    struct sockaddr_in saddr = {};
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
    uint8_t *packet = (uint8_t*)malloc(pkt_sz);
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
            struct v4l2_buffer buf = {};
            buf.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
            buf.memory = V4L2_MEMORY_MMAP;
            if (ioctl(cam_fd, VIDIOC_DQBUF, &buf) < 0) {
                perror("VIDIOC_DQBUF");
                break;
            }

            uint8_t *frame = (uint8_t*)buffers[buf.index].start;

            /* Preprocess: YUYV -> int8 96x96 */
            struct timespec t1, t2, t3, t4;
            clock_gettime(CLOCK_MONOTONIC, &t1);
            preprocess_yuyv(frame, preprocess_buf, CAM_WIDTH, CAM_HEIGHT);
            clock_gettime(CLOCK_MONOTONIC, &t2);

            /* Run inference on Cortex-A */
            memcpy(input->data.int8, preprocess_buf, MODEL_INPUT_SZ);
            TfLiteStatus status = interp.Invoke();
            clock_gettime(CLOCK_MONOTONIC, &t3);

            /* Read results */
            uint8_t confidence = 0;
            int8_t pscore = 0, npscore = 0;
            if (status == kTfLiteOk) {
                npscore = output->data.int8[0];
                pscore  = output->data.int8[1];
                confidence = (uint8_t)(pscore + 128);
            } else {
                fprintf(stderr, "Invoke failed\n");
            }

            /* Build packet */
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
