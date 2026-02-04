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
#include <chrono>

#include "tensorflow/lite/micro/micro_interpreter.h"
#include "tensorflow/lite/micro/micro_mutable_op_resolver.h"
#include "tensorflow/lite/schema/schema_generated.h"
#include "tensorflow/lite/micro/models/person_detect_model_data.h"

#define CAM_WIDTH  640
#define CAM_HEIGHT 480
#define MODEL_WIDTH  96
#define MODEL_HEIGHT 96
#define PORT 8080
#define NUM_BUFFERS 4

constexpr int kTensorArenaSize = 300 * 1024;
uint8_t* tensor_arena = (uint8_t*)aligned_alloc(16, kTensorArenaSize);

struct buffer { void *start; size_t length; };

void preprocess(uint8_t* yuyv, int8_t* output, int src_w, int src_h, int dst_w, int dst_h) {
    float scale_x = (float)src_w / dst_w;
    float scale_y = (float)src_h / dst_h;
    for (int y = 0; y < dst_h; y++) {
        for (int x = 0; x < dst_w; x++) {
            int src_x = (int)(x * scale_x);
            int src_y = (int)(y * scale_y);
            int src_idx = (src_y * src_w + src_x) * 2;
            output[y * dst_w + x] = (int8_t)(yuyv[src_idx] - 128);
        }
    }
}

int main() {
    printf("Starting server...\n");
    
    // TFLite Micro setup
    printf("Loading model...\n");
    const tflite::Model* model = tflite::GetModel(g_person_detect_model_data);
    if (!model) {
        fprintf(stderr, "Failed to load model\n");
        return 1;
    }
    printf("Model version: %lu\n", (unsigned long)model->version());
    
    if (model->version() != TFLITE_SCHEMA_VERSION) {
        fprintf(stderr, "Model schema mismatch: got %lu, expected %d\n", 
                (unsigned long)model->version(), TFLITE_SCHEMA_VERSION);
        return 1;
    }

    tflite::MicroMutableOpResolver<5> resolver;
    resolver.AddConv2D();
    resolver.AddDepthwiseConv2D();
    resolver.AddReshape();
    resolver.AddSoftmax();
    resolver.AddAveragePool2D();
    printf("Resolver configured\n");

    tflite::MicroInterpreter interpreter(model, resolver, tensor_arena, kTensorArenaSize);
    printf("Interpreter created\n");
    
    if (interpreter.AllocateTensors() != kTfLiteOk) {
        fprintf(stderr, "AllocateTensors failed\n");
        return 1;
    }

    size_t used = interpreter.arena_used_bytes();
    printf("Tensors allocated. Arena: %zu / %d bytes used\n", used, kTensorArenaSize);

    printf("Input count: %zu\n", interpreter.inputs_size());
    printf("Output count: %zu\n", interpreter.outputs_size());

    printf("Model inputs: %d\n", model->subgraphs()->Get(0)->inputs()->size());
    printf("Model outputs: %d\n", model->subgraphs()->Get(0)->outputs()->size());

    printf("Getting input tensor...\n"); fflush(stdout);
    TfLiteTensor* input = interpreter.input(0);
    printf("Input ptr: %p\n", (void*)input); fflush(stdout);

    if (input) {
        printf("Input dims ptr: %p\n", (void*)input->dims); fflush(stdout);
        if (input->dims) {
            printf("Input tensor: dims=%d\n", input->dims->size);
        }
    }

    TfLiteTensor* output = interpreter.output(0);
    
    if (!input || !output) {
        printf("Failed to get input/output tensors\n");
        return 1;
    }
    
    printf("Input tensor: dims=%d\n", input->dims->size);
    fflush(stdout);
    
    if (input->dims->size >= 4) {
        printf("Model loaded: input [%d,%d,%d]\n",
               input->dims->data[1], input->dims->data[2], input->dims->data[3]);
    } else {
        printf("Model loaded: input dims=%d\n", input->dims->size);
    }
    fflush(stdout);

    // V4L2 setup
    printf("Opening camera...\n");
    int fd = open("/dev/video0", O_RDWR);
    if (fd < 0) { perror("open video"); return 1; }
    printf("Camera opened\n");

    struct v4l2_format fmt = {0};
    fmt.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    fmt.fmt.pix.width = CAM_WIDTH;
    fmt.fmt.pix.height = CAM_HEIGHT;
    fmt.fmt.pix.pixelformat = V4L2_PIX_FMT_YUYV;
    if (ioctl(fd, VIDIOC_S_FMT, &fmt) < 0) {
        perror("VIDIOC_S_FMT");
    }
    printf("Camera format set: %dx%d\n", fmt.fmt.pix.width, fmt.fmt.pix.height);

    struct v4l2_requestbuffers req = {0};
    req.count = NUM_BUFFERS;
    req.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    req.memory = V4L2_MEMORY_MMAP;
    ioctl(fd, VIDIOC_REQBUFS, &req);

    struct buffer buffers[NUM_BUFFERS];
    for (int i = 0; i < NUM_BUFFERS; i++) {
        struct v4l2_buffer buf = {0};
        buf.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
        buf.memory = V4L2_MEMORY_MMAP;
        buf.index = i;
        ioctl(fd, VIDIOC_QUERYBUF, &buf);
        buffers[i].length = buf.length;
        buffers[i].start = mmap(NULL, buf.length, PROT_READ|PROT_WRITE, MAP_SHARED, fd, buf.m.offset);
        ioctl(fd, VIDIOC_QBUF, &buf);
    }

    enum v4l2_buf_type type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    ioctl(fd, VIDIOC_STREAMON, &type);

    // TCP server setup
    int srv = socket(AF_INET, SOCK_STREAM, 0);
    int opt = 1;
    setsockopt(srv, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));
    setsockopt(srv, IPPROTO_TCP, TCP_NODELAY, &opt, sizeof(opt));

    struct sockaddr_in addr = {0};
    addr.sin_family = AF_INET;
    addr.sin_addr.s_addr = INADDR_ANY;
    addr.sin_port = htons(PORT);
    bind(srv, (struct sockaddr*)&addr, sizeof(addr));
    listen(srv, 5);
    printf("Person detection server on port %d\n", PORT);

    while (1) {
        int client = accept(srv, NULL, NULL);
        if (client < 0) continue;
        setsockopt(client, IPPROTO_TCP, TCP_NODELAY, &opt, sizeof(opt));
        printf("Client connected, starting capture loop\n");
        fflush(stdout);

        int frames = 0;
        struct timespec start, now;
        clock_gettime(CLOCK_MONOTONIC, &start);

        while (1) {
            struct v4l2_buffer buf = {0};
            buf.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
            buf.memory = V4L2_MEMORY_MMAP;
            if (ioctl(fd, VIDIOC_DQBUF, &buf) < 0) {
                perror("VIDIOC_DQBUF");
                break;
            }

            uint8_t* frame = (uint8_t*)buffers[buf.index].start;

            auto t1 = std::chrono::steady_clock::now();
            preprocess(frame, input->data.int8, CAM_WIDTH, CAM_HEIGHT, MODEL_WIDTH, MODEL_HEIGHT);
            auto t2 = std::chrono::steady_clock::now();

            if (interpreter.Invoke() != kTfLiteOk) {
                ioctl(fd, VIDIOC_QBUF, &buf);
                continue;
            }
            auto t3 = std::chrono::steady_clock::now();

            int8_t person_score = output->data.int8[1];
            uint8_t confidence = (uint8_t)(person_score + 128);

            // Send: confidence(1) + frame data (fixed 614400 bytes for 640x480 YUYV)
            uint8_t packet[1 + CAM_WIDTH * CAM_HEIGHT * 2];
            packet[0] = confidence;
            memcpy(&packet[1], frame, CAM_WIDTH * CAM_HEIGHT * 2);

            if (send(client, packet, sizeof(packet), MSG_NOSIGNAL) <= 0) {
                ioctl(fd, VIDIOC_QBUF, &buf);
                break;
            }
            auto t4 = std::chrono::steady_clock::now();

            printf("preprocess: %.1fms, inference: %.1fms, send: %.1fms\n",
                std::chrono::duration<double, std::milli>(t2 - t1).count(),
                std::chrono::duration<double, std::milli>(t3 - t2).count(),
                std::chrono::duration<double, std::milli>(t4 - t3).count());

            ioctl(fd, VIDIOC_QBUF, &buf);

            frames++;
            clock_gettime(CLOCK_MONOTONIC, &now);
            double elapsed = (now.tv_sec - start.tv_sec) + (now.tv_nsec - start.tv_nsec) / 1e9;
            if (elapsed >= 5.0) {
                printf("%.1f fps | confidence: %d%%\n", frames / elapsed, confidence * 100 / 255);
                frames = 0;
                start = now;
            }
        }
        printf("Client disconnected\n");
        close(client);
    }

    ioctl(fd, VIDIOC_STREAMOFF, &type);
    for (int i = 0; i < NUM_BUFFERS; i++)
        munmap(buffers[i].start, buffers[i].length);
    close(fd);
    close(srv);
    return 0;
}