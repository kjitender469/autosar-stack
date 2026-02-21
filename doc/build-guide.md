# Build & Compile Guide

This document explains how to compile and build the AUTOSAR-inspired stack for different MCU variants using `arm-none-eabi-gcc`.

---

## 1. Prerequisites

- **Toolchain**: ARM GCC Embedded  
  Download: [https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm](https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm)

- **Optional IDE**: VSCode + C/C++ extension + GitLens  
- **Build system**: Make or CMake (optional)

- **Python** (for scripts / code generation if needed)

---

## 2. Repository Structure

```text
autosar-stack/
├── app/
├── rte/
├── bsw/
├── mcal/
├── config/
├── platform/
├── toolchain/
├── scripts/
├── tests/
└── doc/

---

## 3. Build Process (Basic Make Example)

1. cd path/to/autosar-stack

2. Select MCU variant:
    export MCU=STM32F4   # or STM32F7

3. Compile
    make all