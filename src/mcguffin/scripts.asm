;Author: Phoenix Cushman (Diet-Gameboy on GitHub)
;File Name scripts.asm
;Date Created: Fall 2023 (Unknown)
;Last Modified: 6/17/2025
;Description: This file contains every individual script function used by every interactable actor in the game.

;************************************************************************************************************
; Actor Scripts
;************************************************************************************************************

room_2_script_1:
	ld hl,room_2_script_1_dialogue
	call dialogue_printer_2_row
	ret 
room_2_script_2:
	ld hl,room_2_script_2_dialogue
	call dialogue_printer_3_row
	ret
;
room_3_script_1:
	ld a,(check_money_3)
	cp 0
	ret nz
	ld a,1
	ld (check_money_3),a
	ld a,(check_money_count)
	add a,5
	daa
	ld (check_money_count),a
	ld hl,room_3_script_1_dialogue
	call dialogue_printer_1_row
	call load_room
	ret
room_3_script_2:
    ld hl,room_3_script_2_dialogue_1
    call dialogue_printer_3_row
    ld hl,room_3_script_2_dialogue_2
    call dialogue_printer_2_row
    ret
;
room_4_script_1: ;Flower person
    ld a,(item_flower)
    cp 0
    jr z,room_4_script_1_jmp
    cp 1
    jr z,room_4_script_1_jmp
    ret
room_4_script_1_jmp
    ld hl,room_4_script_1_dialogue_1
    call dialogue_printer_3_row
    ld a,(item_flower)
    cp 1
    ret nz
    ld hl,room_4_script_1_dialogue_2
    call decision_printer_1_row
    cp 0
    ret z
    ld a,2
    ld (item_flower),a
    ld a,1
    ld (equip_key),a
    ld hl,room_4_script_1_dialogue_3
    call dialogue_printer_2_row
    ld hl,room_4_script_1_dialogue_4
    call dialogue_printer_1_row
	ret
room_4_script_2: ;Sign
	ld hl,room_4_script_2_dialogue
	call dialogue_printer_2_row
	ret
;
room_5_script_1:
	ld a,(equip_key)
	cp 2
	ret z
	ld a,(equip_key)
	ld hl,room_5_script_1_dialogue_1
	cp 0
	call z,dialogue_printer_2_row
	ld a,(equip_key)
	cp 1
	ret nz
	ld a,2
	ld (equip_key),a
	ld hl,room_5_script_1_dialogue_2
	call dialogue_printer_1_row
	call load_room
	ret
;
room_6_script_1:
    ld a,(check_bee_30)
    cp 0
    ret z
	jr room_6_script_shared
room_6_script_2:
    ld a,(check_bee_16)
    cp 0
    ret z
	jr room_6_script_shared
room_6_script_3:
    ld a,(check_bee_32)
    cp 0
    ret z
room_6_script_shared:
    ld hl,room_6_script_shared_dialogue
    call dialogue_printer_2_row
    ret
;
room_7_script_1:
	ld a,(item_bees)
    cp 4
    jr z,room_7_script_1_thanks
	cp 0
	jr z,room_7_script_1_3_left
	cp 1
    jr z,room_7_script_1_2_left
    cp 2
    jr z,room_7_script_1_1_left
    ld a,4
    ld (item_bees),a
    ld a,1
    ld (mcguffin_bee),a
    ld hl,room_7_script_1_dialogue_4
    call dialogue_printer_3_row
    ld hl,room_7_script_1_dialogue_5
    call dialogue_printer_2_row
    ld hl,room_7_script_1_dialogue_6
    call dialogue_printer_1_row
    ret
room_7_script_1_3_left:
    ld hl,room_7_script_1_dialogue_1
	call dialogue_printer_3_row
    ret
room_7_script_1_2_left:
    ld hl,room_7_script_1_dialogue_2
	call dialogue_printer_2_row
    ret
room_7_script_1_1_left:
    ld hl,room_7_script_1_dialogue_3
	call dialogue_printer_2_row
    ret
room_7_script_1_thanks:
    ld hl,room_7_script_1_dialogue_7
    call dialogue_printer_1_row
    ret
room_7_script_2:
    ld hl,room_7_script_2_dialogue
    call dialogue_printer_1_row
    ret
;
room_8_script_1:
	ld hl,room_8_script_1_dialogue
	call dialogue_printer_1_row
	ret
room_8_script_2:
	ld hl,room_8_script_2_dialogue
	call dialogue_printer_1_row
	ret
;
room_9_script:
	ld a,(item_seagull)
	cp 0
	jr nz,room_9_script_second_phase
room_9_script_first_phase:
	ld hl,room_9_script_dialogue_2
	call dialogue_printer_1_row
	ld b, (room_9_script_data_1_end - room_9_script_data_1) / 5 - 1
	ld ix,room_9_script_data_1
room_9_script_first_phase_loop:
    ld a,(ix)
    ld d,(ix+1)
    ld e,(ix+2)
    call output_c
    ld a,'W' ;seagull
    ld d,(ix+3)
    ld e,(ix+4)
    call output_c
    ld de,5
    add ix,de
    ld a,1
	call wait_time
    djnz room_9_script_first_phase_loop
    ld a,'W'
	ld (background_buffer+18),a
	ld a,'='
	ld (background_buffer+58),a
	ld a,'0'
	ld (collision_buffer+58),a
    ret
room_9_script_second_phase:
	ld a,(item_seagull)
	cp 1
	ret nz
	ld hl,room_9_script_dialogue_1
	call decision_printer_1_row
	cp 0
	;jr z,room_9_script_first_phase
    jp z,room_9_script_first_phase
	ld a,2
	ld (item_seagull),a
	ld hl,room_9_script_dialogue_2
	call dialogue_printer_1_row
	ld hl,room_9_script_dialogue_3
	call dialogue_printer_1_row
    call load_room
	ret
;
room_10_script_1: ;boy
    ld hl,room_10_script_1_dialogue_1
    call dialogue_printer_2_row
    ld a,(item_seagull)
    cp 3
    ret z
    ld hl,room_10_script_1_dialogue_2
    call dialogue_printer_2_row
    ld a,(item_seagull)
    cp 2
    ret nz
    ld hl,room_10_script_1_dialogue_3
    call decision_printer_1_row
    cp 0
    ret z
    ld a,3
    ld (item_seagull),a
    ld a,(check_money_count)
	add a,5
	daa
	ld (check_money_count),a
    ld hl,room_10_script_1_dialogue_4
    call dialogue_printer_2_row
    ld hl,room_10_script_1_dialogue_7
    call dialogue_printer_1_row
    call load_room
	ret
room_10_script_2: ;seagull
    ld a,(item_seagull)
	cp 3
	ret nz
    ld hl,room_9_script_dialogue_2
    call dialogue_printer_1_row
	ret
room_10_script_3: ;boat
    ld a,(equip_oars)
    cp 1
    jr z,room_10_script_3_oars
    ld hl,room_10_script_3_dialogue_1
    call dialogue_printer_1_row
    ret
room_10_script_3_oars:
    ld hl,room_10_script_3_dialogue_2
    call dialogue_printer_1_row
    ld a,4
    ld (y_pos),a
    ld a,9
    ld (x_pos),a
    call set_positions
    ld a,31
    ld (room_number),a
    call load_room
	ret
;
room_12_script:
    ld a,(item_lemon)
    cp 0
    ret nz
    ld a,1
    ld (item_lemon),a
    ld hl,room_12_script_dialogue
    call dialogue_printer_1_row
    call load_room
    ret
;
room_13_script_1:
;    ld hl,room_13_script_1_dialogue
;    call dialogue_printer_1_row
;    ret
room_13_script_2:
;    ld hl,room_13_script_2_dialogue
;    call dialogue_printer_1_row
;    ret
room_13_script_3:
    ld hl,room_13_script_3_dialogue
    call dialogue_printer_1_row
    ret
;
room_14_script_1:
    ld a,(item_flower)
    cp 0
    ret nz
    ld a,1
    ld (item_flower),a
    ld hl,room_14_script_1_dialogue
    call dialogue_printer_1_row
    call load_room
    ret
room_14_script_2:
    ld hl,room_14_script_2_dialogue
    call decision_printer_1_row
    cp 0
    ret z
    ld a,5
    ld (y_pos),a
    ld a,15
    ld (x_pos),a
    call set_positions
    ld a,36
    ld (room_number),a
    call load_room
    ret
;
room_15_script_1:
    ld a,(item_pumpkin)
    cp 0
    ret nz
    ld hl,room_15_script_1_dialogue_1
    call decision_printer_1_row
    cp 0
    jr z,room_15_script_1_take
room_15_script_1_talk:
    ld hl,room_15_script_1_dialogue_2
    call dialogue_printer_2_row
    ret
room_15_script_1_take:
    ld hl,room_15_script_1_dialogue_3
    call dialogue_printer_2_row
    ld hl,room_15_script_1_dialogue_4
    call dialogue_printer_2_row
    ld a,1
    ld (item_pumpkin),a
    ld (item_seagull),a
    call load_room
    ret
room_15_script_2:
    ld hl,room_15_script_2_dialogue
    call dialogue_printer_1_row
    ret

;
room_16_script_1:
    ld hl,room_16_script_1_dialogue
    call dialogue_printer_1_row
    ret
room_16_script_2:
    ld a,(check_bee_16)
    cp 0
    ret nz
    ld a,1
    ld (check_bee_16),a
    ld a,(item_bees)
    add a,1
    ld (item_bees),a
    ld hl,room_16_script_2_dialogue_1
    call dialogue_printer_2_row
    ld hl,room_16_script_2_dialogue_2
    call dialogue_printer_1_row
    call load_room    
    ret
room_16_script_3:
    ld hl,room_16_script_3_dialogue
    call dialogue_printer_1_row
    ret
;
room_17_script:
    ld a,(equip_boots)
    cp 0
    ret nz
    ld a,1
    ld (equip_boots),a
    ld hl,room_17_script_dialogue
    call dialogue_printer_1_row
    call load_room
    ret
;
room_18_script:
    ld hl,room_18_script_dialogue
    call dialogue_printer_2_row
    ret
;
room_20_script:
    ld a,(equip_rod)
    cp 1
    jr nz,room_20_script_explain
    ld hl,room_20_script_dialogue_1
    call decision_printer_1_row
    cp 0
    ret z
    ld a,(equip_oil)
    cp 0
    jr nz,room_20_script_nothing
    ld a,1
    ld (equip_oil),a
    ld hl,room_20_script_dialogue_3
    call dialogue_printer_1_row
    ld hl,room_20_script_data
    ld de,background_buffer+22
    ld bc,4
    ldir
    ld de,background_buffer+37
    ld bc,5
    ldir
    ld de,background_buffer+51
    ld bc,7
    ldir
    ld de,background_buffer+69
    ld bc,3
    ldir
    ld hl,room_20_script_dialogue_4
    call dialogue_printer_2_row
    ld hl,room_20_script_dialogue_5
    call dialogue_printer_2_row
    ld hl,room_20_script_dialogue_6
    call dialogue_printer_1_row
    call load_room
    ret
room_20_script_nothing:
    ld hl,room_20_script_dialogue_2
    call dialogue_printer_1_row
    ret
room_20_script_explain:
    ld hl,room_20_script_dialogue_0
    call dialogue_printer_2_row
    ret
;
room_21_script_1:
    ld hl,room_21_script_1_dialogue
    call dialogue_printer_2_row
    ret
room_21_script_2:
    ld hl,room_21_script_2_dialogue
    call dialogue_printer_2_row
    ret
;
room_22_script:
    ld hl,room_22_script_dialogue
    call dialogue_printer_2_row
    ret
;
room_23_script:
    ld hl,room_23_script_dialogue
    call dialogue_printer_3_row
    ret
;
room_24_script_1:
    ld a,(mcguffin_bog)
    cp 0
    jr nz,room_24_script_1_thanks
    ld hl,room_24_script_1_dialogue_1
    call dialogue_printer_2_row
    ld a,(item_fly)
    cp 1
    jr nz,room_24_script_1_leave
    ld hl,room_24_script_1_dialogue_3
    call decision_printer_1_row
    cp 0
    jr z,room_24_script_1_leave
    ld a,1
    ld (mcguffin_bog),a
    ld a,2
    ld (item_fly),a
    ld hl,room_24_script_1_dialogue_4
    call dialogue_printer_2_row
    ld hl,room_24_script_1_dialogue_5
    call dialogue_printer_1_row
    ret
room_24_script_1_leave:
    ld hl,room_24_script_1_dialogue_2
    call dialogue_printer_2_row
    ret
room_24_script_1_thanks:
    ld hl,room_24_script_1_dialogue_6
    call dialogue_printer_2_row
    ret
room_24_script_2:
    ld hl,room_24_script_2_dialogue
    call dialogue_printer_1_row
    ret
;
room_25_script:
    ld a,(item_fly)
    cp 0
    ret nz
    ld a,1
    ld (item_fly),a
    ld hl,room_25_script_dialogue
    call dialogue_printer_1_row
    call load_room
    ret
;
room_26_script_1:
    ld hl,room_26_script_1_dialogue
    call dialogue_printer_2_row
    ret
room_26_script_2:
    ld a,(equip_rod)
    cp 0
    ret nz
    call room_26_script_shared
    cp 0
    ret z
    ld a,1
    ld (equip_rod),a
    ld hl,room_26_script_2_dialogue
    call dialogue_printer_1_row
    call load_room
    ret
room_26_script_3:
    ld a,(equip_oars)
    cp 0
    ret nz
    call room_26_script_shared
    cp 0
    ret z
    ld a,1
    ld (equip_oars),a
    ld hl,room_26_script_3_dialogue
    call dialogue_printer_1_row
    call load_room
    ret
room_26_script_shared:
    ld hl,room_26_script_shared_dialogue_1
    call dialogue_printer_1_row
    ld a,(check_money_count)
    ld b,$10
    sub b
    daa
    jp m,room_26_script_not_enough
    ld hl,room_26_script_shared_dialogue_3
    call decision_printer_2_row
    cp 0
    ret z
    ld a,(check_money_count)
    ld b,$10
    sub b
    daa
    ld (check_money_count),a
    ld a,1
    ret
room_26_script_not_enough:
    ld hl,room_26_script_shared_dialogue_2
    call dialogue_printer_2_row
    ld a,0
    ret
;
room_27_script:
    ld hl,room_27_script_dialogue
    call dialogue_printer_2_row
    ret
;
room_28_script_1:
    ld a,(equip_glass)
    cp 0
    ret nz
    ld a,1
    ld (equip_glass),a
    ld hl,room_28_script_1_dialogue
    call dialogue_printer_1_row
    call load_room
    ret
room_28_script_2:
    ld hl,room_28_script_2_dialogue
    call dialogue_printer_1_row
    ret
;
room_29_script_1:
    ld a,(check_money_29)
    cp 0
    ret nz
    ld a,1
    ld (check_money_29),a
    ld a,(check_money_count)
    ld b,5
    add a,b
    daa
    ld (check_money_count),a
    ld hl,room_29_script_1_dialogue
    call dialogue_printer_1_row
    ret
room_29_script_2:
    ld hl,room_29_script_2_dialogue
    call dialogue_printer_1_row
    ret
room_29_script_3:
    ld hl,room_29_script_3_dialogue
    call dialogue_printer_1_row
    ret
;
room_30_script_1:
    ld a,(check_bee_30)
    cp 0
    ret nz
    ld a,1
    ld (check_bee_30),a
    ld a,(item_bees)
    add a,1
    ld (item_bees),a
    ld hl,room_30_script_1_dialogue_1
    call dialogue_printer_2_row
    ld hl,room_30_script_1_dialogue_2
    call dialogue_printer_1_row
    call load_room
    ret
room_30_script_2:
    ld hl,room_30_script_2_dialogue
    call dialogue_printer_1_row
    ret
;
room_31_script:
    ld hl,room_31_script_dialogue
    call dialogue_printer_1_row
    ld a,6
    ld (y_pos),a
    ld (x_pos),a
    call set_positions
    ld a,10
    ld (room_number),a
    call load_room
	ret
;
room_32_script_1:
    ld a,(item_lemon)
    cp 2
    jr z,room_32_script_1_thanks
    cp 3
    jr z,room_32_script_1_thanks
    ld hl,room_32_script_1_dialogue_1
    call dialogue_printer_2_row
    ld a,(item_lemon)
    cp 0
    ret z
    ld hl,room_32_script_1_dialogue_2
    call decision_printer_1_row
    cp 0
    ret z
    ld a,2
    ld (item_lemon),a
    ld hl,room_32_script_1_dialogue_3
    call dialogue_printer_3_row
    ld hl,room_32_script_1_dialogue_4
    call dialogue_printer_1_row
    ret
room_32_script_1_thanks:
    ld hl,room_32_script_1_dialogue_5
    call dialogue_printer_1_row
    ret
room_32_script_2:
    ld a,(check_bee_32)
    cp 0
    ret nz
    ld a,1
    ld (check_bee_32),a
    ld a,(item_bees)
    add a,1
    ld (item_bees),a
    ld hl,room_32_script_2_dialogue_1
    call dialogue_printer_2_row
    ld hl,room_32_script_2_dialogue_2
    call dialogue_printer_1_row
    call load_room
    ret
;
room_33_script:
    ld hl,room_33_script_dialogue_1
    call dialogue_printer_2_row
    ld a,(equip_oil)
    cp 0
    jr z,room_33_script_exit
    ld hl,room_33_script_dialogue_2
    call decision_printer_1_row
    cp 0
    jr z,room_33_script_exit
    ld a,1
    ld (check_oil_33),a
    ld hl,room_33_script_dialogue_3
    call dialogue_printer_2_row
    call load_room
    ret
room_33_script_exit:
    ld a,16
    ld (x_pos),a
    call set_positions
    ret
;
room_34_script:
    ld hl,room_34_script_dialogue
    call dialogue_printer_1_row
    ret
;
room_35_script:
    ld a,(item_lemon)
    sub 3
    jp p,room_35_script_thanks
    ld hl,room_35_script_dialogue_1
    call dialogue_printer_2_row
    ld a,(item_lemon)
    cp 2
    ret nz
    ld hl,room_35_script_dialogue_2
    call decision_printer_1_row
    cp 0
    ret z
    ld hl,room_35_script_dialogue_3
    call dialogue_printer_2_row
    ld a,1
    ld (mcguffin_fire),a
    ld a,3
    ld (item_lemon),a
    call load_room
    ld hl,room_35_script_dialogue_4
    call dialogue_printer_1_row
    ret
room_35_script_thanks:
    ld hl,room_35_script_dialogue_5
    call dialogue_printer_2_row
    ret
;
room_36_script:
    ld hl,room_36_script_dialogue
    call dialogue_printer_2_row
    ret
;
room_37_script_1:
    ld a,(check_town_37)
    cp 0
    jr nz,room_37_script_1_wave
    ld hl,room_37_script_1_dialogue_1
    call dialogue_printer_2_row
    ld hl,room_37_script_1_dialogue_2
    call dialogue_printer_2_row
    ld a,(equip_glass)
    cp 0
    ret z
    ld hl,room_37_script_1_dialogue_3
    call decision_printer_2_row
    cp 0
    ret z
    ld hl,room_37_script_1_dialogue_6
    call dialogue_printer_2_row
    ld hl,room_37_script_1_dialogue_4
    call dialogue_printer_3_row
    ld hl,room_37_script_1_dialogue_5
    call dialogue_printer_1_row
    ld a,(check_money_count)
    add a,5
    daa
    ld (check_money_count),a
    ld a,1
    ld (check_town_37),a
    ret
room_37_script_1_wave:
    ld hl,room_37_script_1_dialogue_6
    call dialogue_printer_2_row
    ret
room_37_script_2:
    ld hl,room_37_script_2_dialogue
    call dialogue_printer_3_row
    ret
;
room_38_script_1:
    ld a,(mcguffin_ice)
    cp 0
    jr nz,room_38_script_1_thanks
    ld hl,room_38_script_1_dialogue_1
    call dialogue_printer_2_row
    ld a,(item_pumpkin)
    cp 1
    ret nz
    ld hl,room_38_script_1_dialogue_2
    call decision_printer_1_row
    cp 0
    ret z
    ld a,2
    ld (item_pumpkin),a
    ld a,1
    ld (mcguffin_ice),a
    ld hl,room_38_script_1_dialogue_3
    call dialogue_printer_2_row
    ld hl,room_38_script_1_dialogue_4
    call dialogue_printer_1_row
    call load_room
    ret
room_38_script_1_thanks:
    ld hl,room_38_script_1_dialogue_5
    call dialogue_printer_1_row
    ret
room_38_script_2:
    ld a,(item_pumpkin)
    cp 2
    ret nz
    ld hl,room_38_script_2_dialogue
    call dialogue_printer_2_row
    ret
;