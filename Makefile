# Makefile for autosar-stack minimal build
# Supports STM32F0/F4/F7 variants

# === Toolchain ===
CC      := arm-none-eabi-gcc
LD      := arm-none-eabi-gcc
OBJCOPY := arm-none-eabi-objcopy
SIZE    := arm-none-eabi-size

# === Default MCU ===
MCU ?= STM32F7

# === Lowercase MCU for folder naming ===
MCU_LOWER := $(shell echo $(MCU) | tr '[:upper:]' '[:lower:]')

# === Common Includes ===
INCLUDES := -I mcal/common

# === Compiler / Linker Flags ===
#CFLAGS  := -mthumb -Wall -O0 -std=c11 -ffreestanding \
			-nostartfiles -I mcal/common

CFLAGS := -Wall -O0 -std=c11 -ffreestanding \
          -ffunction-sections -fdata-sections \
          -nostartfiles -mthumb $(INCLUDES)

# === Folders ===
SRC_DIR := app
#STARTUP := platform/startup/startup.s
BUILD   := build
OUT     := $(BUILD)/main.elf

LDFLAGS := -Wl,--gc-sections

# === Common Startup ===
STARTUP_COMMON := \
    platform/startup/common/startup_core.S \
    platform/startup/common/reset_handler.c

STARTUP_VARIANT := platform/startup/common/$(MCU_LOWER)/vectors.S

# === Source files ===
#SRCS := $(SRC_DIR)/main.c
SRCS := $(SRC_DIR)/main.c mcal/variants/$(MCU_LOWER)/syscalls.c

# ==============================
# MCU Variant Selection
# ==============================
ifeq ($(MCU),STM32F7)
    CFLAGS  += -mcpu=cortex-m7 -mthumb
    LDFLAGS := -T platform/linker/stm32f7.ld

#	STARTUP_VARIANT := \
        platform/startup/stm32f7/vectors.S
endif

ifeq ($(MCU),STM32F4)
    CFLAGS  += -mcpu=cortex-m4 -mthumb
    LDFLAGS := -T platform/linker/stm32f4.ld

#	STARTUP_VARIANT := \
        platform/startup/stm32f4/vectors.S
endif

# Combine startup files
STARTUP := $(STARTUP_COMMON) $(STARTUP_VARIANT)

# === Targets ===
all: prepare $(OUT) elf2bin size

prepare:
	@mkdir -p $(BUILD)

$(OUT): $(SRCS) $(STARTUP)
	$(CC) $(CFLAGS) $(SRCS) $(STARTUP) $(LDFLAGS) -o $@

elf2bin:
	$(OBJCOPY) -O binary $(OUT) $(BUILD)/main.bin

size:
	$(SIZE) $(OUT)

clean:
	rm -rf $(BUILD) *.o *.d

.PHONY: all clean prepare elf2bin