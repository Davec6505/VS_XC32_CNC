

void CPU_Initialize(void) {
    // Disable the clock monitor
    // This is typically done by setting the appropriate bits in the OSCCON register
    OSCCONbits.COSC = 0b000; // Set the clock source to FRC (Fast RC Oscillator)
    OSCCONbits.NOSC = 0b000; // Set the new oscillator source to FRC
    OSCCONbits.SOSCEN = 0;   // Disable the secondary oscillator
    OSCCONbits.CLKLOCK = 0;  // Allow changes to the OSCCON register

    // Set the PLL prescaler and multiplier for 200 MHz
    // Assuming the FRC is 8 MHz, we need to set the PLL to 200 MHz
    // PLL prescaler = 2, PLL multiplier = 25
    PLLFBD = 24;              // M = 25 (M-1)
    CLKDIVbits.PLLPOST = 0;  // N2 = 2 (N2-1)
    CLKDIVbits.PLLPRE = 0;   // N1 = 2 (N1-1)

    // Initiate the PLL
    OSCCONbits.PLLEN = 1;    // Enable the PLL
    while (OSCCONbits.LOCK != 1); // Wait for the PLL to lock

    // Set the CPU clock to the PLL output
    OSCCONbits.COSC = 0b001; // Switch to PLL output
    OSCCONbits.NOSC = 0b001; // Set the new oscillator source to PLL
}