#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <xil_printf.h>
#include "aes.h"

#define AES_BUFFER_SZ 0x2000

typedef struct __attribute__((__packed__)) {
    volatile bool mb_to_arm_flag;
    volatile bool arm_to_mb_flag;
    volatile bool ready;
    volatile bool executing;
    volatile uint32_t command;
    volatile uint32_t data[50000];
} shared_ocm_t;

enum aes_command {
    NONE = 0,
    ENC,
    DEC,
    GETMODE
};

typedef struct __attribute__((__packed__)) {
    volatile bool ready;
    volatile bool err;
    volatile bool complete;
    volatile enum aes_command command;
    volatile uint8_t key_sz;
    volatile uint8_t key[32];
    volatile uint32_t data_sz;
    volatile uint8_t data[AES_BUFFER_SZ];
} aes_struct_t;

shared_ocm_t* ocm_memory = (shared_ocm_t*) 0xFFFC0000;

uint8_t aes_key[AES_KEYLEN];
uint8_t aes_buffer[AES_BUFFER_SZ];

static void phex(uint8_t *str, uint8_t len) {
    unsigned char i;
    for (i = 0; i < len; ++i) xil_printf("%.2x", str[i]);
    xil_printf("\r\n");
}

int module_main() {
    while (1) {
        aes_struct_t* aes_data = (aes_struct_t*) ocm_memory->data;
        if (aes_data->command == NONE) continue;
        aes_data->ready = false;
        aes_data->complete = false;
        const size_t aes_key_sz = aes_data->key_sz < AES_KEYLEN ? aes_data : AES_KEYLEN;
        const size_t aes_buffer_sz = aes_data->data_sz < AES_BUFFER_SZ ? aes_data->data_sz : AES_BUFFER_SZ;
        memcpy(aes_key, (void*) aes_data->key, aes_key_sz);
        memcpy(aes_buffer, (void*) aes_data->data, aes_buffer_sz);

        struct AES_ctx ctx;
        AES_init_ctx(&ctx, aes_key);

        int i;

        switch (aes_data->command)
        {
        case ENC:
            for (i = 0; i < (aes_buffer_sz + AES_KEYLEN - 1)/AES_KEYLEN; ++i) {
                AES_ECB_encrypt(&ctx, aes_buffer + (i * AES_KEYLEN));
                phex(aes_buffer + (i * AES_KEYLEN), AES_KEYLEN);
            }
            memcpy((void *)aes_data->data, aes_buffer, aes_buffer_sz);
            break;
        case DEC:
            for (i = 0; i < (aes_buffer_sz + AES_KEYLEN - 1)/AES_KEYLEN; ++i) {
                AES_ECB_decrypt(&ctx, aes_buffer + (i * AES_KEYLEN));
                phex(aes_buffer + (i * AES_KEYLEN), AES_KEYLEN);
            }
            memcpy((void *)aes_data->data, aes_buffer, aes_buffer_sz);
            break;
        default:
            xil_printf("SSC> Unrecognized command!!!\r\n");
            break;
        }
        aes_data->command = NONE;
        memset(aes_buffer, 0xFF, AES_BUFFER_SZ);
        aes_data->complete = true;
    }
    return 0;
}
