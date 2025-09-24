/******************************************************************************
* Copyright (C) 2023  - 2024 Advanced Micro Devices, Inc. All Rights Reserved.
* SPDX-License-Identifier: MIT
******************************************************************************/

#ifndef __PLATFORM_H_
#define __PLATFORM_H_

#include <stdint.h>
#ifdef __cplusplus
extern "C" {
#endif

#ifndef SDT
#include "platform_config.h"
#endif

void init_platform();
void cleanup_platform();
void send_command(uint32_t command, uint32_t* new_data, uint32_t data_sz);

#ifdef __cplusplus
}
#endif
#endif
