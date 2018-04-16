################################################################################
# Copyright (c) 2015 Intel Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
################################################################################

export PROJS = $(CURDIR)

include $(PROJS)/product/$(TARGET_PRODUCT).cfg
export EVMM_CMPL_FLAGS

ifneq (, $(findstring -DDEBUG, $(EVMM_CMPL_FLAGS)))
OUTPUTTYPE = debug
else
OUTPUTTYPE = release
endif

export BUILD_DIR ?= $(PROJS)/build_$(OUTPUTTYPE)/

export CC = $(COMPILE_TOOLCHAIN)gcc
export AS = $(COMPILE_TOOLCHAIN)gcc
export LD = $(COMPILE_TOOLCHAIN)ld

CFLAGS = -c $(EVMM_CMPL_FLAGS) -O2 -std=gnu99

# product position indepent code for relocation.
CFLAGS += -fPIC

# print error type like [-Werror=packed].
CFLAGS += -fdiagnostics-show-option

# without this flag, the highest bit will be treated as sign bit
# e.g. int a:2 = 3, but it's printf("%d", a) is -1.
CFLAGS += -funsigned-bitfields

# the program running on the 64bit extension Pentium 4 CPU.
CFLAGS += -m64 -march=nocona

# if function don't need frame-pointer(rbp), don't store it in a register.
CFLAGS += -fomit-frame-pointer

# don't need extended instruction sets.
CFLAGS += -mno-mmx -mno-sse -mno-sse2 -mno-sse3 -mno-3dnow

# don't link dynamic library and don't rely on standard library.
CFLAGS += -static -nostdinc -fno-hosted

# add warning checks as much as possible.
# -Wconversion option will cause a warning like i += 1, so we strip this
# warning option
CFLAGS += -Wall -Wextra -Werror -Wbad-function-cast -Wpacked -Wpadded \
	-Winit-self -Wswitch-default -Wtrampolines -Wdeclaration-after-statement \
	-Wredundant-decls -Wnested-externs -Winline -Wstack-protector \
	-Woverlength-strings -Wlogical-op -Waggregate-return \
	-Wmissing-field-initializers -Wpointer-arith -Wcast-qual \
	-Wcast-align -Wwrite-strings

ifneq (, $(findstring -DSTACK_PROTECTOR, $(EVMM_CMPL_FLAGS)))
CFLAGS += -fstack-protector-strong
else
CFLAGS += -fno-stack-protector
endif

AFLAGS = -c -m64 $(EVMM_CMPL_FLAGS) -fPIC -static -nostdinc
# treat warnings as errors
AFLAGS += -Wa,--fatal-warnings

export CFLAGS
export AFLAGS

.PHONY: lib vmm loader packer pack clean

all: pack

vmm: lib
	$(MAKE) -C $(PROJS)/vmm

loader: lib
	$(MAKE) -C $(PROJS)/loader

packer:
	$(MAKE) -C $(PROJS)/packer

pack: vmm loader packer
	$(MAKE) -C $(PROJS)/packer pack

lib :
	$(MAKE) -C $(PROJS)/lib

clean:
	-rm -rf $(BUILD_DIR)

# End of file