#include "app.h"

uintptr_t context_tmr1;
uintptr_t context_tmr2;
static uint16_t ms100;


//Timer1 callback register 100ms
void tmr1(uint32_t status, uintptr_t context){
    context_tmr1 = context;

    ms100++;
    if(ms100 > 99){
        LED1_Toggle();
        ms100 = 0;
    }
}


//timer2 callback register for pulse axis
void tmr2(uint32_t status, uintptr_t context){
    LED2_Toggle();
}


void app_config(void){
    TMR1_CallbackRegister(tmr1,context_tmr1);
    TMR1_Start();

    TMR2_CallbackRegister(tmr2,context_tmr2);
    TMR2_Start();

}


//cycle for state machine functionality
void cycle(void){


}