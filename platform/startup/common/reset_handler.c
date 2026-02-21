#include <stdint.h>

__attribute__((weak)) void SystemInit(void)
{
    /* Default empty.
       MCU-specific file should override this. */
}

__attribute__((weak)) void Default_Handler(void)
{
    while (1)
    {
        __asm__("nop");
    }
}