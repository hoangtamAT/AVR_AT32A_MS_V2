/*******************************************************
Project : MS_V2
Version : 01
Date    : 1/11/2018
Author  : AT

Chip type               : ATmega32A
Program type            : Application
AVR Core Clock frequency: 16.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 512
*******************************************************/

#include <mega32a.h>
#include <stdio.h>
// I2C Bus functions
#include <i2c.h>
// DS1307 Real Time Clock functions
#include <ds1307.h>
// 1 Wire Bus interface functions
#include <1wire.h>
// DS18b20 Temperature Sensor functions
#include <ds18b20.h>
// Graphic Display functions
#include <glcd.h>
// Font used for displaying text
// on the graphic display
#include <font5x7.h>
// library extern
#include "LIB/exlib.h"
// DHT library
#include <DHT.h>

//Define ouput
#define Q_N     PORTB.7   
#define MOTOR   PORTB.6   
#define VAN     PORTB.5   
#define DTN     PORTB.4 
#define Q_L     PORTB.3 
#define M_NEN   PORTB.2 
#define LAMP    PORTB.1 
#define DP      PORTB.0
// Declare your global variables here
unsigned char hour,minute,sec;
eeprom unsigned char mTempSet;

/*******************  FUNCTION  *****************************/
void getTime();
void tempDisplay(unsigned char x, unsigned char y);
void timeSettingDisplay(unsigned char x, unsigned char y);
void tempSettingDisplay(unsigned char x, unsigned char y);
void statusDisplay(unsigned char x, unsigned char y);
void processOn(unsigned char tempSet);
void processOff();
/***********************************************************/
// External Interrupt 0 service routine
interrupt [EXT_INT0] void ext_int0_isr(void)
{
// Place your code here

}

// Timer 1 overflow interrupt service routine (1.0486s)

interrupt [TIM1_OVF] void timer1_ovf_isr(void)
{
// Place your code here

}

void main(void)
{
// Declare your local variables here
// Variable used to store graphic display
// controller initialization data
GLCDINIT_t glcd_init_data;

// Input/Output Ports initialization
// Port A initialization
// Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=In Bit2=In Bit1=In Bit0=In 
DDRA=(1<<DDA7) | (1<<DDA6) | (1<<DDA5) | (1<<DDA4) | (0<<DDA3) | (0<<DDA2) | (0<<DDA1) | (0<<DDA0);
// State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=P Bit2=T Bit1=T Bit0=T 
PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (1<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);

// Port B initialization
// Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out 
DDRB=(1<<DDB7) | (1<<DDB6) | (1<<DDB5) | (1<<DDB4) | (1<<DDB3) | (1<<DDB2) | (1<<DDB1) | (1<<DDB0);
// State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=0 Bit2=0 Bit1=0 Bit0=0 
PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);

// Port C initialization
// Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out 
DDRC=(1<<DDC7) | (1<<DDC6) | (1<<DDC5) | (1<<DDC4) | (1<<DDC3) | (1<<DDC2) | (1<<DDC1) | (1<<DDC0);
// State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=0 Bit2=0 Bit1=0 Bit0=0 
PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);

// Port D initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
DDRD=(0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
// State: Bit7=T Bit6=T Bit5=P Bit4=P Bit3=P Bit2=P Bit1=P Bit0=P 
PORTD=(0<<PORTD7) | (0<<PORTD6) | (1<<PORTD5) | (1<<PORTD4) | (1<<PORTD3) | (1<<PORTD2) | (1<<PORTD1) | (1<<PORTD0);

// Timer/Counter 1 initialization
// Clock source: System Clock
// Clock value: 62.500 kHz
// Mode: Normal top=0xFFFF
// OC1A output: Disconnected
// OC1B output: Disconnected
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer Period: 1.0486 s
// Timer1 Overflow Interrupt: On
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (0<<WGM10);
TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (1<<CS12) | (0<<CS11) | (0<<CS10);
TCNT1H=0x00;
TCNT1L=0x00;
ICR1H=0x00;
ICR1L=0x00;
OCR1AH=0x00;
OCR1AL=0x00;
OCR1BH=0x00;
OCR1BL=0x00;

// Timer(s)/Counter(s) Interrupt(s) initialization
TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (1<<TOIE1) | (0<<OCIE0) | (0<<TOIE0);

// External Interrupt(s) initialization
// INT0: On
// INT0 Mode: Falling Edge
// INT1: Off
// INT2: Off
GICR|=(0<<INT1) | (1<<INT0) | (0<<INT2);
MCUCR=(0<<ISC11) | (0<<ISC10) | (1<<ISC01) | (0<<ISC00);
MCUCSR=(0<<ISC2);
GIFR=(0<<INTF1) | (1<<INTF0) | (0<<INTF2);

// Bit-Banged I2C Bus initialization
// I2C Port: PORTD
// I2C SDA bit: 6
// I2C SCL bit: 7
// Bit Rate: 100 kHz
// Note: I2C settings are specified in the
// Project|Configure|C Compiler|Libraries|I2C menu.
i2c_init();

// DS1307 Real Time Clock initialization
// Square wave output on pin SQW/OUT: Off
// SQW/OUT pin state: 0
rtc_init(0,0,0);

// 1 Wire Bus initialization
// 1 Wire Data port: PORTA
// 1 Wire Data bit: 0
// Note: 1 Wire port settings are specified in the
// Project|Configure|C Compiler|Libraries|1 Wire menu.
w1_init();

// Graphic Display Controller initialization
// The ST7920 connections are specified in the
// Project|Configure|C Compiler|Libraries|Graphic Display menu:
// DB0 - PORTC Bit 4
// DB1 - PORTC Bit 5
// DB2 - PORTC Bit 6
// DB3 - PORTC Bit 7
// DB4 - PORTA Bit 7
// DB5 - PORTA Bit 6
// DB6 - PORTA Bit 5
// DB7 - PORTA Bit 4
// E - PORTC Bit 2
// R /W - PORTC Bit 1
// RS - PORTC Bit 0
// /RST - PORTC Bit 3

// Specify the current font for displaying text
glcd_init_data.font=font5x7;
// No function is used for reading
// image data from external memory
glcd_init_data.readxmem=NULL;
// No function is used for writing
// image data to external memory
glcd_init_data.writexmem=NULL;

glcd_init(&glcd_init_data);

// Global enable interrupts
#asm("sei")

while (1)
      {

      }
}

/******************  FUNCTION  *******************************/

/**
    @brief: Get real-time from DS1307  
    @prama: None
    @retval: None
*/
void getTime()
{
    rtc_get_time(&hour,&minute,&sec);
}

/**
    @brief: Display temperature & humidity on LCD 128x64 
    @prama: - x: Horizontal axis (0-127)
            - y: Vertical axis (0-63)
    @retval: None
*/
void tempDisplay(unsigned char x, unsigned char y)
{
    float temperature,humidity; 
    char lcdBuff[10];  
    //#asm("cli");
    temperature=DHT_GetTemHumi(DHT_ND);
    humidity=DHT_GetTemHumi(DHT_DA);
    //#asm("sei"); 
    sprintf(lcdBuff,"T:%2.0f",temperature);
    glcd_outtextxy(x,y+3,lcdBuff);
    glcd_outtextxyf(x+25,y,"o");
    glcd_outtextxyf(x+32,y+3,"C");
          
    sprintf(lcdBuff,"H:%2.0f",humidity);
    glcd_outtextxy(x,y+13,lcdBuff);
    glcd_outtextxyf(x+25,y+13,"%");
}

/**
    @brief: Display time run setting on LCD 128x64 
    @prama: - x: Horizontal axis (0-127)
            - y: Vertical axis (0-63)
    @retval: None
*/
void timeSettingDisplay(unsigned char x, unsigned char y)
{

}

/**
    @brief: Display temperature control setting on LCD 128x64 
    @prama: - x: Horizontal axis (0-127)
            - y: Vertical axis (0-63)
    @retval: None
*/
void tempSettingDisplay(unsigned char x, unsigned char y)
{

}

/**
    @brief: Display status device (stop/running), Progress complete(%) on LCD 128x64 
    @prama: - x: Horizontal axis (0-127)
            - y: Vertical axis (0-63)
    @retval: None
*/
void statusDisplay(unsigned char x, unsigned char y)
{

}

/**
    @brief: Process turn ON device sequence by setting 
    @prama: tempSet: Temperature setting for control heating at this temperature
    @retval: None
*/
void processOn(unsigned char tempSet)
{   
    unsigned char Htime,Mtime,Stime;
    bit flagTime;
    Q_N=1;   
    MOTOR=1;
    flagTime=1;
    if(flagTime){
        Htime=hour;
        Mtime=minute;
        Stime=sec;
        flagTime=0;
    } 
    while(flagTime==1);
    if(hour==Htime && minute==Mtime+1){
       Q_L=1;
       M_NEN=1; 
    }
    if(hour==Htime && minute==Mtime+2){
    
    }
    
    /*when temp set > temp created by the compressor. this case,
     the compressor is always turn ON, this time just control heat resistance. 
    */ 
    if(tempSet>mTempSet){
       
       if(minute>=1){
          Q_L=1;
          M_NEN=1;
          if(minute>=2){
            VAN=1;
            DTN=1; 
          }
       }
    } 
    /*when temp set < temp created by the compressor. this case,
     the heat resistance is always turn OFF, this time just control the compressor. 
    */
    else{
       DTN=0;
       if(minute>=1){
            Q_L=1;
            M_NEN=1;
            if(minute>=2){
            VAN=1; 
          }
       }
    }
}

/**
    @brief: Process turn OFF device sequence by setting 
    @prama:
    @retval: None
*/
void processOff()
{

}