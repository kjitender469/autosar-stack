.syntax unified
.thumb

.global Reset_Handler
.extern main
.extern SystemInit

.extern _sidata
.extern _sdata
.extern _edata
.extern _sbss
.extern _ebss

.section .text.Reset_Handler
.type Reset_Handler, %function

Reset_Handler:

    /* Copy .data from FLASH to RAM */
    ldr r0, =_sidata
    ldr r1, =_sdata
    ldr r2, =_edata

CopyData:
    cmp r1, r2
    ittt lt
    ldrlt r3, [r0], #4
    strlt r3, [r1], #4
    blt CopyData

    /* Zero .bss */
    ldr r0, =_sbss
    ldr r1, =_ebss

ZeroBss:
    cmp r0, r1
    itt lt
    movlt r2, #0
    strlt r2, [r0], #4
    blt ZeroBss

    /* Call system init (clock/FPU/cache) */
    bl SystemInit

    /* Call main */
    bl main

InfiniteLoop:
    b InfiniteLoop

.size Reset_Handler, . - Reset_Handler