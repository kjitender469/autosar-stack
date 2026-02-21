# Running AUTOSAR Minimal Build in Renode

## 1. Prerequisites

-   Install ARM GCC Toolchain (`arm-none-eabi-gcc`)
-   Install Renode
-   Ensure your Makefile builds successfully

------------------------------------------------------------------------

## 2. Build the Project

Build for STM32F4 (recommended for Renode support):

``` bash
make clean
make MCU=STM32F4
```

Output generated:

    build/main.elf
    build/main.bin

------------------------------------------------------------------------

## 3. Verify Renode STM32 Support

Open Renode:

``` bash
renode
```

Inside Renode monitor:

    mach create
    machine LoadPlatformDescription @platforms/stm32f4_discovery.repl

If it loads without error → board is supported.

------------------------------------------------------------------------

## 4. Create Renode Script File

Create file:

    renode/stm32f4.resc

Add following content:

    mach create
    machine LoadPlatformDescription @platforms/stm32f4_discovery.repl

    sysbus LoadELF @build/main.elf

    showAnalyzer sysbus.uart2

    start

------------------------------------------------------------------------

## 5. Run in Renode

From project root:

``` bash
renode renode/stm32f4.resc
```

------------------------------------------------------------------------

## 6. If Your Code Uses UART

Ensure your linker script places vector table correctly. UART output
will appear in Renode analyzer window.

------------------------------------------------------------------------

## 7. Debugging with GDB (Optional)

In `.resc` file add:

    machine StartGdbServer 3333

Then in another terminal:

``` bash
arm-none-eabi-gdb build/main.elf
target remote :3333
```

------------------------------------------------------------------------

## 8. Common Issues

### ELF not loading

-   Check linker script
-   Ensure correct MCU flags (-mcpu=cortex-m4)

### No UART output

-   Verify correct UART peripheral used
-   Confirm correct baudrate configuration

------------------------------------------------------------------------

## 9. Recommended Structure

    project/
    ├── app/
    ├── mcal/
    ├── platform/
    ├── build/
    ├── renode/
    │   └── stm32f4.resc
    └── Makefile

------------------------------------------------------------------------

You can now emulate your minimal AUTOSAR stack inside Renode.