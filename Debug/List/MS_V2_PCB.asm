
;CodeVisionAVR C Compiler V3.12 Advanced
;(C) Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATmega32A
;Program type           : Application
;Clock frequency        : 16.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 512 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: Yes
;Enhanced function parameter passing: Yes
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega32A
	#pragma AVRPART MEMORY PROG_FLASH 32768
	#pragma AVRPART MEMORY EEPROM 1024
	#pragma AVRPART MEMORY INT_SRAM SIZE 2048
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x085F
	.EQU __DSTACK_SIZE=0x0200
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  _ext_int0_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _timer0_ovf_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_font5x7:
	.DB  0x5,0x7,0x20,0x60,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x4,0x4,0x4,0x4,0x4
	.DB  0x0,0x4,0xA,0xA,0xA,0x0,0x0,0x0
	.DB  0x0,0xA,0xA,0x1F,0xA,0x1F,0xA,0xA
	.DB  0x4,0x1E,0x5,0xE,0x14,0xF,0x4,0x3
	.DB  0x13,0x8,0x4,0x2,0x19,0x18,0x6,0x9
	.DB  0x5,0x2,0x15,0x9,0x16,0x6,0x4,0x2
	.DB  0x0,0x0,0x0,0x0,0x8,0x4,0x2,0x2
	.DB  0x2,0x4,0x8,0x2,0x4,0x8,0x8,0x8
	.DB  0x4,0x2,0x0,0xA,0x4,0x1F,0x4,0xA
	.DB  0x0,0x0,0x4,0x4,0x1F,0x4,0x4,0x0
	.DB  0x0,0x0,0x0,0x0,0x6,0x4,0x2,0x0
	.DB  0x0,0x0,0x1F,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x6,0x6,0x0,0x0,0x10,0x8
	.DB  0x4,0x2,0x1,0x0,0xE,0x11,0x19,0x15
	.DB  0x13,0x11,0xE,0x4,0x6,0x4,0x4,0x4
	.DB  0x4,0xE,0xE,0x11,0x10,0x8,0x4,0x2
	.DB  0x1F,0x1F,0x8,0x4,0x8,0x10,0x11,0xE
	.DB  0x8,0xC,0xA,0x9,0x1F,0x8,0x8,0x1F
	.DB  0x1,0xF,0x10,0x10,0x11,0xE,0xC,0x2
	.DB  0x1,0xF,0x11,0x11,0xE,0x1F,0x10,0x8
	.DB  0x4,0x2,0x2,0x2,0xE,0x11,0x11,0xE
	.DB  0x11,0x11,0xE,0xE,0x11,0x11,0x1E,0x10
	.DB  0x8,0x6,0x0,0x6,0x6,0x0,0x6,0x6
	.DB  0x0,0x0,0x6,0x6,0x0,0x6,0x4,0x2
	.DB  0x10,0x8,0x4,0x2,0x4,0x8,0x10,0x0
	.DB  0x0,0x1F,0x0,0x1F,0x0,0x0,0x1,0x2
	.DB  0x4,0x8,0x4,0x2,0x1,0xE,0x11,0x10
	.DB  0x8,0x4,0x0,0x4,0xE,0x11,0x10,0x16
	.DB  0x15,0x15,0xE,0xE,0x11,0x11,0x11,0x1F
	.DB  0x11,0x11,0xF,0x11,0x11,0xF,0x11,0x11
	.DB  0xF,0xE,0x11,0x1,0x1,0x1,0x11,0xE
	.DB  0x7,0x9,0x11,0x11,0x11,0x9,0x7,0x1F
	.DB  0x1,0x1,0xF,0x1,0x1,0x1F,0x1F,0x1
	.DB  0x1,0x7,0x1,0x1,0x1,0xE,0x11,0x1
	.DB  0x1,0x19,0x11,0xE,0x11,0x11,0x11,0x1F
	.DB  0x11,0x11,0x11,0xE,0x4,0x4,0x4,0x4
	.DB  0x4,0xE,0x1C,0x8,0x8,0x8,0x8,0x9
	.DB  0x6,0x11,0x9,0x5,0x3,0x5,0x9,0x11
	.DB  0x1,0x1,0x1,0x1,0x1,0x1,0x1F,0x11
	.DB  0x1B,0x15,0x11,0x11,0x11,0x11,0x11,0x11
	.DB  0x13,0x15,0x19,0x11,0x11,0xE,0x11,0x11
	.DB  0x11,0x11,0x11,0xE,0xF,0x11,0x11,0xF
	.DB  0x1,0x1,0x1,0xE,0x11,0x11,0x11,0x15
	.DB  0x9,0x16,0xF,0x11,0x11,0xF,0x5,0x9
	.DB  0x11,0x1E,0x1,0x1,0xE,0x10,0x10,0xF
	.DB  0x1F,0x4,0x4,0x4,0x4,0x4,0x4,0x11
	.DB  0x11,0x11,0x11,0x11,0x11,0xE,0x11,0x11
	.DB  0x11,0x11,0x11,0xA,0x4,0x11,0x11,0x11
	.DB  0x15,0x15,0x1B,0x11,0x11,0x11,0xA,0x4
	.DB  0xA,0x11,0x11,0x11,0x11,0xA,0x4,0x4
	.DB  0x4,0x4,0x1F,0x10,0x8,0x4,0x2,0x1
	.DB  0x1F,0x1C,0x4,0x4,0x4,0x4,0x4,0x1C
	.DB  0x0,0x1,0x2,0x4,0x8,0x10,0x0,0x7
	.DB  0x4,0x4,0x4,0x4,0x4,0x7,0x4,0xA
	.DB  0x11,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x1F,0x2,0x4,0x8,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0xE,0x10,0x1E
	.DB  0x11,0x1E,0x1,0x1,0xD,0x13,0x11,0x11
	.DB  0xF,0x0,0x0,0xE,0x1,0x1,0x11,0xE
	.DB  0x10,0x10,0x16,0x19,0x11,0x11,0x1E,0x0
	.DB  0x0,0xE,0x11,0x1F,0x1,0xE,0xC,0x12
	.DB  0x2,0x7,0x2,0x2,0x2,0x0,0x0,0x1E
	.DB  0x11,0x1E,0x10,0xC,0x1,0x1,0xD,0x13
	.DB  0x11,0x11,0x11,0x4,0x0,0x6,0x4,0x4
	.DB  0x4,0xE,0x8,0x0,0xC,0x8,0x8,0x9
	.DB  0x6,0x2,0x2,0x12,0xA,0x6,0xA,0x12
	.DB  0x6,0x4,0x4,0x4,0x4,0x4,0xE,0x0
	.DB  0x0,0xB,0x15,0x15,0x11,0x11,0x0,0x0
	.DB  0xD,0x13,0x11,0x11,0x11,0x0,0x0,0xE
	.DB  0x11,0x11,0x11,0xE,0x0,0x0,0xF,0x11
	.DB  0xF,0x1,0x1,0x0,0x0,0x16,0x19,0x1E
	.DB  0x10,0x10,0x0,0x0,0xD,0x13,0x1,0x1
	.DB  0x1,0x0,0x0,0xE,0x1,0xE,0x10,0xF
	.DB  0x2,0x2,0x7,0x2,0x2,0x12,0xC,0x0
	.DB  0x0,0x11,0x11,0x11,0x19,0x16,0x0,0x0
	.DB  0x11,0x11,0x11,0xA,0x4,0x0,0x0,0x11
	.DB  0x11,0x15,0x15,0xA,0x0,0x0,0x11,0xA
	.DB  0x4,0xA,0x11,0x0,0x0,0x11,0x11,0x1E
	.DB  0x10,0xE,0x0,0x0,0x1F,0x8,0x4,0x2
	.DB  0x1F,0x8,0x4,0x4,0x2,0x4,0x4,0x8
	.DB  0x4,0x4,0x4,0x4,0x4,0x4,0x4,0x2
	.DB  0x4,0x4,0x8,0x4,0x4,0x2,0x2,0x15
	.DB  0x8,0x0,0x0,0x0,0x0,0x1F,0x11,0x11
	.DB  0x11,0x11,0x11,0x1F
_conv_delay_G101:
	.DB  0x64,0x0,0xC8,0x0,0x90,0x1,0x20,0x3
_bit_mask_G101:
	.DB  0xF8,0xFF,0xFC,0xFF,0xFE,0xFF,0xFF,0xFF
__glcd_mask:
	.DB  0x0,0x1,0x3,0x7,0xF,0x1F,0x3F,0x7F
	.DB  0xFF
_st7920_base_y_G102:
	.DB  0x80,0x90,0x88,0x98

_0x2140060:
	.DB  0x1
_0x2140000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0

__GLOBAL_INI_TBL:
	.DW  0x01
	.DW  __seed_G10A
	.DW  _0x2140060*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x260

	.CSEG
;/*******************************************************
;Project : MS_V2
;Version : 01
;Date    : 1/11/2018
;Author  : AT
;Company :
;Comments:
;
;
;Chip type               : ATmega32A
;Program type            : Application
;AVR Core Clock frequency: 16.000000 MHz
;Memory model            : Small
;External RAM size       : 0
;Data Stack size         : 512
;*******************************************************/
;
;#include <mega32a.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;// I2C Bus functions
;#include <i2c.h>
;// DS1307 Real Time Clock functions
;#include <ds1307.h>
;// 1 Wire Bus interface functions
;#include <1wire.h>
;// DS18b20 Temperature Sensor functions
;#include <ds18b20.h>
;// Graphic Display functions
;#include <glcd.h>
;// Font used for displaying text
;// on the graphic display
;#include <font5x7.h>
;// library extern
;#include "LIB/exlib.h"
;// DHT library
;#include <DHT.h>
;// Declare your global variables here
;
;// External Interrupt 0 service routine
;interrupt [EXT_INT0] void ext_int0_isr(void)
; 0000 0028 {

	.CSEG
_ext_int0_isr:
; .FSTART _ext_int0_isr
; 0000 0029 // Place your code here
; 0000 002A 
; 0000 002B }
	RETI
; .FEND
;
;// Timer 0 overflow interrupt service routine
;interrupt [TIM0_OVF] void timer0_ovf_isr(void)
; 0000 002F {
_timer0_ovf_isr:
; .FSTART _timer0_ovf_isr
; 0000 0030 // Place your code here
; 0000 0031 
; 0000 0032 }
	RETI
; .FEND
;
;void main(void)
; 0000 0035 {
_main:
; .FSTART _main
; 0000 0036 // Declare your local variables here
; 0000 0037 // Variable used to store graphic display
; 0000 0038 // controller initialization data
; 0000 0039 GLCDINIT_t glcd_init_data;
; 0000 003A 
; 0000 003B // Input/Output Ports initialization
; 0000 003C // Port A initialization
; 0000 003D // Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 003E DDRA=(1<<DDA7) | (1<<DDA6) | (1<<DDA5) | (1<<DDA4) | (0<<DDA3) | (0<<DDA2) | (0<<DDA1) | (0<<DDA0);
	SBIW R28,6
;	glcd_init_data -> Y+0
	LDI  R30,LOW(240)
	OUT  0x1A,R30
; 0000 003F // State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=P Bit2=T Bit1=T Bit0=T
; 0000 0040 PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (1<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);
	LDI  R30,LOW(8)
	OUT  0x1B,R30
; 0000 0041 
; 0000 0042 // Port B initialization
; 0000 0043 // Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out
; 0000 0044 DDRB=(1<<DDB7) | (1<<DDB6) | (1<<DDB5) | (1<<DDB4) | (1<<DDB3) | (1<<DDB2) | (1<<DDB1) | (1<<DDB0);
	LDI  R30,LOW(255)
	OUT  0x17,R30
; 0000 0045 // State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=0 Bit2=0 Bit1=0 Bit0=0
; 0000 0046 PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);
	LDI  R30,LOW(0)
	OUT  0x18,R30
; 0000 0047 
; 0000 0048 // Port C initialization
; 0000 0049 // Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out
; 0000 004A DDRC=(1<<DDC7) | (1<<DDC6) | (1<<DDC5) | (1<<DDC4) | (1<<DDC3) | (1<<DDC2) | (1<<DDC1) | (1<<DDC0);
	LDI  R30,LOW(255)
	OUT  0x14,R30
; 0000 004B // State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=0 Bit2=0 Bit1=0 Bit0=0
; 0000 004C PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);
	LDI  R30,LOW(0)
	OUT  0x15,R30
; 0000 004D 
; 0000 004E // Port D initialization
; 0000 004F // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0050 DDRD=(0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
	OUT  0x11,R30
; 0000 0051 // State: Bit7=T Bit6=T Bit5=P Bit4=P Bit3=P Bit2=P Bit1=P Bit0=P
; 0000 0052 PORTD=(0<<PORTD7) | (0<<PORTD6) | (1<<PORTD5) | (1<<PORTD4) | (1<<PORTD3) | (1<<PORTD2) | (1<<PORTD1) | (1<<PORTD0);
	LDI  R30,LOW(63)
	OUT  0x12,R30
; 0000 0053 
; 0000 0054 // Timer/Counter 0 initialization
; 0000 0055 // Clock source: System Clock
; 0000 0056 // Clock value: 62.500 kHz
; 0000 0057 // Mode: Normal top=0xFF
; 0000 0058 // OC0 output: Disconnected
; 0000 0059 // Timer Period: 4.096 ms
; 0000 005A TCCR0=(0<<WGM00) | (0<<COM01) | (0<<COM00) | (0<<WGM01) | (1<<CS02) | (0<<CS01) | (0<<CS00);
	LDI  R30,LOW(4)
	OUT  0x33,R30
; 0000 005B TCNT0=0x00;
	LDI  R30,LOW(0)
	OUT  0x32,R30
; 0000 005C OCR0=0x00;
	OUT  0x3C,R30
; 0000 005D 
; 0000 005E // Timer(s)/Counter(s) Interrupt(s) initialization
; 0000 005F TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (0<<TOIE1) | (0<<OCIE0) | (1<<TOIE0);
	LDI  R30,LOW(1)
	OUT  0x39,R30
; 0000 0060 
; 0000 0061 // External Interrupt(s) initialization
; 0000 0062 // INT0: On
; 0000 0063 // INT0 Mode: Falling Edge
; 0000 0064 // INT1: Off
; 0000 0065 // INT2: Off
; 0000 0066 GICR|=(0<<INT1) | (1<<INT0) | (0<<INT2);
	IN   R30,0x3B
	ORI  R30,0x40
	OUT  0x3B,R30
; 0000 0067 MCUCR=(0<<ISC11) | (0<<ISC10) | (1<<ISC01) | (0<<ISC00);
	LDI  R30,LOW(2)
	OUT  0x35,R30
; 0000 0068 MCUCSR=(0<<ISC2);
	LDI  R30,LOW(0)
	OUT  0x34,R30
; 0000 0069 GIFR=(0<<INTF1) | (1<<INTF0) | (0<<INTF2);
	LDI  R30,LOW(64)
	OUT  0x3A,R30
; 0000 006A 
; 0000 006B // Bit-Banged I2C Bus initialization
; 0000 006C // I2C Port: PORTD
; 0000 006D // I2C SDA bit: 6
; 0000 006E // I2C SCL bit: 7
; 0000 006F // Bit Rate: 100 kHz
; 0000 0070 // Note: I2C settings are specified in the
; 0000 0071 // Project|Configure|C Compiler|Libraries|I2C menu.
; 0000 0072 i2c_init();
	CALL _i2c_init
; 0000 0073 
; 0000 0074 // DS1307 Real Time Clock initialization
; 0000 0075 // Square wave output on pin SQW/OUT: Off
; 0000 0076 // SQW/OUT pin state: 0
; 0000 0077 rtc_init(0,0,0);
	LDI  R30,LOW(0)
	ST   -Y,R30
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _rtc_init
; 0000 0078 
; 0000 0079 // 1 Wire Bus initialization
; 0000 007A // 1 Wire Data port: PORTA
; 0000 007B // 1 Wire Data bit: 0
; 0000 007C // Note: 1 Wire port settings are specified in the
; 0000 007D // Project|Configure|C Compiler|Libraries|1 Wire menu.
; 0000 007E w1_init();
	CALL _w1_init
; 0000 007F 
; 0000 0080 // Graphic Display Controller initialization
; 0000 0081 // The ST7920 connections are specified in the
; 0000 0082 // Project|Configure|C Compiler|Libraries|Graphic Display menu:
; 0000 0083 // DB0 - PORTC Bit 4
; 0000 0084 // DB1 - PORTC Bit 5
; 0000 0085 // DB2 - PORTC Bit 6
; 0000 0086 // DB3 - PORTC Bit 7
; 0000 0087 // DB4 - PORTA Bit 7
; 0000 0088 // DB5 - PORTA Bit 6
; 0000 0089 // DB6 - PORTA Bit 5
; 0000 008A // DB7 - PORTA Bit 4
; 0000 008B // E - PORTC Bit 2
; 0000 008C // R /W - PORTC Bit 1
; 0000 008D // RS - PORTC Bit 0
; 0000 008E // /RST - PORTC Bit 3
; 0000 008F 
; 0000 0090 // Specify the current font for displaying text
; 0000 0091 glcd_init_data.font=font5x7;
	LDI  R30,LOW(_font5x7*2)
	LDI  R31,HIGH(_font5x7*2)
	ST   Y,R30
	STD  Y+1,R31
; 0000 0092 // No function is used for reading
; 0000 0093 // image data from external memory
; 0000 0094 glcd_init_data.readxmem=NULL;
	LDI  R30,LOW(0)
	STD  Y+2,R30
	STD  Y+2+1,R30
; 0000 0095 // No function is used for writing
; 0000 0096 // image data to external memory
; 0000 0097 glcd_init_data.writexmem=NULL;
	STD  Y+4,R30
	STD  Y+4+1,R30
; 0000 0098 
; 0000 0099 glcd_init(&glcd_init_data);
	MOVW R26,R28
	RCALL _glcd_init
; 0000 009A 
; 0000 009B // Global enable interrupts
; 0000 009C #asm("sei")
	sei
; 0000 009D 
; 0000 009E while (1)
_0x3:
; 0000 009F       {
; 0000 00A0       // Place your code here
; 0000 00A1 
; 0000 00A2       }
	RJMP _0x3
; 0000 00A3 }
_0x6:
	RJMP _0x6
; .FEND

	.CSEG
_rtc_init:
; .FSTART _rtc_init
	ST   -Y,R26
	LDD  R30,Y+2
	ANDI R30,LOW(0x3)
	STD  Y+2,R30
	LDD  R30,Y+1
	CPI  R30,0
	BREQ _0x2000003
	LDD  R30,Y+2
	ORI  R30,0x10
	STD  Y+2,R30
_0x2000003:
	LD   R30,Y
	CPI  R30,0
	BREQ _0x2000004
	LDD  R30,Y+2
	ORI  R30,0x80
	STD  Y+2,R30
_0x2000004:
	CALL _i2c_start
	LDI  R26,LOW(208)
	CALL _i2c_write
	LDI  R26,LOW(7)
	CALL _i2c_write
	LDD  R26,Y+2
	CALL _i2c_write
	CALL _i2c_stop
	ADIW R28,3
	RET
; .FEND

	.CSEG
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG
_st7920_delay_G102:
; .FSTART _st7920_delay_G102
    nop
    nop
    nop
	RET
; .FEND
_st7920_wrbus_G102:
; .FSTART _st7920_wrbus_G102
	ST   -Y,R26
	CBI  0x15,1
	SBI  0x15,2
	SBI  0x14,4
	SBI  0x14,5
	SBI  0x14,6
	SBI  0x14,7
	SBI  0x1A,7
	SBI  0x1A,6
	SBI  0x1A,5
	SBI  0x1A,4
	LD   R30,Y
	ANDI R30,LOW(0x1)
	BREQ _0x2040003
	SBI  0x15,4
	RJMP _0x2040004
_0x2040003:
	CBI  0x15,4
_0x2040004:
	LD   R30,Y
	ANDI R30,LOW(0x2)
	BREQ _0x2040005
	SBI  0x15,5
	RJMP _0x2040006
_0x2040005:
	CBI  0x15,5
_0x2040006:
	LD   R30,Y
	ANDI R30,LOW(0x4)
	BREQ _0x2040007
	SBI  0x15,6
	RJMP _0x2040008
_0x2040007:
	CBI  0x15,6
_0x2040008:
	LD   R30,Y
	ANDI R30,LOW(0x8)
	BREQ _0x2040009
	SBI  0x15,7
	RJMP _0x204000A
_0x2040009:
	CBI  0x15,7
_0x204000A:
	LD   R30,Y
	ANDI R30,LOW(0x10)
	BREQ _0x204000B
	SBI  0x1B,7
	RJMP _0x204000C
_0x204000B:
	CBI  0x1B,7
_0x204000C:
	LD   R30,Y
	ANDI R30,LOW(0x20)
	BREQ _0x204000D
	SBI  0x1B,6
	RJMP _0x204000E
_0x204000D:
	CBI  0x1B,6
_0x204000E:
	LD   R30,Y
	ANDI R30,LOW(0x40)
	BREQ _0x204000F
	SBI  0x1B,5
	RJMP _0x2040010
_0x204000F:
	CBI  0x1B,5
_0x2040010:
	LD   R30,Y
	ANDI R30,LOW(0x80)
	BREQ _0x2040011
	SBI  0x1B,4
	RJMP _0x2040012
_0x2040011:
	CBI  0x1B,4
_0x2040012:
	RCALL _st7920_delay_G102
	CBI  0x15,2
	RJMP _0x2180002
; .FEND
_st7920_busy_G102:
; .FSTART _st7920_busy_G102
	CBI  0x15,0
	SBI  0x15,1
	CBI  0x14,4
	CBI  0x14,5
	CBI  0x14,6
	CBI  0x14,7
	CBI  0x1A,7
	CBI  0x1A,6
	CBI  0x1A,5
	CBI  0x1A,4
	SBI  0x15,2
	RCALL _st7920_delay_G102
_0x204001B:
	SBIC 0x19,4
	RJMP _0x204001B
	CBI  0x15,2
	__DELAY_USB 5
	RET
; .FEND
_st7920_wrdata:
; .FSTART _st7920_wrdata
	ST   -Y,R26
	RCALL _st7920_busy_G102
	SBI  0x15,0
	LD   R26,Y
	RCALL _st7920_wrbus_G102
	RJMP _0x2180002
; .FEND
_st7920_wrcmd:
; .FSTART _st7920_wrcmd
	ST   -Y,R26
	RCALL _st7920_busy_G102
	LD   R26,Y
	RCALL _st7920_wrbus_G102
	RJMP _0x2180002
; .FEND
_st7920_setxy_G102:
; .FSTART _st7920_setxy_G102
	ST   -Y,R26
	LD   R30,Y
	ANDI R30,LOW(0x1F)
	ORI  R30,0x80
	MOV  R26,R30
	RCALL _st7920_wrcmd
	LD   R26,Y
	CPI  R26,LOW(0x20)
	BRLO _0x204001E
	LDD  R30,Y+1
	ORI  R30,0x80
	STD  Y+1,R30
_0x204001E:
	LDD  R30,Y+1
	SWAP R30
	ANDI R30,0xF
	ORI  R30,0x80
	MOV  R26,R30
	RCALL _st7920_wrcmd
	RJMP _0x2180001
; .FEND
_glcd_display:
; .FSTART _glcd_display
	ST   -Y,R26
	CALL SUBOPT_0x0
	LD   R30,Y
	CPI  R30,0
	BREQ _0x204001F
	LDI  R30,LOW(12)
	RJMP _0x2040020
_0x204001F:
	LDI  R30,LOW(8)
_0x2040020:
	MOV  R26,R30
	RCALL _st7920_wrcmd
	LD   R30,Y
	CPI  R30,0
	BREQ _0x2040022
	LDI  R30,LOW(2)
	RJMP _0x2040023
_0x2040022:
	LDI  R30,LOW(0)
_0x2040023:
	STS  _st7920_graphics_on_G102,R30
	CALL SUBOPT_0x0
	CALL SUBOPT_0x1
_0x2180002:
	ADIW R28,1
	RET
; .FEND
_glcd_cleargraphics:
; .FSTART _glcd_cleargraphics
	CALL __SAVELOCR4
	LDI  R19,0
	__GETB1MN _glcd_state,1
	CPI  R30,0
	BREQ _0x2040025
	LDI  R19,LOW(255)
_0x2040025:
	CALL SUBOPT_0x1
	LDI  R16,LOW(0)
_0x2040026:
	CPI  R16,64
	BRSH _0x2040028
	LDI  R30,LOW(0)
	ST   -Y,R30
	MOV  R26,R16
	SUBI R16,-1
	RCALL _st7920_setxy_G102
	LDI  R17,LOW(16)
_0x2040029:
	MOV  R30,R17
	SUBI R17,1
	CPI  R30,0
	BREQ _0x204002B
	MOV  R26,R19
	RCALL _st7920_wrdata
	RJMP _0x2040029
_0x204002B:
	RJMP _0x2040026
_0x2040028:
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _glcd_moveto
	CALL __LOADLOCR4
	ADIW R28,4
	RET
; .FEND
_glcd_init:
; .FSTART _glcd_init
	ST   -Y,R27
	ST   -Y,R26
	SBI  0x14,2
	CBI  0x15,2
	SBI  0x14,1
	SBI  0x15,1
	SBI  0x14,0
	CBI  0x15,0
	SBI  0x14,3
	LDI  R26,LOW(50)
	LDI  R27,0
	CALL _delay_ms
	CBI  0x15,3
	LDI  R26,LOW(1)
	LDI  R27,0
	CALL _delay_ms
	SBI  0x15,3
	LDI  R26,LOW(1)
	LDI  R27,0
	CALL _delay_ms
	CALL SUBOPT_0x2
	CALL SUBOPT_0x2
	LDI  R26,LOW(8)
	RCALL _st7920_wrbus_G102
	__DELAY_USW 800
	LDI  R26,LOW(1)
	RCALL _st7920_wrcmd
	LDI  R26,LOW(15)
	LDI  R27,0
	CALL _delay_ms
	LDI  R30,LOW(0)
	STS  _yt_G102,R30
	STS  _xt_G102,R30
	LDI  R26,LOW(6)
	RCALL _st7920_wrcmd
	LDI  R26,LOW(52)
	RCALL _st7920_wrcmd
	LDI  R26,LOW(64)
	RCALL _st7920_wrcmd
	LDI  R26,LOW(2)
	RCALL _st7920_wrcmd
	LDI  R30,LOW(0)
	STS  _st7920_graphics_on_G102,R30
	RCALL _glcd_cleargraphics
	LDI  R26,LOW(1)
	RCALL _glcd_display
	LDI  R30,LOW(1)
	STS  _glcd_state,R30
	LDI  R30,LOW(0)
	__PUTB1MN _glcd_state,1
	LDI  R30,LOW(1)
	__PUTB1MN _glcd_state,6
	__PUTB1MN _glcd_state,7
	LD   R30,Y
	LDD  R31,Y+1
	SBIW R30,0
	BREQ _0x204002C
	LD   R26,Y
	LDD  R27,Y+1
	CALL __GETW1P
	__PUTW1MN _glcd_state,4
	ADIW R26,2
	CALL __GETW1P
	__PUTW1MN _glcd_state,25
	LD   R26,Y
	LDD  R27,Y+1
	ADIW R26,4
	CALL __GETW1P
	RJMP _0x20400BB
_0x204002C:
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	__PUTW1MN _glcd_state,4
	__PUTW1MN _glcd_state,25
_0x20400BB:
	__PUTW1MN _glcd_state,27
	LDI  R30,LOW(1)
	__PUTB1MN _glcd_state,8
	LDI  R30,LOW(255)
	__PUTB1MN _glcd_state,9
	LDI  R30,LOW(1)
	__PUTB1MN _glcd_state,16
	__POINTW1MN _glcd_state,17
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(255)
	ST   -Y,R30
	LDI  R26,LOW(8)
	LDI  R27,0
	CALL _memset
	LDI  R30,LOW(1)
	RJMP _0x2180001
; .FEND

	.CSEG
_glcd_clipx:
; .FSTART _glcd_clipx
	CALL SUBOPT_0x3
	BRLT _0x2060003
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RJMP _0x2180001
_0x2060003:
	LD   R26,Y
	LDD  R27,Y+1
	CPI  R26,LOW(0x80)
	LDI  R30,HIGH(0x80)
	CPC  R27,R30
	BRLT _0x2060004
	LDI  R30,LOW(127)
	LDI  R31,HIGH(127)
	RJMP _0x2180001
_0x2060004:
	LD   R30,Y
	LDD  R31,Y+1
	RJMP _0x2180001
; .FEND
_glcd_clipy:
; .FSTART _glcd_clipy
	CALL SUBOPT_0x3
	BRLT _0x2060005
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RJMP _0x2180001
_0x2060005:
	LD   R26,Y
	LDD  R27,Y+1
	CPI  R26,LOW(0x40)
	LDI  R30,HIGH(0x40)
	CPC  R27,R30
	BRLT _0x2060006
	LDI  R30,LOW(63)
	LDI  R31,HIGH(63)
	RJMP _0x2180001
_0x2060006:
	LD   R30,Y
	LDD  R31,Y+1
	RJMP _0x2180001
; .FEND
_glcd_moveto:
; .FSTART _glcd_moveto
	ST   -Y,R26
	LDD  R26,Y+1
	CLR  R27
	RCALL _glcd_clipx
	__PUTB1MN _glcd_state,2
	LD   R26,Y
	CLR  R27
	RCALL _glcd_clipy
	__PUTB1MN _glcd_state,3
_0x2180001:
	ADIW R28,2
	RET
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG

	.CSEG

	.CSEG
_memset:
; .FSTART _memset
	ST   -Y,R27
	ST   -Y,R26
    ldd  r27,y+1
    ld   r26,y
    adiw r26,0
    breq memset1
    ldd  r31,y+4
    ldd  r30,y+3
    ldd  r22,y+2
memset0:
    st   z+,r22
    sbiw r26,1
    brne memset0
memset1:
    ldd  r30,y+3
    ldd  r31,y+4
	ADIW R28,5
	RET
; .FEND

	.CSEG

	.CSEG

	.CSEG

	.DSEG

	.CSEG

	.CSEG

	.DSEG
___ds18b20_scratch_pad:
	.BYTE 0x9
_glcd_state:
	.BYTE 0x1D
_st7920_graphics_on_G102:
	.BYTE 0x1
_st7920_bits8_15_G102:
	.BYTE 0x1
_xt_G102:
	.BYTE 0x1
_yt_G102:
	.BYTE 0x1
__seed_G10A:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x0:
	LDS  R30,_st7920_graphics_on_G102
	ORI  R30,LOW(0x30)
	MOV  R26,R30
	JMP  _st7920_wrcmd

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1:
	LDS  R30,_st7920_graphics_on_G102
	ORI  R30,LOW(0x34)
	MOV  R26,R30
	JMP  _st7920_wrcmd

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x2:
	LDI  R26,LOW(48)
	CALL _st7920_wrbus_G102
	__DELAY_USW 800
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3:
	ST   -Y,R27
	ST   -Y,R26
	LD   R26,Y
	LDD  R27,Y+1
	CALL __CPW02
	RET


	.CSEG
	.equ __sda_bit=6
	.equ __scl_bit=7
	.equ __i2c_port=0x12 ;PORTD
	.equ __i2c_dir=__i2c_port-1
	.equ __i2c_pin=__i2c_port-2

_i2c_init:
	cbi  __i2c_port,__scl_bit
	cbi  __i2c_port,__sda_bit
	sbi  __i2c_dir,__scl_bit
	cbi  __i2c_dir,__sda_bit
	rjmp __i2c_delay2
_i2c_start:
	cbi  __i2c_dir,__sda_bit
	cbi  __i2c_dir,__scl_bit
	clr  r30
	nop
	sbis __i2c_pin,__sda_bit
	ret
	sbis __i2c_pin,__scl_bit
	ret
	rcall __i2c_delay1
	sbi  __i2c_dir,__sda_bit
	rcall __i2c_delay1
	sbi  __i2c_dir,__scl_bit
	ldi  r30,1
__i2c_delay1:
	ldi  r22,27
	rjmp __i2c_delay2l
_i2c_stop:
	sbi  __i2c_dir,__sda_bit
	sbi  __i2c_dir,__scl_bit
	rcall __i2c_delay2
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay1
	cbi  __i2c_dir,__sda_bit
__i2c_delay2:
	ldi  r22,53
__i2c_delay2l:
	dec  r22
	brne __i2c_delay2l
	ret
_i2c_read:
	ldi  r23,8
__i2c_read0:
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay1
__i2c_read3:
	sbis __i2c_pin,__scl_bit
	rjmp __i2c_read3
	rcall __i2c_delay1
	clc
	sbic __i2c_pin,__sda_bit
	sec
	sbi  __i2c_dir,__scl_bit
	rcall __i2c_delay2
	rol  r30
	dec  r23
	brne __i2c_read0
	mov  r23,r26
	tst  r23
	brne __i2c_read1
	cbi  __i2c_dir,__sda_bit
	rjmp __i2c_read2
__i2c_read1:
	sbi  __i2c_dir,__sda_bit
__i2c_read2:
	rcall __i2c_delay1
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay2
	sbi  __i2c_dir,__scl_bit
	rcall __i2c_delay1
	cbi  __i2c_dir,__sda_bit
	rjmp __i2c_delay1

_i2c_write:
	ldi  r23,8
__i2c_write0:
	lsl  r26
	brcc __i2c_write1
	cbi  __i2c_dir,__sda_bit
	rjmp __i2c_write2
__i2c_write1:
	sbi  __i2c_dir,__sda_bit
__i2c_write2:
	rcall __i2c_delay2
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay1
__i2c_write3:
	sbis __i2c_pin,__scl_bit
	rjmp __i2c_write3
	rcall __i2c_delay1
	sbi  __i2c_dir,__scl_bit
	dec  r23
	brne __i2c_write0
	cbi  __i2c_dir,__sda_bit
	rcall __i2c_delay1
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay2
	ldi  r30,1
	sbic __i2c_pin,__sda_bit
	clr  r30
	sbi  __i2c_dir,__scl_bit
	rjmp __i2c_delay1

_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0xFA0
	wdr
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

	.equ __w1_port=0x1B
	.equ __w1_bit=0x00

_w1_init:
	clr  r30
	cbi  __w1_port,__w1_bit
	sbi  __w1_port-1,__w1_bit
	__DELAY_USW 0x780
	cbi  __w1_port-1,__w1_bit
	__DELAY_USB 0x4B
	sbis __w1_port-2,__w1_bit
	ret
	__DELAY_USW 0x130
	sbis __w1_port-2,__w1_bit
	ldi  r30,1
	__DELAY_USW 0x618
	ret

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__CPW02:
	CLR  R0
	CP   R0,R26
	CPC  R0,R27
	RET

__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

;END OF CODE MARKER
__END_OF_CODE:
