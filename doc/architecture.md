# autosar-stack Architecture

This document describes the layered architecture of the AUTOSAR-inspired stack.

---

## 1. Layered Overview

Application
↓
RTE
↓
BSW (Basic Software)
├─ Services
├─ Communication
├─ Memory
└─ System
↓
MCAL (Microcontroller Abstraction Layer)
├─ Common API
└─ MCU Variants (STM32F4, STM32F7, etc.)
↓
Hardware


- **Application**: Functional software components (SWCs)
- **RTE**: Runtime Environment connecting SWCs and BSW
- **BSW**: Reusable, MCU-agnostic services
- **MCAL**: MCU-specific drivers, startup, linker
- **Hardware**: Target MCU peripherals

---

## 2. Branch & Development Strategy

- `main` → stable releases
- `develop` → integration
- `feature/*` → new modules
- `bugfix/*` → fixes

See [`git-workflow.md`](git-workflow.md) for details.

---

## 3. Design Principles

1. Strict layer separation
2. No direct register access above MCAL
3. Variant-based MCU abstraction
4. Configuration-driven
5. Toolchain-agnostic (GCC / arm-none-eabi-gcc)
6. Small logical commits

---

## 4. File & Folder Guidelines

- `mcal/common` → APIs
- `mcal/variants` → MCU-specific drivers
- `bsw` → upper-layer drivers & services
- `platform/startup` → MCU-specific startup and linker scripts
- `config/variants` → module-specific configuration

---

## 5. Notes

- Upper layers should remain MCU-independent
- MCAL is where all hardware mapping is done
- Always document new modules in `/doc`