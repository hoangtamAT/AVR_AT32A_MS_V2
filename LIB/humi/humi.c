/****************************************************************************
Image data created by the LCD Vision V1.05 font & image editor/converter
(C) Copyright 2011-2013 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Graphic LCD controller: ST7920 128x64 8bit Bus /RST PSB=1
Image width: 25 pixels
Image height: 10 pixels
Color depth: 1 bits/pixel
Imported image file name: New image

Exported monochrome image data size:
24 bytes for displays organized as horizontal rows of bytes
34 bytes for displays organized as rows of vertical bytes.
****************************************************************************/

flash unsigned char humi[]=
{
/* Image width: 15 pixels */
0x0F, 0x00,
/* Image height: 10 pixels */
0x0A, 0x00,
#ifndef _GLCD_DATA_BYTEY_
/* Image data for monochrome displays organized
   as horizontal rows of bytes */
0xC8, 0x62, 0x90, 0x44, 0x28, 0x0A, 0x44, 0x11, 
0x92, 0x24, 0xB9, 0x4F, 0x7F, 0x7F, 0xBB, 0x6F, 
0xFE, 0x37, 0x38, 0x0E, 
#else
/* Image data for monochrome displays organized
   as rows of vertical bytes */
0xE0, 0xD0, 0x48, 0xE5, 0xF2, 0xE4, 0x49, 0xB3, 
0xE8, 0xE5, 0xF2, 0xE4, 0x48, 0xD1, 0xE3, 0x00, 
0x01, 0x01, 0x03, 0x03, 0x03, 0x01, 0x01, 0x01, 
0x03, 0x03, 0x02, 0x01, 0x01, 0x00, 
#endif
};

