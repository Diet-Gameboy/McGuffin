;Author: Phoenix Cushman (Diet-Gameboy on GitHub)
;File Name hardware_defs.asm
;Date Created: 6/2/2025
;Last Modified: 6/2/2025
;Description: Includes several defines to help detail and make interfacing with the hardware easier and more readible.
;Acknowledgements:
;	Special Thanks to the folks at WikiTI for all their amazing documentation and calculator specifications!

_LCD_BUSY_QUICK:	.equ $000B ;extra equate because ti83plus.inc doesn't have this one

;port 3 (Interrupt Masking Port) bit masks
#define PORT3 ($3)
#define PORT3_ON_KEY_bm (%00000001)
#define PORT3_HARDWARE_TIMER_1_bm (%00000010)
#define PORT3_HARDWARE_TIMER_2_bm (%00000100)
#define PORT3_LOW_POWER_bm (%00001000)
#define PORT3_LINKPORT_bm (%00010000)

;port 4 (Interrupting Device Identification and Memory Map Control) bit masks
#define PORT4 ($4)
;port read bit masks (identifies interrupt trigger)
#define PORT4_r_ON_KEY_bm (%00000001)
#define PORT4_r_HARDWARE_TIMER_1_bm (%00000010)
#define PORT4_r_HARDWARE_TIMER_2_bm (%00000100)
#define PORT4_r_ON_KEY_PRESSED_bm (%00001000)
#define PORT4_r_LINKPORT_bm (%00010000)
;port write bit masks (sets interrupt device settings)
#define PORT4_w_MEM_MAP_MODE_bm (%00000001)
#define PORT4_w_HARDWARE_TIMER_FREQ_b0 (%00000010)
#define PORT4_w_HARDWARE_TIMER_FREQ_b1 (%00000100)
#define PORT4_w_HARDWARE_TIMER_FREQ_gm (%00000110)
#define PORT4_w_HARDWARE_TIMER_FREQ_MODE0_gc (%00000000)
#define PORT4_w_HARDWARE_TIMER_FREQ_MODE1_gc (%00000010)
#define PORT4_w_HARDWARE_TIMER_FREQ_MODE2_gc (%00000100)
#define PORT4_w_HARDWARE_TIMER_FREQ_MODE3_gc (%00000110)

;port 10 (LCD Command and Status Port) bit masks
#define PORT10 ($10)
;port read bit masks (reads the LCD device status flags)
#define PORT10_r_AUTO_INC_DEC_MODE_bm (%00000001)
#define PORT10_r_AUTO_INC_ROW_COL_bm (%00000010)
#define PORT10_r_OPERATING_STATE_bm (%00010000)
#define PORT10_r_DISPLAY_ENABLED_bm (%00100000)
#define PORT10_r_LCD_TRANSFER_WIDTH_bm (%01000000)
#define PORT10_r_LCD_BUSY_bm (%10000000)
;port write bit masks (sends commands to the LCD device controller)
#define PORT10_w_6_BIT_MODE_gc ($00)
#define PORT10_w_8_BIT_MODE_gc ($01)
#define PORT10_w_DISABLE_SCREEN_gc ($02)
#define PORT10_w_ENABLE_SCREEN_gc ($03)
#define PORT10_w_AUTO_X_DEC_MODE_gc ($04)
#define PORT10_w_AUTO_X_INC_MODE_gc ($05)
#define PORT10_w_AUTO_Y_DEC_MODE_gc ($06)
#define PORT10_w_AUTO_Y_INC_MODE_gc ($07)
#define PORT10_w_POWER_SUPPLY_ENHANCEMENT_ib ($08) ;$08-$0B
#define PORT10_w_SCREEN_MIRRORING_ib ($0C) ;$0C-$0F
#define PORT10_w_POWER_SUPPLY_LEVEL_ib ($10) ;$10-$13
#define PORT10_w_CANCEL_TEST_MODE_gc ($18)
#define PORT10_w_ENTER_TEST_MODE_ib ($1C) ;$1C-1F
#define PORT10_w_SET_COL_ib ($20) ;$20-$3F
#define PORT10_w_Z_ADRESSING_ib ($40) ;$40-$7F
#define PORT10_w_SET_ROW_ib ($80) ;$80-$BF
#define PORT10_w_SET_CONTRAST_ib ($C0) ;$C0-$FF

;port 11 (LCD Data Port)
#define PORT11 ($11)