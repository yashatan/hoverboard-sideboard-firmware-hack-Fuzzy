/*!
    \file  gd32f1x0_it.h
    \brief the header file of the ISR
*/

/*
    Copyright (C) 2017 GigaDevice

    2014-12-26, V1.0.0, platform GD32F1x0(x=3,5)
    2016-01-15, V2.0.0, platform GD32F1x0(x=3,5,7,9)
    2016-04-30, V3.0.0, firmware update for GD32F1x0(x=3,5,7,9)
    2017-06-19, V3.1.0, firmware update for GD32F1x0(x=3,5,7,9)
*/

#ifndef GD32F1X0_IT_H
#define GD32F1X0_IT_H

#include "gd32f1x0.h"
#include "config.h"

/* function declarations */
/* NMI handle function */
void NMI_Handler(void);
/* HardFault handle function */
void HardFault_Handler(void);
/* MemManage handle function */
void MemManage_Handler(void);
/* BusFault handle function */
void BusFault_Handler(void);
/* UsageFault handle function */
void UsageFault_Handler(void);
/* SVC handle function */
void SVC_Handler(void);
/* DebugMon handle function */
void DebugMon_Handler(void);
/* PendSV handle function */
void PendSV_Handler(void);
/* SysTick handle function */
void SysTick_Handler(void);
/* I2C0 event handle function */
void I2C0_EV_IRQHandler(void);
/* I2C0 error handle function */
void I2C0_ER_IRQHandler(void);
#ifdef AUX45_USE_I2C
/* I2C1 event handle function */
void I2C1_EV_IRQHandler(void);
/* I2C1 error handle function */
void I2C1_ER_IRQHandler(void);
#endif


#endif /* GD32F1X0_IT_H */
