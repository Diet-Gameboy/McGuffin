;Author: Phoenix Cushman (Diet-Gameboy on GitHub)
;File Name isr.asm
;Date Created: 6/12/2025 12:42pm
;Last Modified: 6/17/2025
;Description: This file contains all the functions that create and interact with
;   the custom ISR that is used to time elements of the game and UI components.

;************************************************************************************************************
; Custom Interrupt Service Routine Functions
;************************************************************************************************************

#define CLOCK_CYCLES_PER_SEC (110)
#define CLOCK_CYCLES_PER_HALF_SEC (CLOCK_CYCLES_PER_SEC / 2)

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
	;shares the below code with enable_ISR for optimization

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
	inc (hl) ;count up the cycle counter
	ld a,CLOCK_CYCLES_PER_HALF_SEC
	cp (hl) ;perform a bounds check
	jr nz,ISR_SKIP_RESET
	ld (hl),0 ;reset cycle counter
	ld hl,time_counter_animation
	inc (hl) ;increment the animation counter
	ld hl,time_counter_half_sec
	xor a ;ld a,0
	cp (hl) ;perform a check on the half second counter
    jr z,ISR_SKIP_RESET
    dec (hl) ;decrement it if it's nonzero
ISR_SKIP_RESET:
	;--restore all the registers and return execution to the main program
	ex af,af'
	exx
	ei
	reti
ISR_END:
