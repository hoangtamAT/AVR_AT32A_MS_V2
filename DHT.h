/*
  Written By AT

  Library for read temperature and Humidity of DHT22/DHT21

*/
#ifndef _DHT_
#define _DHT_INCLUDED_
#include <mega32a.h>
#include <delay.h>

#define DHT_ER      0 
#define DHT_OK      1 
#define DHT_ND      2 
#define DHT_ND1     3
#define DHT_DA      0
#define DHT_DA1     1

#define DATA_DDR    DDRA.1
#define DATA_PORT   PORTA.1
#define DATA_PIN    PINA.1

unsigned char DHT_GetTemHumi (unsigned char select);

#pragma library DHT.c
#endif