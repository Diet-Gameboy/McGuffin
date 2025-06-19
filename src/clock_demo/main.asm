;Author: Phoenix Cushman (Diet-Gameboy on GitHub)
;File Name main.asm
;Date Created: 1/23/2025 4:30pm
;Last Modified: 6/5/2025
;Description:
;	This is a small application that runs an ascii clock.
;	The clock is timed using an Interrupt service routine driven by the First TI83+ Hardware Timer at 110Hz.
;	The clock will run for exactly an hour and then swap out the clock display with a nifty message.
;	You can press the down arrow at any time to exit the program.
;Acknowledgements:
;	Special Thanks to Brandon Wilson for the ti83plus.inc include file
;	Special Thanks to the folks at WikiTI for all their amazing documentation and calculator specifications!
;	Special Thanks to Spencer Putt and Don Straney for the SPASM-ng Z80 Assembler

.nolist
#include "ti83plus.inc"
#include "hardware_defs.inc"

;custom defines for the program
#define CLOCK_CYCLES_PER_SEC (110)
#define FAV_BRIGHTNESS_LEVEL ($17+OS_CONTRAST_COMMAND_OFFSET) ; = $EF (screen brightness)(this was my favorite level)
#define OS_CONTRAST_COMMAND_OFFSET ($D8)
#define CLOCK_TIME_FIELD_ROW (4)
#define CLOCK_TIME_FIELD_COL (5)

.list

	.org $4000

		;File header pulled from WikiTI
	; Master Field
	.db	$80, $0F, 0, 0, 0, 0
	; Name. Note that the name field reads 80 43 because the name specified here is 3 characters long.
	.db	$80, $48, "TimeDemo" ;NOTE: File name must be 8bytes longs so the 43 was replaced by 48 and the name was extended
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

initialization:
	; disable interrupts while initalizing values and clear/reset the LCD
	di
	bcall(_ClrScrn)
	; reset cursor to 0,0
	xor a
	ld (curRow),a
	ld (curCol),a
	; initialize the counter ascii values
	ld a,'0'
	ld (time_counter_10_min),a
	ld (time_counter_min),a
	ld (time_counter_10_sec),a
	ld (time_counter_sec),a
	ld a,':'
	ld (time_counter_colon),a
	xor a
	ld (time_counter_null),a
	; copy the backgrond string into a ram buffer and print from there
	ld hl,BACKGROUND_STRING
	ld de,background_string_buffer
	bcall(_strcopy)
	ld hl,background_string_buffer
	bcall(_PutS)
	; install the ISR and activate
	call install_ISR
	ei
	jr main_loop
main:
main_loop:

	;bcall(_GrBufCpy)

	; scan for a user key press
	bcall(_kdbScan)
	bcall(_GetCSC)
    cp skDown
    jp z,exit ;exit the program if the down key was pressed
	;
	; reset the cursor to point to the time field in the clock art background
	ld a,CLOCK_TIME_FIELD_ROW
	ld (curRow),a
	ld a,CLOCK_TIME_FIELD_COL
	ld (curCol),a
	;
	; run the update logic to update the timer display if needed
update_time_sec:
	ld a,(time_counter_cycles)
	cp CLOCK_CYCLES_PER_SEC		;if the timer has counted this number of cycles a second has passed
	jr nz, skip_update_time_sec
	xor a		;reset the cycle counter
	ld (time_counter_cycles),a
	ld hl,time_counter_sec
	inc (hl)	;increment the seconds counter
skip_update_time_sec:
	;
update_time_10_sec:
	ld a,(time_counter_sec)
	cp '0'+10	;if the seconds counter has reached '10' it can be reset to '0' the next digit over can be incremented (the 10 seconds counter)
	jr nz, skip_update_time_10_sec
	ld a,'0'	;reset the seconds counter
	ld (time_counter_sec),a
	ld hl,time_counter_10_sec
	inc (hl)	;increment the 10 seconds counter
skip_update_time_10_sec:
	;
update_colon:
	ld a,(time_counter_cycles)
	cp 0 ;if the cycle counter is zero set the colon to on
	jr z,update_colon_set
	cp CLOCK_CYCLES_PER_SEC / 2 ;if the cycle counter is halfway through a second set the colon to off
	jr z,update_colon_reset
	jr skip_update_colon
update_colon_set:
	ld a,':'
	ld (time_counter_colon),a
	jr skip_update_colon
update_colon_reset:
	ld a,' '
	ld (time_counter_colon),a
skip_update_colon:
	;
update_time_min:
	ld a,(time_counter_10_sec)
	cp '0'+6	;if the 10 seconds counter has reached '6' a minute has passed
	jr nz, skip_update_time_min
	ld a,'0'	;reset the 10 seconds counter to '0'
	ld (time_counter_10_sec),a
	ld hl,time_counter_min
	inc (hl)	;increment the minutes counter
skip_update_time_min:
	;
update_time_10_min:
	ld a,(time_counter_min)
	cp '0'+10	;if the minutes counter has reached '10', increment the 10 minutes counter
	jr nz, skip_update_time_10_min
	ld a,'0'	;reset the minutes counter to '0'
	ld (time_counter_min),a
	ld hl,time_counter_10_min
	inc (hl)	;increment the 10 minutes counter
skip_update_time_10_min:
	;
overflow_error:
	ld a,(time_counter_10_min)
	cp '0'+6	;if the 10 minutes counter reaches '6' then an hour has passed and the clock can be turned off to display the fun message
	jr nz, skip_overflow_error
	call disable_ISR
	bcall(_ClrWindow)
	ld hl,ERROR_STRING
	ld de,error_string_buffer
	bcall(_strcopy)
	ld hl,error_string_buffer
	bcall(_PutS)
overflow_error_loop: ;this loop keeps scanning the keys to allow the user to exit the program whenever they would like
	bcall(_kdbScan)
	bcall(_GetCSC)
    cp skDown
    jr nz,overflow_error_loop ;don't exit the program if the down key wasn't pressed
	jr exit
skip_overflow_error:
	;
	; print the finally updated time display string
	ld hl,time_counter
	bcall(_PutS)
	call enable_ISR ;PutS is one of the bcalls in the TIOS that disable interrupts after being called so we have to re-enable our interrupt afterwards
	;
	jp main_loop
exit:
	call disable_ISR
	di
	bcall(_ClrWindow)
	xor a ;set this for the both as 0 col and row
	ld (curRow),a
	ld (curCol),a
	ld a,(contrast) ;reset to the system contrast just in case
	add a,OS_CONTRAST_COMMAND_OFFSET
	call send_lcd_command
	ei
	bjump(_JForceCmdNoChar) ;End the program and the return to the Operating System

;************************************************************************************************************
; Program Functions
;************************************************************************************************************

;**********************************
;Function Name: send_lcd_command
;Description: Sends a 8-bit command to the lcd command port
;Parameters:
;	A register - The 8-bit command
;**********************************
send_lcd_command:
	out (PORT10),a ;the lcd command port
	call _LCD_BUSY_QUICK
	ret

;**********************************
;Function Name: install_ISR
;Description: Loads the custom Interrupt Service Routine (ISR) and the Interrupt Mode 2 vector table
;	into a region in the Graph Screen Ram. The ISR is loaded into ram because if it attempted to be executed
;	out of the Application ROM this program could potentially be pages out of memory, so running it from
;	RAM is safer.
;Parameters:
;	None
;**********************************
install_ISR:
	di
	;--copy the table into the open ram location we are going to use
	ld hl,ISR_table_start ;$9400
	ld (hl),ISR_code_buffer_start >> 8 ;$95
	ld de,ISR_table_start + 1 ;$9400 + 1
	ld bc,ISR_table_size
	ldir
	;--copy the ISR code to the pointer value that will be put into the table
	ld hl,ISR_START
	ld de,ISR_code_buffer_start ;$9595
	ld bc,ISR_END - ISR_START
	ldir
	;--set the interrupt settings for the devices
	ld a,PORT3_LOW_POWER_bm		;Acknowledge and disable, keep the Low power mode disabled by writing 1
	out (PORT3),a
	ld a,PORT3_LOW_POWER_bm | PORT3_HARDWARE_TIMER_1_bm		;Set 1st timer active
	out (PORT3),a
	ld a,PORT4_w_HARDWARE_TIMER_FREQ_MODE3_gc		;Slowest frequency, ~110Hz
	out (PORT4),a
	;--set the interrupt register upper byte to point to the table's page
	ld a,ISR_table_start >> 8 ;$94
	ld i,a
	im 2
	ei
	ret

;**********************************
;Function Name: enable_ISR
;Description: Turns on the custom interrupt service routine by switching the CPU into
;	mode 2, and setting the interrupt register upper byte to point to the table's page.
;Parameters:
;	None
;Note: Typically this function should be used to reactivate the ISR after the use of a bcall
;   that resets interrupt modes (ex: arc_unarc). The install ISR function already does this
;   function as well, so no need to call it if you just called install_ISR.
;**********************************
enable_ISR:
	im 2
	ei
	ret

;**********************************
;Function Name: disable_ISR
;Description: Turns off the custom interrupt service routine by switching the CPU out of
;	mode 2, into mode 1, and resetting the system devices to normal operation modes.
;Parameters:
;	None
;**********************************
disable_ISR:
	di
	;--reset any system devices we need to for normal OS operation (On button, Hardware Clock 1, Low power mode off)
	ld a,PORT3_LOW_POWER_bm | PORT3_HARDWARE_TIMER_1_bm | PORT3_ON_KEY_bm
	out (PORT3),a
	;--basically just reset the processor to interrupt mode 1
	im 1
	ei
	ret

;**********************************
;Function Name: ISR
;Description: This is the custom interrupt service routine used to make an accurate clock. It executes
;	at a rate of 110Hz. It resets Hardware clock 1 for the next routine and increments a global variable
;	called time_counter_cycles which drive the clock logic in the main program.
;Parameters:
;	None
;Note: this code should not execute from this location in the application memory. The install_ISR
;	function will instead copy this code into ram for safe execution, as we can't know if the
;	OS rom, or Application rom, is paged into memory at any given moment.
;**********************************
ISR:
ISR_START:
	exx ;because the TI-OS doesn't use the shadow registers for anything, we can use them for speedy interrupt execution
	ex af,af'
	;--refresh the interrupt settings for the devices
	ld a,PORT3_LOW_POWER_bm		;Acknowledge and disable, keep the Low power mode disabled by writing 1
	out (PORT3),a
	ld a,PORT3_LOW_POWER_bm | PORT3_HARDWARE_TIMER_1_bm		;Set 1st timer active
	out (PORT3),a
	ld a,PORT4_w_HARDWARE_TIMER_FREQ_MODE3_gc		;Slowest frequency, ~110Hz
	out (PORT4),a
	;--run all non essential computations (updating the counter in this case)
	ld hl,time_counter_cycles
	inc (hl)
	;--restore all the registers and return execution to the main program
	ex af,af'
	exx
	ei
	reti
ISR_END:

;************************************************************************************************************
; Program Data and Strings
;************************************************************************************************************
BACKGROUND_STRING:	
	.db "Hit Down To Exit"
	.db "     _   _      "
	.db "    (_)T(_)     "
	.db "   /",$0A,"-----",$0A,"\\    "
	.db "   ",$7F,"|     |",$7F,"    "
	.db "   ",$7F,$D4,"-----",$D4,$7F,"    "
	.db "   \\_______/    "
	.db "    ",$B6,$B6,"   ",$B7,$B7,"     ",0
BACKGROUND_STRING_END:

ERROR_STRING:
	.db "Man you must have nothing to do XD. Thanks for watching! -Phoenix Cushman @Diet-Gameboy on Github 2025",0
ERROR_STRING_END:

;************************************************************************************************************
; Program Variables and Ram space
;	Note: For some reason the spasm-ng assembler doesn't
;	like it when this stuff is placed before the application header
;	so that is why it's located down here.
;************************************************************************************************************
ram_location:	equ	plotSScreen ;I'm using the graphscreen as free ram ;$9340
#define background_string_buffer_size (BACKGROUND_STRING_END - BACKGROUND_STRING)
#define error_string_buffer_size (ERROR_STRING_END - ERROR_STRING)
ISR_table_start:		equ	$9400
ISR_code_buffer_start:		equ	$9595
#define ISR_table_size (257)
#define ISR_code_buffer_size (ISR_END - ISR_START)

	.org ram_location

time_counter: ;this label is used as the pointer into this string that stores the time data
time_counter_10_min:	.db 0
time_counter_min:		.db 0
time_counter_colon:		.db 0
time_counter_10_sec:	.db 0
time_counter_sec:		.db 0
time_counter_null:		.db 0
time_counter_cycles:	.db 0
background_string_buffer:	.fill background_string_buffer_size,0
error_string_buffer:		.fill error_string_buffer_size,0

	.org ISR_table_start

ISR_table:		.fill ISR_table_size,0
ISR_table_end: ;AKA $9501

	.org ISR_code_buffer_start

ISR_code_buffer:	.fill ISR_code_buffer_size,0
ISR_code_buffer_end: