/******************************************************************************
* Copyright (C) 2023 Advanced Micro Devices, Inc. All Rights Reserved.
* SPDX-License-Identifier: MIT
******************************************************************************/

#ifndef __PLATFORM_H_
#define __PLATFORM_H_

#include <stdbool.h>
#ifndef SDT
#include "platform_config.h"
#endif

int init_platform();
void cleanup_platform();

#endif
