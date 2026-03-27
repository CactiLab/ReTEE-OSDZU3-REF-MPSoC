#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include <dirent.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <unistd.h>

#define OCM_PHYS  0xFFFC0000
#define OCM_SIZE  0x40000  /* 256KB */

typedef struct __attribute__((__packed__)) {
    volatile bool mb_to_arm_flag;
    volatile bool arm_to_mb_flag;
    volatile bool ready;
    volatile bool executing;
    volatile uint32_t command;
    volatile uint8_t data[];
} shared_ocm_t;

typedef enum : uint32_t {
    STATUS_BUSY     = 0b0000,
    STATUS_READY    = 0b0001,
    STATUS_ERR      = 0b1000,
} ml_status_t;

typedef struct __attribute__((__packed__)) {
    volatile ml_status_t status;
    volatile uint32_t command;
    volatile uint32_t data_sz;
    volatile uint8_t confidence;
    volatile int8_t person_score;
    volatile int8_t no_person_score;
    volatile uint32_t model_id;
    volatile int8_t data[];
} ml_data_t;

static const char *cmd_name(uint32_t cmd)
{
    switch (cmd) {
    case 0:          return "CMD_NONE";
    case 0x44414F4C: return "CMD_LOAD_ELF";
    case 0x44524D4C: return "CMD_LOAD_ELF_DRAM";
    case 0x4C534547: return "CMD_LOAD_SEG";
    case 0x45584543: return "CMD_EXEC";
    default:         return "UNKNOWN";
    }
}

static const char *model_name(uint32_t id)
{
    switch (id) {
    case 0x50445431: return "PERSON_DETECT_V1";
    case 0:          return "(none)";
    default:         return "UNKNOWN";
    }
}

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

    printf("UIO %s\n", dev_name);

    char path[40];
    snprintf(path, sizeof(path), "/dev/%s", dev_name);
    int fd = open(path, O_RDWR | O_SYNC);
    if (fd < 0) { perror("open uio device"); return NULL; }

    /* map0 is always at file offset 0; subsequent maps are at N * getpagesize() */
    void *mapped = mmap(NULL, OCM_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
    if (mapped == MAP_FAILED) { perror("mmap"); close(fd); return NULL; }

    return (shared_ocm_t*)mapped;
}

int main(void) {
    volatile shared_ocm_t *ocm = map_ocm();

    printf("=== shared_ocm_t @ 0x%08X ===\n", OCM_PHYS);
    printf("  mb_to_arm_flag : %d\n", ocm->mb_to_arm_flag);
    printf("  arm_to_mb_flag : %d\n", ocm->arm_to_mb_flag);
    printf("  ready          : %d\n", ocm->ready);
    printf("  executing      : %d\n", ocm->executing);
    printf("  command        : 0x%08X (%s)\n", ocm->command, cmd_name(ocm->command));
    printf("  data[0]        : 0x%08X\n", ocm->data[0]);
    printf("  data[1]        : 0x%08X\n", ocm->data[1]);
    printf("  data[2]        : 0x%08X\n", ocm->data[2]);
    printf("  data[3]        : 0x%08X\n", ocm->data[3]);

    /* ml_data_t lives inside data[] — figure out where your firmware puts it */
    /* assuming it starts at data[0] */
    volatile ml_data_t *ml = (volatile ml_data_t *)&ocm->data[0];

    printf("\n=== ml_data_t @ ocm->data[0] ===\n");
    printf("  status          : %d\n", ml->status);
    printf("  command         : 0x%08X (%s)\n", ml->command,
           ml->command == 1 ? "CMD_INFER" : cmd_name(ml->command));
    printf("  data_sz         : %u\n", ml->data_sz);
    printf("  confidence      : %u\n", ml->confidence);
    printf("  person_score    : %d\n", ml->person_score);
    printf("  no_person_score : %d\n", ml->no_person_score);
    printf("  model_id        : 0x%08X (%s)\n", ml->model_id, model_name(ml->model_id));

    /* dump first 32 bytes of ml input data */
    printf("  data[0..31]     : ");
    for (int i = 0; i < 32; i++)
        printf("%02x ", (uint8_t)ml->data[i]);
    printf("\n");

    /* raw hex dump of first 64 bytes of OCM */
    printf("\n=== raw OCM hex (first 64 bytes) ===\n");
    volatile uint8_t *raw = (volatile uint8_t *)ocm;
    for (int i = 0; i < 64; i++) {
        if (i % 16 == 0) printf("  %04x: ", i);
        printf("%02x ", raw[i]);
        if (i % 16 == 15) printf("\n");
    }

    munmap(ocm, OCM_SIZE);
    return 0;
}