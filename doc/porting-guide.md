# Porting Guide

This guide describes how to add support for a new MCU variant to the AUTOSAR-style stack.

---

## 1. Steps to Add a New MCU

1. Create a variant folder under `mcal/variants/`:
    - eg. mcal/variants/<new_mcu>/
2. Copy common API headers from `mcal/common/`
3. Implement startup, linker, and low-level drivers specific to MCU
4. Add configuration in `config/variants/<new_mcu>/`
5. Update CMake / Makefile to include new MCU
6. Test minimal startup and GPIO blink before adding higher layers

---

## 2. Required Files

- `startup.s` or `startup_<new_mcu>.s`
- `<new_mcu>.ld` (linker script)
- Peripheral drivers (Dio, Port, Uart, Timer, etc.)
- Peripheral configuration PBcfg files

---

## 3. Compiler Flags

- Define MCU macro during build:

```bash
-DMCU_<NEW_MCU>

Example for STM32F4:
    -DMCU_STM32F4