# MCAL Layer Design

This document describes the Microcontroller Abstraction Layer (MCAL) for multi-MCU support.

---

## 1. Structure

mcal/
├── common/ # API definitions, headers
├── variants/
│ ├── stm32f4/ # F4-specific drivers
│ └── stm32f7/ # F7-specific drivers


---

## 2. Design Principles

1. **API Separation**
   - Common API headers in `common/`
   - Implementation in variant-specific folders

2. **Variant-Based Implementation**
   - Conditional compilation avoided
   - Each MCU has dedicated source files

3. **Peripheral Abstraction**
   - No direct register access outside MCAL
   - Example: `Dio_WriteChannel(DIO_LED, STD_HIGH);`

4. **Startup & Linker**
   - Located in `platform/startup` and `platform/linker`
   - Separate for each MCU
   - Handles `.data`/.bss initialization, stack pointer

5. **Configuration**
   - `config/common` → API-independent config
   - `config/variants` → MCU-specific PB-config

---

## 3. Key MCAL Modules

| Module       | Purpose                                  | Variant |
|--------------|------------------------------------------|---------|
| Mcu          | Clock, reset, power                       | Yes     |
| Dio          | Digital I/O                               | Yes     |
| Port         | Pin mapping                               | Yes     |
| Wdg          | Watchdog                                  | Yes     |
| Uart         | Communication                             | Yes     |
| Spi          | Communication                             | Yes     |
| Adc          | Analog input                              | Yes     |
| Timer        | Counters / PWM                             | Yes     |

---

## 4. Notes

- All DMA operations must handle cache for F7
- Common API headers must not include MCU registers
- Unit test framework can target `common/` for logic validation