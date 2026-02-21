/* platform/linker/stm32f4.ld */

/* STM32F407VG Linker Script */

ENTRY(Reset_Handler)

/* Memory regions */
MEMORY
{
    FLASH (rx)  : ORIGIN = 0x08000000, LENGTH = 1M
    RAM   (rwx) : ORIGIN = 0x20000000, LENGTH = 192K
}

/* Stack top (end of RAM) */
_estack = ORIGIN(RAM) + LENGTH(RAM);

SECTIONS
{
    /* Vector table */
    .isr_vector :
    {
        KEEP(*(.isr_vector))
    } > FLASH

    /* Code and RO data */
    .text :
    {
        *(.text*)
        *(.rodata*)
        *(.glue_7)
        *(.glue_7t)
        *(.eh_frame)
    } > FLASH

    /* Initialized data (copied to RAM at startup) */
    .data : AT(ADDR(.text) + SIZEOF(.text))
    {
        _sdata = .;
        *(.data*)
        _edata = .;
    } > RAM

    _sidata = LOADADDR(.data);

    /* Zero-initialized data */
    .bss :
    {
        _sbss = .;
        *(.bss*)
        *(COMMON)
        _ebss = .;
    } > RAM
}