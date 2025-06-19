;Author: Phoenix Cushman (Diet-Gameboy on GitHub)
;File Name memory.asm
;Date Created: 6/2/2025 2:44pm
;Last Modified: 6/17/2025
;Description: This file contains all the defines and memory allocations for the variables and data
;	stored in the RAM space of the calculator.

;************************************************************************************************************
; Program Variables and Ram space
;	Note: For some reason the spasm-ng assembler doesn't
;	like it when this stuff is placed before the application header
;	so that is why it's located in a seperate file.
;************************************************************************************************************

.nolist

ram_location	equ plotSScreen ;I'm using the graphscreen as free ram ;$9340
ISR_table_start		equ	$9400
ISR_code_buffer_start		equ	$9595
#define ISR_table_size (257)
#define ISR_code_buffer_size (ISR_END - ISR_START)

	.org ram_location

ram_save_data_beginning:
;=======================variables
x_pos:		.db 0
y_pos:		.db 0
prev_x_pos:		.db 0
prev_y_pos:		.db 0
room_number:	.db 0
latest_key:		.db 0
rand_num:		.db 0
menu_page:		.db 0
;=======================inventory
	;==items==
item_flower:	.db 0	; flower
item_lemon:		.db 0	; lemon
item_pumpkin:	.db 0	; pumpkin
item_seagull:	.db 0	; seagull
item_bees:		.db 0	; bees
item_fly:		.db 0	; fly
	;==equipment==
equip_key:		.db 0	; gate key
equip_boots:	.db 0	; mud boots
equip_oars:		.db 0	; boat oars
equip_glass:	.db 0	; magnifying glass
equip_rod:		.db 0	; fishing rod
equip_oil:		.db 0	; fish oil
	;==McGuffins==
mcguffin_bee:	.db 0	; Bee
mcguffin_bog:	.db 0	; Bog
mcguffin_ice:	.db 0	; Ice
mcguffin_fire:	.db 0	; Fire
	;==game_variables or checks==
		;==Money==
check_money_count:	.db 0	; money count
check_money_3:		.db 0	; Room 3
check_money_29:		.db 0	; Room 29
check_money_37:		.db 0	; Room 30
		;==Bees==
check_bee_16:		.db 0	; Room 16
check_bee_30:		.db 0	; Room 30
check_bee_32:		.db 0	; Room 32
		;==Environment Checks==
check_oil_33:		.db 0	; Room 33
check_town_37:		.db 0	; Room 37
game_complete:		.db 0
ram_save_data_end:

time_counter_cycles:	.db 0

time_counter_half_sec:	.db 0

time_counter_animation:	.db 0

exit_game:	.db 0

ram_location_end:

	.org ISR_table_start

ISR_table:		.fill ISR_table_size,0
ISR_table_end: ;AKA $9501

	.org ISR_code_buffer_start

ISR_code_buffer:	.fill ISR_code_buffer_size,0
ISR_code_buffer_end:


	.org appBackUpScreen

#define SCREEN_BUFFER_SIZE (16*8) ;16 character columns by 8 character rows

buffers_start:
background_buffer:	.fill SCREEN_BUFFER_SIZE
;	.db "+-000000000000-+"
;	.db "|00000000000000|"
;	.db "0000000000000000"
;	.db "0000000000000000"
;	.db "0000000000000000"
;	.db "0000000000000000"
;	.db "|00000000000000|"
;	.db "+-000000000000-+"
background_buffer_null:		.db 0
collision_buffer:	.fill SCREEN_BUFFER_SIZE
;	.db "1111111111111111"
;	.db "1000000000000001"
;	.db "1000000000000001"
;	.db "1000000000000001"
;	.db "1000000000000001"
;	.db "1000000000000001"
;	.db "1000000000000001"
;	.db "1111111111111111"
dialogue_box_1_row_buffer:	.fill 48+1	;16*3=48 + 1 for null
dialogue_box_2_row_buffer:	.fill 64+1	;16*4=64 + 1 for null
dialogue_box_3_row_buffer:	.fill 80+1	;16*5=80 + 1 for null

stringy_buffer:	.fill 10

buffers_ends:		;this label is used by the rle decompressor to avoid overflow

.list