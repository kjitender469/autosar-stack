/* app/main.c */
#include <stdio.h>
#include "Std_Types.h"

// Dummy Hello World function
void HelloWorld(void) 
{
    // In real MCU, this could blink an LED
    // For simulation, just a placeholder
    volatile int i = 0;
    for(i=0; i<1000000; i++); // Delay loop
}

// Main entry point
int main(void)
{
    printf("Hi, Hello World...\n");
    HelloWorld();

    while(1) 
    {
        // Infinite loop to keep MCU alive
    }
    return 0; // never reached
}