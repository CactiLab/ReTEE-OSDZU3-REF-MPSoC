#include <stdio.h>
#include <stdlib.h>
#include <xil_printf.h>

int test = 0;

int module_main()
{
    print("[load] Hello World\n\r");
    test = 1;
    print("[load] Successfully ran Hello World application\n\r");
    xil_printf("test: %d\n\r", test);
    void* malloc_test = malloc(0x100);
    xil_printf("malloc test: 0x%x\n\r", malloc_test);
    for (int i = 0; i < 8; ++i) {
        toggle_LED(i);
        msleep(50);
    }
    free(malloc_test);
    return 0;
}
