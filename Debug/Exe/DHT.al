;PCODE: $00000000 VOL: 0
	#ifndef __SLEEP_DEFINED__
;PCODE: $00000001 VOL: 0
	#define __SLEEP_DEFINED__
;PCODE: $00000002 VOL: 0
	.EQU __se_bit=0x80
;PCODE: $00000003 VOL: 0
	.EQU __sm_mask=0x70
;PCODE: $00000004 VOL: 0
	.EQU __sm_powerdown=0x20
;PCODE: $00000005 VOL: 0
	.EQU __sm_powersave=0x30
;PCODE: $00000006 VOL: 0
	.EQU __sm_standby=0x60
;PCODE: $00000007 VOL: 0
	.EQU __sm_ext_standby=0x70
;PCODE: $00000008 VOL: 0
	.EQU __sm_adc_noise_red=0x10
;PCODE: $00000009 VOL: 0
	.SET power_ctrl_reg=mcucr
;PCODE: $0000000A VOL: 0
	#endif
;PCODE: $0000000B VOL: 0
;PCODE: $0000000C VOL: 0

	.CSEG
;PCODE: $0000000D VOL: 0
;PCODE: $0000000E VOL: 0
;PCODE: $0000000F VOL: 0
;PCODE: $00000010 VOL: 0
;PCODE: $00000011 VOL: 0
;PCODE: $00000012 VOL: 0
;PCODE: $00000013 VOL: 0
;PCODE: $00000014 VOL: 0
;PCODE: $00000015 VOL: 0
;PCODE: $00000016 VOL: 0
;PCODE: $00000017 VOL: 0
;PCODE: $00000018 VOL: 0
;PCODE: $00000019 VOL: 0
;PCODE: $0000001A VOL: 0
;PCODE: $0000001B VOL: 0
;PCODE: $0000001C VOL: 0
;PCODE: $0000001D VOL: 0
;PCODE: $0000001E VOL: 0
;PCODE: $0000001F VOL: 0
;PCODE: $00000020 VOL: 0
;PCODE: $00000021 VOL: 0
;PCODE: $00000022 VOL: 0
;PCODE: $00000023 VOL: 0
;PCODE: $00000024 VOL: 0
;PCODE: $00000025 VOL: 0
;PCODE: $00000026 VOL: 0
;PCODE: $00000027 VOL: 0
;PCODE: $00000028 VOL: 0
;PCODE: $00000029 VOL: 0
;PCODE: $0000002A VOL: 0
;PCODE: $0000002B VOL: 0
;PCODE: $0000002C VOL: 0
;PCODE: $0000002D VOL: 0
;PCODE: $0000002E VOL: 0
;PCODE: $0000002F VOL: 0
;PCODE: $00000030 VOL: 0
;PCODE: $00000031 VOL: 0
;PCODE: $00000032 VOL: 0
;PCODE: $00000033 VOL: 0
;PCODE: $00000034 VOL: 0
;PCODE: $00000035 VOL: 0
;PCODE: $00000036 VOL: 0
;PCODE: $00000037 VOL: 0
;PCODE: $00000038 VOL: 0
;PCODE: $00000039 VOL: 0
;PCODE: $0000003A VOL: 0
;PCODE: $0000003B VOL: 0
;PCODE: $0000003C VOL: 0
;PCODE: $0000003D VOL: 0
;PCODE: $0000003E VOL: 0
;PCODE: $0000003F VOL: 0
;PCODE: $00000040 VOL: 0
;PCODE: $00000041 VOL: 0
;PCODE: $00000042 VOL: 0
;PCODE: $00000043 VOL: 0
;PCODE: $00000044 VOL: 0
;PCODE: $00000045 VOL: 0
;PCODE: $00000046 VOL: 0
;PCODE: $00000047 VOL: 0
;PCODE: $00000048 VOL: 0
;PCODE: $00000049 VOL: 0
;PCODE: $0000004A VOL: 0
;PCODE: $0000004B VOL: 0
;PCODE: $0000004C VOL: 0
;PCODE: $0000004D VOL: 0
;PCODE: $0000004E VOL: 0
;PCODE: $0000004F VOL: 0
;PCODE: $00000050 VOL: 0
;PCODE: $00000051 VOL: 0
;PCODE: $00000052 VOL: 0
;PCODE: $00000053 VOL: 0
;PCODE: $00000054 VOL: 0
;PCODE: $00000055 VOL: 0
;PCODE: $00000056 VOL: 0
;PCODE: $00000057 VOL: 0
;PCODE: $00000058 VOL: 0
;PCODE: $00000059 VOL: 0
;PCODE: $0000005A VOL: 0
;PCODE: $0000005B VOL: 0
;PCODE: $0000005C VOL: 0
;PCODE: $0000005D VOL: 0
;PCODE: $0000005E VOL: 0
;PCODE: $0000005F VOL: 0
;PCODE: $00000060 VOL: 0
;PCODE: $00000061 VOL: 0
;PCODE: $00000062 VOL: 0
;PCODE: $00000063 VOL: 0
;PCODE: $00000064 VOL: 0
;PCODE: $00000065 VOL: 0
;PCODE: $00000066 VOL: 0
;PCODE: $00000067 VOL: 0
;PCODE: $00000068 VOL: 0
;PCODE: $00000069 VOL: 0
;PCODE: $0000006A VOL: 0
;PCODE: $0000006B VOL: 0
;PCODE: $0000006C VOL: 0
;PCODE: $0000006D VOL: 0
;PCODE: $0000006E VOL: 0
;PCODE: $0000006F VOL: 0
;PCODE: $00000070 VOL: 0
;PCODE: $00000071 VOL: 0
;PCODE: $00000072 VOL: 0
;PCODE: $00000073 VOL: 0
;PCODE: $00000074 VOL: 0
;PCODE: $00000075 VOL: 0
;PCODE: $00000076 VOL: 0
;PCODE: $00000077 VOL: 0
;PCODE: $00000078 VOL: 0
;PCODE: $00000079 VOL: 0
;PCODE: $0000007A VOL: 0
;PCODE: $0000007B VOL: 0
;PCODE: $0000007C VOL: 0
;PCODE: $0000007D VOL: 0
;PCODE: $0000007E VOL: 0
;PCODE: $0000007F VOL: 0
;PCODE: $00000080 VOL: 0
;PCODE: $00000081 VOL: 0
;PCODE: $00000082 VOL: 0
;PCODE: $00000083 VOL: 0
;PCODE: $00000084 VOL: 0
;PCODE: $00000085 VOL: 0
;PCODE: $00000086 VOL: 0
;PCODE: $00000087 VOL: 0
;PCODE: $00000088 VOL: 0
;PCODE: $00000089 VOL: 0
;PCODE: $0000008A VOL: 0
;PCODE: $0000008B VOL: 0
;PCODE: $0000008C VOL: 0
;PCODE: $0000008D VOL: 0
;PCODE: $0000008E VOL: 0
;PCODE: $0000008F VOL: 0
;PCODE: $00000090 VOL: 0
;PCODE: $00000091 VOL: 0
;PCODE: $00000092 VOL: 0
;PCODE: $00000093 VOL: 0
;PCODE: $00000094 VOL: 0
;PCODE: $00000095 VOL: 0
;PCODE: $00000096 VOL: 0
;PCODE: $00000097 VOL: 0
;PCODE: $00000098 VOL: 0
;PCODE: $00000099 VOL: 0
;PCODE: $0000009A VOL: 0
;PCODE: $0000009B VOL: 0
;PCODE: $0000009C VOL: 0
;PCODE: $0000009D VOL: 0
;PCODE: $0000009E VOL: 0
;PCODE: $0000009F VOL: 0
;PCODE: $000000A0 VOL: 0
;PCODE: $000000A1 VOL: 0
;PCODE: $000000A2 VOL: 0
;PCODE: $000000A3 VOL: 0
;PCODE: $000000A4 VOL: 0
;PCODE: $000000A5 VOL: 0
;PCODE: $000000A6 VOL: 0
;PCODE: $000000A7 VOL: 0
;PCODE: $000000A8 VOL: 0
;PCODE: $000000A9 VOL: 0
;PCODE: $000000AA VOL: 0
;PCODE: $000000AB VOL: 0
;PCODE: $000000AC VOL: 0
;PCODE: $000000AD VOL: 0
;PCODE: $000000AE VOL: 0
;PCODE: $000000AF VOL: 0
;PCODE: $000000B0 VOL: 0
;PCODE: $000000B1 VOL: 0
;PCODE: $000000B2 VOL: 0
;PCODE: $000000B3 VOL: 0
;PCODE: $000000B4 VOL: 0
;PCODE: $000000B5 VOL: 0
;PCODE: $000000B6 VOL: 0
;PCODE: $000000B7 VOL: 0
;PCODE: $000000B8 VOL: 0
;PCODE: $000000B9 VOL: 0
;PCODE: $000000BA VOL: 0
;PCODE: $000000BB VOL: 0
