#include <stdio.h>
#include <stdlib.h>
#include <dirent.h>
#include <fcntl.h>
#include <string.h>
#include <unistd.h>
#include <time.h>
#include <sys/mman.h>

#include <elf.h>

#include "comm.h"

int read_sysfs_string(const char *path, char *buffer, size_t size) {
    int fd = open(path, O_RDONLY);
    if (fd < 0) {
        return -1;
    }
    
    ssize_t n = read(fd, buffer, size - 1);
    close(fd);
    
    if (n < 0) {
        return -1;
    }
    
    // Remove trailing newline
    if (n > 0 && buffer[n - 1] == '\n') {
        n--;
    }
    buffer[n] = '\0';
    
    return 0;
}


int main()
{
    printf("Hello World\n");
    //system("devmem 0x80010000 32 1; devmem 0x80010000 32 0;");

    DIR *dir = opendir("/sys/class/uio/");
    bool found = false;
    struct dirent *entry;

    while ((entry = readdir(dir)) != NULL) {
        // Skip . and ..
        if (entry->d_name[0] == '.') {
            continue;
        } 
        char path[64];
        char name[64];
        snprintf(path, sizeof(path), "/sys/class/uio/%s/name", entry->d_name);
        read_sysfs_string(path, name, sizeof(name));
        printf("%s: %s\n", path, name);

        if (strncmp("ocm@", name, 4) == 0) {
            found = true;
            break;
        }
    }

    if (!found) {
        printf("ERR: could not locate uio device!\n");
        return 1;
    }
    printf("Found uio device: /dev/%s\n", entry->d_name);

    char mem_path[512];
    memset(mem_path, 0, sizeof(mem_path));

    snprintf(mem_path, sizeof(mem_path), "/sys/class/uio/%s/maps/map0/size", entry->d_name);
    FILE *f = fopen(mem_path, "r");
    if (!f) {
        printf("Failed to read UIO memory size");
        fclose(f);
        return -1;
    }
    
    unsigned long size;
    fscanf(f, "0x%lx", &size);
    fclose(f);

    snprintf(mem_path, sizeof(mem_path), "/dev/%s", entry->d_name);
    int dev_fd = open(mem_path, O_RDWR);
    if (!f) {
        printf("Failed to open UIO fd");
        return -1;
    }

    // Memory-map the region
    void* mapped_region = mmap(NULL, size, 
                              PROT_READ | PROT_WRITE, 
                              MAP_SHARED, 
                              dev_fd, 0);

    if (mapped_region == MAP_FAILED) {
        printf("Failed to map UIO memory");
        return -1;
    }

    shared_ocm_t* ocm_memory = (shared_ocm_t*) mapped_region;

    srand(time(NULL));

    int random = rand();
    ocm_memory->command = random;
    printf("triggered ocm with command: %x\n", random);

    system("devmem 0x80010000 32 1; devmem 0x80010000 32 0;");

    while(ocm_memory->executing) continue;
    
    printf("fw image load test (no valid ELF)\n");
    ocm_memory->command = 0x44414F4C;
    system("devmem 0x80010000 32 1; devmem 0x80010000 32 0;");

    while(ocm_memory->executing) continue;

    printf("loading linux image: \n");
    FILE* load_elf_file = fopen("/home/petalinux/loadable_app_test.elf", "r");
    int sz = fread(ocm_memory->data, 1, sizeof(ocm_memory->data), load_elf_file);

    char* data_buf = ocm_memory->data;
    Elf32_Ehdr* ehdr = (Elf32_Ehdr*) data_buf;
    Elf32_Phdr* phdr = (Elf32_Phdr*) &data_buf[ehdr->e_phoff];
    //char* module_mem = &_MODULE_BASE;
    for (int i = 0; i < ehdr->e_phnum; i++) {
        printf("i: %d, type: %d, phdr: %x paddr: %x sz: %x\r\n", i, phdr[i].p_type, phdr[i].p_offset, phdr[i].p_paddr, phdr[i].p_filesz);
        if (phdr[i].p_type == PT_LOAD) {
            //memcpy(phdr[i].p_paddr, data_buf + phdr[i].p_offset, phdr[i].p_filesz);
            //module_mem += phdr[i].p_filesz;
        }
    }
    printf("loaded 0x%x bytes to ocm_memory\n", sz);
    // for (int i = 0; i < 16000; i+=2) {
    //     char* bytes = (char*) &ocm_memory->data[i];
    //     printf("[%04lX] %02X %02X %02X %02X %02X %02X %02X %02X | %X %X\n", i * sizeof(uint32_t), 
    //         bytes[0], 
    //         bytes[1],
    //         bytes[2],
    //         bytes[3],
    //         bytes[4],
    //         bytes[5],
    //         bytes[6],
    //         bytes[7],
    //         ocm_memory->data[i],
    //         ocm_memory->data[i + 1]);
    // }
    system("devmem 0x80010000 32 1; devmem 0x80010000 32 0;");
    printf("end\n");
    return 0;
}
