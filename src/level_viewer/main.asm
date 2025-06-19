;Author: Phoenix Cushman (Diet-Gameboy on GitHub)
;File Name main.asm
;Date Created: 3/3/2024 1:09pm
;Last Modified: 6/7/2025
;Description:
;	This program is a small slideshow app that's lets the user look through the level backgrounds of
;	the MCGuffin game. You press left and right to scroll through the levels and press down to exit.
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
#define LEVEL_NUM_FIELD_POS ($0102)
#define SMALLEST_PAGE (0)
#define LARGEST_PAGE ((background_lookup_table_end - background_lookup_table - 1)/2)
#define CHECK_KEYS_COOLDOWN (2)

.list

	.org $4000

		;File header pulled from WikiTI
	; Master Field
	.db	$80, $0F, 0, 0, 0, 0
	; Name. Note that the name field reads 80 43 because the name specified here is 3 characters long.
	.db	$80, $48, "MCLevels" ;NOTE: File name must be 8bytes longs so the 43 was replaced by 48 and the name was extended
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
	; initialize variables
	xor a
	ld (background_buffer_null),a
	ld a,SMALLEST_PAGE
	ld (page_number),a
	ld a,1
	ld (update_page),a
	;
	call install_ISR
	; re-enable interrutps now that initialization is complete
	ei
main:
main_loop:
	; scan for a user key press
	bcall(_kdbScan)
	bcall(_GetCSC)
    cp skDown
    jp z,exit ;exit the program if the down key was pressed

;--Read the key inputs to determine what page we're on
	ld hl,page_number
	;Left key check
	cp skLeft
	jr nz, flip_left_skip
flip_left:
	dec (hl)
	ld a,(hl)
	cp SMALLEST_PAGE - 1
	jr nz,flip_left_skip_bound
	ld (hl), SMALLEST_PAGE
	jr flip_left_skip
flip_left_skip_bound:
	ld hl,update_page
	ld (hl),1
flip_left_skip:
	;Right key check
	cp skRight
	jr nz, flip_right_skip
flip_right:
	inc (hl)
	ld a,(hl)
	cp (LARGEST_PAGE + 1) % 256 ;this is a weird trick needed for the assembler to work. (If the largest page is 255 then 255+1 needs to be modulo-ed by 256 to make 0)
	jr nz,flip_right_skip_bound
	ld (hl),LARGEST_PAGE
	jr flip_right_skip
flip_right_skip_bound:
	ld hl,update_page
	ld (hl),1
flip_right_skip:
display_menu:
;--Check if the page needs to be updated
	ld a,(update_page)
	cp 0
	jp z,display_arrows_skip
	xor a
	ld (update_page),a
;--Render the Background First
	bcall(_ClrScrn) ;Refresh the screen before printing
	call display_background
;--Display the Menu Arrows
	call print_level_num
	ld a,(page_number)
	cp SMALLEST_PAGE
	jr z,display_right_arrows
	cp LARGEST_PAGE
	jr z,display_left_arrows
display_both_arrows:
	ld a,1
	ld (hide_ui_counter_sec),a
	xor a
	ld (hide_ui_counter_cycles),a
	call render_left_arrows
	call render_right_arrows
	jr display_arrows_skip
display_left_arrows:
	ld a,1
	ld (hide_ui_counter_sec),a
	xor a
	ld (hide_ui_counter_cycles),a
	call render_left_arrows
	jr display_arrows_skip
display_right_arrows:
	ld a,1
	ld (hide_ui_counter_sec),a
	xor a
	ld (hide_ui_counter_cycles),a
	call render_right_arrows
	jr display_arrows_skip
display_arrows_skip:
	ld hl,hide_ui_flag
	ld a,1
	cp (hl)
	jr nz, skip_ui_hide
	ld (hl),0
	call display_background
skip_ui_hide:
	jp main_loop
exit:
	call disable_ISR
	di
	call loadgraph
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
;Function Name: render_left_arrows
;Description: This function draws the bitmap of the scroll left arrows
;	onto the screen.
;Parameters:
;	None
;**********************************
render_left_arrows:
	ld a,PORT10_w_AUTO_X_INC_MODE_gc
	call send_lcd_command
	ld a,PORT10_w_SET_ROW_ib + (8*8 / 2) - 11 ;the second bunch of numbers is the y offset for the graphic
	call send_lcd_command
	ld a,PORT10_w_SET_COL_ib
	call send_lcd_command	
	ld hl,left_arrow_graphic
	ld b, left_arrow_graphic_end - left_arrow_graphic
render_left_arrows_loop:
	ld a,(hl)
	call send_lcd_data
	inc hl
	djnz render_left_arrows_loop
	ret

;**********************************
;Function Name: render_right_arrows
;Description: This function draws the bitmap of the scroll right arrows
;	onto the screen.
;Parameters:
;	None
;**********************************
render_right_arrows:
	ld a,PORT10_w_AUTO_X_INC_MODE_gc
	call send_lcd_command
	ld a,PORT10_w_SET_ROW_ib + (8*8 / 2) - 11 ;the second bunch of numbers is the y offset for the graphic
	call send_lcd_command
	ld a,PORT10_w_SET_COL_ib + (12 - 1) ;the second bunch of numbers is the x offset for the graphic
	call send_lcd_command	
	ld hl,right_arrow_graphic
	ld b, right_arrow_graphic_end - right_arrow_graphic
render_right_arrows_loop:
	ld a,(hl)
	call send_lcd_data
	inc hl
	djnz render_right_arrows_loop
	ret

;**********************************
;Function Name: render_number_field
;Description: This function draws the bitmap of the level number background field 
;	onto the screen.
;Parameters:
;	None
;**********************************
render_number_field:
	ld c,PORT10_w_SET_ROW_ib
	ld a,c
	call send_lcd_command
	ld a,PORT10_w_SET_COL_ib
	call send_lcd_command
	ld hl,number_field_graphic
	ld b, number_field_graphic_end - number_field_graphic
	ld a,PORT10_w_AUTO_Y_INC_MODE_gc
	call send_lcd_command
render_number_field_loop:
	ld a,(hl)
	call send_lcd_data
	inc hl
	dec b
	ld a,(hl)
	call send_lcd_data
	inc hl
	inc c
	push bc
	ld a,c
	call send_lcd_command
	pop bc
	ld a,PORT10_w_SET_COL_ib
	call send_lcd_command
	djnz render_number_field_loop
	ret

;**********************************
;Function Name: display_background
;Description: This function uses the rle_decompressor function to load the current
;	level background data into the background buffer and then uses _PutS to print
;	it to the screen.
;Parameters:
;	None
;**********************************
display_background:
	;xor a
	;ld (curRow),a
	;ld a,1
	;ld (curCol),a
	;ld a,(time_counter_cycles)
	;bcall(_PutC)
	;
	ld hl,background_lookup_table
	ld d,0
	ld a,(page_number)
	ld e,a
	sla e
	add hl,de
	;
	ld e,(hl)
	inc hl
	ld d,(hl)
	ld hl,background_buffer
	ex de,hl
	call rle_decompressor
	;
	xor a
	ld (background_buffer_null),a
	ld (curCol),a
	ld (curRow),a
	ld hl,background_buffer
	bcall(_PutS)
	call enable_ISR ;PutS is one of the bcalls in the TIOS that disable interrupts after being called so we have to re-enable our interrupt afterwards
	ret

;**********************************
;Function Name: print_level_num
;Description: This function first calls render_number_field to render the bitmap
;	of the level number field and then calls bin8_to_dec3 to convert the level
;	number to BCD which it then prints using _VPutMap.
;Parameters:
;	None
;**********************************
print_level_num:
	call render_number_field
	ld a,(page_number)
	call bin8_to_dec3
	push de
	ld a,'0'
	add a,b
	ld hl,LEVEL_NUM_FIELD_POS
	ld (penCol),hl
	BCALL(_VPutMap)
	call enable_ISR ;VPutMap is one of the bcalls in the TIOS that disable interrupts after being called so we have to re-enable our interrupt afterwards
	ld a,'0'
	add a,c
	BCALL(_VPutMap)
	call enable_ISR ;VPutMap is one of the bcalls in the TIOS that disable interrupts after being called so we have to re-enable our interrupt afterwards
	pop de
	ld a,'0'
	add a,d
	BCALL(_VPutMap)
	call enable_ISR ;VPutMap is one of the bcalls in the TIOS that disable interrupts after being called so we have to re-enable our interrupt afterwards
	ret

;**********************************
;Function Name: bin8_to_dec3
;Description: This function takes an 8-bit binary number in the a register and returns
;	3 Binary Coded Decimal digits representing the number in the b,c,d registers (hehe)
;Parameters:
;	A register - Input 8-bit Value
;	B register - Lower nibble contains the most significant BCD digit (upper nibble is 0000)
;	C register - Lower nibble contains the middle BCD digit (upper nibble is 0000)
;	D register - Lower nibble contains the least significant BCD digit (upper nibble is 0000)
;**********************************
bin8_to_dec3:
	ld bc,0
	ld d,0
bin8_to_dec3_add_bit0:
	bit 0,a
	jr z,bin8_to_dec3_skip_bit0
	inc d
bin8_to_dec3_skip_bit0:
bin8_to_dec3_add_bit1:
	bit 1,a
	jr z,bin8_to_dec3_skip_bit1
	inc d
	inc d
bin8_to_dec3_skip_bit1:
bin8_to_dec3_add_bit2:
	bit 2,a
	jr z,bin8_to_dec3_skip_bit2
	inc d
	inc d
	inc d
	inc d
bin8_to_dec3_skip_bit2:
bin8_to_dec3_add_bit3:
	bit 3,a
	jr z,bin8_to_dec3_skip_bit3
	inc d
	inc d
	inc d
	inc d
	inc d
	inc d
	inc d
	inc d
bin8_to_dec3_skip_bit3:
bin8_to_dec3_add_bit4:
	bit 4,a
	jr z,bin8_to_dec3_skip_bit4
	inc d
	inc d
	inc d
	inc d
	inc d
	inc d
	inc c
bin8_to_dec3_skip_bit4:
bin8_to_dec3_add_bit5:
	bit 5,a
	jr z,bin8_to_dec3_skip_bit5
	inc d
	inc d
	inc c
	inc c
	inc c
bin8_to_dec3_skip_bit5:
bin8_to_dec3_add_bit6:
	bit 6,a
	jr z,bin8_to_dec3_skip_bit6
	inc d
	inc d
	inc d
	inc d
	inc c
	inc c
	inc c
	inc c
	inc c
	inc c
bin8_to_dec3_skip_bit6:
bin8_to_dec3_add_bit7:
	bit 7,a
	jr z,bin8_to_dec3_skip_bit7
	inc d
	inc d
	inc d
	inc d
	inc d
	inc d
	inc d
	inc d
	inc c
	inc c
	inc b
bin8_to_dec3_skip_bit7:
bin8_to_dec3_mod_d:
	ld a,d
bin8_to_dec3_mod_d_loop:
	sub a,10
	jr c, bin8_to_dec3_mod_d_exit
	inc c
	jr bin8_to_dec3_mod_d_loop
bin8_to_dec3_mod_d_exit:
	add a,10
	ld d,a
bin8_to_dec3_mod_c:
	ld a,c
bin8_to_dec3_mod_c_loop:
	sub a,10
	jr c, bin8_to_dec3_mod_c_exit
	inc b
	jr bin8_to_dec3_mod_c_loop
bin8_to_dec3_mod_c_exit:
	add a,10
	ld c,a
	ret

;**********************************
;Function Name: rle_decompressor
;Description: This function takes an RLE compressed data stream
;	at address HL and decompresses it into the buffer pointed
;	to by the DE register.
;Parameters:
;	HL register - Input Address
;	DE register - Output Address
;**********************************
rle_decompressor: ;hl input location, de output location
	push de
	push bc
	ld c,0
rle_decompressor_loop:
	ld a,(hl)
	cp $FF ;stop execution
	jr z,rle_decompressor_exit
	cp $FE ;set to single mode
	jr z,rle_decompressor_set_single
	cp $FD ;set to double mode
	jr z,rle_decompressor_set_double
	push hl
	ld hl,all_buffers_end
	sbc hl,de
	bit 7,h
	jr nz,rle_decompressor_overflow_exit
	pop hl
	bit 0,c
	jr nz,rle_decompressor_single
	ld b,a
	inc hl
	ld a,(hl)
rle_decompressor_double_loop:
	ld (de),a
	inc de
	djnz rle_decompressor_double_loop
	inc hl
	jr rle_decompressor_loop
rle_decompressor_single:
	ld a,(hl)
	ld (de),a
	inc hl
	inc de
	jr rle_decompressor_loop
rle_decompressor_set_double:
	ld c,0
	inc hl
	jr rle_decompressor_loop
rle_decompressor_set_single:
	ld c,1
	inc hl
	jr rle_decompressor_loop
rle_decompressor_overflow_exit:
	pop hl
rle_decompressor_exit:
	pop bc
	pop de
	ret

;**********************************
;Function Name: send_lcd_command
;Description: Sends an 8-bit command to the lcd command port
;Parameters:
;	A register - The 8-bit command
;**********************************
send_lcd_command:
	out (PORT10),a ;the lcd command port
	call _LCD_BUSY_QUICK
	ret

;**********************************
;Function Name: send_lcd_data
;Description: Sends an 8-bit piece of data to the lcd data port
;Parameters:
;	A register - The 8-bit data value
;**********************************
send_lcd_data:
	call _LCD_BUSY_QUICK
	out (PORT11),a
	ret

;**********************************
;Function Name: loadgraph
;Description: Copies the image currently displaying on the LCD screen into the PlotScreen Ram
;Parameters:
;	None
;**********************************
loadgraph:
	ld de,plotSScreen ;graph ram location
	ld b,64 ;64 rows on the lcd screen
	ld h,PORT10_w_SET_ROW_ib ;row 0
loadgraph_reset_col:
	ld c,12 ;12 columns in 6-bit mode on the lcd screen
	ld l,PORT10_w_SET_COL_ib ;column 0
loadgraph_loop:
	ld a,h
	call send_lcd_command
	ld a,l
	call send_lcd_command
	in a,(PORT11)
	call _LCD_BUSY_QUICK
	in a,(PORT11)
	ld (de),a
	;
	inc de
	inc l
	dec c
	jr nz,loadgraph_loop
	;
	inc h
	dec b
	jr nz,loadgraph_reset_col
	;
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
	ld hl,hide_ui_counter_cycles
	inc (hl)
	ld a,(CLOCK_CYCLES_PER_SEC)
	cp (hl)
	jr nz,ISR_SKIP_CYCLE_RESET
	ld (hl),0
	ld hl,hide_ui_counter_sec
	dec (hl)
	xor a
	cp (hl)
	jr nz,ISR_SKIP_CYCLE_RESET
	ld hl,hide_ui_flag
	ld (hl),1
ISR_SKIP_CYCLE_RESET:
	;--restore all the registers and return execution to the main program
	ex af,af'
	exx
	ei
	reti
ISR_END:

;************************************************************************************************************
; Program Data and Strings
;************************************************************************************************************

#include "data.asm"

;************************************************************************************************************
; Program Variables and Ram space
;	Note: For some reason the spasm-ng assembler doesn't
;	like it when this stuff is placed before the application header
;	so that is why it's located down here.
;************************************************************************************************************
ram_location:	equ	plotSScreen ;I'm using the graphscreen as free ram ;$9340
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
page_number				.db 0
update_page				.db 0
hide_ui_counter_cycles	.db 0
hide_ui_counter_sec:	.db 0
hide_ui_flag:			.db 0

	.org ISR_table_start

ISR_table:		.fill ISR_table_size,0
ISR_table_end: ;AKA $9501

	.org ISR_code_buffer_start

ISR_code_buffer:	.fill ISR_code_buffer_size,0
ISR_code_buffer_end:

	.org appBackUpScreen

background_buffer:			.fill 16*8
;	.db "0000000000000000"
;	.db "0000000000000000"
;	.db "0000000000000000"
;	.db "0000000000000000"
;	.db "0000000000000000"
;	.db "0000000000000000"
;	.db "0000000000000000"
;	.db "0000000000000000"
background_buffer_null:		.db 0
dialogue_box_1_row_buffer:	.fill 48+1 ;16*3=48 + 1 for null
dialogue_box_2_row_buffer:	.fill 64+1 ;16*4=64 + 1 for null
dialogue_box_3_row_buffer:	.fill 80+1 ;16*5=80 + 1 for null
all_buffers_end:		;this label is used by the rle decompressor to avoid overflow