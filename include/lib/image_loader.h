/*******************************************************************************
* Copyright (c) 2015 Intel Corporation
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*      http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*******************************************************************************/

#ifndef _IMAGE_LOADER_H_
#define _IMAGE_LOADER_H_

#include "vmm_base.h"
#include "evmm_desc.h"

/**************************************************************************
 *
 * Get info about the VMM memory image itself
 *
 ************************************************************************** */
typedef struct {
	char        *start;
	uint32_t    size;
	boolean_t   readable;
	boolean_t   writable;
	boolean_t   executable;
	boolean_t   valid;
	uint32_t    pad;
} image_section_info_t;


boolean_t get_image_section(void *image_base, uint16_t index, image_section_info_t *info);

/*----------------------------------------------------------------------
 *
 * relocate image in memory
 *
 * Input:
 * module_file_info_t* file_info - file info
 * uint64_t* p_entry - address of the uint64_t that will be filled
 * with the address of image entry point if
 * all is ok
 *
 * Output:
 * Return value - FALSE on any error
 *---------------------------------------------------------------------- */
boolean_t relocate_elf_image(module_file_info_t *file_info, uint64_t *p_entry);

#endif     /* _IMAGE_LOADER_H_ */