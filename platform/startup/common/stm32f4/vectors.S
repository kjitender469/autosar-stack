.syntax unified
.cpu cortex-m4
.thumb

.global g_pfnVectors
.extern _estack
.extern Reset_Handler
.extern Default_Handler

.section .isr_vector,"a",%progbits
.type g_pfnVectors, %object

g_pfnVectors:
    .word _estack
    .word Reset_Handler

    /* Core Exceptions */
    .word Default_Handler /* NMI */
    .word Default_Handler /* HardFault */
    .word Default_Handler /* MemManage */
    .word Default_Handler /* BusFault */
    .word Default_Handler /* UsageFault */
    .word 0
    .word 0
    .word 0
    .word 0
    .word Default_Handler /* SVC */
    .word Default_Handler /* DebugMon */
    .word 0
    .word Default_Handler /* PendSV */
    .word Default_Handler /* SysTick */

    /* Peripheral IRQs (partial example) */
    .word Default_Handler /* WWDG */
    .word Default_Handler /* PVD */
    .word Default_Handler /* TAMP_STAMP */
    .word Default_Handler /* RTC_WKUP */
    .word Default_Handler /* FLASH */
    .word Default_Handler /* RCC */
    /* Add remaining IRQs as required */

.size g_pfnVectors, . - g_pfnVectors