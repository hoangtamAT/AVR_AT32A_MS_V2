/*******************************************************
Project : MS_V2
Version : 01
Date    : 1/11/2018
Author  : AT

Chip type               : ATmega32A
Program type            : Application
AVR Core Clock frequency: 8.000000 MHz
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
// library Symbol
#include <symbol.h>
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

#define BTN_SET     PINA.3
#define BTN_MODE    PIND.0
#define BTN_UP      PIND.1
#define BTN_DOWN    PIND.3
#define BTN_START   PIND.4
#define BTN_STOP    PIND.5
// Declare your global variables here
unsigned char hour,minute,sec,mode,day,date,month,year,Dhour;
eeprom unsigned char mTempSet,hourSet,minSet,tempSet;
float temperature,humidity; 
unsigned char time1, min1=0,min0;
int time0;
bit flagStart=0,privateSet=0,flagStop=0,timerEn=0;

/*******************  FUNCTION  *****************************/
void timer1DeInit();
void timer1Init();
void timer0DeInit();
void timer0Init();
void getTime();
void tempDisplay();
void timeSettingDisplay(unsigned char x, unsigned char y);
void tempSettingDisplay(unsigned char x, unsigned char y);
void statusDisplay();
void themeDisplay();
void processOn();
void processOff();
void mTempSetDisplay();
/***********************************************************/
// External Interrupt 0 service routine
interrupt [EXT_INT0] void ext_int0_isr(void)
{
// Place your code here
    if(BTN_MODE==0 && flagStart==0){ 
           mode++;
           if(mode>3){
            mode=0; 
            }            
    }
    
    else if(BTN_UP==0){ 
        
        if(privateSet){
            mTempSet++;
            if(mTempSet>60) mTempSet=35;
        }
        else{
            switch(mode)
            { 
                case 0: LAMP=~LAMP;
                    break;
                case 1:          
                    tempSet++;
                    if(tempSet>85) tempSet=20;
                    break;
                case 2:
                    hourSet++;
                    if(hourSet>48) hourSet=0;
                    break;
                case 3: 
                    minSet++;
                    if(minSet>59) minSet=0;
                    break;
            } 
        }
    }
    else if(BTN_DOWN==0){
        if(privateSet){
            mTempSet--;
            if(mTempSet<35) mTempSet=60;
        }  
        else{
            switch(mode)
            {   
                case 0: 
                    while(BTN_DOWN==0){
                        while(BTN_UP==1);
                        while(BTN_UP==0);
                        privateSet=1;
                        break;
                    } 
                    break;
                case 1:          
                    tempSet--;
                    if(tempSet<20) tempSet=85;
                    break;
                case 2:
                    if(hourSet==0) hourSet=48;
                    else hourSet--;
                    break;
                case 3: 
                    if(minSet==0) minSet=59;
                    else minSet--;
                    break;
            } 
        }
    }
    else if(BTN_START==0){
     rtc_set_time(0,0,0);
     rtc_set_date(1,1,1,1);  
     flagStop=0;   
     min1=0;
     flagStart=1; 
     timerEn=1;   
     }
    else if(BTN_STOP==0) { 
    min0=0; 
    flagStart=0;
    flagStop=1;;  
    }

}
// Timer Period: 32.768 ms
interrupt [TIM0_OVF] void timer0_ovf_isr(void)
{
     time0++;
     if(time0>1820){
       time0=0;
       min0++;
     }
}

// Timer 1 overflow interrupt service routine (2.0972s)

interrupt [TIM1_OVF] void timer1_ovf_isr(void)
{
   //tempDisplay();
   time1++;
   if(time1>25)
   {
     min1++; 
     time1=0;
   } 

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
// Clock value: 31.250 kHz
// Mode: Normal top=0xFFFF
// OC1A output: Disconnected
// OC1B output: Disconnected
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer Period: 2.0972 s
// Timer1 Overflow Interrupt: On
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (0<<WGM10);
TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (0<<CS11) | (0<<CS10);
TCNT1H=0x00;
TCNT1L=0x00;
ICR1H=0x00;
ICR1L=0x00;
OCR1AH=0x00;
OCR1AL=0x00;
OCR1BH=0x00;
OCR1BL=0x00;

// Timer(s)/Counter(s) Interrupt(s) initialization
TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (0<<TOIE1) | (0<<OCIE0) | (0<<TOIE0);

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
if(tempSet==255)
{
   tempSet=40;
   hourSet=1;
   minSet=0; 
   mTempSet=40;
}
rtc_set_time(0,0,0);
themeDisplay();
while (1)
      { 
        if(privateSet) mTempSetDisplay(); 
        if(mode==0){   
            if(flagStart){ 
              tempDisplay(); 
              getTime();
              processOn();
            } 
            if(flagStop){
              timer0Init();
              processOff();
            }
            glcd_outtextxyf(113,55," ");
            
            statusDisplay(); 
            if(mode<4){
              timeSettingDisplay(81,55);
              tempSettingDisplay(16,55); 
            }
        }  
        else if(mode<4){      
            timeSettingDisplay(81,55);
            tempSettingDisplay(16,55);
            if(mode==1) glcd_outtextxyf(8,55,"#");
            else if(mode==2) {
              glcd_outtextxyf(8,55," ");
              glcd_outtextxyf(72,55,"#");
            }  
            else if(mode==3){
              glcd_outtextxyf(72,55," ");
              glcd_outtextxyf(113,55,"#");
            }
        }
        
        //processOn();
        
      }
}

/******************  FUNCTION  *******************************/
/**
    @brief: Start timer1  
    @prama: None
    @retval: None
*/
void timer0Init()
{
// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: 7.813 kHz
// Mode: Normal top=0xFF
// OC0 output: Disconnected
// Timer Period: 32.768 ms
TCCR0=(0<<WGM00) | (0<<COM01) | (0<<COM00) | (0<<WGM01) | (1<<CS02) | (0<<CS01) | (1<<CS00);
TCNT0=0x00;
OCR0=0x00;
 // enable interrupt timer0
    TIMSK=(1<<TOIE0);
}
void timer0DeInit()
{
TCCR0=(0<<WGM00) | (0<<COM01) | (0<<COM00) | (0<<WGM01) | (0<<CS02) | (0<<CS01) | (0<<CS00);
TCNT0=0x00;
OCR0=0x00;
min0=0;
TIMSK=(0<<TOIE0);      
}
void timer1Init()
{
    // Timer/Counter 1 initialization
    // Clock source: System Clock
    // Clock value: 31.250 kHz
    // Mode: Normal top=0xFFFF
    // OC1A output: Disconnected
    // OC1B output: Disconnected
    // Noise Canceler: Off
    // Input Capture on Falling Edge
    // Timer Period: 2.0972 s
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
    // enable interrupt timer1
    TIMSK=(1<<TOIE1);
}

/**
    @brief: Stop timer1  
    @prama: None
    @retval: None
*/
void timer1DeInit()
{
    TCCR1A=0;
    TCCR1B=0;
    TCNT1H=0x00;
    TCNT1L=0x00;
    ICR1H=0x00;
    ICR1L=0x00;
    OCR1AH=0x00;
    OCR1AL=0x00;
    OCR1BH=0x00;
    OCR1BL=0x00;  
    min1=0;
    time1=0; 
    timerEn=0;
    // disable interrupt timer1
    TIMSK=(0<<TOIE1);      
}


/**
    @brief: Get real-time from DS1307  
    @prama: None
    @retval: None
*/
void getTime()
{
    rtc_get_time(&hour,&minute,&sec);    
    rtc_get_date(&day,&date,&month,&year);
}

/**
    @brief: Display temperature & humidity on LCD 128x64 
    @prama: - x: Horizontal axis (0-127)
            - y: Vertical axis (0-63)
    @retval: None
*/
void tempDisplay()
{
    char lcdBuff[10],lcdBuff1[10]; 
    float nd,nd1,da,da1; 
   // #asm("cli");
    nd=DHT_GetTemHumi(DHT_ND);
    delay_ms(500);
    nd1=DHT_GetTemHumi(DHT_ND1); 
    delay_ms(500);   
    temperature=((nd*256)+nd1)/10; 
    sprintf(lcdBuff,"%2.1f",temperature);
    glcd_outtextxy(30,5,lcdBuff);
    glcd_outtextxyf(54,2,"o");
    glcd_outtextxyf(60,5,"C");
    
    da=DHT_GetTemHumi(DHT_DA);
    delay_ms(500);
    da1=DHT_GetTemHumi(DHT_DA1); 
    delay_ms(500);
    humidity=((da*256)+da1)/10;    
    sprintf(lcdBuff1,"%2.1f",humidity);
    glcd_outtextxy(93,5,lcdBuff1);
    glcd_outtextf("%");
   // #asm("sei"); 

          

}

/**
    @brief: Display time run setting on LCD 128x64 
    @prama: - x: Horizontal axis (0-127)
            - y: Vertical axis (0-63)
    @retval: None
*/
void timeSettingDisplay(unsigned char x, unsigned char y)
{
     glcd_putcharxy(x,y,48+hourSet/10);   
     glcd_putchar(48+hourSet%10);
     glcd_outtextf(":");
     glcd_putchar(48+minSet/10);
     glcd_putchar(48+minSet%10);
}

/**
    @brief: Display temperature control setting on LCD 128x64 
    @prama: - x: Horizontal axis (0-127)
            - y: Vertical axis (0-63)
    @retval: None
*/
void tempSettingDisplay(unsigned char x, unsigned char y)
{
      glcd_putcharxy(x,y,48+tempSet/10);
      glcd_putchar(48+tempSet%10); 
      glcd_outtextxyf(x+13,y-4,"o");
      glcd_outtextxyf(x+20,y,"C");
}

/**
    @brief: Display status device (stop/running), Progress complete(%) on LCD 128x64 
    @prama: - x: Horizontal axis (0-127)
            - y: Vertical axis (0-63)
    @retval: None
*/
void statusDisplay()
{    unsigned int setPercent, runPercent,percent;
     
     Dhour=24*(date-1)+hour;

     setPercent = hourSet*60 + minSet;
     runPercent = hour*60 + minute; 
     percent = (runPercent*100)/setPercent;  
     
     if(flagStart){
         glcd_outtextxyf(20,20,">>> RUNNING <<<"); 
         glcd_putcharxy(5,31,48+Dhour/10);  
         glcd_putchar(48+Dhour%10);
         glcd_outtextf(":");  
         glcd_putchar(48+minute/10);
         glcd_putchar(48+minute%10);  
         
         glcd_outtextf("/");   
                                 
         glcd_putchar(48+hourSet/10);
         glcd_putchar(48+hourSet%10);
         glcd_outtextf(":");  
         glcd_putchar(48+minSet/10);
         glcd_putchar(48+minSet%10);   
         
         if(percent<100)
         { 
         glcd_outtextxyf(99,31," ");
         glcd_putchar(48+percent/10);
         glcd_putchar(48+percent%10); 
         glcd_outtextf("%");   
         }
         else{
           glcd_outtextxyf(99,31,"100%"); 
         }
     }  
     else if(mode<4){
        glcd_outtextxyf(20,20,">>> STOPPED <<<");  
        glcd_outtextxyf(5,31,"           ");
        glcd_outtextxyf(99,31,"    ");
      }
     
     
}

/**
    @brief: Process turn ON device sequence by setting 
    @prama: tempSet: Temperature setting for control heating at this temperature
    @retval: None
*/
void processOn()
{   
    bit flagTime=0,flagss=0;  
    
    if(Dhour==hourSet && minute==minSet){
     flagStop=1;
     flagStart=0;      
     }
    else
    {
        /*****************************************/ 
        if(tempSet>mTempSet)
        {
            Q_N=1;   
            MOTOR=1;
            timer1Init();  
            if(min1==1){
               Q_L=1;
               M_NEN=1; 
            }  
            if(min1==2){
               VAN=1;
               DTN=1;  
               flagTime=1;
               timer1DeInit();
            }   
            if(flagTime){
                if(temperature>(tempSet-1)){
                 DTN=0; 
                 flagss=1;   
                }
                else if(flagss==1){
                      if(temperature<(tempSet-2)) DTN=1;
                    } else if(temperature < tempSet) DTN=1;                                 
                
            }
        }else
        {
            Q_N=1;   
            MOTOR=1;
            DTN=0;
            if(flagss==0 && temperature<tempSet)
            {
                timer1Init();
                timer0DeInit();  
                if(min1==1){
                   Q_L=1;
                   M_NEN=1; 
                }  
                if(min1==2){
                   VAN=1;
                   DTN=1; 
                   flagss=1; 
                   timer1DeInit();  
                   
                }   
            }
            else{
                 if(temperature>=tempSet && flagss==1){
                    VAN=0; 
                    timer0Init(); 
                    timer1DeInit();
                    if(min0==1){
                        M_NEN=0;      
                        flagss=0;
                        timer0DeInit();
                    }
                } 
            }
            
        }
        /*******************************************/ 
    } 
}
/**
    @brief: Process turn OFF device sequence by setting 
    @prama:
    @retval: None
*/
void processOff()
{
   DTN=0;
   VAN=0;
   if(min0==1) Q_N=0;
   if(min0==2){
        MOTOR=0;
        M_NEN=0;
        Q_L=0;
        LAMP=1;
        mode=10;  
        glcd_clear();
        delay_ms(500);
        glcd_outtextxyf(32,5,"HOAN THANH!");
        glcd_outtextxyf(30,35,"NHAN 'RESET'"); 
        glcd_outtextxyf(15,50,"DE KHOI DONG LAI");     
        timer0DeInit();
   }
}

/**
    @brief: Display theme on all main screen                                 
    @prama:None
    @retval: None
*/
void themeDisplay()
{
    glcd_line(0,16,127,16);
    glcd_line(0,41,127,41);
    glcd_line(62,41,62,63);  
    glcd_line(64,41,64,63);   
    
//    glcd_line(62,3,62,16);  
//    glcd_line(64,3,64,16);
    
    glcd_outtextxyf(7,43,"TEMP SET");
    glcd_outtextxyf(72,43,"TIME SET");
    glcd_putimagef(2,3,heat,GLCD_PUTCOPY);
    glcd_putimagef(73,3,humi,GLCD_PUTCOPY);
}

void mTempSetDisplay()
{
    glcd_putcharxy(113,22,48+mTempSet/10);
    glcd_putchar(48+mTempSet%10);
}
