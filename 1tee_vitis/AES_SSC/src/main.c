#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <xil_printf.h>
#include "aes.h"

#define AES_KEY_SZ 32
#define AES_BUFFER_SZ 16384

typedef struct __attribute__((__packed__)) {
    volatile bool mb_to_arm_flag;
    volatile bool arm_to_mb_flag;
    volatile bool ready;
    volatile bool executing;
    volatile uint32_t command;
    volatile uint32_t data[50000];
} shared_ocm_t;

enum aes_command {
    ENC = 1,
    DEC = 2,
};

typedef struct __attribute__((__packed__)) {
    volatile bool ready;
    volatile bool err;
    volatile enum aes_command command;
    volatile uint8_t key_sz;
    volatile uint8_t key[32];
    volatile uint32_t data_sz;
    volatile uint8_t data[AES_BUFFER_SZ];
} aes_struct_t;

shared_ocm_t* ocm_memory = (shared_ocm_t*) 0xFFFC0000;

char aes_key[32];
char aes_buffer[AES_BUFFER_SZ];

int module_main() {
    memset(aes_buffer, 0, AES_BUFFER_SZ);
    while (1) {
        aes_struct_t* aes_data = (aes_struct_t*) ocm_memory->data;
        memcpy(aes_key, (void*) aes_data->key, aes_data->key_sz < AES_KEY_SZ ? aes_data : AES_KEY_SZ);
        memcpy(aes_buffer, (void*) aes_data->data, aes_data->data_sz < AES_BUFFER_SZ ? aes_data->data_sz : AES_BUFFER_SZ);

        switch (aes_data->command)
        {
        case ENC:
            aes_enc_test();
            memcpy((void *)cmd_chnl->enc_dec_data, received_data, ENC_DEC_DATA_SIZE);
            break;
        case DEC:
            aes_dec_test();
            memcpy((void *)cmd_chnl->enc_dec_data, received_data, ENC_DEC_DATA_SIZE);
            break;
        default:
            xil_printf("SSC> Unrecognized command!!!\r\n");
            break;
        }
        //memset(ptr, 0xff, 80);
        att_md.output_att_size = ENC_DEC_DATA_SIZE;
        memcpy(&att_md.att_output_data, received_data, ENC_DEC_DATA_SIZE);
    }
    ocm_memory->data = 
    return 0;
}
