/*
 * Copyright (c) 2015-2019 Intel Corporation.
 * All rights reserved.
 *
 * SPDX-License-Identifier: Apache-2.0
 *
 */

#ifndef _GCPU_SETUP_H_
#define _GCPU_SETUP_H_

#include "evmm_desc.h"

boolean_t g0_gcpu_setup(evmm_desc_t *evmm_desc,
		uint64_t boot_param_addr, uint64_t kernel_entry_point);

#endif
