/*******************************************************************************
* Copyright (c) 2017 Intel Corporation
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

#ifndef _PERF_CTRL_ISOLATION_H_
#define _PERF_CTRL_ISOLATION_H_

#ifndef MODULE_PERF_CTRL_ISOLATION
#error "MODULE_PERF_CTRL_ISOLATION is not defined"
#endif

void msr_perf_ctrl_isolation_init(void);

#endif /* _PERF_CTRL_ISOLATION_H_ */
