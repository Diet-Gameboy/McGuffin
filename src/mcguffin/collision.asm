;Author: Phoenix Cushman (Diet-Gameboy on GitHub)
;File Name collision.asm
;Date Created: 6/16/2025 7:43pm
;Last Modified: 6/17/2025
;Description: This file contains the collision check function which handles the player's interaction with the
;	collision map of a room when the player attempts to move positions. It also contains all relevant helper
;	functions and tables.

;************************************************************************************************************
; Player Collision Response Functions and Tables
;************************************************************************************************************

warps_lookup_table:
	.dw room_1_warps
	.dw room_2_warps
	.dw room_3_warps
	.dw room_4_warps
	.dw room_5_warps
	.dw room_6_warps
	.dw room_7_warps
	.dw room_8_warps
	.dw room_9_warps
	.dw room_10_warps
	.dw room_11_warps
	.dw room_12_warps
	.dw room_13_warps
	.dw room_14_warps
	.dw room_15_warps
	.dw room_16_warps
	.dw room_17_warps
	.dw room_18_warps
	.dw room_19_warps
	.dw room_20_warps
	.dw room_21_warps
	.dw room_22_warps
	.dw room_23_warps
	.dw room_24_warps
	.dw room_25_warps
	.dw room_26_warps
	.dw room_27_warps
	.dw room_28_warps
	.dw room_29_warps
	.dw room_30_warps
	.dw room_31_warps
	.dw room_32_warps
	.dw room_33_warps
	.dw room_34_warps
	.dw room_35_warps
	.dw room_36_warps
	.dw room_37_warps
	.dw room_38_warps
	.dw room_39_warps
;	.dw room_40_warps

triggers_lookup_table:
	.dw room_1_triggers
	.dw room_2_triggers
	.dw room_3_triggers
	.dw room_4_triggers
	.dw room_5_triggers
	.dw room_6_triggers
	.dw room_7_triggers
	.dw room_8_triggers
	.dw room_9_triggers
	.dw room_10_triggers
	.dw room_11_triggers
	.dw room_12_triggers
	.dw room_13_triggers
	.dw room_14_triggers
	.dw room_15_triggers
	.dw room_16_triggers
	.dw room_17_triggers
	.dw room_18_triggers
	.dw room_19_triggers
	.dw room_20_triggers
	.dw room_21_triggers
	.dw room_22_triggers
	.dw room_23_triggers
	.dw room_24_triggers
	.dw room_25_triggers
	.dw room_26_triggers
	.dw room_27_triggers
	.dw room_28_triggers
	.dw room_29_triggers
	.dw room_30_triggers
	.dw room_31_triggers
	.dw room_32_triggers
	.dw room_33_triggers
	.dw room_34_triggers
	.dw room_35_triggers
	.dw room_36_triggers
	.dw room_37_triggers
	.dw room_38_triggers
	.dw room_39_triggers
;	.dw room_40_triggers

;**********************************
;Function Name: collision_check
;Description: When the player moves this function checks which collision type the tile
;   is that the player just stepped on and triggers room loads, actor dialogue, player
;   position changes, and any other collision based functions.
;Parameters:
;	None
;**********************************
collision_check:
	;cap the x and y pos
	ld a,(x_pos)
	dec a
	and %00001111 ;mask out the lower 4 bits (0-15)
	inc a
	ld (x_pos),a
	ld a,(y_pos)
	dec a
	and %00000111 ;mask out the lower 3 bits (0-7)
	inc a
	ld (y_pos),a
	;load the current index into the collision buffer where the player is located
	ld hl,collision_buffer
	ld d,0
	ld a,(y_pos)
	dec a
	sla a
	sla a
	sla a
	sla a
	ld e,a
	add hl,de
	ld a,(x_pos)
	dec a
	ld e,a
	add hl,de
	ld a,(hl)
    ;check which collision type this tile is
	cp '1'
	jp z,reset_positions
	cp '2'
	jp z,collision_check_2
	cp '3'
	jp z,collision_check_3
	cp '4'
	jp z,collision_check_4
	cp '5'
	jp z,collision_check_5
	ret
collision_check_2:
	call collision_check_room_index_setup
	ld a,(y_pos)
	cp 8
	jr z,collision_check_2_down
	cp 1
	jr z,collision_check_2_up
	ld a,(x_pos)
	cp 1
	jr z,collision_check_2_left
	cp 16
	jr z,collision_check_2_right
	ret
collision_check_2_exit:
	call enter_room
	ret
collision_check_2_down:
	ld a,(hl)
	ld (room_number),a
	ld a,2
	ld (y_pos),a
	jr collision_check_2_exit
collision_check_2_up:
	inc hl
	ld a,(hl)
	ld (room_number),a
	ld a,7
	ld (y_pos),a
	jr collision_check_2_exit
collision_check_2_left:
	inc hl
	inc hl
	ld a,(hl)
	ld (room_number),a
	ld a,15
	ld (x_pos),a
	jr collision_check_2_exit
collision_check_2_right:
	inc hl
	inc hl
	inc hl
	ld a,(hl)
	ld (room_number),a
	ld a,2
	ld (x_pos),a
	jr collision_check_2_exit
collision_check_3:
	call collision_check_room_index_setup
collision_check_3_zero_loop:
	ld a,(hl)
	cp $FF
	jp z,collision_check_error
	cp 0
	inc hl
	jr nz,collision_check_3_zero_loop
collision_check_3_match_loop:
	ld a,(hl)
	ld b,a
	ld a,(x_pos)
	cp b
	jr nz,collision_check_3_match_loop_x
	inc hl
	ld a,(hl)
	ld b,a
	ld a,(y_pos)
	cp b
	jr nz,collision_check_3_match_loop_y
	inc hl
	ld a,(hl)
	ld (room_number),a
	inc hl
	ld a,(hl)
	ld (x_pos),a
	inc hl
	ld a,(hl)
	ld (y_pos),a
	call enter_room
	ret
collision_check_3_match_loop_x:
	inc hl
	inc hl
	inc hl
	inc hl
	inc hl
	jr collision_check_3_match_loop
collision_check_3_match_loop_y:
	inc hl
	inc hl
	inc hl
	inc hl
	jr collision_check_3_match_loop
collision_check_4:
    ld a,(equip_boots)
	cp 1
	call nz,reset_positions
    ret
collision_check_5:
	ld a,(room_number)
	dec a
	sla a
	ld d,0
	ld e,a
	ld hl,triggers_lookup_table
	add hl,de
	ld a,(hl)
	ld e,a
	inc hl
	ld a,(hl)
	ld d,a
	ex de,hl ;hl now points to the first value in the rooms' personal triggers coordinates array
collision_check_5_loop:
	ld a,0
	cp (hl)
	jr z,collision_check_5_exit
	ld a,(y_pos)
	cp (hl)
	jr z,collision_check_5_x_match
	inc hl
	inc hl
	inc hl
	inc hl
	jr collision_check_5_loop
collision_check_5_x_match:
	inc hl
	ld a,(x_pos)
	cp (hl)
	jr z,collision_check_5_y_match
	inc hl
	inc hl
	inc hl
	jr collision_check_5_loop
collision_check_5_y_match:
	inc hl
	ld a,(hl)
	ld e,a
	inc hl
	ld a,(hl)
	ld d,a
	ld hl,collision_check_5_exit
	push hl
	ex de,hl
	call reset_positions
	jp (hl)
collision_check_5_exit:
	call reset_positions
	call draw_buffer
	ret
collision_check_error:
	call reset_positions
	ret

;**********************************
;Function Name: collision_check_room_index_setup
;Description: This function locates the warps information table for the specific
;   room the player is in so that the collision_check function can calculate any
;   room change operations if the player steps on a loading zone tile.
;Parameters:
;	None
;**********************************
collision_check_room_index_setup:
	ld a,(room_number)
	dec a
	sla a
	ld d,0
	ld e,a
	ld hl,warps_lookup_table
	add hl,de
	ld a,(hl)
	ld e,a
	inc hl
	ld a,(hl)
	ld d,a
	ex de,hl ;hl now points to the first value in the rooms' personal warp coordinates array
	ret
