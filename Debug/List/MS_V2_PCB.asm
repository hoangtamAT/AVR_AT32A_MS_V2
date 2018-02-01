
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

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _hour=R5
	.DEF _minute=R4
	.DEF _sec=R7
	.DEF _time1=R6
	.DEF _min1=R9

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
	JMP  _timer1_ovf_isr
	JMP  0x00
	JMP  0x00
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
_humi:
	.DB  0xF,0x0,0xA,0x0,0xC8,0x62,0x90,0x44
	.DB  0x28,0xA,0x44,0x11,0x92,0x24,0xB9,0x4F
	.DB  0x7F,0x7F,0xBB,0x6F,0xFE,0x37,0x38,0xE
_heat:
	.DB  0x19,0x0,0xA,0x0,0x70,0x0,0x0,0x0
	.DB  0xFC,0x1,0x0,0x0,0xFE,0x3,0x0,0x0
	.DB  0xFE,0xFF,0xFF,0x0,0xFF,0x1F,0x49,0x1
	.DB  0xFF,0x1F,0x0,0x1,0xF6,0xFF,0xFF,0x0
	.DB  0xDE,0x3,0x0,0x0,0xFC,0x1,0x0,0x0
	.DB  0x70,0x0,0x0,0x0
_tbl10_G100:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G100:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0
_conv_delay_G102:
	.DB  0x64,0x0,0xC8,0x0,0x90,0x1,0x20,0x3
_bit_mask_G102:
	.DB  0xF8,0xFF,0xFC,0xFF,0xFE,0xFF,0xFF,0xFF
__glcd_mask:
	.DB  0x0,0x1,0x3,0x7,0xF,0x1F,0x3F,0x7F
	.DB  0xFF
_st7920_base_y_G103:
	.DB  0x80,0x90,0x88,0x98

;REGISTER BIT VARIABLES INITIALIZATION
__REG_BIT_VARS:
	.DW  0x0000

;GLOBAL REGISTER VARIABLES INITIALIZATION
__REG_VARS:
	.DB  0x0

_0x0:
	.DB  0x54,0x3A,0x25,0x32,0x2E,0x31,0x66,0x0
	.DB  0x6F,0x0,0x43,0x0,0x48,0x3A,0x25,0x32
	.DB  0x2E,0x31,0x66,0x0,0x25,0x0,0x3A,0x0
	.DB  0x3E,0x3E,0x3E,0x20,0x52,0x55,0x4E,0x4E
	.DB  0x49,0x4E,0x47,0x20,0x3C,0x3C,0x3C,0x0
	.DB  0x3E,0x3E,0x3E,0x20,0x53,0x54,0x4F,0x50
	.DB  0x50,0x45,0x44,0x20,0x3C,0x3C,0x3C,0x0
	.DB  0x2F,0x0,0x54,0x45,0x4D,0x50,0x20,0x53
	.DB  0x45,0x54,0x0,0x54,0x49,0x4D,0x45,0x20
	.DB  0x53,0x45,0x54,0x0
_0x21A0060:
	.DB  0x1
_0x21A0000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0

__GLOBAL_INI_TBL:
	.DW  0x01
	.DW  0x02
	.DW  __REG_BIT_VARS*2

	.DW  0x01
	.DW  0x09
	.DW  __REG_VARS*2

	.DW  0x01
	.DW  __seed_G10D
	.DW  _0x21A0060*2

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
;
;Chip type               : ATmega32A
;Program type            : Application
;AVR Core Clock frequency: 8.000000 MHz
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
;#include <stdio.h>
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
;// library Symbol
;#include <symbol.h>
;// DHT library
;#include <DHT.h>
;
;//Define ouput
;#define Q_N     PORTB.7
;#define MOTOR   PORTB.6
;#define VAN     PORTB.5
;#define DTN     PORTB.4
;#define Q_L     PORTB.3
;#define M_NEN   PORTB.2
;#define LAMP    PORTB.1
;#define DP      PORTB.0
;// Declare your global variables here
;unsigned char hour,minute,sec;
;eeprom unsigned char mTempSet,hourSet,minSet,tempSet;
;float temperature,humidity;
;unsigned char time1, min1=0;
;bit flagStart=0;
;
;/*******************  FUNCTION  *****************************/
;void timer1DeInit();
;void timer1Init();
;void getTime();
;void tempDisplay(unsigned char x, unsigned char y);
;void timeSettingDisplay(unsigned char x, unsigned char y);
;void tempSettingDisplay(unsigned char x, unsigned char y);
;void statusDisplay();
;void themeDisplay();
;void processOn();
;void processOff();
;/***********************************************************/
;// External Interrupt 0 service routine
;interrupt [EXT_INT0] void ext_int0_isr(void)
; 0000 0041 {

	.CSEG
_ext_int0_isr:
; .FSTART _ext_int0_isr
; 0000 0042 // Place your code here
; 0000 0043 
; 0000 0044 }
	RETI
; .FEND
;
;// Timer 1 overflow interrupt service routine (2.0972s)
;
;interrupt [TIM1_OVF] void timer1_ovf_isr(void)
; 0000 0049 {
_timer1_ovf_isr:
; .FSTART _timer1_ovf_isr
	ST   -Y,R0
	ST   -Y,R1
	ST   -Y,R15
	ST   -Y,R22
	ST   -Y,R23
	ST   -Y,R24
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 004A    tempDisplay(0,0);
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _tempDisplay
; 0000 004B    time1++;
	INC  R6
; 0000 004C    if(time1>28)
	LDI  R30,LOW(28)
	CP   R30,R6
	BRSH _0x3
; 0000 004D    {
; 0000 004E      min1++;
	INC  R9
; 0000 004F      time1=0;
	CLR  R6
; 0000 0050    }
; 0000 0051 
; 0000 0052 }
_0x3:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R25,Y+
	LD   R24,Y+
	LD   R23,Y+
	LD   R22,Y+
	LD   R15,Y+
	LD   R1,Y+
	LD   R0,Y+
	RETI
; .FEND
;
;void main(void)
; 0000 0055 {
_main:
; .FSTART _main
; 0000 0056 // Declare your local variables here
; 0000 0057 // Variable used to store graphic display
; 0000 0058 // controller initialization data
; 0000 0059 GLCDINIT_t glcd_init_data;
; 0000 005A 
; 0000 005B // Input/Output Ports initialization
; 0000 005C // Port A initialization
; 0000 005D // Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 005E DDRA=(1<<DDA7) | (1<<DDA6) | (1<<DDA5) | (1<<DDA4) | (0<<DDA3) | (0<<DDA2) | (0<<DDA1) | (0<<DDA0);
	SBIW R28,6
;	glcd_init_data -> Y+0
	LDI  R30,LOW(240)
	OUT  0x1A,R30
; 0000 005F // State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=P Bit2=T Bit1=T Bit0=T
; 0000 0060 PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (1<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);
	LDI  R30,LOW(8)
	OUT  0x1B,R30
; 0000 0061 
; 0000 0062 // Port B initialization
; 0000 0063 // Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out
; 0000 0064 DDRB=(1<<DDB7) | (1<<DDB6) | (1<<DDB5) | (1<<DDB4) | (1<<DDB3) | (1<<DDB2) | (1<<DDB1) | (1<<DDB0);
	LDI  R30,LOW(255)
	OUT  0x17,R30
; 0000 0065 // State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=0 Bit2=0 Bit1=0 Bit0=0
; 0000 0066 PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);
	LDI  R30,LOW(0)
	OUT  0x18,R30
; 0000 0067 
; 0000 0068 // Port C initialization
; 0000 0069 // Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out
; 0000 006A DDRC=(1<<DDC7) | (1<<DDC6) | (1<<DDC5) | (1<<DDC4) | (1<<DDC3) | (1<<DDC2) | (1<<DDC1) | (1<<DDC0);
	LDI  R30,LOW(255)
	OUT  0x14,R30
; 0000 006B // State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=0 Bit2=0 Bit1=0 Bit0=0
; 0000 006C PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);
	LDI  R30,LOW(0)
	OUT  0x15,R30
; 0000 006D 
; 0000 006E // Port D initialization
; 0000 006F // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0070 DDRD=(0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
	OUT  0x11,R30
; 0000 0071 // State: Bit7=T Bit6=T Bit5=P Bit4=P Bit3=P Bit2=P Bit1=P Bit0=P
; 0000 0072 PORTD=(0<<PORTD7) | (0<<PORTD6) | (1<<PORTD5) | (1<<PORTD4) | (1<<PORTD3) | (1<<PORTD2) | (1<<PORTD1) | (1<<PORTD0);
	LDI  R30,LOW(63)
	OUT  0x12,R30
; 0000 0073 // Timer/Counter 1 initialization
; 0000 0074 // Clock source: System Clock
; 0000 0075 // Clock value: 31.250 kHz
; 0000 0076 // Mode: Normal top=0xFFFF
; 0000 0077 // OC1A output: Disconnected
; 0000 0078 // OC1B output: Disconnected
; 0000 0079 // Noise Canceler: Off
; 0000 007A // Input Capture on Falling Edge
; 0000 007B // Timer Period: 2.0972 s
; 0000 007C // Timer1 Overflow Interrupt: On
; 0000 007D // Input Capture Interrupt: Off
; 0000 007E // Compare A Match Interrupt: Off
; 0000 007F // Compare B Match Interrupt: Off
; 0000 0080 TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (0<<WGM10);
	CALL SUBOPT_0x0
; 0000 0081 TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (0<<CS11) | (0<<CS10);
; 0000 0082 TCNT1H=0x00;
; 0000 0083 TCNT1L=0x00;
; 0000 0084 ICR1H=0x00;
; 0000 0085 ICR1L=0x00;
; 0000 0086 OCR1AH=0x00;
; 0000 0087 OCR1AL=0x00;
; 0000 0088 OCR1BH=0x00;
; 0000 0089 OCR1BL=0x00;
; 0000 008A 
; 0000 008B // Timer(s)/Counter(s) Interrupt(s) initialization
; 0000 008C TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (0<<TOIE1) | (0<<OCIE0) | (0<<TOIE0);
; 0000 008D 
; 0000 008E // External Interrupt(s) initialization
; 0000 008F // INT0: On
; 0000 0090 // INT0 Mode: Falling Edge
; 0000 0091 // INT1: Off
; 0000 0092 // INT2: Off
; 0000 0093 GICR|=(0<<INT1) | (1<<INT0) | (0<<INT2);
	IN   R30,0x3B
	ORI  R30,0x40
	OUT  0x3B,R30
; 0000 0094 MCUCR=(0<<ISC11) | (0<<ISC10) | (1<<ISC01) | (0<<ISC00);
	LDI  R30,LOW(2)
	OUT  0x35,R30
; 0000 0095 MCUCSR=(0<<ISC2);
	LDI  R30,LOW(0)
	OUT  0x34,R30
; 0000 0096 GIFR=(0<<INTF1) | (1<<INTF0) | (0<<INTF2);
	LDI  R30,LOW(64)
	OUT  0x3A,R30
; 0000 0097 
; 0000 0098 // Bit-Banged I2C Bus initialization
; 0000 0099 // I2C Port: PORTD
; 0000 009A // I2C SDA bit: 6
; 0000 009B // I2C SCL bit: 7
; 0000 009C // Bit Rate: 100 kHz
; 0000 009D // Note: I2C settings are specified in the
; 0000 009E // Project|Configure|C Compiler|Libraries|I2C menu.
; 0000 009F i2c_init();
	CALL _i2c_init
; 0000 00A0 
; 0000 00A1 // DS1307 Real Time Clock initialization
; 0000 00A2 // Square wave output on pin SQW/OUT: Off
; 0000 00A3 // SQW/OUT pin state: 0
; 0000 00A4 rtc_init(0,0,0);
	LDI  R30,LOW(0)
	ST   -Y,R30
	ST   -Y,R30
	LDI  R26,LOW(0)
	CALL _rtc_init
; 0000 00A5 
; 0000 00A6 // 1 Wire Bus initialization
; 0000 00A7 // 1 Wire Data port: PORTA
; 0000 00A8 // 1 Wire Data bit: 0
; 0000 00A9 // Note: 1 Wire port settings are specified in the
; 0000 00AA // Project|Configure|C Compiler|Libraries|1 Wire menu.
; 0000 00AB w1_init();
	CALL _w1_init
; 0000 00AC 
; 0000 00AD // Graphic Display Controller initialization
; 0000 00AE // The ST7920 connections are specified in the
; 0000 00AF // Project|Configure|C Compiler|Libraries|Graphic Display menu:
; 0000 00B0 // DB0 - PORTC Bit 4
; 0000 00B1 // DB1 - PORTC Bit 5
; 0000 00B2 // DB2 - PORTC Bit 6
; 0000 00B3 // DB3 - PORTC Bit 7
; 0000 00B4 // DB4 - PORTA Bit 7
; 0000 00B5 // DB5 - PORTA Bit 6
; 0000 00B6 // DB6 - PORTA Bit 5
; 0000 00B7 // DB7 - PORTA Bit 4
; 0000 00B8 // E - PORTC Bit 2
; 0000 00B9 // R /W - PORTC Bit 1
; 0000 00BA // RS - PORTC Bit 0
; 0000 00BB // /RST - PORTC Bit 3
; 0000 00BC 
; 0000 00BD // Specify the current font for displaying text
; 0000 00BE glcd_init_data.font=font5x7;
	LDI  R30,LOW(_font5x7*2)
	LDI  R31,HIGH(_font5x7*2)
	ST   Y,R30
	STD  Y+1,R31
; 0000 00BF // No function is used for reading
; 0000 00C0 // image data from external memory
; 0000 00C1 glcd_init_data.readxmem=NULL;
	LDI  R30,LOW(0)
	STD  Y+2,R30
	STD  Y+2+1,R30
; 0000 00C2 // No function is used for writing
; 0000 00C3 // image data to external memory
; 0000 00C4 glcd_init_data.writexmem=NULL;
	STD  Y+4,R30
	STD  Y+4+1,R30
; 0000 00C5 
; 0000 00C6 glcd_init(&glcd_init_data);
	MOVW R26,R28
	CALL _glcd_init
; 0000 00C7 
; 0000 00C8 // Global enable interrupts
; 0000 00C9 #asm("sei")
	sei
; 0000 00CA if(tempSet==255)
	CALL SUBOPT_0x1
	CPI  R30,LOW(0xFF)
	BRNE _0x4
; 0000 00CB {
; 0000 00CC    tempSet=30;
	LDI  R26,LOW(_tempSet)
	LDI  R27,HIGH(_tempSet)
	LDI  R30,LOW(30)
	CALL __EEPROMWRB
; 0000 00CD    hourSet=2;
	LDI  R26,LOW(_hourSet)
	LDI  R27,HIGH(_hourSet)
	LDI  R30,LOW(2)
	CALL __EEPROMWRB
; 0000 00CE    minSet=10;
	LDI  R26,LOW(_minSet)
	LDI  R27,HIGH(_minSet)
	LDI  R30,LOW(10)
	CALL __EEPROMWRB
; 0000 00CF }
; 0000 00D0 
; 0000 00D1 themeDisplay();
_0x4:
	RCALL _themeDisplay
; 0000 00D2 timeSettingDisplay(81,55);
	LDI  R30,LOW(81)
	ST   -Y,R30
	LDI  R26,LOW(55)
	RCALL _timeSettingDisplay
; 0000 00D3 tempSettingDisplay(16,55);
	LDI  R30,LOW(16)
	ST   -Y,R30
	LDI  R26,LOW(55)
	RCALL _tempSettingDisplay
; 0000 00D4 //statusDisplay();
; 0000 00D5 timer1Init();
	RCALL _timer1Init
; 0000 00D6 while (1)
_0x5:
; 0000 00D7       {
; 0000 00D8         getTime();
	RCALL _getTime
; 0000 00D9         processOn();
	RCALL _processOn
; 0000 00DA 
; 0000 00DB       }
	RJMP _0x5
; 0000 00DC }
_0x8:
	RJMP _0x8
; .FEND
;
;/******************  FUNCTION  *******************************/
;/**
;    @brief: Start timer1
;    @prama: None
;    @retval: None
;*/
;void timer1Init()
; 0000 00E5 {
_timer1Init:
; .FSTART _timer1Init
; 0000 00E6     // Timer/Counter 1 initialization
; 0000 00E7     // Clock source: System Clock
; 0000 00E8     // Clock value: 31.250 kHz
; 0000 00E9     // Mode: Normal top=0xFFFF
; 0000 00EA     // OC1A output: Disconnected
; 0000 00EB     // OC1B output: Disconnected
; 0000 00EC     // Noise Canceler: Off
; 0000 00ED     // Input Capture on Falling Edge
; 0000 00EE     // Timer Period: 2.0972 s
; 0000 00EF     // Timer1 Overflow Interrupt: On
; 0000 00F0     // Input Capture Interrupt: Off
; 0000 00F1     // Compare A Match Interrupt: Off
; 0000 00F2     // Compare B Match Interrupt: Off
; 0000 00F3     TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (0<<WGM10);
	LDI  R30,LOW(0)
	OUT  0x2F,R30
; 0000 00F4     TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (1<<CS12) | (0<<CS11) | (0<<CS10);
	LDI  R30,LOW(4)
	OUT  0x2E,R30
; 0000 00F5     TCNT1H=0x00;
	LDI  R30,LOW(0)
	OUT  0x2D,R30
; 0000 00F6     TCNT1L=0x00;
	OUT  0x2C,R30
; 0000 00F7     ICR1H=0x00;
	OUT  0x27,R30
; 0000 00F8     ICR1L=0x00;
	OUT  0x26,R30
; 0000 00F9     OCR1AH=0x00;
	OUT  0x2B,R30
; 0000 00FA     OCR1AL=0x00;
	OUT  0x2A,R30
; 0000 00FB     OCR1BH=0x00;
	OUT  0x29,R30
; 0000 00FC     OCR1BL=0x00;
	OUT  0x28,R30
; 0000 00FD     // enable interrupt timer1
; 0000 00FE     TIMSK=(1<<TOIE1);
	LDI  R30,LOW(4)
	OUT  0x39,R30
; 0000 00FF }
	RET
; .FEND
;
;/**
;    @brief: Stop timer1
;    @prama: None
;    @retval: None
;*/
;void timer1DeInit()
; 0000 0107 {
_timer1DeInit:
; .FSTART _timer1DeInit
; 0000 0108     // Timer/Counter 1 initialization
; 0000 0109     // Clock source: System Clock
; 0000 010A     // Clock value: 62.500 kHz
; 0000 010B     // Mode: Normal top=0xFFFF
; 0000 010C     // OC1A output: Disconnected
; 0000 010D     // OC1B output: Disconnected
; 0000 010E     // Noise Canceler: Off
; 0000 010F     // Input Capture on Falling Edge
; 0000 0110     // Timer Period: 1.0486 s
; 0000 0111     // Timer1 Overflow Interrupt: On
; 0000 0112     // Input Capture Interrupt: Off
; 0000 0113     // Compare A Match Interrupt: Off
; 0000 0114     // Compare B Match Interrupt: Off
; 0000 0115     TCCR1A=0;
	CALL SUBOPT_0x0
; 0000 0116     TCCR1B=0;
; 0000 0117     TCNT1H=0x00;
; 0000 0118     TCNT1L=0x00;
; 0000 0119     ICR1H=0x00;
; 0000 011A     ICR1L=0x00;
; 0000 011B     OCR1AH=0x00;
; 0000 011C     OCR1AL=0x00;
; 0000 011D     OCR1BH=0x00;
; 0000 011E     OCR1BL=0x00;
; 0000 011F     // enable interrupt timer1
; 0000 0120     TIMSK=(0<<TOIE1);
; 0000 0121     min1=0;
	CLR  R9
; 0000 0122     time1=0;
	CLR  R6
; 0000 0123 }
	RET
; .FEND
;
;
;/**
;    @brief: Get real-time from DS1307
;    @prama: None
;    @retval: None
;*/
;void getTime()
; 0000 012C {
_getTime:
; .FSTART _getTime
; 0000 012D     rtc_get_time(&hour,&minute,&sec);
	LDI  R30,LOW(5)
	LDI  R31,HIGH(5)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(7)
	LDI  R27,HIGH(7)
	CALL _rtc_get_time
; 0000 012E }
	RET
; .FEND
;
;/**
;    @brief: Display temperature & humidity on LCD 128x64
;    @prama: - x: Horizontal axis (0-127)
;            - y: Vertical axis (0-63)
;    @retval: None
;*/
;void tempDisplay(unsigned char x, unsigned char y)
; 0000 0137 {
_tempDisplay:
; .FSTART _tempDisplay
; 0000 0138     char lcdBuff[10];
; 0000 0139     float nd,nd1,da,da1;
; 0000 013A     //#asm("cli");
; 0000 013B     nd=DHT_GetTemHumi(DHT_ND);
	ST   -Y,R26
	SBIW R28,26
;	x -> Y+27
;	y -> Y+26
;	lcdBuff -> Y+16
;	nd -> Y+12
;	nd1 -> Y+8
;	da -> Y+4
;	da1 -> Y+0
	LDI  R26,LOW(2)
	CALL SUBOPT_0x2
	__PUTD1S 12
; 0000 013C     delay_ms(400);
	LDI  R26,LOW(400)
	LDI  R27,HIGH(400)
	CALL _delay_ms
; 0000 013D     nd1=DHT_GetTemHumi(DHT_ND1);
	LDI  R26,LOW(3)
	CALL SUBOPT_0x2
	__PUTD1S 8
; 0000 013E     delay_ms(200);
	LDI  R26,LOW(200)
	LDI  R27,0
	CALL _delay_ms
; 0000 013F 
; 0000 0140     da=DHT_GetTemHumi(DHT_DA);
	LDI  R26,LOW(0)
	CALL SUBOPT_0x2
	__PUTD1S 4
; 0000 0141     delay_ms(400);
	LDI  R26,LOW(400)
	LDI  R27,HIGH(400)
	CALL _delay_ms
; 0000 0142     da1=DHT_GetTemHumi(DHT_DA1);
	LDI  R26,LOW(1)
	CALL SUBOPT_0x2
	CALL __PUTD1S0
; 0000 0143     delay_ms(200);
	LDI  R26,LOW(200)
	LDI  R27,0
	CALL _delay_ms
; 0000 0144 
; 0000 0145     temperature=((nd*256)+nd1)/10;
	__GETD2S 12
	CALL SUBOPT_0x3
	__GETD2S 8
	CALL SUBOPT_0x4
	STS  _temperature,R30
	STS  _temperature+1,R31
	STS  _temperature+2,R22
	STS  _temperature+3,R23
; 0000 0146     humidity=((da*256)+da1)/10;
	__GETD2S 4
	CALL SUBOPT_0x3
	CALL __GETD2S0
	CALL SUBOPT_0x4
	STS  _humidity,R30
	STS  _humidity+1,R31
	STS  _humidity+2,R22
	STS  _humidity+3,R23
; 0000 0147     //#asm("sei");
; 0000 0148     sprintf(lcdBuff,"T:%2.1f",temperature);
	MOVW R30,R28
	ADIW R30,16
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0x0,0
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x5
	CALL SUBOPT_0x6
; 0000 0149     glcd_outtextxy(x,y+3,lcdBuff);
	SUBI R30,-LOW(3)
	CALL SUBOPT_0x7
; 0000 014A     glcd_outtextxyf(x+25,y,"o");
	ST   -Y,R30
	__POINTW2FN _0x0,8
	CALL _glcd_outtextxyf
; 0000 014B     glcd_outtextxyf(x+32,y+3,"C");
	LDD  R30,Y+27
	SUBI R30,-LOW(32)
	ST   -Y,R30
	LDD  R30,Y+27
	SUBI R30,-LOW(3)
	ST   -Y,R30
	__POINTW2FN _0x0,10
	CALL _glcd_outtextxyf
; 0000 014C 
; 0000 014D     sprintf(lcdBuff,"H:%2.1f",humidity);
	MOVW R30,R28
	ADIW R30,16
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0x0,12
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_humidity
	LDS  R31,_humidity+1
	LDS  R22,_humidity+2
	LDS  R23,_humidity+3
	CALL SUBOPT_0x6
; 0000 014E     glcd_outtextxy(x,y+13,lcdBuff);
	SUBI R30,-LOW(13)
	CALL SUBOPT_0x7
; 0000 014F     glcd_outtextxyf(x+25,y+13,"%");
	SUBI R30,-LOW(13)
	ST   -Y,R30
	__POINTW2FN _0x0,20
	CALL _glcd_outtextxyf
; 0000 0150 }
	ADIW R28,28
	RET
; .FEND
;
;/**
;    @brief: Display time run setting on LCD 128x64
;    @prama: - x: Horizontal axis (0-127)
;            - y: Vertical axis (0-63)
;    @retval: None
;*/
;void timeSettingDisplay(unsigned char x, unsigned char y)
; 0000 0159 {
_timeSettingDisplay:
; .FSTART _timeSettingDisplay
; 0000 015A      glcd_putcharxy(x,y,48+hourSet/10);
	ST   -Y,R26
;	x -> Y+1
;	y -> Y+0
	LDD  R30,Y+1
	ST   -Y,R30
	LDD  R30,Y+1
	ST   -Y,R30
	CALL SUBOPT_0x8
	CALL SUBOPT_0x9
	CALL _glcd_putcharxy
; 0000 015B      glcd_putchar(48+hourSet%10);
	CALL SUBOPT_0x8
	CALL SUBOPT_0xA
; 0000 015C      glcd_outtextf(":");
	__POINTW2FN _0x0,22
	CALL _glcd_outtextf
; 0000 015D      glcd_putchar(48+minSet/10);
	CALL SUBOPT_0xB
	CALL SUBOPT_0x9
	CALL _glcd_putchar
; 0000 015E      glcd_putchar(48+minSet%10);
	CALL SUBOPT_0xB
	CALL SUBOPT_0xA
; 0000 015F }
	JMP  _0x21C000B
; .FEND
;
;/**
;    @brief: Display temperature control setting on LCD 128x64
;    @prama: - x: Horizontal axis (0-127)
;            - y: Vertical axis (0-63)
;    @retval: None
;*/
;void tempSettingDisplay(unsigned char x, unsigned char y)
; 0000 0168 {
_tempSettingDisplay:
; .FSTART _tempSettingDisplay
; 0000 0169       glcd_putcharxy(x,y,48+tempSet/10);
	ST   -Y,R26
;	x -> Y+1
;	y -> Y+0
	LDD  R30,Y+1
	ST   -Y,R30
	LDD  R30,Y+1
	ST   -Y,R30
	CALL SUBOPT_0x1
	LDI  R31,0
	MOVW R26,R30
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL SUBOPT_0x9
	CALL _glcd_putcharxy
; 0000 016A       glcd_putchar(48+tempSet%10);
	CALL SUBOPT_0x1
	LDI  R31,0
	MOVW R26,R30
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL SUBOPT_0xA
; 0000 016B       glcd_outtextxyf(x+13,y-4,"o");
	LDD  R30,Y+1
	SUBI R30,-LOW(13)
	ST   -Y,R30
	LDD  R30,Y+1
	SUBI R30,LOW(4)
	ST   -Y,R30
	__POINTW2FN _0x0,8
	CALL _glcd_outtextxyf
; 0000 016C       glcd_outtextxyf(x+20,y,"C");
	LDD  R30,Y+1
	SUBI R30,-LOW(20)
	ST   -Y,R30
	LDD  R30,Y+1
	ST   -Y,R30
	__POINTW2FN _0x0,10
	CALL _glcd_outtextxyf
; 0000 016D }
	JMP  _0x21C000B
; .FEND
;
;/**
;    @brief: Display status device (stop/running), Progress complete(%) on LCD 128x64
;    @prama: - x: Horizontal axis (0-127)
;            - y: Vertical axis (0-63)
;    @retval: None
;*/
;void statusDisplay()
; 0000 0176 {    unsigned int setPercent, runPercent,percent;
; 0000 0177 
; 0000 0178      setPercent = hourSet*60 + minSet;
;	setPercent -> R16,R17
;	runPercent -> R18,R19
;	percent -> R20,R21
; 0000 0179      runPercent = hour*60 + minute;
; 0000 017A      percent = (runPercent*100)/setPercent;
; 0000 017B 
; 0000 017C      if(flagStart) glcd_outtextxyf(5,23,">>> RUNNING <<<");
; 0000 017D      else glcd_outtextxyf(20,23,">>> STOPPED <<<");
; 0000 017E 
; 0000 017F      glcd_putcharxy(15,33,48+hour/10);
; 0000 0180      glcd_putchar(48+hour%10);
; 0000 0181      glcd_outtextf(":");
; 0000 0182      glcd_putchar(48+minute/10);
; 0000 0183      glcd_putchar(48+minute%10);
; 0000 0184 
; 0000 0185      glcd_outtextf("/");
; 0000 0186 
; 0000 0187      glcd_putchar(48+hourSet/10);
; 0000 0188      glcd_putchar(48+hourSet%10);
; 0000 0189      glcd_outtextf(":");
; 0000 018A      glcd_putchar(48+minSet/10);
; 0000 018B      glcd_putchar(48+minSet%10);
; 0000 018C 
; 0000 018D      glcd_putcharxy(110,33,48+percent/10);
; 0000 018E      glcd_putchar(48+percent%10);
; 0000 018F      glcd_outtextf("%");
; 0000 0190 }
;
;/**
;    @brief: Process turn ON device sequence by setting
;    @prama: tempSet: Temperature setting for control heating at this temperature
;    @retval: None
;*/
;void processOn()
; 0000 0198 {
_processOn:
; .FSTART _processOn
	PUSH R15
; 0000 0199     int i;
; 0000 019A     bit flagTime=0;
; 0000 019B     Q_N=1;
	ST   -Y,R17
	ST   -Y,R16
;	i -> R16,R17
;	flagTime -> R15.0
	CLR  R15
	SBI  0x18,7
; 0000 019C     MOTOR=1;
	SBI  0x18,6
; 0000 019D     timer1Init();
	RCALL _timer1Init
; 0000 019E     while(min1==0);
_0xF:
	TST  R9
	BREQ _0xF
; 0000 019F     if(min1==1){
	LDI  R30,LOW(1)
	CP   R30,R9
	BRNE _0x12
; 0000 01A0        Q_L=1;
	SBI  0x18,3
; 0000 01A1        M_NEN=1;
	SBI  0x18,2
; 0000 01A2     }
; 0000 01A3     if(min1==2){
_0x12:
	LDI  R30,LOW(2)
	CP   R30,R9
	BRNE _0x17
; 0000 01A4        VAN=1;
	SBI  0x18,5
; 0000 01A5        DTN=1;
	SBI  0x18,4
; 0000 01A6        flagTime=1;
	SET
	BLD  R15,0
; 0000 01A7        timer1DeInit();
	RCALL _timer1DeInit
; 0000 01A8     }
; 0000 01A9     while(flagTime){
_0x17:
_0x1C:
	SBRS R15,0
	RJMP _0x1E
; 0000 01AA        while((int)temperature > (tempSet-5) && (int)temperature<tempSet)
_0x1F:
	CALL SUBOPT_0xC
	LDI  R31,0
	SBIW R30,5
	CP   R30,R0
	CPC  R31,R1
	BRGE _0x22
	CALL SUBOPT_0xC
	MOVW R26,R0
	LDI  R31,0
	CP   R26,R30
	CPC  R27,R31
	BRLT _0x23
_0x22:
	RJMP _0x21
_0x23:
; 0000 01AB        {
; 0000 01AC         DTN=0;
	CBI  0x18,4
; 0000 01AD         delay_ms(500);
	LDI  R26,LOW(500)
	LDI  R27,HIGH(500)
	CALL _delay_ms
; 0000 01AE         if((int)temperature > tempSet) break;
	CALL SUBOPT_0xC
	MOVW R26,R0
	LDI  R31,0
	CP   R30,R26
	CPC  R31,R27
	BRLT _0x21
; 0000 01AF         else{
; 0000 01B0             DTN=1;
	SBI  0x18,4
; 0000 01B1             delay_ms(500);
	LDI  R26,LOW(500)
	LDI  R27,HIGH(500)
	CALL _delay_ms
; 0000 01B2         }
; 0000 01B3        }
	RJMP _0x1F
_0x21:
; 0000 01B4        if(temperature>tempSet) DTN=0;
	CALL SUBOPT_0x1
	LDS  R26,_temperature
	LDS  R27,_temperature+1
	LDS  R24,_temperature+2
	LDS  R25,_temperature+3
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __CDF1
	CALL __CMPF12
	BREQ PC+2
	BRCC PC+2
	RJMP _0x2A
	CBI  0x18,4
; 0000 01B5     }
_0x2A:
	RJMP _0x1C
_0x1E:
; 0000 01B6 
; 0000 01B7     /*when temp set > temp created by the compressor. this case,
; 0000 01B8      the compressor is always turn ON, this time just control heat resistance.
; 0000 01B9     */
; 0000 01BA     if(tempSet>mTempSet){
	CALL SUBOPT_0x1
	MOV  R0,R30
	LDI  R26,LOW(_mTempSet)
	LDI  R27,HIGH(_mTempSet)
	CALL __EEPROMRDB
	CP   R30,R0
	BRSH _0x2D
; 0000 01BB 
; 0000 01BC        if(minute>=1){
	LDI  R30,LOW(1)
	CP   R4,R30
	BRLO _0x2E
; 0000 01BD           Q_L=1;
	SBI  0x18,3
; 0000 01BE           M_NEN=1;
	SBI  0x18,2
; 0000 01BF           if(minute>=2){
	LDI  R30,LOW(2)
	CP   R4,R30
	BRLO _0x33
; 0000 01C0             VAN=1;
	SBI  0x18,5
; 0000 01C1             DTN=1;
	SBI  0x18,4
; 0000 01C2           }
; 0000 01C3        }
_0x33:
; 0000 01C4     }
_0x2E:
; 0000 01C5     /*when temp set < temp created by the compressor. this case,
; 0000 01C6      the heat resistance is always turn OFF, this time just control the compressor.
; 0000 01C7     */
; 0000 01C8     else{
	RJMP _0x38
_0x2D:
; 0000 01C9        DTN=0;
	CBI  0x18,4
; 0000 01CA        if(minute>=1){
	LDI  R30,LOW(1)
	CP   R4,R30
	BRLO _0x3B
; 0000 01CB             Q_L=1;
	SBI  0x18,3
; 0000 01CC             M_NEN=1;
	SBI  0x18,2
; 0000 01CD             if(minute>=2){
	LDI  R30,LOW(2)
	CP   R4,R30
	BRLO _0x40
; 0000 01CE             VAN=1;
	SBI  0x18,5
; 0000 01CF           }
; 0000 01D0        }
_0x40:
; 0000 01D1     }
_0x3B:
_0x38:
; 0000 01D2 }
	LD   R16,Y+
	LD   R17,Y+
	POP  R15
	RET
; .FEND
;
;/**
;    @brief: Process turn OFF device sequence by setting
;    @prama:
;    @retval: None
;*/
;void processOff()
; 0000 01DA {
; 0000 01DB 
; 0000 01DC }
;
;/**
;    @brief: Display theme on all main screen
;    @prama:None
;    @retval: None
;*/
;void themeDisplay()
; 0000 01E4 {
_themeDisplay:
; .FSTART _themeDisplay
; 0000 01E5     glcd_line(0,20,127,20);
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R30,LOW(20)
	ST   -Y,R30
	LDI  R30,LOW(127)
	ST   -Y,R30
	LDI  R26,LOW(20)
	CALL _glcd_line
; 0000 01E6     glcd_line(0,41,127,41);
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R30,LOW(41)
	ST   -Y,R30
	LDI  R30,LOW(127)
	ST   -Y,R30
	LDI  R26,LOW(41)
	CALL _glcd_line
; 0000 01E7     glcd_line(62,41,62,63);
	LDI  R30,LOW(62)
	ST   -Y,R30
	LDI  R30,LOW(41)
	ST   -Y,R30
	LDI  R30,LOW(62)
	ST   -Y,R30
	LDI  R26,LOW(63)
	CALL _glcd_line
; 0000 01E8     glcd_line(64,41,64,63);
	LDI  R30,LOW(64)
	ST   -Y,R30
	LDI  R30,LOW(41)
	ST   -Y,R30
	LDI  R30,LOW(64)
	ST   -Y,R30
	LDI  R26,LOW(63)
	CALL _glcd_line
; 0000 01E9 
; 0000 01EA     glcd_line(62,3,62,16);
	LDI  R30,LOW(62)
	ST   -Y,R30
	LDI  R30,LOW(3)
	ST   -Y,R30
	LDI  R30,LOW(62)
	ST   -Y,R30
	LDI  R26,LOW(16)
	CALL _glcd_line
; 0000 01EB     glcd_line(64,3,64,16);
	LDI  R30,LOW(64)
	ST   -Y,R30
	LDI  R30,LOW(3)
	ST   -Y,R30
	LDI  R30,LOW(64)
	ST   -Y,R30
	LDI  R26,LOW(16)
	CALL _glcd_line
; 0000 01EC 
; 0000 01ED     glcd_outtextxyf(7,43,"TEMP SET");
	LDI  R30,LOW(7)
	ST   -Y,R30
	LDI  R30,LOW(43)
	ST   -Y,R30
	__POINTW2FN _0x0,58
	CALL _glcd_outtextxyf
; 0000 01EE     glcd_outtextxyf(72,43,"TIME SET");
	LDI  R30,LOW(72)
	ST   -Y,R30
	LDI  R30,LOW(43)
	ST   -Y,R30
	__POINTW2FN _0x0,67
	CALL _glcd_outtextxyf
; 0000 01EF     glcd_putimagef(8,6,heat,GLCD_PUTCOPY);
	LDI  R30,LOW(8)
	ST   -Y,R30
	LDI  R30,LOW(6)
	ST   -Y,R30
	LDI  R30,LOW(_heat*2)
	LDI  R31,HIGH(_heat*2)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(0)
	CALL _glcd_putimagef
; 0000 01F0     glcd_putimagef(75,6,humi,GLCD_PUTCOPY);
	LDI  R30,LOW(75)
	ST   -Y,R30
	LDI  R30,LOW(6)
	ST   -Y,R30
	LDI  R30,LOW(_humi*2)
	LDI  R31,HIGH(_humi*2)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(0)
	CALL _glcd_putimagef
; 0000 01F1 }
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
_put_buff_G100:
; .FSTART _put_buff_G100
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,2
	CALL __GETW1P
	SBIW R30,0
	BREQ _0x2000010
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,4
	CALL __GETW1P
	MOVW R16,R30
	SBIW R30,0
	BREQ _0x2000012
	__CPWRN 16,17,2
	BRLO _0x2000013
	MOVW R30,R16
	SBIW R30,1
	MOVW R16,R30
	__PUTW1SNS 2,4
_0x2000012:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,2
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	SBIW R30,1
	LDD  R26,Y+4
	STD  Z+0,R26
_0x2000013:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	CALL __GETW1P
	TST  R31
	BRMI _0x2000014
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
_0x2000014:
	RJMP _0x2000015
_0x2000010:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	ST   X+,R30
	ST   X,R31
_0x2000015:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,5
	RET
; .FEND
__print_G100:
; .FSTART __print_G100
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,6
	CALL __SAVELOCR6
	LDI  R17,0
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   X+,R30
	ST   X,R31
_0x2000016:
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	ADIW R30,1
	STD  Y+18,R30
	STD  Y+18+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R18,R30
	CPI  R30,0
	BRNE PC+2
	RJMP _0x2000018
	MOV  R30,R17
	CPI  R30,0
	BRNE _0x200001C
	CPI  R18,37
	BRNE _0x200001D
	LDI  R17,LOW(1)
	RJMP _0x200001E
_0x200001D:
	CALL SUBOPT_0xD
_0x200001E:
	RJMP _0x200001B
_0x200001C:
	CPI  R30,LOW(0x1)
	BRNE _0x200001F
	CPI  R18,37
	BRNE _0x2000020
	CALL SUBOPT_0xD
	RJMP _0x20000CC
_0x2000020:
	LDI  R17,LOW(2)
	LDI  R20,LOW(0)
	LDI  R16,LOW(0)
	CPI  R18,45
	BRNE _0x2000021
	LDI  R16,LOW(1)
	RJMP _0x200001B
_0x2000021:
	CPI  R18,43
	BRNE _0x2000022
	LDI  R20,LOW(43)
	RJMP _0x200001B
_0x2000022:
	CPI  R18,32
	BRNE _0x2000023
	LDI  R20,LOW(32)
	RJMP _0x200001B
_0x2000023:
	RJMP _0x2000024
_0x200001F:
	CPI  R30,LOW(0x2)
	BRNE _0x2000025
_0x2000024:
	LDI  R21,LOW(0)
	LDI  R17,LOW(3)
	CPI  R18,48
	BRNE _0x2000026
	ORI  R16,LOW(128)
	RJMP _0x200001B
_0x2000026:
	RJMP _0x2000027
_0x2000025:
	CPI  R30,LOW(0x3)
	BREQ PC+2
	RJMP _0x200001B
_0x2000027:
	CPI  R18,48
	BRLO _0x200002A
	CPI  R18,58
	BRLO _0x200002B
_0x200002A:
	RJMP _0x2000029
_0x200002B:
	LDI  R26,LOW(10)
	MUL  R21,R26
	MOV  R21,R0
	MOV  R30,R18
	SUBI R30,LOW(48)
	ADD  R21,R30
	RJMP _0x200001B
_0x2000029:
	MOV  R30,R18
	CPI  R30,LOW(0x63)
	BRNE _0x200002F
	CALL SUBOPT_0xE
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	LDD  R26,Z+4
	ST   -Y,R26
	CALL SUBOPT_0xF
	RJMP _0x2000030
_0x200002F:
	CPI  R30,LOW(0x73)
	BRNE _0x2000032
	CALL SUBOPT_0xE
	CALL SUBOPT_0x10
	CALL _strlen
	MOV  R17,R30
	RJMP _0x2000033
_0x2000032:
	CPI  R30,LOW(0x70)
	BRNE _0x2000035
	CALL SUBOPT_0xE
	CALL SUBOPT_0x10
	CALL _strlenf
	MOV  R17,R30
	ORI  R16,LOW(8)
_0x2000033:
	ORI  R16,LOW(2)
	ANDI R16,LOW(127)
	LDI  R19,LOW(0)
	RJMP _0x2000036
_0x2000035:
	CPI  R30,LOW(0x64)
	BREQ _0x2000039
	CPI  R30,LOW(0x69)
	BRNE _0x200003A
_0x2000039:
	ORI  R16,LOW(4)
	RJMP _0x200003B
_0x200003A:
	CPI  R30,LOW(0x75)
	BRNE _0x200003C
_0x200003B:
	LDI  R30,LOW(_tbl10_G100*2)
	LDI  R31,HIGH(_tbl10_G100*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(5)
	RJMP _0x200003D
_0x200003C:
	CPI  R30,LOW(0x58)
	BRNE _0x200003F
	ORI  R16,LOW(8)
	RJMP _0x2000040
_0x200003F:
	CPI  R30,LOW(0x78)
	BREQ PC+2
	RJMP _0x2000071
_0x2000040:
	LDI  R30,LOW(_tbl16_G100*2)
	LDI  R31,HIGH(_tbl16_G100*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(4)
_0x200003D:
	SBRS R16,2
	RJMP _0x2000042
	CALL SUBOPT_0xE
	CALL SUBOPT_0x11
	LDD  R26,Y+11
	TST  R26
	BRPL _0x2000043
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	CALL __ANEGW1
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDI  R20,LOW(45)
_0x2000043:
	CPI  R20,0
	BREQ _0x2000044
	SUBI R17,-LOW(1)
	RJMP _0x2000045
_0x2000044:
	ANDI R16,LOW(251)
_0x2000045:
	RJMP _0x2000046
_0x2000042:
	CALL SUBOPT_0xE
	CALL SUBOPT_0x11
_0x2000046:
_0x2000036:
	SBRC R16,0
	RJMP _0x2000047
_0x2000048:
	CP   R17,R21
	BRSH _0x200004A
	SBRS R16,7
	RJMP _0x200004B
	SBRS R16,2
	RJMP _0x200004C
	ANDI R16,LOW(251)
	MOV  R18,R20
	SUBI R17,LOW(1)
	RJMP _0x200004D
_0x200004C:
	LDI  R18,LOW(48)
_0x200004D:
	RJMP _0x200004E
_0x200004B:
	LDI  R18,LOW(32)
_0x200004E:
	CALL SUBOPT_0xD
	SUBI R21,LOW(1)
	RJMP _0x2000048
_0x200004A:
_0x2000047:
	MOV  R19,R17
	SBRS R16,1
	RJMP _0x200004F
_0x2000050:
	CPI  R19,0
	BREQ _0x2000052
	SBRS R16,3
	RJMP _0x2000053
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LPM  R18,Z+
	STD  Y+6,R30
	STD  Y+6+1,R31
	RJMP _0x2000054
_0x2000053:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R18,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
_0x2000054:
	CALL SUBOPT_0xD
	CPI  R21,0
	BREQ _0x2000055
	SUBI R21,LOW(1)
_0x2000055:
	SUBI R19,LOW(1)
	RJMP _0x2000050
_0x2000052:
	RJMP _0x2000056
_0x200004F:
_0x2000058:
	LDI  R18,LOW(48)
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CALL __GETW1PF
	STD  Y+8,R30
	STD  Y+8+1,R31
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,2
	STD  Y+6,R30
	STD  Y+6+1,R31
_0x200005A:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x200005C
	SUBI R18,-LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+10,R30
	STD  Y+10+1,R31
	RJMP _0x200005A
_0x200005C:
	CPI  R18,58
	BRLO _0x200005D
	SBRS R16,3
	RJMP _0x200005E
	SUBI R18,-LOW(7)
	RJMP _0x200005F
_0x200005E:
	SUBI R18,-LOW(39)
_0x200005F:
_0x200005D:
	SBRC R16,4
	RJMP _0x2000061
	CPI  R18,49
	BRSH _0x2000063
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,1
	BRNE _0x2000062
_0x2000063:
	RJMP _0x20000CD
_0x2000062:
	CP   R21,R19
	BRLO _0x2000067
	SBRS R16,0
	RJMP _0x2000068
_0x2000067:
	RJMP _0x2000066
_0x2000068:
	LDI  R18,LOW(32)
	SBRS R16,7
	RJMP _0x2000069
	LDI  R18,LOW(48)
_0x20000CD:
	ORI  R16,LOW(16)
	SBRS R16,2
	RJMP _0x200006A
	ANDI R16,LOW(251)
	ST   -Y,R20
	CALL SUBOPT_0xF
	CPI  R21,0
	BREQ _0x200006B
	SUBI R21,LOW(1)
_0x200006B:
_0x200006A:
_0x2000069:
_0x2000061:
	CALL SUBOPT_0xD
	CPI  R21,0
	BREQ _0x200006C
	SUBI R21,LOW(1)
_0x200006C:
_0x2000066:
	SUBI R19,LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,2
	BRLO _0x2000059
	RJMP _0x2000058
_0x2000059:
_0x2000056:
	SBRS R16,0
	RJMP _0x200006D
_0x200006E:
	CPI  R21,0
	BREQ _0x2000070
	SUBI R21,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	CALL SUBOPT_0xF
	RJMP _0x200006E
_0x2000070:
_0x200006D:
_0x2000071:
_0x2000030:
_0x20000CC:
	LDI  R17,LOW(0)
_0x200001B:
	RJMP _0x2000016
_0x2000018:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	CALL __GETW1P
	CALL __LOADLOCR6
	ADIW R28,20
	RET
; .FEND
_sprintf:
; .FSTART _sprintf
	PUSH R15
	MOV  R15,R24
	SBIW R28,6
	CALL __SAVELOCR4
	CALL SUBOPT_0x12
	SBIW R30,0
	BRNE _0x2000072
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x21C000D
_0x2000072:
	MOVW R26,R28
	ADIW R26,6
	CALL __ADDW2R15
	MOVW R16,R26
	CALL SUBOPT_0x12
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R30,LOW(0)
	STD  Y+8,R30
	STD  Y+8+1,R30
	MOVW R26,R28
	ADIW R26,10
	CALL __ADDW2R15
	CALL __GETW1P
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(_put_buff_G100)
	LDI  R31,HIGH(_put_buff_G100)
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R28
	ADIW R26,10
	RCALL __print_G100
	MOVW R18,R30
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(0)
	ST   X,R30
	MOVW R30,R18
_0x21C000D:
	CALL __LOADLOCR4
	ADIW R28,10
	POP  R15
	RET
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
	BREQ _0x2020003
	LDD  R30,Y+2
	ORI  R30,0x10
	STD  Y+2,R30
_0x2020003:
	LD   R30,Y
	CPI  R30,0
	BREQ _0x2020004
	LDD  R30,Y+2
	ORI  R30,0x80
	STD  Y+2,R30
_0x2020004:
	CALL _i2c_start
	LDI  R26,LOW(208)
	CALL _i2c_write
	LDI  R26,LOW(7)
	CALL _i2c_write
	LDD  R26,Y+2
	CALL _i2c_write
	CALL _i2c_stop
	RJMP _0x21C000A
; .FEND
_rtc_get_time:
; .FSTART _rtc_get_time
	ST   -Y,R27
	ST   -Y,R26
	CALL _i2c_start
	LDI  R26,LOW(208)
	CALL _i2c_write
	LDI  R26,LOW(0)
	CALL _i2c_write
	CALL _i2c_stop
	CALL _i2c_start
	LDI  R26,LOW(209)
	CALL _i2c_write
	CALL SUBOPT_0x13
	LD   R26,Y
	LDD  R27,Y+1
	ST   X,R30
	CALL SUBOPT_0x13
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ST   X,R30
	LDI  R26,LOW(0)
	CALL _i2c_read
	MOV  R26,R30
	CALL _bcd2bin
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ST   X,R30
	CALL _i2c_stop
	JMP  _0x21C0009
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
_st7920_delay_G103:
; .FSTART _st7920_delay_G103
    nop
    nop
    nop
	RET
; .FEND
_st7920_wrbus_G103:
; .FSTART _st7920_wrbus_G103
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
	BREQ _0x2060003
	SBI  0x15,4
	RJMP _0x2060004
_0x2060003:
	CBI  0x15,4
_0x2060004:
	LD   R30,Y
	ANDI R30,LOW(0x2)
	BREQ _0x2060005
	SBI  0x15,5
	RJMP _0x2060006
_0x2060005:
	CBI  0x15,5
_0x2060006:
	LD   R30,Y
	ANDI R30,LOW(0x4)
	BREQ _0x2060007
	SBI  0x15,6
	RJMP _0x2060008
_0x2060007:
	CBI  0x15,6
_0x2060008:
	LD   R30,Y
	ANDI R30,LOW(0x8)
	BREQ _0x2060009
	SBI  0x15,7
	RJMP _0x206000A
_0x2060009:
	CBI  0x15,7
_0x206000A:
	LD   R30,Y
	ANDI R30,LOW(0x10)
	BREQ _0x206000B
	SBI  0x1B,7
	RJMP _0x206000C
_0x206000B:
	CBI  0x1B,7
_0x206000C:
	LD   R30,Y
	ANDI R30,LOW(0x20)
	BREQ _0x206000D
	SBI  0x1B,6
	RJMP _0x206000E
_0x206000D:
	CBI  0x1B,6
_0x206000E:
	LD   R30,Y
	ANDI R30,LOW(0x40)
	BREQ _0x206000F
	SBI  0x1B,5
	RJMP _0x2060010
_0x206000F:
	CBI  0x1B,5
_0x2060010:
	LD   R30,Y
	ANDI R30,LOW(0x80)
	BREQ _0x2060011
	SBI  0x1B,4
	RJMP _0x2060012
_0x2060011:
	CBI  0x1B,4
_0x2060012:
	RCALL _st7920_delay_G103
	CBI  0x15,2
	RJMP _0x21C000C
; .FEND
_st7920_rdbus_G103:
; .FSTART _st7920_rdbus_G103
	ST   -Y,R17
	CALL SUBOPT_0x14
	LDI  R17,LOW(0)
	SBIC 0x13,4
	LDI  R17,LOW(1)
	SBIC 0x13,5
	ORI  R17,LOW(2)
	SBIC 0x13,6
	ORI  R17,LOW(4)
	SBIC 0x13,7
	ORI  R17,LOW(8)
	SBIC 0x19,7
	ORI  R17,LOW(16)
	SBIC 0x19,6
	ORI  R17,LOW(32)
	SBIC 0x19,5
	ORI  R17,LOW(64)
	SBIC 0x19,4
	ORI  R17,LOW(128)
	CBI  0x15,2
	MOV  R30,R17
	LD   R17,Y+
	RET
; .FEND
_st7920_busy_G103:
; .FSTART _st7920_busy_G103
	CBI  0x15,0
	CALL SUBOPT_0x14
_0x206001B:
	SBIC 0x19,4
	RJMP _0x206001B
	CBI  0x15,2
	__DELAY_USB 5
	RET
; .FEND
_st7920_wrdata:
; .FSTART _st7920_wrdata
	ST   -Y,R26
	RCALL _st7920_busy_G103
	SBI  0x15,0
	LD   R26,Y
	RCALL _st7920_wrbus_G103
	RJMP _0x21C000C
; .FEND
_st7920_rddata:
; .FSTART _st7920_rddata
	RCALL _st7920_busy_G103
	SBI  0x15,0
	RCALL _st7920_rdbus_G103
	RET
; .FEND
_st7920_wrcmd:
; .FSTART _st7920_wrcmd
	ST   -Y,R26
	RCALL _st7920_busy_G103
	LD   R26,Y
	RCALL _st7920_wrbus_G103
	RJMP _0x21C000C
; .FEND
_st7920_setxy_G103:
; .FSTART _st7920_setxy_G103
	ST   -Y,R26
	LD   R30,Y
	ANDI R30,LOW(0x1F)
	ORI  R30,0x80
	MOV  R26,R30
	RCALL _st7920_wrcmd
	LD   R26,Y
	CPI  R26,LOW(0x20)
	BRLO _0x206001E
	LDD  R30,Y+1
	ORI  R30,0x80
	STD  Y+1,R30
_0x206001E:
	LDD  R30,Y+1
	SWAP R30
	ANDI R30,0xF
	ORI  R30,0x80
	MOV  R26,R30
	RCALL _st7920_wrcmd
	RJMP _0x21C000B
; .FEND
_glcd_display:
; .FSTART _glcd_display
	ST   -Y,R26
	CALL SUBOPT_0x15
	LD   R30,Y
	CPI  R30,0
	BREQ _0x206001F
	LDI  R30,LOW(12)
	RJMP _0x2060020
_0x206001F:
	LDI  R30,LOW(8)
_0x2060020:
	MOV  R26,R30
	RCALL _st7920_wrcmd
	LD   R30,Y
	CPI  R30,0
	BREQ _0x2060022
	LDI  R30,LOW(2)
	RJMP _0x2060023
_0x2060022:
	LDI  R30,LOW(0)
_0x2060023:
	STS  _st7920_graphics_on_G103,R30
	CALL SUBOPT_0x15
	CALL SUBOPT_0x16
_0x21C000C:
	ADIW R28,1
	RET
; .FEND
_glcd_cleargraphics:
; .FSTART _glcd_cleargraphics
	CALL __SAVELOCR4
	LDI  R19,0
	__GETB1MN _glcd_state,1
	CPI  R30,0
	BREQ _0x2060025
	LDI  R19,LOW(255)
_0x2060025:
	CALL SUBOPT_0x16
	LDI  R16,LOW(0)
_0x2060026:
	CPI  R16,64
	BRSH _0x2060028
	LDI  R30,LOW(0)
	ST   -Y,R30
	MOV  R26,R16
	SUBI R16,-1
	RCALL _st7920_setxy_G103
	LDI  R17,LOW(16)
_0x2060029:
	MOV  R30,R17
	SUBI R17,1
	CPI  R30,0
	BREQ _0x206002B
	MOV  R26,R19
	RCALL _st7920_wrdata
	RJMP _0x2060029
_0x206002B:
	RJMP _0x2060026
_0x2060028:
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
	CALL SUBOPT_0x17
	CALL SUBOPT_0x17
	LDI  R26,LOW(8)
	RCALL _st7920_wrbus_G103
	__DELAY_USW 800
	LDI  R26,LOW(1)
	RCALL _st7920_wrcmd
	LDI  R26,LOW(15)
	LDI  R27,0
	CALL _delay_ms
	LDI  R30,LOW(0)
	STS  _yt_G103,R30
	STS  _xt_G103,R30
	LDI  R26,LOW(6)
	RCALL _st7920_wrcmd
	LDI  R26,LOW(52)
	RCALL _st7920_wrcmd
	LDI  R26,LOW(64)
	RCALL _st7920_wrcmd
	LDI  R26,LOW(2)
	RCALL _st7920_wrcmd
	LDI  R30,LOW(0)
	STS  _st7920_graphics_on_G103,R30
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
	BREQ _0x206002C
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
	RJMP _0x20600BB
_0x206002C:
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	__PUTW1MN _glcd_state,4
	__PUTW1MN _glcd_state,25
_0x20600BB:
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
	RJMP _0x21C000B
; .FEND
_st7920_rdbyte_G103:
; .FSTART _st7920_rdbyte_G103
	ST   -Y,R26
	LDD  R30,Y+1
	ST   -Y,R30
	LDD  R26,Y+1
	RCALL _st7920_setxy_G103
	RCALL _st7920_rddata
	LDD  R30,Y+1
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0x8)
	BRLO _0x206002E
	RCALL _st7920_rddata
	STS  _st7920_bits8_15_G103,R30
_0x206002E:
	RCALL _st7920_rddata
_0x21C000B:
	ADIW R28,2
	RET
; .FEND
_st7920_wrbyte_G103:
; .FSTART _st7920_wrbyte_G103
	ST   -Y,R26
	LDD  R30,Y+2
	ST   -Y,R30
	LDD  R26,Y+2
	RCALL _st7920_setxy_G103
	LDD  R30,Y+2
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0x8)
	BRLO _0x206002F
	LDS  R26,_st7920_bits8_15_G103
	RCALL _st7920_wrdata
_0x206002F:
	LD   R26,Y
	RCALL _st7920_wrdata
_0x21C000A:
	ADIW R28,3
	RET
; .FEND
_glcd_putpixel:
; .FSTART _glcd_putpixel
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
	LDD  R26,Y+4
	CPI  R26,LOW(0x80)
	BRSH _0x2060031
	LDD  R26,Y+3
	CPI  R26,LOW(0x40)
	BRLO _0x2060030
_0x2060031:
	LDD  R17,Y+1
	LDD  R16,Y+0
	JMP  _0x21C0003
_0x2060030:
	CALL SUBOPT_0x16
	LDD  R30,Y+4
	ST   -Y,R30
	LDD  R26,Y+4
	RCALL _st7920_rdbyte_G103
	MOV  R17,R30
	LDD  R30,Y+4
	ANDI R30,LOW(0x7)
	LDI  R26,LOW(7)
	CALL __SWAPB12
	SUB  R30,R26
	LDI  R26,LOW(1)
	CALL __LSLB12
	MOV  R16,R30
	LDD  R30,Y+2
	CPI  R30,0
	BREQ _0x2060033
	OR   R17,R16
	RJMP _0x2060034
_0x2060033:
	MOV  R30,R16
	COM  R30
	AND  R17,R30
_0x2060034:
	LDD  R30,Y+4
	ST   -Y,R30
	LDD  R30,Y+4
	ST   -Y,R30
	MOV  R26,R17
	RCALL _st7920_wrbyte_G103
	LDD  R17,Y+1
	LDD  R16,Y+0
	JMP  _0x21C0003
; .FEND
_st7920_wrmasked_G103:
; .FSTART _st7920_wrmasked_G103
	ST   -Y,R26
	ST   -Y,R17
	CALL SUBOPT_0x16
	LDD  R30,Y+5
	ST   -Y,R30
	LDD  R26,Y+5
	CALL SUBOPT_0x18
	MOV  R17,R30
	LDD  R30,Y+1
	CPI  R30,LOW(0x7)
	BREQ _0x206003F
	CPI  R30,LOW(0x8)
	BRNE _0x2060040
_0x206003F:
	LDD  R30,Y+3
	ST   -Y,R30
	LDD  R26,Y+2
	CALL _glcd_mappixcolor1bit
	STD  Y+3,R30
	RJMP _0x2060041
_0x2060040:
	CPI  R30,LOW(0x3)
	BRNE _0x2060043
	LDD  R30,Y+3
	COM  R30
	STD  Y+3,R30
	RJMP _0x2060044
_0x2060043:
	CPI  R30,0
	BRNE _0x2060045
_0x2060044:
	RJMP _0x2060046
_0x2060045:
	CPI  R30,LOW(0x9)
	BRNE _0x2060047
_0x2060046:
	RJMP _0x2060048
_0x2060047:
	CPI  R30,LOW(0xA)
	BRNE _0x2060049
_0x2060048:
_0x2060041:
	LDD  R30,Y+2
	COM  R30
	AND  R17,R30
	RJMP _0x206004A
_0x2060049:
	CPI  R30,LOW(0x2)
	BRNE _0x206004B
_0x206004A:
	LDD  R30,Y+2
	LDD  R26,Y+3
	AND  R30,R26
	OR   R17,R30
	RJMP _0x206003D
_0x206004B:
	CPI  R30,LOW(0x1)
	BRNE _0x206004C
	LDD  R30,Y+2
	LDD  R26,Y+3
	AND  R30,R26
	EOR  R17,R30
	RJMP _0x206003D
_0x206004C:
	CPI  R30,LOW(0x4)
	BRNE _0x206003D
	LDD  R30,Y+2
	COM  R30
	LDD  R26,Y+3
	OR   R30,R26
	AND  R17,R30
_0x206003D:
	LDD  R30,Y+5
	ST   -Y,R30
	LDD  R30,Y+5
	ST   -Y,R30
	MOV  R26,R17
	CALL _glcd_revbits
	MOV  R26,R30
	RCALL _st7920_wrbyte_G103
	LDD  R17,Y+0
_0x21C0009:
	ADIW R28,6
	RET
; .FEND
_glcd_block:
; .FSTART _glcd_block
	ST   -Y,R26
	SBIW R28,7
	CALL __SAVELOCR6
	LDD  R26,Y+20
	CPI  R26,LOW(0x80)
	BRSH _0x206004F
	LDD  R26,Y+19
	CPI  R26,LOW(0x40)
	BRSH _0x206004F
	LDD  R26,Y+18
	CPI  R26,LOW(0x0)
	BREQ _0x206004F
	LDD  R26,Y+17
	CPI  R26,LOW(0x0)
	BRNE _0x206004E
_0x206004F:
	RJMP _0x21C0005
_0x206004E:
	LDD  R30,Y+18
	LSR  R30
	LSR  R30
	LSR  R30
	MOV  R18,R30
	__PUTBSR 18,8
	LDD  R30,Y+18
	ANDI R30,LOW(0x7)
	STD  Y+11,R30
	CPI  R30,0
	BREQ _0x2060051
	LDD  R30,Y+8
	SUBI R30,-LOW(1)
	STD  Y+8,R30
_0x2060051:
	LDD  R16,Y+18
	LDD  R26,Y+20
	CLR  R27
	LDD  R30,Y+18
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	CPI  R26,LOW(0x81)
	LDI  R30,HIGH(0x81)
	CPC  R27,R30
	BRLO _0x2060052
	LDD  R26,Y+20
	LDI  R30,LOW(128)
	SUB  R30,R26
	STD  Y+18,R30
_0x2060052:
	LDD  R30,Y+17
	STD  Y+10,R30
	LDD  R26,Y+19
	CLR  R27
	LDD  R30,Y+17
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	CPI  R26,LOW(0x41)
	LDI  R30,HIGH(0x41)
	CPC  R27,R30
	BRLO _0x2060053
	LDD  R26,Y+19
	LDI  R30,LOW(64)
	SUB  R30,R26
	STD  Y+17,R30
_0x2060053:
	LDD  R30,Y+13
	CPI  R30,LOW(0x6)
	BREQ PC+2
	RJMP _0x2060057
	LDD  R30,Y+16
	CPI  R30,LOW(0x1)
	BRNE _0x206005B
	RJMP _0x21C0005
_0x206005B:
	CPI  R30,LOW(0x3)
	BRNE _0x206005E
	__GETW1MN _glcd_state,27
	SBIW R30,0
	BRNE _0x206005D
	RJMP _0x21C0005
_0x206005D:
_0x206005E:
	LDD  R30,Y+11
	CPI  R30,0
	BRNE _0x2060060
	LDD  R26,Y+18
	CP   R16,R26
	BREQ _0x206005F
_0x2060060:
	MOV  R30,R18
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	LDI  R31,0
	CALL SUBOPT_0x19
	LDD  R17,Y+17
_0x2060062:
	CPI  R17,0
	BREQ _0x2060064
	MOV  R19,R18
_0x2060065:
	PUSH R19
	SUBI R19,-1
	LDD  R30,Y+8
	POP  R26
	CP   R26,R30
	BRSH _0x2060067
	CALL SUBOPT_0x1A
	RJMP _0x2060065
_0x2060067:
	MOV  R30,R18
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R31,0
	CALL SUBOPT_0x19
	SUBI R17,LOW(1)
	RJMP _0x2060062
_0x2060064:
_0x206005F:
	LDD  R18,Y+17
	LDD  R30,Y+10
	CP   R30,R18
	BREQ _0x2060068
	MOV  R26,R18
	CLR  R27
	LDD  R30,Y+8
	LDI  R31,0
	CALL __MULW12U
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	CALL SUBOPT_0x19
_0x2060069:
	PUSH R18
	SUBI R18,-1
	LDD  R30,Y+10
	POP  R26
	CP   R26,R30
	BRSH _0x206006B
	LDI  R19,LOW(0)
_0x206006C:
	PUSH R19
	SUBI R19,-1
	LDD  R30,Y+8
	POP  R26
	CP   R26,R30
	BRSH _0x206006E
	CALL SUBOPT_0x1A
	RJMP _0x206006C
_0x206006E:
	RJMP _0x2060069
_0x206006B:
_0x2060068:
	RJMP _0x2060056
_0x2060057:
	CPI  R30,LOW(0x9)
	BRNE _0x206006F
	LDI  R30,LOW(0)
	RJMP _0x20600BC
_0x206006F:
	CPI  R30,LOW(0xA)
	BRNE _0x2060056
	LDI  R30,LOW(255)
_0x20600BC:
	STD  Y+10,R30
	ST   -Y,R30
	LDD  R26,Y+14
	CALL _glcd_mappixcolor1bit
	STD  Y+10,R30
_0x2060056:
	LDD  R30,Y+20
	ANDI R30,LOW(0x7)
	MOV  R19,R30
	LDI  R30,LOW(8)
	SUB  R30,R19
	MOV  R18,R30
	MOV  R21,R18
	LDD  R26,Y+18
	CP   R18,R26
	BRLO _0x2060073
	LDD  R21,Y+18
	RJMP _0x2060074
_0x2060073:
	CPI  R19,0
	BREQ _0x2060075
	MOV  R20,R19
	LDD  R26,Y+18
	CPI  R26,LOW(0x9)
	BRSH _0x2060076
	LDD  R30,Y+18
	SUB  R30,R18
	MOV  R20,R30
_0x2060076:
	MOV  R30,R20
	LDI  R31,0
	SUBI R30,LOW(-__glcd_mask*2)
	SBCI R31,HIGH(-__glcd_mask*2)
	LPM  R20,Z
_0x2060075:
_0x2060074:
	ST   -Y,R19
	MOV  R26,R21
	CALL _glcd_getmask
	MOV  R21,R30
	LDD  R26,Y+11
	CP   R18,R26
	BRSH _0x2060077
	LDD  R30,Y+11
	SUB  R30,R18
	STD  Y+11,R30
_0x2060077:
	LDD  R30,Y+11
	LDI  R31,0
	SUBI R30,LOW(-__glcd_mask*2)
	SBCI R31,HIGH(-__glcd_mask*2)
	LPM  R0,Z
	STD  Y+12,R0
	CALL SUBOPT_0x16
_0x2060078:
	LDD  R30,Y+17
	SUBI R30,LOW(1)
	STD  Y+17,R30
	SUBI R30,-LOW(1)
	BRNE PC+2
	RJMP _0x206007A
	LDI  R17,LOW(0)
	LDD  R16,Y+20
	LDD  R30,Y+14
	LDD  R31,Y+14+1
	STD  Y+6,R30
	STD  Y+6+1,R31
	CPI  R19,0
	BRNE PC+2
	RJMP _0x206007B
	__PUTBSR 20,11
	LDD  R26,Y+13
	CPI  R26,LOW(0x6)
	BREQ PC+2
	RJMP _0x206007C
_0x206007D:
	LDD  R30,Y+18
	CP   R17,R30
	BRLO PC+2
	RJMP _0x206007F
	ST   -Y,R16
	LDD  R26,Y+20
	CALL SUBOPT_0x18
	AND  R30,R21
	MOV  R26,R30
	MOV  R30,R19
	CALL __LSRB12
	STD  Y+9,R30
	CALL SUBOPT_0x1B
	MOV  R1,R30
	MOV  R30,R19
	MOV  R26,R21
	CALL __LSRB12
	COM  R30
	AND  R30,R1
	LDD  R26,Y+9
	OR   R30,R26
	STD  Y+9,R30
	LDD  R26,Y+18
	CP   R18,R26
	BRSH _0x2060081
	MOV  R30,R16
	LSR  R30
	LSR  R30
	LSR  R30
	CPI  R30,LOW(0xF)
	BRLO _0x2060080
_0x2060081:
	CALL SUBOPT_0x1C
	ST   -Y,R31
	ST   -Y,R30
	LDD  R26,Y+12
	CALL _glcd_writemem
	RJMP _0x206007F
_0x2060080:
	LDD  R26,Y+18
	SUB  R26,R17
	CPI  R26,LOW(0x8)
	BRSH _0x2060083
	LDD  R30,Y+12
	STD  Y+11,R30
_0x2060083:
	SUBI R16,-LOW(8)
	ST   -Y,R16
	LDD  R26,Y+20
	CALL SUBOPT_0x18
	LDD  R26,Y+11
	AND  R30,R26
	MOV  R26,R30
	MOV  R30,R18
	CALL __LSLB12
	STD  Y+10,R30
	MOV  R30,R18
	LDD  R26,Y+11
	CALL __LSLB12
	COM  R30
	LDD  R26,Y+9
	AND  R30,R26
	LDD  R26,Y+10
	OR   R30,R26
	STD  Y+10,R30
	CALL SUBOPT_0x1C
	ADIW R30,1
	STD  Y+7,R30
	STD  Y+7+1,R31
	SBIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	LDD  R26,Y+13
	CALL _glcd_writemem
	SUBI R17,-LOW(8)
	RJMP _0x206007D
_0x206007F:
	RJMP _0x2060084
_0x206007C:
_0x2060085:
	LDD  R30,Y+18
	CP   R17,R30
	BRSH _0x2060087
	LDD  R30,Y+13
	CPI  R30,LOW(0x9)
	BREQ _0x206008C
	CPI  R30,LOW(0xA)
	BRNE _0x206008E
_0x206008C:
	RJMP _0x206008A
_0x206008E:
	CALL SUBOPT_0x1C
	ADIW R30,1
	STD  Y+7,R30
	STD  Y+7+1,R31
	SBIW R30,1
	CLR  R22
	CLR  R23
	MOVW R26,R30
	MOVW R24,R22
	CALL _glcd_readmem
	STD  Y+10,R30
_0x206008A:
	ST   -Y,R16
	LDD  R30,Y+20
	ST   -Y,R30
	MOV  R30,R19
	LDD  R26,Y+12
	CALL __LSLB12
	ST   -Y,R30
	ST   -Y,R21
	LDD  R26,Y+17
	RCALL _st7920_wrmasked_G103
	LDD  R26,Y+18
	CP   R18,R26
	BRSH _0x2060087
	MOV  R30,R16
	LSR  R30
	LSR  R30
	LSR  R30
	CPI  R30,LOW(0xF)
	BRSH _0x2060087
	SUB  R26,R17
	CPI  R26,LOW(0x8)
	BRSH _0x2060091
	LDD  R30,Y+12
	STD  Y+11,R30
_0x2060091:
	SUBI R16,-LOW(8)
	ST   -Y,R16
	LDD  R30,Y+20
	ST   -Y,R30
	MOV  R30,R18
	LDD  R26,Y+12
	CALL __LSRB12
	CALL SUBOPT_0x1D
	SUBI R17,-LOW(8)
	RJMP _0x2060085
_0x2060087:
_0x2060084:
	RJMP _0x2060092
_0x206007B:
	__PUTBSR 21,11
_0x2060093:
	LDD  R30,Y+18
	CP   R17,R30
	BRSH _0x2060095
	LDD  R26,Y+18
	SUB  R26,R17
	CPI  R26,LOW(0x8)
	BRSH _0x2060096
	LDD  R30,Y+12
	STD  Y+11,R30
_0x2060096:
	LDD  R30,Y+13
	CPI  R30,LOW(0x9)
	BREQ _0x206009B
	CPI  R30,LOW(0xA)
	BRNE _0x206009D
_0x206009B:
	RJMP _0x2060099
_0x206009D:
	LDD  R26,Y+13
	CPI  R26,LOW(0x6)
	BRNE _0x206009F
	LDD  R26,Y+11
	CPI  R26,LOW(0xFF)
	BREQ _0x206009E
_0x206009F:
	CALL SUBOPT_0x1B
	STD  Y+10,R30
_0x206009E:
_0x2060099:
	LDD  R26,Y+13
	CPI  R26,LOW(0x6)
	BRNE _0x20600A1
	CALL SUBOPT_0x1C
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R16
	LDD  R26,Y+23
	CALL SUBOPT_0x18
	LDD  R26,Y+14
	AND  R30,R26
	MOV  R0,R30
	LDD  R30,Y+14
	COM  R30
	LDD  R26,Y+13
	AND  R30,R26
	OR   R30,R0
	MOV  R26,R30
	CALL _glcd_writemem
	RJMP _0x20600A2
_0x20600A1:
	ST   -Y,R16
	LDD  R30,Y+20
	ST   -Y,R30
	LDD  R30,Y+12
	CALL SUBOPT_0x1D
_0x20600A2:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,1
	STD  Y+6,R30
	STD  Y+6+1,R31
	SUBI R16,-LOW(8)
	SUBI R17,-LOW(8)
	RJMP _0x2060093
_0x2060095:
_0x2060092:
	LDD  R30,Y+19
	SUBI R30,-LOW(1)
	STD  Y+19,R30
	LDD  R30,Y+8
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STD  Y+14,R30
	STD  Y+14+1,R31
	RJMP _0x2060078
_0x206007A:
	RJMP _0x21C0005
; .FEND
_glcd_putcharcg:
; .FSTART _glcd_putcharcg
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
	LDD  R26,Y+4
	CPI  R26,LOW(0x10)
	BRLO _0x20600A5
	LDI  R30,LOW(15)
	STD  Y+4,R30
_0x20600A5:
	LDD  R26,Y+3
	CPI  R26,LOW(0x4)
	BRLO _0x20600A6
	LDI  R30,LOW(3)
	STD  Y+3,R30
_0x20600A6:
	LDD  R30,Y+3
	LDI  R31,0
	SUBI R30,LOW(-_st7920_base_y_G103*2)
	SBCI R31,HIGH(-_st7920_base_y_G103*2)
	LPM  R26,Z
	LDD  R30,Y+4
	LSR  R30
	OR   R30,R26
	MOV  R17,R30
	CALL SUBOPT_0x15
	MOV  R26,R17
	RCALL _st7920_wrcmd
	RCALL _st7920_rddata
	LDD  R30,Y+4
	ANDI R30,LOW(0x1)
	BREQ _0x20600A7
	RCALL _st7920_rddata
	MOV  R16,R30
_0x20600A7:
	MOV  R26,R17
	RCALL _st7920_wrcmd
	LDD  R30,Y+4
	ANDI R30,LOW(0x1)
	BREQ _0x20600A8
	MOV  R26,R16
	RCALL _st7920_wrdata
_0x20600A8:
	LDD  R26,Y+2
	RCALL _st7920_wrdata
	LDD  R17,Y+1
	LDD  R16,Y+0
	JMP  _0x21C0003
; .FEND

	.CSEG
_glcd_clipx:
; .FSTART _glcd_clipx
	CALL SUBOPT_0x1E
	BRLT _0x2080003
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	JMP  _0x21C0002
_0x2080003:
	LD   R26,Y
	LDD  R27,Y+1
	CPI  R26,LOW(0x80)
	LDI  R30,HIGH(0x80)
	CPC  R27,R30
	BRLT _0x2080004
	LDI  R30,LOW(127)
	LDI  R31,HIGH(127)
	JMP  _0x21C0002
_0x2080004:
	LD   R30,Y
	LDD  R31,Y+1
	JMP  _0x21C0002
; .FEND
_glcd_clipy:
; .FSTART _glcd_clipy
	CALL SUBOPT_0x1E
	BRLT _0x2080005
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	JMP  _0x21C0002
_0x2080005:
	LD   R26,Y
	LDD  R27,Y+1
	CPI  R26,LOW(0x40)
	LDI  R30,HIGH(0x40)
	CPC  R27,R30
	BRLT _0x2080006
	LDI  R30,LOW(63)
	LDI  R31,HIGH(63)
	JMP  _0x21C0002
_0x2080006:
	LD   R30,Y
	LDD  R31,Y+1
	JMP  _0x21C0002
; .FEND
_glcd_imagesize:
; .FSTART _glcd_imagesize
	ST   -Y,R26
	ST   -Y,R17
	LDD  R26,Y+2
	CPI  R26,LOW(0x80)
	BRSH _0x2080008
	LDD  R26,Y+1
	CPI  R26,LOW(0x40)
	BRLO _0x2080007
_0x2080008:
	__GETD1N 0x0
	LDD  R17,Y+0
	JMP  _0x21C0001
_0x2080007:
	LDD  R30,Y+2
	ANDI R30,LOW(0x7)
	MOV  R17,R30
	LDD  R30,Y+2
	LSR  R30
	LSR  R30
	LSR  R30
	STD  Y+2,R30
	CPI  R17,0
	BREQ _0x208000A
	SUBI R30,-LOW(1)
	STD  Y+2,R30
_0x208000A:
	LDD  R26,Y+2
	CLR  R27
	CLR  R24
	CLR  R25
	LDD  R30,Y+1
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __MULD12U
	__ADDD1N 4
	LDD  R17,Y+0
	JMP  _0x21C0001
; .FEND
_glcd_getcharw_G104:
; .FSTART _glcd_getcharw_G104
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,3
	CALL SUBOPT_0x1F
	MOVW R16,R30
	MOV  R0,R16
	OR   R0,R17
	BRNE _0x208000B
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RJMP _0x21C0008
_0x208000B:
	CALL SUBOPT_0x20
	STD  Y+7,R0
	CALL SUBOPT_0x20
	STD  Y+6,R0
	CALL SUBOPT_0x20
	STD  Y+8,R0
	LDD  R30,Y+11
	LDD  R26,Y+8
	CP   R30,R26
	BRSH _0x208000C
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RJMP _0x21C0008
_0x208000C:
	MOVW R30,R16
	__ADDWRN 16,17,1
	LPM  R21,Z
	LDD  R26,Y+8
	CLR  R27
	CLR  R30
	ADD  R26,R21
	ADC  R27,R30
	LDD  R30,Y+11
	LDI  R31,0
	CP   R30,R26
	CPC  R31,R27
	BRLO _0x208000D
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RJMP _0x21C0008
_0x208000D:
	LDD  R30,Y+7
	CPI  R30,0
	BREQ _0x208000E
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	ST   X,R30
	LSR  R30
	LSR  R30
	LSR  R30
	MOV  R20,R30
	LDD  R30,Y+7
	ANDI R30,LOW(0x7)
	BREQ _0x208000F
	SUBI R20,-LOW(1)
_0x208000F:
	LDD  R26,Y+8
	LDD  R30,Y+11
	SUB  R30,R26
	LDI  R31,0
	MOVW R26,R30
	LDD  R30,Y+6
	LDI  R31,0
	CALL __MULW12U
	MOVW R26,R30
	MOV  R30,R20
	LDI  R31,0
	CALL __MULW12U
	ADD  R30,R16
	ADC  R31,R17
	RJMP _0x21C0008
_0x208000E:
	MOVW R18,R16
	MOV  R30,R21
	LDI  R31,0
	__ADDWRR 16,17,30,31
_0x2080010:
	LDD  R26,Y+8
	SUBI R26,-LOW(1)
	STD  Y+8,R26
	SUBI R26,LOW(1)
	LDD  R30,Y+11
	CP   R26,R30
	BRSH _0x2080012
	MOVW R30,R18
	LPM  R30,Z
	LSR  R30
	LSR  R30
	LSR  R30
	MOV  R20,R30
	MOVW R30,R18
	__ADDWRN 18,19,1
	LPM  R30,Z
	ANDI R30,LOW(0x7)
	BREQ _0x2080013
	SUBI R20,-LOW(1)
_0x2080013:
	LDD  R26,Y+6
	CLR  R27
	MOV  R30,R20
	LDI  R31,0
	CALL __MULW12U
	__ADDWRR 16,17,30,31
	RJMP _0x2080010
_0x2080012:
	MOVW R30,R18
	LPM  R30,Z
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	ST   X,R30
	MOVW R30,R16
_0x21C0008:
	CALL __LOADLOCR6
	ADIW R28,12
	RET
; .FEND
_glcd_new_line_G104:
; .FSTART _glcd_new_line_G104
	LDI  R30,LOW(0)
	__PUTB1MN _glcd_state,2
	__GETB2MN _glcd_state,3
	CLR  R27
	CALL SUBOPT_0x21
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	__GETB1MN _glcd_state,7
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	CALL SUBOPT_0x22
	RET
; .FEND
_glcd_putchar:
; .FSTART _glcd_putchar
	ST   -Y,R26
	SBIW R28,1
	CALL SUBOPT_0x1F
	SBIW R30,0
	BRNE PC+2
	RJMP _0x2080020
	LDD  R26,Y+7
	CPI  R26,LOW(0xA)
	BRNE _0x2080021
	RJMP _0x2080022
_0x2080021:
	LDD  R30,Y+7
	ST   -Y,R30
	MOVW R26,R28
	ADIW R26,7
	RCALL _glcd_getcharw_G104
	MOVW R20,R30
	SBIW R30,0
	BRNE _0x2080023
	RJMP _0x21C0007
_0x2080023:
	__GETB1MN _glcd_state,6
	LDD  R26,Y+6
	ADD  R30,R26
	MOV  R19,R30
	__GETB2MN _glcd_state,2
	CLR  R27
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	MOVW R16,R30
	__CPWRN 16,17,129
	BRLO _0x2080024
	MOV  R16,R19
	CLR  R17
	RCALL _glcd_new_line_G104
_0x2080024:
	CALL SUBOPT_0x23
	LDD  R30,Y+8
	ST   -Y,R30
	CALL SUBOPT_0x21
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	ST   -Y,R21
	ST   -Y,R20
	LDI  R26,LOW(7)
	CALL SUBOPT_0x24
	LDD  R26,Y+6
	ADD  R30,R26
	ST   -Y,R30
	__GETB1MN _glcd_state,3
	ST   -Y,R30
	__GETB1MN _glcd_state,6
	ST   -Y,R30
	CALL SUBOPT_0x21
	CALL SUBOPT_0x25
	CALL SUBOPT_0x24
	ST   -Y,R30
	__GETB2MN _glcd_state,3
	CALL SUBOPT_0x21
	ADD  R30,R26
	ST   -Y,R30
	ST   -Y,R19
	__GETB1MN _glcd_state,7
	CALL SUBOPT_0x25
	RCALL _glcd_block
	LDI  R30,LOW(128)
	LDI  R31,HIGH(128)
	CP   R30,R16
	CPC  R31,R17
	BRNE _0x2080025
_0x2080022:
	RCALL _glcd_new_line_G104
	RJMP _0x21C0007
_0x2080025:
	RJMP _0x2080026
_0x2080020:
	LDD  R26,Y+7
	CPI  R26,LOW(0xA)
	BREQ _0x2080028
	__GETB1MN _glcd_state,2
	LSR  R30
	LSR  R30
	LSR  R30
	MOV  R19,R30
	__GETB1MN _glcd_state,3
	SWAP R30
	ANDI R30,0xF
	MOV  R18,R30
	ST   -Y,R19
	ST   -Y,R18
	LDD  R26,Y+9
	RCALL _glcd_putcharcg
	MOV  R30,R19
	LSL  R30
	LSL  R30
	LSL  R30
	__PUTB1MN _glcd_state,2
	LDI  R26,LOW(16)
	MUL  R18,R26
	MOVW R30,R0
	__PUTB1MN _glcd_state,3
	CALL SUBOPT_0x23
	LDI  R30,LOW(8)
	ST   -Y,R30
	LDI  R30,LOW(16)
	CALL SUBOPT_0x25
	CALL SUBOPT_0x24
	LDI  R31,0
	ADIW R30,8
	MOVW R16,R30
	__CPWRN 16,17,128
	BRLO _0x2080029
_0x2080028:
	__GETWRN 16,17,0
	__GETB1MN _glcd_state,3
	LDI  R31,0
	ADIW R30,16
	MOVW R26,R30
	CALL SUBOPT_0x22
_0x2080029:
_0x2080026:
	__PUTBMRN _glcd_state,2,16
_0x21C0007:
	CALL __LOADLOCR6
	ADIW R28,8
	RET
; .FEND
_glcd_putcharxy:
; .FSTART _glcd_putcharxy
	ST   -Y,R26
	LDD  R30,Y+2
	ST   -Y,R30
	LDD  R26,Y+2
	RCALL _glcd_moveto
	LD   R26,Y
	RCALL _glcd_putchar
	JMP  _0x21C0001
; .FEND
_glcd_outtextxy:
; .FSTART _glcd_outtextxy
	CALL SUBOPT_0x26
_0x208002A:
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LD   R30,X+
	STD  Y+1,R26
	STD  Y+1+1,R27
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x208002C
	MOV  R26,R17
	RCALL _glcd_putchar
	RJMP _0x208002A
_0x208002C:
	LDD  R17,Y+0
	JMP  _0x21C0003
; .FEND
_glcd_outtextxyf:
; .FSTART _glcd_outtextxyf
	CALL SUBOPT_0x26
_0x208002D:
	CALL SUBOPT_0x27
	BREQ _0x208002F
	MOV  R26,R17
	RCALL _glcd_putchar
	RJMP _0x208002D
_0x208002F:
	LDD  R17,Y+0
	JMP  _0x21C0003
; .FEND
_glcd_outtextf:
; .FSTART _glcd_outtextf
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
_0x2080036:
	CALL SUBOPT_0x27
	BREQ _0x2080038
	MOV  R26,R17
	RCALL _glcd_putchar
	RJMP _0x2080036
_0x2080038:
	LDD  R17,Y+0
	JMP  _0x21C0001
; .FEND
_glcd_putimagef:
; .FSTART _glcd_putimagef
	ST   -Y,R26
	CALL __SAVELOCR4
	LDD  R26,Y+4
	CPI  R26,LOW(0x5)
	BRSH _0x208003D
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	LPM  R16,Z+
	CALL SUBOPT_0x28
	LPM  R17,Z+
	CALL SUBOPT_0x28
	LPM  R18,Z+
	CALL SUBOPT_0x28
	LPM  R19,Z+
	STD  Y+5,R30
	STD  Y+5+1,R31
	LDD  R30,Y+8
	ST   -Y,R30
	LDD  R30,Y+8
	ST   -Y,R30
	ST   -Y,R16
	ST   -Y,R18
	LDI  R30,LOW(1)
	ST   -Y,R30
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	ST   -Y,R31
	ST   -Y,R30
	LDD  R26,Y+11
	RCALL _glcd_block
	ST   -Y,R16
	MOV  R26,R18
	RCALL _glcd_imagesize
	RJMP _0x21C0006
_0x208003D:
	__GETD1N 0x0
_0x21C0006:
	CALL __LOADLOCR4
	ADIW R28,9
	RET
; .FEND
_glcd_putpixelm_G104:
; .FSTART _glcd_putpixelm_G104
	ST   -Y,R26
	LDD  R30,Y+2
	ST   -Y,R30
	LDD  R30,Y+2
	ST   -Y,R30
	__GETB1MN _glcd_state,9
	LDD  R26,Y+2
	AND  R30,R26
	BREQ _0x2080043
	LDS  R30,_glcd_state
	RJMP _0x2080044
_0x2080043:
	__GETB1MN _glcd_state,1
_0x2080044:
	MOV  R26,R30
	RCALL _glcd_putpixel
	LD   R30,Y
	LSL  R30
	ST   Y,R30
	CPI  R30,0
	BRNE _0x2080046
	LDI  R30,LOW(1)
	ST   Y,R30
_0x2080046:
	LD   R30,Y
	JMP  _0x21C0001
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
	CALL SUBOPT_0x22
	JMP  _0x21C0002
; .FEND
_glcd_line:
; .FSTART _glcd_line
	ST   -Y,R26
	SBIW R28,11
	CALL __SAVELOCR6
	LDD  R26,Y+20
	CLR  R27
	RCALL _glcd_clipx
	STD  Y+20,R30
	LDD  R26,Y+18
	CLR  R27
	RCALL _glcd_clipx
	STD  Y+18,R30
	LDD  R26,Y+19
	CLR  R27
	RCALL _glcd_clipy
	STD  Y+19,R30
	LDD  R26,Y+17
	CLR  R27
	RCALL _glcd_clipy
	STD  Y+17,R30
	LDD  R30,Y+18
	__PUTB1MN _glcd_state,2
	LDD  R30,Y+17
	__PUTB1MN _glcd_state,3
	LDI  R30,LOW(1)
	STD  Y+8,R30
	LDD  R30,Y+17
	LDD  R26,Y+19
	CP   R30,R26
	BRNE _0x2080047
	LDD  R17,Y+20
	LDD  R26,Y+18
	CP   R17,R26
	BRNE _0x2080048
	ST   -Y,R17
	LDD  R30,Y+20
	ST   -Y,R30
	LDI  R26,LOW(1)
	RCALL _glcd_putpixelm_G104
	RJMP _0x21C0005
_0x2080048:
	LDD  R26,Y+18
	CP   R17,R26
	BRSH _0x2080049
	LDD  R30,Y+18
	SUB  R30,R17
	MOV  R16,R30
	__GETWRN 20,21,1
	RJMP _0x208004A
_0x2080049:
	LDD  R26,Y+18
	MOV  R30,R17
	SUB  R30,R26
	MOV  R16,R30
	__GETWRN 20,21,-1
_0x208004A:
_0x208004C:
	LDD  R19,Y+19
	LDI  R30,LOW(0)
	STD  Y+6,R30
_0x208004E:
	CALL SUBOPT_0x29
	BRSH _0x2080050
	ST   -Y,R17
	ST   -Y,R19
	INC  R19
	LDD  R26,Y+10
	RCALL _glcd_putpixelm_G104
	STD  Y+7,R30
	RJMP _0x208004E
_0x2080050:
	LDD  R30,Y+7
	STD  Y+8,R30
	ADD  R17,R20
	MOV  R30,R16
	SUBI R16,1
	CPI  R30,0
	BRNE _0x208004C
	RJMP _0x2080051
_0x2080047:
	LDD  R30,Y+18
	LDD  R26,Y+20
	CP   R30,R26
	BRNE _0x2080052
	LDD  R19,Y+19
	LDD  R26,Y+17
	CP   R19,R26
	BRSH _0x2080053
	LDD  R30,Y+17
	SUB  R30,R19
	MOV  R18,R30
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	RJMP _0x2080120
_0x2080053:
	LDD  R26,Y+17
	MOV  R30,R19
	SUB  R30,R26
	MOV  R18,R30
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
_0x2080120:
	STD  Y+13,R30
	STD  Y+13+1,R31
_0x2080056:
	LDD  R17,Y+20
	LDI  R30,LOW(0)
	STD  Y+6,R30
_0x2080058:
	CALL SUBOPT_0x29
	BRSH _0x208005A
	ST   -Y,R17
	INC  R17
	CALL SUBOPT_0x2A
	STD  Y+7,R30
	RJMP _0x2080058
_0x208005A:
	LDD  R30,Y+7
	STD  Y+8,R30
	LDD  R30,Y+13
	ADD  R19,R30
	MOV  R30,R18
	SUBI R18,1
	CPI  R30,0
	BRNE _0x2080056
	RJMP _0x208005B
_0x2080052:
	LDI  R30,LOW(0)
	STD  Y+6,R30
_0x208005C:
	CALL SUBOPT_0x29
	BRLO PC+2
	RJMP _0x208005E
	LDD  R17,Y+20
	LDD  R19,Y+19
	LDI  R30,LOW(1)
	MOV  R18,R30
	MOV  R16,R30
	LDD  R26,Y+18
	CLR  R27
	LDD  R30,Y+20
	LDI  R31,0
	SUB  R26,R30
	SBC  R27,R31
	MOVW R20,R26
	TST  R21
	BRPL _0x208005F
	LDI  R16,LOW(255)
	MOVW R30,R20
	CALL __ANEGW1
	MOVW R20,R30
_0x208005F:
	MOVW R30,R20
	LSL  R30
	ROL  R31
	STD  Y+15,R30
	STD  Y+15+1,R31
	LDD  R26,Y+17
	CLR  R27
	LDD  R30,Y+19
	LDI  R31,0
	SUB  R26,R30
	SBC  R27,R31
	STD  Y+13,R26
	STD  Y+13+1,R27
	LDD  R26,Y+14
	TST  R26
	BRPL _0x2080060
	LDI  R18,LOW(255)
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	CALL __ANEGW1
	STD  Y+13,R30
	STD  Y+13+1,R31
_0x2080060:
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	LSL  R30
	ROL  R31
	STD  Y+11,R30
	STD  Y+11+1,R31
	ST   -Y,R17
	ST   -Y,R19
	LDI  R26,LOW(1)
	RCALL _glcd_putpixelm_G104
	STD  Y+8,R30
	LDI  R30,LOW(0)
	STD  Y+9,R30
	STD  Y+9+1,R30
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	CP   R20,R26
	CPC  R21,R27
	BRLT _0x2080061
_0x2080063:
	ADD  R17,R16
	LDD  R30,Y+11
	LDD  R31,Y+11+1
	CALL SUBOPT_0x2B
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	CP   R20,R26
	CPC  R21,R27
	BRGE _0x2080065
	ADD  R19,R18
	LDD  R26,Y+15
	LDD  R27,Y+15+1
	CALL SUBOPT_0x2C
_0x2080065:
	ST   -Y,R17
	CALL SUBOPT_0x2A
	STD  Y+8,R30
	LDD  R30,Y+18
	CP   R30,R17
	BRNE _0x2080063
	RJMP _0x2080066
_0x2080061:
_0x2080068:
	ADD  R19,R18
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	CALL SUBOPT_0x2B
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	CP   R30,R26
	CPC  R31,R27
	BRGE _0x208006A
	ADD  R17,R16
	LDD  R26,Y+11
	LDD  R27,Y+11+1
	CALL SUBOPT_0x2C
_0x208006A:
	ST   -Y,R17
	CALL SUBOPT_0x2A
	STD  Y+8,R30
	LDD  R30,Y+17
	CP   R30,R19
	BRNE _0x2080068
_0x2080066:
	LDD  R30,Y+19
	SUBI R30,-LOW(1)
	STD  Y+19,R30
	LDD  R30,Y+17
	SUBI R30,-LOW(1)
	STD  Y+17,R30
	RJMP _0x208005C
_0x208005E:
_0x208005B:
_0x2080051:
_0x21C0005:
	CALL __LOADLOCR6
	ADIW R28,21
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
_DHT_GetTemHumi:
; .FSTART _DHT_GetTemHumi
	ST   -Y,R26
	SBIW R28,5
	LDI  R30,LOW(0)
	ST   Y,R30
	STD  Y+1,R30
	STD  Y+2,R30
	STD  Y+3,R30
	STD  Y+4,R30
	CALL __SAVELOCR4
	SBI  0x1A,1
	SBI  0x1B,1
	CALL SUBOPT_0x2D
	CBI  0x1B,1
	LDI  R26,LOW(25)
	LDI  R27,0
	CALL _delay_ms
	SBI  0x1B,1
	CBI  0x1A,1
	CALL SUBOPT_0x2D
	SBIS 0x19,1
	RJMP _0x20E000D
	LDI  R30,LOW(0)
	RJMP _0x21C0004
_0x20E000D:
_0x20E000F:
	SBIS 0x19,1
	RJMP _0x20E000F
	CALL SUBOPT_0x2D
	SBIC 0x19,1
	RJMP _0x20E0012
	LDI  R30,LOW(0)
	RJMP _0x21C0004
_0x20E0012:
_0x20E0014:
	SBIC 0x19,1
	RJMP _0x20E0014
	LDI  R17,LOW(0)
_0x20E0018:
	CPI  R17,5
	BRSH _0x20E0019
	LDI  R16,LOW(0)
_0x20E001B:
	CPI  R16,8
	BRSH _0x20E001C
_0x20E001D:
	SBIS 0x19,1
	RJMP _0x20E001D
	__DELAY_USW 200
	SBIS 0x19,1
	RJMP _0x20E0020
	MOV  R30,R17
	LDI  R31,0
	MOVW R26,R28
	ADIW R26,4
	ADD  R30,R26
	ADC  R31,R27
	MOVW R22,R30
	LD   R1,Z
	LDI  R30,LOW(7)
	SUB  R30,R16
	LDI  R26,LOW(1)
	CALL __LSLB12
	OR   R30,R1
	MOVW R26,R22
	ST   X,R30
_0x20E0021:
	SBIC 0x19,1
	RJMP _0x20E0021
_0x20E0020:
	SUBI R16,-1
	RJMP _0x20E001B
_0x20E001C:
	SUBI R17,-1
	RJMP _0x20E0018
_0x20E0019:
	LDD  R30,Y+5
	LDD  R26,Y+4
	ADD  R30,R26
	LDD  R26,Y+6
	ADD  R30,R26
	LDD  R26,Y+7
	ADD  R30,R26
	MOV  R19,R30
	LDD  R30,Y+8
	CP   R30,R19
	BREQ _0x20E0024
	LDI  R30,LOW(0)
	RJMP _0x21C0004
_0x20E0024:
	LDD  R26,Y+9
	CPI  R26,LOW(0x2)
	BRNE _0x20E0025
	LDD  R30,Y+6
	RJMP _0x21C0004
_0x20E0025:
	LDD  R26,Y+9
	CPI  R26,LOW(0x3)
	BRNE _0x20E0027
	LDD  R30,Y+7
	RJMP _0x21C0004
_0x20E0027:
	LDD  R30,Y+9
	CPI  R30,0
	BRNE _0x20E0029
	LDD  R30,Y+4
	RJMP _0x21C0004
_0x20E0029:
	LDD  R26,Y+9
	CPI  R26,LOW(0x1)
	BRNE _0x20E002B
	LDD  R30,Y+5
	RJMP _0x21C0004
_0x20E002B:
	LDI  R30,LOW(1)
_0x21C0004:
	CALL __LOADLOCR4
	ADIW R28,10
	RET
; .FEND

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
_0x21C0003:
	ADIW R28,5
	RET
; .FEND
_strlen:
; .FSTART _strlen
	ST   -Y,R27
	ST   -Y,R26
    ld   r26,y+
    ld   r27,y+
    clr  r30
    clr  r31
strlen0:
    ld   r22,x+
    tst  r22
    breq strlen1
    adiw r30,1
    rjmp strlen0
strlen1:
    ret
; .FEND
_strlenf:
; .FSTART _strlenf
	ST   -Y,R27
	ST   -Y,R26
    clr  r26
    clr  r27
    ld   r30,y+
    ld   r31,y+
strlenf0:
	lpm  r0,z+
    tst  r0
    breq strlenf1
    adiw r26,1
    rjmp strlenf0
strlenf1:
    movw r30,r26
    ret
; .FEND

	.CSEG
_bcd2bin:
; .FSTART _bcd2bin
	ST   -Y,R26
    ld   r30,y
    swap r30
    andi r30,0xf
    mov  r26,r30
    lsl  r26
    lsl  r26
    add  r30,r26
    lsl  r30
    ld   r26,y+
    andi r26,0xf
    add  r30,r26
    ret
; .FEND

	.CSEG

	.CSEG
_glcd_getmask:
; .FSTART _glcd_getmask
	ST   -Y,R26
	LD   R30,Y
	LDI  R31,0
	SUBI R30,LOW(-__glcd_mask*2)
	SBCI R31,HIGH(-__glcd_mask*2)
	LPM  R26,Z
	LDD  R30,Y+1
	CALL __LSLB12
_0x21C0002:
	ADIW R28,2
	RET
; .FEND
_glcd_mappixcolor1bit:
; .FSTART _glcd_mappixcolor1bit
	ST   -Y,R26
	ST   -Y,R17
	LDD  R30,Y+1
	CPI  R30,LOW(0x7)
	BREQ _0x2180007
	CPI  R30,LOW(0xA)
	BRNE _0x2180008
_0x2180007:
	LDS  R17,_glcd_state
	RJMP _0x2180009
_0x2180008:
	CPI  R30,LOW(0x9)
	BRNE _0x218000B
	__GETBRMN 17,_glcd_state,1
	RJMP _0x2180009
_0x218000B:
	CPI  R30,LOW(0x8)
	BRNE _0x2180005
	__GETBRMN 17,_glcd_state,16
_0x2180009:
	__GETB1MN _glcd_state,1
	CPI  R30,0
	BREQ _0x218000E
	CPI  R17,0
	BREQ _0x218000F
	LDI  R30,LOW(255)
	LDD  R17,Y+0
	RJMP _0x21C0001
_0x218000F:
	LDD  R30,Y+2
	COM  R30
	LDD  R17,Y+0
	RJMP _0x21C0001
_0x218000E:
	CPI  R17,0
	BRNE _0x2180011
	LDI  R30,LOW(0)
	LDD  R17,Y+0
	RJMP _0x21C0001
_0x2180011:
_0x2180005:
	LDD  R30,Y+2
	LDD  R17,Y+0
	RJMP _0x21C0001
; .FEND
_glcd_readmem:
; .FSTART _glcd_readmem
	ST   -Y,R27
	ST   -Y,R26
	LDD  R30,Y+2
	CPI  R30,LOW(0x1)
	BRNE _0x2180015
	LD   R30,Y
	LDD  R31,Y+1
	LPM  R30,Z
	RJMP _0x21C0001
_0x2180015:
	CPI  R30,LOW(0x2)
	BRNE _0x2180016
	LD   R26,Y
	LDD  R27,Y+1
	CALL __EEPROMRDB
	RJMP _0x21C0001
_0x2180016:
	CPI  R30,LOW(0x3)
	BRNE _0x2180018
	LD   R26,Y
	LDD  R27,Y+1
	__CALL1MN _glcd_state,25
	RJMP _0x21C0001
_0x2180018:
	LD   R26,Y
	LDD  R27,Y+1
	LD   R30,X
_0x21C0001:
	ADIW R28,3
	RET
; .FEND
_glcd_writemem:
; .FSTART _glcd_writemem
	ST   -Y,R26
	LDD  R30,Y+3
	CPI  R30,0
	BRNE _0x218001C
	LD   R30,Y
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	ST   X,R30
	RJMP _0x218001B
_0x218001C:
	CPI  R30,LOW(0x2)
	BRNE _0x218001D
	LD   R30,Y
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	CALL __EEPROMWRB
	RJMP _0x218001B
_0x218001D:
	CPI  R30,LOW(0x3)
	BRNE _0x218001B
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ST   -Y,R31
	ST   -Y,R30
	LDD  R26,Y+2
	__CALL1MN _glcd_state,27
_0x218001B:
	ADIW R28,4
	RET
; .FEND
_glcd_revbits:
; .FSTART _glcd_revbits
	ST   -Y,R26
    ld  r26,y+
    bst r26,0
    bld r30,7

    bst r26,1
    bld r30,6

    bst r26,2
    bld r30,5

    bst r26,3
    bld r30,4

    bst r26,4
    bld r30,3

    bst r26,5
    bld r30,2

    bst r26,6
    bld r30,1

    bst r26,7
    bld r30,0
    ret
; .FEND

	.CSEG

	.DSEG

	.CSEG

	.DSEG
___ds18b20_scratch_pad:
	.BYTE 0x9
_glcd_state:
	.BYTE 0x1D

	.ESEG
_mTempSet:
	.BYTE 0x1
_hourSet:
	.BYTE 0x1
_minSet:
	.BYTE 0x1
_tempSet:
	.BYTE 0x1

	.DSEG
_temperature:
	.BYTE 0x4
_humidity:
	.BYTE 0x4
_st7920_graphics_on_G103:
	.BYTE 0x1
_st7920_bits8_15_G103:
	.BYTE 0x1
_xt_G103:
	.BYTE 0x1
_yt_G103:
	.BYTE 0x1
__seed_G10D:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:17 WORDS
SUBOPT_0x0:
	LDI  R30,LOW(0)
	OUT  0x2F,R30
	OUT  0x2E,R30
	OUT  0x2D,R30
	OUT  0x2C,R30
	OUT  0x27,R30
	OUT  0x26,R30
	OUT  0x2B,R30
	OUT  0x2A,R30
	OUT  0x29,R30
	OUT  0x28,R30
	OUT  0x39,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x1:
	LDI  R26,LOW(_tempSet)
	LDI  R27,HIGH(_tempSet)
	CALL __EEPROMRDB
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0x2:
	CALL _DHT_GetTemHumi
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __CDF1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3:
	__GETD1N 0x43800000
	CALL __MULF12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x4:
	CALL __ADDF12
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x41200000
	CALL __DIVF21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x5:
	LDS  R30,_temperature
	LDS  R31,_temperature+1
	LDS  R22,_temperature+2
	LDS  R23,_temperature+3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x6:
	CALL __PUTPARD1
	LDI  R24,4
	CALL _sprintf
	ADIW R28,8
	LDD  R30,Y+27
	ST   -Y,R30
	LDD  R30,Y+27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x7:
	ST   -Y,R30
	MOVW R26,R28
	ADIW R26,18
	CALL _glcd_outtextxy
	LDD  R30,Y+27
	SUBI R30,-LOW(25)
	ST   -Y,R30
	LDD  R30,Y+27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x8:
	LDI  R26,LOW(_hourSet)
	LDI  R27,HIGH(_hourSet)
	CALL __EEPROMRDB
	LDI  R31,0
	MOVW R26,R30
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x9:
	CALL __DIVW21
	SUBI R30,-LOW(48)
	MOV  R26,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0xA:
	CALL __MODW21
	SUBI R30,-LOW(48)
	MOV  R26,R30
	JMP  _glcd_putchar

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xB:
	LDI  R26,LOW(_minSet)
	LDI  R27,HIGH(_minSet)
	CALL __EEPROMRDB
	LDI  R31,0
	MOVW R26,R30
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0xC:
	RCALL SUBOPT_0x5
	CALL __CFD1
	MOVW R0,R30
	RJMP SUBOPT_0x1

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0xD:
	ST   -Y,R18
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0xE:
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	SBIW R30,4
	STD  Y+16,R30
	STD  Y+16+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xF:
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x10:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	CALL __GETW1P
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x11:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	CALL __GETW1P
	STD  Y+10,R30
	STD  Y+10+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x12:
	MOVW R26,R28
	ADIW R26,12
	CALL __ADDW2R15
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x13:
	LDI  R26,LOW(1)
	CALL _i2c_read
	MOV  R26,R30
	JMP  _bcd2bin

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x14:
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
	JMP  _st7920_delay_G103

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x15:
	LDS  R30,_st7920_graphics_on_G103
	ORI  R30,LOW(0x30)
	MOV  R26,R30
	JMP  _st7920_wrcmd

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x16:
	LDS  R30,_st7920_graphics_on_G103
	ORI  R30,LOW(0x34)
	MOV  R26,R30
	JMP  _st7920_wrcmd

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x17:
	LDI  R26,LOW(48)
	CALL _st7920_wrbus_G103
	__DELAY_USW 800
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x18:
	CALL _st7920_rdbyte_G103
	MOV  R26,R30
	JMP  _glcd_revbits

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x19:
	ADD  R30,R26
	ADC  R31,R27
	STD  Y+6,R30
	STD  Y+6+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x1A:
	LDD  R30,Y+16
	ST   -Y,R30
	LDD  R30,Y+7
	LDD  R31,Y+7+1
	ADIW R30,1
	STD  Y+7,R30
	STD  Y+7+1,R31
	SBIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(0)
	JMP  _glcd_writemem

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1B:
	LDD  R30,Y+16
	ST   -Y,R30
	LDD  R26,Y+7
	LDD  R27,Y+7+1
	CLR  R24
	CLR  R25
	JMP  _glcd_readmem

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1C:
	LDD  R30,Y+16
	ST   -Y,R30
	LDD  R30,Y+7
	LDD  R31,Y+7+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1D:
	ST   -Y,R30
	LDD  R30,Y+14
	ST   -Y,R30
	LDD  R26,Y+17
	JMP  _st7920_wrmasked_G103

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1E:
	ST   -Y,R27
	ST   -Y,R26
	LD   R26,Y
	LDD  R27,Y+1
	CALL __CPW02
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1F:
	CALL __SAVELOCR6
	__GETW1MN _glcd_state,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x20:
	MOVW R30,R16
	__ADDWRN 16,17,1
	LPM  R0,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x21:
	__GETW1MN _glcd_state,4
	ADIW R30,1
	LPM  R30,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x22:
	CALL _glcd_clipy
	__PUTB1MN _glcd_state,3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x23:
	__GETB1MN _glcd_state,2
	ST   -Y,R30
	__GETB1MN _glcd_state,3
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x24:
	CALL _glcd_block
	__GETB1MN _glcd_state,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x25:
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(9)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x26:
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	LDD  R30,Y+4
	ST   -Y,R30
	LDD  R26,Y+4
	JMP  _glcd_moveto

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x27:
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ADIW R30,1
	STD  Y+1,R30
	STD  Y+1+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R17,R30
	CPI  R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x28:
	STD  Y+5,R30
	STD  Y+5+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x29:
	LDD  R26,Y+6
	SUBI R26,-LOW(1)
	STD  Y+6,R26
	SUBI R26,LOW(1)
	__GETB1MN _glcd_state,8
	CP   R26,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2A:
	ST   -Y,R19
	LDD  R26,Y+10
	JMP  _glcd_putpixelm_G104

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2B:
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	ADD  R30,R26
	ADC  R31,R27
	STD  Y+9,R30
	STD  Y+9+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2C:
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+9,R30
	STD  Y+9+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2D:
	__DELAY_USW 240
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

__ROUND_REPACK:
	TST  R21
	BRPL __REPACK
	CPI  R21,0x80
	BRNE __ROUND_REPACK0
	SBRS R30,0
	RJMP __REPACK
__ROUND_REPACK0:
	ADIW R30,1
	ADC  R22,R25
	ADC  R23,R25
	BRVS __REPACK1

__REPACK:
	LDI  R21,0x80
	EOR  R21,R23
	BRNE __REPACK0
	PUSH R21
	RJMP __ZERORES
__REPACK0:
	CPI  R21,0xFF
	BREQ __REPACK1
	LSL  R22
	LSL  R0
	ROR  R21
	ROR  R22
	MOV  R23,R21
	RET
__REPACK1:
	PUSH R21
	TST  R0
	BRMI __REPACK2
	RJMP __MAXRES
__REPACK2:
	RJMP __MINRES

__UNPACK:
	LDI  R21,0x80
	MOV  R1,R25
	AND  R1,R21
	LSL  R24
	ROL  R25
	EOR  R25,R21
	LSL  R21
	ROR  R24

__UNPACK1:
	LDI  R21,0x80
	MOV  R0,R23
	AND  R0,R21
	LSL  R22
	ROL  R23
	EOR  R23,R21
	LSL  R21
	ROR  R22
	RET

__CFD1U:
	SET
	RJMP __CFD1U0
__CFD1:
	CLT
__CFD1U0:
	PUSH R21
	RCALL __UNPACK1
	CPI  R23,0x80
	BRLO __CFD10
	CPI  R23,0xFF
	BRCC __CFD10
	RJMP __ZERORES
__CFD10:
	LDI  R21,22
	SUB  R21,R23
	BRPL __CFD11
	NEG  R21
	CPI  R21,8
	BRTC __CFD19
	CPI  R21,9
__CFD19:
	BRLO __CFD17
	SER  R30
	SER  R31
	SER  R22
	LDI  R23,0x7F
	BLD  R23,7
	RJMP __CFD15
__CFD17:
	CLR  R23
	TST  R21
	BREQ __CFD15
__CFD18:
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	DEC  R21
	BRNE __CFD18
	RJMP __CFD15
__CFD11:
	CLR  R23
__CFD12:
	CPI  R21,8
	BRLO __CFD13
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R23
	SUBI R21,8
	RJMP __CFD12
__CFD13:
	TST  R21
	BREQ __CFD15
__CFD14:
	LSR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	DEC  R21
	BRNE __CFD14
__CFD15:
	TST  R0
	BRPL __CFD16
	RCALL __ANEGD1
__CFD16:
	POP  R21
	RET

__CDF1U:
	SET
	RJMP __CDF1U0
__CDF1:
	CLT
__CDF1U0:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	BREQ __CDF10
	CLR  R0
	BRTS __CDF11
	TST  R23
	BRPL __CDF11
	COM  R0
	RCALL __ANEGD1
__CDF11:
	MOV  R1,R23
	LDI  R23,30
	TST  R1
__CDF12:
	BRMI __CDF13
	DEC  R23
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R1
	RJMP __CDF12
__CDF13:
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R1
	PUSH R21
	RCALL __REPACK
	POP  R21
__CDF10:
	RET

__SWAPACC:
	PUSH R20
	MOVW R20,R30
	MOVW R30,R26
	MOVW R26,R20
	MOVW R20,R22
	MOVW R22,R24
	MOVW R24,R20
	MOV  R20,R0
	MOV  R0,R1
	MOV  R1,R20
	POP  R20
	RET

__UADD12:
	ADD  R30,R26
	ADC  R31,R27
	ADC  R22,R24
	RET

__NEGMAN1:
	COM  R30
	COM  R31
	COM  R22
	SUBI R30,-1
	SBCI R31,-1
	SBCI R22,-1
	RET

__ADDF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R25,0x80
	BREQ __ADDF129

__ADDF120:
	CPI  R23,0x80
	BREQ __ADDF128
__ADDF121:
	MOV  R21,R23
	SUB  R21,R25
	BRVS __ADDF1211
	BRPL __ADDF122
	RCALL __SWAPACC
	RJMP __ADDF121
__ADDF122:
	CPI  R21,24
	BRLO __ADDF123
	CLR  R26
	CLR  R27
	CLR  R24
__ADDF123:
	CPI  R21,8
	BRLO __ADDF124
	MOV  R26,R27
	MOV  R27,R24
	CLR  R24
	SUBI R21,8
	RJMP __ADDF123
__ADDF124:
	TST  R21
	BREQ __ADDF126
__ADDF125:
	LSR  R24
	ROR  R27
	ROR  R26
	DEC  R21
	BRNE __ADDF125
__ADDF126:
	MOV  R21,R0
	EOR  R21,R1
	BRMI __ADDF127
	RCALL __UADD12
	BRCC __ADDF129
	ROR  R22
	ROR  R31
	ROR  R30
	INC  R23
	BRVC __ADDF129
	RJMP __MAXRES
__ADDF128:
	RCALL __SWAPACC
__ADDF129:
	RCALL __REPACK
	POP  R21
	RET
__ADDF1211:
	BRCC __ADDF128
	RJMP __ADDF129
__ADDF127:
	SUB  R30,R26
	SBC  R31,R27
	SBC  R22,R24
	BREQ __ZERORES
	BRCC __ADDF1210
	COM  R0
	RCALL __NEGMAN1
__ADDF1210:
	TST  R22
	BRMI __ADDF129
	LSL  R30
	ROL  R31
	ROL  R22
	DEC  R23
	BRVC __ADDF1210

__ZERORES:
	CLR  R30
	CLR  R31
	CLR  R22
	CLR  R23
	POP  R21
	RET

__MINRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	SER  R23
	POP  R21
	RET

__MAXRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	LDI  R23,0x7F
	POP  R21
	RET

__MULF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R23,0x80
	BREQ __ZERORES
	CPI  R25,0x80
	BREQ __ZERORES
	EOR  R0,R1
	SEC
	ADC  R23,R25
	BRVC __MULF124
	BRLT __ZERORES
__MULF125:
	TST  R0
	BRMI __MINRES
	RJMP __MAXRES
__MULF124:
	PUSH R0
	PUSH R17
	PUSH R18
	PUSH R19
	PUSH R20
	CLR  R17
	CLR  R18
	CLR  R25
	MUL  R22,R24
	MOVW R20,R0
	MUL  R24,R31
	MOV  R19,R0
	ADD  R20,R1
	ADC  R21,R25
	MUL  R22,R27
	ADD  R19,R0
	ADC  R20,R1
	ADC  R21,R25
	MUL  R24,R30
	RCALL __MULF126
	MUL  R27,R31
	RCALL __MULF126
	MUL  R22,R26
	RCALL __MULF126
	MUL  R27,R30
	RCALL __MULF127
	MUL  R26,R31
	RCALL __MULF127
	MUL  R26,R30
	ADD  R17,R1
	ADC  R18,R25
	ADC  R19,R25
	ADC  R20,R25
	ADC  R21,R25
	MOV  R30,R19
	MOV  R31,R20
	MOV  R22,R21
	MOV  R21,R18
	POP  R20
	POP  R19
	POP  R18
	POP  R17
	POP  R0
	TST  R22
	BRMI __MULF122
	LSL  R21
	ROL  R30
	ROL  R31
	ROL  R22
	RJMP __MULF123
__MULF122:
	INC  R23
	BRVS __MULF125
__MULF123:
	RCALL __ROUND_REPACK
	POP  R21
	RET

__MULF127:
	ADD  R17,R0
	ADC  R18,R1
	ADC  R19,R25
	RJMP __MULF128
__MULF126:
	ADD  R18,R0
	ADC  R19,R1
__MULF128:
	ADC  R20,R25
	ADC  R21,R25
	RET

__DIVF21:
	PUSH R21
	RCALL __UNPACK
	CPI  R23,0x80
	BRNE __DIVF210
	TST  R1
__DIVF211:
	BRPL __DIVF219
	RJMP __MINRES
__DIVF219:
	RJMP __MAXRES
__DIVF210:
	CPI  R25,0x80
	BRNE __DIVF218
__DIVF217:
	RJMP __ZERORES
__DIVF218:
	EOR  R0,R1
	SEC
	SBC  R25,R23
	BRVC __DIVF216
	BRLT __DIVF217
	TST  R0
	RJMP __DIVF211
__DIVF216:
	MOV  R23,R25
	PUSH R17
	PUSH R18
	PUSH R19
	PUSH R20
	CLR  R1
	CLR  R17
	CLR  R18
	CLR  R19
	CLR  R20
	CLR  R21
	LDI  R25,32
__DIVF212:
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	CPC  R20,R17
	BRLO __DIVF213
	SUB  R26,R30
	SBC  R27,R31
	SBC  R24,R22
	SBC  R20,R17
	SEC
	RJMP __DIVF214
__DIVF213:
	CLC
__DIVF214:
	ROL  R21
	ROL  R18
	ROL  R19
	ROL  R1
	ROL  R26
	ROL  R27
	ROL  R24
	ROL  R20
	DEC  R25
	BRNE __DIVF212
	MOVW R30,R18
	MOV  R22,R1
	POP  R20
	POP  R19
	POP  R18
	POP  R17
	TST  R22
	BRMI __DIVF215
	LSL  R21
	ROL  R30
	ROL  R31
	ROL  R22
	DEC  R23
	BRVS __DIVF217
__DIVF215:
	RCALL __ROUND_REPACK
	POP  R21
	RET

__CMPF12:
	TST  R25
	BRMI __CMPF120
	TST  R23
	BRMI __CMPF121
	CP   R25,R23
	BRLO __CMPF122
	BRNE __CMPF121
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	BRLO __CMPF122
	BREQ __CMPF123
__CMPF121:
	CLZ
	CLC
	RET
__CMPF122:
	CLZ
	SEC
	RET
__CMPF123:
	SEZ
	CLC
	RET
__CMPF120:
	TST  R23
	BRPL __CMPF122
	CP   R25,R23
	BRLO __CMPF121
	BRNE __CMPF122
	CP   R30,R26
	CPC  R31,R27
	CPC  R22,R24
	BRLO __CMPF122
	BREQ __CMPF123
	RJMP __CMPF121

__ADDW2R15:
	CLR  R0
	ADD  R26,R15
	ADC  R27,R0
	RET

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__ANEGD1:
	COM  R31
	COM  R22
	COM  R23
	NEG  R30
	SBCI R31,-1
	SBCI R22,-1
	SBCI R23,-1
	RET

__LSLB12:
	TST  R30
	MOV  R0,R30
	MOV  R30,R26
	BREQ __LSLB12R
__LSLB12L:
	LSL  R30
	DEC  R0
	BRNE __LSLB12L
__LSLB12R:
	RET

__LSRB12:
	TST  R30
	MOV  R0,R30
	MOV  R30,R26
	BREQ __LSRB12R
__LSRB12L:
	LSR  R30
	DEC  R0
	BRNE __LSRB12L
__LSRB12R:
	RET

__CBD1:
	MOV  R31,R30
	ADD  R31,R31
	SBC  R31,R31
	MOV  R22,R31
	MOV  R23,R31
	RET

__MULW12U:
	MUL  R31,R26
	MOV  R31,R0
	MUL  R30,R27
	ADD  R31,R0
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	RET

__MULD12U:
	MUL  R23,R26
	MOV  R23,R0
	MUL  R22,R27
	ADD  R23,R0
	MUL  R31,R24
	ADD  R23,R0
	MUL  R30,R25
	ADD  R23,R0
	MUL  R22,R26
	MOV  R22,R0
	ADD  R23,R1
	MUL  R31,R27
	ADD  R22,R0
	ADC  R23,R1
	MUL  R30,R24
	ADD  R22,R0
	ADC  R23,R1
	CLR  R24
	MUL  R31,R26
	MOV  R31,R0
	ADD  R22,R1
	ADC  R23,R24
	MUL  R30,R27
	ADD  R31,R0
	ADC  R22,R1
	ADC  R23,R24
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	ADC  R22,R24
	ADC  R23,R24
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__DIVW21:
	RCALL __CHKSIGNW
	RCALL __DIVW21U
	BRTC __DIVW211
	RCALL __ANEGW1
__DIVW211:
	RET

__MODW21:
	CLT
	SBRS R27,7
	RJMP __MODW211
	COM  R26
	COM  R27
	ADIW R26,1
	SET
__MODW211:
	SBRC R31,7
	RCALL __ANEGW1
	RCALL __DIVW21U
	MOVW R30,R26
	BRTC __MODW212
	RCALL __ANEGW1
__MODW212:
	RET

__CHKSIGNW:
	CLT
	SBRS R31,7
	RJMP __CHKSW1
	RCALL __ANEGW1
	SET
__CHKSW1:
	SBRS R27,7
	RJMP __CHKSW2
	COM  R26
	COM  R27
	ADIW R26,1
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSW2:
	RET

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__GETW1PF:
	LPM  R0,Z+
	LPM  R31,Z
	MOV  R30,R0
	RET

__GETD2S0:
	LD   R26,Y
	LDD  R27,Y+1
	LDD  R24,Y+2
	LDD  R25,Y+3
	RET

__PUTD1S0:
	ST   Y,R30
	STD  Y+1,R31
	STD  Y+2,R22
	STD  Y+3,R23
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

__SWAPB12:
	MOV  R1,R26
	MOV  R26,R30
	MOV  R30,R1
	RET

__EEPROMRDB:
	SBIC EECR,EEWE
	RJMP __EEPROMRDB
	PUSH R31
	IN   R31,SREG
	CLI
	OUT  EEARL,R26
	OUT  EEARH,R27
	SBI  EECR,EERE
	IN   R30,EEDR
	OUT  SREG,R31
	POP  R31
	RET

__EEPROMWRB:
	SBIS EECR,EEWE
	RJMP __EEPROMWRB1
	WDR
	RJMP __EEPROMWRB
__EEPROMWRB1:
	IN   R25,SREG
	CLI
	OUT  EEARL,R26
	OUT  EEARH,R27
	SBI  EECR,EERE
	IN   R24,EEDR
	CP   R30,R24
	BREQ __EEPROMWRB0
	OUT  EEDR,R30
	SBI  EECR,EEMWE
	SBI  EECR,EEWE
__EEPROMWRB0:
	OUT  SREG,R25
	RET

__CPW02:
	CLR  R0
	CP   R0,R26
	CPC  R0,R27
	RET

__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
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
