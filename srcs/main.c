#include "xc.h" // Include the appropriate header file for your PIC32MZ
#include "init.h" // Include the header file for initialization functions


// Function prototype
void CPU_Initialize(void);

int main(void)
{
    // Call the initialization function
    CPU_Initialize();

    // Your main application code here

    while (1)
    {
        // Main loop
    }

    return 0;
}

