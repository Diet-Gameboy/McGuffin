;Author: Phoenix Cushman (Diet-Gameboy on GitHub)
;File Name room_load.asm
;Date Created: Fall 2023 (Unknown)
;Last Modified: 6/17/2025
;Description: This file contains all the load routines for every room in the game.

;************************************************************************************************************
; Room Load Scripts, Functions, and Data
;************************************************************************************************************

room_lookup_table:
	.dw room_1_load, room_1_background, room_1_collision
	.dw room_2_load, room_2_background, room_2_collision
	.dw room_3_load, room_3_background, room_3_collision
	.dw room_4_load, room_4_background, room_4_collision
	.dw room_5_load, room_5_background, room_5_collision
	.dw room_6_load, room_6_background, room_6_collision
	.dw room_7_load, room_7_background, room_7_collision
	.dw room_8_load, room_8_background, room_8_collision
	.dw room_9_load, room_9_background, room_9_collision
	.dw room_10_load, room_10_background, room_10_collision
	.dw room_11_load, room_11_background, room_11_collision
	.dw room_12_load, room_12_background, room_12_collision
	.dw room_13_load, room_13_background, room_13_collision
	.dw room_14_load, room_14_background, room_14_collision
	.dw room_15_load, room_15_background, room_15_collision
	.dw room_16_load, room_16_background, room_16_collision
	.dw room_17_load, room_17_background, room_17_collision
	.dw room_18_load, room_18_background, room_18_collision
	.dw room_19_load, room_19_background, room_19_collision
	.dw room_20_load, room_20_background, room_20_collision
	.dw room_21_load, room_21_background, room_21_collision
	.dw room_22_load, room_22_background, room_22_collision
	.dw room_23_load, room_23_background, room_23_collision
	.dw room_24_load, room_24_background, room_24_collision
	.dw room_25_load, room_25_background, room_25_collision
	.dw room_26_load, room_26_background, room_26_collision
	.dw room_27_load, room_27_background, room_27_collision
	.dw room_28_load, room_28_background, room_28_collision
	.dw room_29_load, room_29_background, room_29_collision
	.dw room_30_load, room_30_background, room_30_collision
	.dw room_31_load, room_31_background, room_31_collision
	.dw room_32_load, room_32_background, room_32_collision
	.dw room_33_load, room_33_background, room_33_collision
	.dw room_34_load, room_34_background, room_34_collision
	.dw room_35_load, room_35_background, room_35_collision
	.dw room_36_load, room_36_background, room_36_collision
	.dw room_37_load, room_37_background, room_37_collision
	.dw room_38_load, room_38_background, room_38_collision
	.dw room_39_load, room_39_background, room_39_collision
	;.dw room_40_load, room_40_background, room_40_collision

load_room:
	;push return address to the stack
	ld hl,load_room_return_address
	push hl
	;generate the pointer into the room_lookup_table
	ld a,(room_number)
	dec a
	ld b,a
	add a,b
	add a,b
	sla a
	ld e,a
	ld d,0
	ld ix,room_lookup_table
	add ix,de
	;run the decompressors
	ld l,(ix+2)
	ld h,(ix+3)
	ld de,background_buffer
	call rle_decompressor
	ld l,(ix+4)
	ld h,(ix+5)
	ld de,collision_buffer
	call rle_decompressor_c
	;jump to the rooms' personal load routines
	ld l,(ix)
	ld h,(ix+1)
	jp (hl)
load_room_return_address:
	ret

;rooms with custom routines

room_1_load:
    ld a,(game_complete)
    cp 0
    ret z
    ld a,'.'
    ld (background_buffer+9),a
    ld (background_buffer+10),a
    ld (background_buffer+11),a
    ld a,'2'
    ld (collision_buffer+9),a
    ld (collision_buffer+10),a
    ld (collision_buffer+11),a
    ;
	ret

room_3_load:
	ld a,(check_money_3) ;Room 2 Money
	cp 0
	ret nz
	ld a,'o'
	ld (background_buffer+77),a
	;
	ret

room_5_load:
	ld a,(equip_key)
	cp 2
	ret z
	ld a,'#'
	ld (background_buffer+43),a
	ld a,'5'
	ld (collision_buffer+43),a
	;
	ret

room_6_load:
	ld a,(check_bee_16) ;Check Bee 16 Block
	cp 0
	jr z,room_6_bee_16_skip
	ld hl,room_6_script_data+2 ;Set up the pointer to the bee drawing string
	ld de,background_buffer+91
	ldd ;ld (background_buffer+91),a
	ld de,background_buffer+75
	ldd ;ld (background_buffer+75),a
	ld de,background_buffer+76
	ldd ;ld (background_buffer+76),a
room_6_bee_16_skip:
	ld a,(check_bee_30) ;Check Bee 30 Block
	cp 0
	jr z,room_6_bee_30_skip
	ld hl,room_6_script_data ;Set up the pointer to the bee drawing string
	ld de,background_buffer+51
	ldi ;ld (background_buffer+51),a
	ldi ;ld (background_buffer+52),a
	ld de,background_buffer+68
	ldi ;ld (background_buffer+68),a
room_6_bee_30_skip:
	ld a,(check_bee_32) ;Check Bee 32 Block
	cp 0
	jr z,room_6_bee_32_skip
	ld hl,room_6_script_data ;Set up the pointer to the bee drawing string
	ld de,background_buffer+45
	ldi ;ld (background_buffer+45),a
	ldi ;ld (background_buffer+46),a
	ld de,background_buffer+62
	ldi ;ld (background_buffer+62),a
room_6_bee_32_skip:
	;
	ret

room_9_load:
	ld a,(item_seagull)
	cp 2
	ret z
    cp 3
    ret z
	ld a,'W'
	ld (background_buffer+58),a
	ld a,'5'
	ld (collision_buffer+58),a
	;
	ret

room_10_load:
	ld a,(item_seagull)
	cp 3
	ret nz
	ld a,'W'
	ld (background_buffer+60),a
	;
	ret

room_11_load:
	ld de,0
	ld a,(time_counter_animation)
	and %00001111
	cp 0
	jr nz,room_11_load_not_0
	inc a
room_11_load_not_0:
	cp 15
	jr nz,room_11_load_not_15
	dec a
room_11_load_not_15:
	ld e,a
	;
	ld hl,background_buffer
	add hl,de
	ld a,'0'
	ld (hl),a
	ld hl,collision_buffer
	add hl,de
	ld a,'3'
	ld (hl),a
	;
	ret

room_12_load:
	ld a,(item_lemon)
	cp 0
	ret nz
	ld a,'{'
	ld (background_buffer+54),a
	ld a,'}'
	ld (background_buffer+55),a
	;
	ret

room_14_load:
	ld a,(item_flower)
	cp 0
	ret nz
	ld a,'*'
	ld (background_buffer+70),a
	;
	ret

room_15_load:
	ld a,(item_pumpkin)
	cp 0
	ret nz
	ld a,$C1
	ld (background_buffer+49),a
	ld a,$A9
	ld (background_buffer+50),a
    ld a,']'
	ld (background_buffer+51),a
    ld a,'5'
    ld (collision_buffer+51),a
	;
	ret

room_16_load:
	ld a,(check_bee_16)
	cp 0
	ret nz
	ld a,'O'
	ld (background_buffer+69),a
	ld a,$F4
	ld (background_buffer+70),a
    ld a,'\''
	ld (background_buffer+85),a
	;
	ret

room_17_load:
    ld a,(equip_boots)
    cp 0
    ret nz
    ld a,$BF
    ld (background_buffer+21),a
    ld (background_buffer+22),a
    ;
	ret

room_25_load:
    ld a,(item_fly)
    cp 0
    ret nz
    ld a,$A5
    ld (background_buffer+93),a
    ;
	ret

room_26_load:
    ld a,(equip_rod)
    cp 0
    jr nz,room_26_load_skip_1
    ld a,'/'
    ld (background_buffer+36),a
    ld a,$B9
    ld (background_buffer+37),a
room_26_load_skip_1:
    ld a,(equip_oars)
    cp 0
    jr nz,room_26_load_skip_2
    ld a,$9C
    ld (background_buffer+41),a
    ld a,$9C
    ld (background_buffer+42),a
room_26_load_skip_2:
    ;
	ret

room_28_load:
    ld a,(equip_glass)
    cp 0
    ret nz
    ld a,$C5
    ld (background_buffer+76),a
    ;
	ret

room_30_load:
    ld a,(check_bee_30)
	cp 0
	ret nz
	ld a,'O'
	ld (background_buffer+46),a
	ld a,$F4
	ld (background_buffer+47),a
    ld a,'\''
	ld (background_buffer+62),a
    ;
	ret

room_32_load:
    ld a,(check_bee_32)
	cp 0
	ret nz
	ld a,'O'
	ld (background_buffer+60),a
	ld a,$F4
	ld (background_buffer+61),a
    ld a,'\''
	ld (background_buffer+76),a
    ;
	ret

room_33_load:
    ld a,(check_oil_33)
    cp 0
    ret nz
    ld a,'5'
    ld (collision_buffer+62),a
    ld (collision_buffer+62+16),a
    ;
	ret

room_35_load:
    ld a,(mcguffin_fire)
    cp 0
    ret z
    ld a,'V'
    ld (background_buffer+56),a
    ;
	ret

room_38_load:
	ld a,(item_pumpkin)
	cp 2
	ret nz
	ld a,$C1
	ld (background_buffer+92),a
	ld a,$A9
	ld (background_buffer+93),a
    ld a,']'
	ld (background_buffer+94),a
    ld a,'5'
    ld (collision_buffer+92),a
	;
	ret

;rooms that don't have any custom loading code

room_2_load:
room_4_load:
room_7_load:
room_8_load:
room_13_load:
room_18_load:
room_19_load:
room_20_load:
room_21_load:
room_22_load:
room_23_load:
room_24_load:
room_27_load:
room_29_load:
room_31_load:
room_34_load:
room_36_load:
room_37_load:
room_39_load:
;room_40_load:
	ret