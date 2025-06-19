;Author: Phoenix Cushman (Diet-Gameboy on GitHub)
;File Name main.asm
;Date Created: Fall 2023 (Unknown)
;Last Modified: 6/17/2025
;Description:
;	This program is the main release of the MCGuffin Game Title.
;	This file contains the main entry point and exit point for the TI Application
;Acknowledgements:
;	Special Thanks to Brandon Wilson for the ti83plus.inc include file
;	Special Thanks to the folks at WikiTI for all their amazing documentation and calculator specifications!
;	Special Thanks to Spencer Putt and Don Straney for the SPASM-ng Z80 Assembler

.nolist
#include "ti83plus.inc"
#include "hardware_defs.inc"

#define FAV_BRIGHTNESS_LEVEL ($17+OS_CONTRAST_COMMAND_OFFSET) ; = $EF (screen brightness)(this was my favorite level)
#define OS_CONTRAST_COMMAND_OFFSET ($D8)

.list

	.org $4000

		;File header pulled from WikiTI
	; Master Field
	.db	$80, $0F, 0, 0, 0, 0
	; Name. Note that the name field reads 80 43 because the name specified here is 3 characters long.
	.db	$80, $48, "MCGuffin" ;NOTE: File name must be 8bytes longs so the 43 was replaced by 48 and the name was extended
	; Disable TI splash screen.
	.db	$80, $90
	; Pages
	.db	$80, $81, 1
	; Signing Key ID
	.db	$80, $12, 1, 4 ; or 15 for the TI-84+CSE
	; Date stamp.  Apparently, the calculator doesn't mind if you put
	; nothing in this.
	.db	$03, $22, $09, $00
	; Date stamp signature.  Since nothing ever checks this, there's no
	; reason ever to update it.  Or even have data in it.
	.db	$02, 00
	; Final field
	.db	$80, $70
	; No need for padding here. The OS will just start execution here.

;************************************************************************************************************
; Main Program Initilization and Execution Loop
;************************************************************************************************************

initialization: ;adress $4020
	di ; disable interrupts while initalizing values and clear/reset the LCD
	bcall(_RunIndicOff)
	bcall(_ClrScrn)
	ld a,FAV_BRIGHTNESS_LEVEL
	call send_lcd_command
	call clean_ram ;clean out our ram for game variables
	call unload_dialogue_boxes
	call load_default_game_vars
	call check_battery
	call save_file_load_manager
	call install_ISR
	ei
start:
	call title_screen
	call load_room
	call draw_player_and_background_background
	call game_loop
exit:
	di
	call disable_ISR
	bcall(_ClrWindow)
	xor a ;set this for the both as 0 col and row
	ld (curRow),a
	ld (curCol),a
	ld a,(contrast) ;reset to the system contrast just in case
	add a,OS_CONTRAST_COMMAND_OFFSET
	call send_lcd_command
	bcall(_RunIndicOn)
	ei
	bjump(_JForceCmdNoChar) ;End the program and the return to the Operating System

;************************************************************************************************************
; Other Game Defines, Functions, and Data.
;************************************************************************************************************

#include "isr.asm"
#include "functions.asm"
#include "rle.asm"
#include "menu.asm"
#include "collision.asm"
#include "scripts.asm"
#include "dialogue.asm"
#include "room_load.asm"
#include "room_data.asm"
#include "memory.asm"