/*
 * app_load_secure — minimal SSA loader for the secure BYOTEE RISC-V TEE.
 *
 * Stages a PEL2 bundle (AES-128-CTR + HMAC-SHA512 packed ELF, produced by
 * pack_elf.py) in DRAM, sends CMD_LOAD_ELF_DRAM, and lets the
 * riscv_firmware_secure loader verify/decrypt it and jump to the module.
 * Then drives the embench module via the bench_data_t overlay: sends
 * CMD_RUN, waits for completion, prints results, and unloads.
 *
 * Usage:  app_load_secure [bundle_path] [dram_addr_hex]
 *   bundle_path — path to the .pel2 bundle  (default: /tmp/embench.pel2)
 *   dram_addr   — DRAM staging address       (default: 0x50000000)
 */

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dirent.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>
#include <signal.h>

#include "comm.h"

/* ------------------------------------------------------------------ */
/*  Globals for cleanup                                                */
/* ------------------------------------------------------------------ */

static volatile bench_data_t *g_bd;
static volatile sig_atomic_t  g_shutdown;

static void shutdown_handler(int sig) {
    (void)sig;
    g_shutdown = 1;
}

/* ------------------------------------------------------------------ */
/*  sysfs helpers                                                      */
/* ------------------------------------------------------------------ */

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

static int read_sysfs_hex(const char *path, unsigned long *val) {
    FILE *f = fopen(path, "r");
    if (!f) return -1;
    int ret = fscanf(f, "%lx", val);
    fclose(f);
    return (ret == 1) ? 0 : -1;
}

/* ------------------------------------------------------------------ */
/*  OCM mapping via UIO                                                */
/* ------------------------------------------------------------------ */

static shared_ocm_t *map_ocm(void) {
    DIR *dir = opendir("/sys/class/uio/");
    if (!dir) { perror("opendir uio"); return NULL; }

    struct dirent *entry;
    char dev_name[64] = {0};

    while ((entry = readdir(dir)) != NULL) {
        if (entry->d_name[0] == '.') continue;
        char path[128], name[64];
        snprintf(path, sizeof(path), "/sys/class/uio/%s/name", entry->d_name);
        if (read_sysfs_string(path, name, sizeof(name)) < 0) continue;
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
    unsigned long size, addr;

    snprintf(path, sizeof(path), "/sys/class/uio/%s/maps/map0/size", dev_name);
    if (read_sysfs_hex(path, &size)) { perror("read uio size"); return NULL; }

    snprintf(path, sizeof(path), "/sys/class/uio/%s/maps/map0/addr", dev_name);
    if (read_sysfs_hex(path, &addr)) { perror("read uio addr"); return NULL; }

    printf("OCM: phys 0x%lx  size 0x%lx\n", addr, size);

    snprintf(path, sizeof(path), "/dev/%s", dev_name);
    int fd = open(path, O_RDWR | O_SYNC);
    if (fd < 0) { perror("open uio device"); return NULL; }

    void *mapped = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
    if (mapped == MAP_FAILED) { perror("mmap ocm"); close(fd); return NULL; }

    return (shared_ocm_t *)mapped;
}

/* ------------------------------------------------------------------ */
/*  Interrupt trigger                                                  */
/* ------------------------------------------------------------------ */

static void trigger_interrupt(void) {
    system("devmem " INTR_ADDR " 32 1; devmem " INTR_ADDR " 32 0;");
}

/* ------------------------------------------------------------------ */
/*  File I/O                                                           */
/* ------------------------------------------------------------------ */

static uint8_t *read_file(const char *path, size_t *out_sz) {
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

/* ------------------------------------------------------------------ */
/*  PEL2 bundle loading via DRAM staging                               */
/* ------------------------------------------------------------------ */

static int load_bundle_dram(shared_ocm_t *ocm, const char *bundle_path,
                            uint32_t dram_addr) {
    size_t sz;
    uint8_t *buf = read_file(bundle_path, &sz);
    if (!buf) return -1;

    int memfd = open("/dev/mem", O_RDWR | O_SYNC);
    if (memfd < 0) { perror("/dev/mem"); free(buf); return -1; }

    uint32_t page_sz     = sysconf(_SC_PAGE_SIZE);
    uint32_t page_offset = dram_addr & (page_sz - 1);
    uint32_t map_base    = dram_addr & ~(page_sz - 1);
    size_t   map_len     = sz + page_offset;

    void *mapped = mmap(NULL, map_len, PROT_READ | PROT_WRITE,
                        MAP_SHARED, memfd, map_base);
    close(memfd);
    if (mapped == MAP_FAILED) { perror("mmap dram"); free(buf); return -1; }

    memcpy((uint8_t *)mapped + page_offset, buf, sz);
    free(buf);

    printf("Wrote %zu bytes to DRAM @ 0x%08X\n", sz, dram_addr);

    ocm->data[0] = dram_addr;
    ocm->data[1] = (uint32_t)sz;
    ocm->ready   = false;
    ocm->command = CMD_LOAD_ELF_DRAM;
    trigger_interrupt();

    printf("Waiting for firmware to verify+decrypt+load bundle...\n");
    while (!ocm->ready)
        continue;
    printf("Bundle loaded and running\n");

    munmap(mapped, map_len);
    return 0;
}

/* ------------------------------------------------------------------ */
/*  Unload                                                             */
/* ------------------------------------------------------------------ */

static void unload_module(volatile bench_data_t *bd) {
    if (!bd) return;
    printf("Unloading module...\n");
    bd->command = CMD_UNLOAD;
    for (int i = 0; i < 500 && bd->bench_id != 0; i++)
        usleep(1000);
    if (bd->bench_id == 0)
        printf("Module unloaded\n");
    else
        fprintf(stderr, "WARN: unload timed out\n");
}

/* ------------------------------------------------------------------ */
/*  main                                                               */
/* ------------------------------------------------------------------ */

int main(int argc, char *argv[]) {
    const char *bundle_path = "/tmp/embench.pel2";
    uint32_t    dram_addr   = 0x50000000;

    if (argc >= 2) bundle_path = argv[1];
    if (argc >= 3) dram_addr   = strtoul(argv[2], NULL, 0);

    /* Signal handling */
    struct sigaction sa = {0};
    sa.sa_handler = shutdown_handler;
    sigaction(SIGINT,  &sa, NULL);
    sigaction(SIGTERM, &sa, NULL);

    /* Map OCM */
    shared_ocm_t *ocm = map_ocm();
    if (!ocm) return 1;

    volatile bench_data_t *bd = (volatile bench_data_t *)ocm->data;
    g_bd = bd;

    /* Load PEL2 bundle */
    printf("Loading %s @ 0x%08X\n", bundle_path, dram_addr);
    if (load_bundle_dram(ocm, bundle_path, dram_addr) < 0)
        return 1;

    /* Wait for module to signal ready */
    printf("Waiting for module ready...\n");
    while (!(bd->status & STATUS_READY)) {
        if (g_shutdown) { unload_module(bd); return 1; }
        continue;
    }
    printf("Module ready (bench_id=0x%08X, %d benchmarks)\n",
           bd->bench_id, bd->total);

    /* Send CMD_RUN */
    printf("Running benchmarks...\n");
    bd->status  = STATUS_BUSY;
    bd->command = CMD_RUN;

    /* Wait for completion */
    while (!(bd->status & STATUS_COMPLETE) && bd->status != STATUS_ERR) {
        if (g_shutdown) break;
        continue;
    }

    if (bd->status & STATUS_COMPLETE) {
        printf("\nResults: %d/%d passed, %u total cycles\n",
               bd->passed, bd->total, bd->total_cycles);
    } else {
        fprintf(stderr, "Module reported error\n");
    }

    /* Unload */
    unload_module(bd);
    return 0;
}
