#include "app.h"

uintptr_t context_tmr1;
uintptr_t context_tmr2;


//Timer1 callback register 100ms
void tmr1(uint32_t status, uintptr_t context){
    LED1_Toggle();
}


//timer2 callback register for pulse axis
void tmr2(uint32_t status, uintptr_t context){
    LED2_Toggle();
}


void app_config(void){
    TMR1_CallbackRegister(tmr1,context_tmr1);
    TMR2_CallbackRegister(tmr2,context_tmr2);

}


//cycle for state machine functionality
void cycle(void){


}