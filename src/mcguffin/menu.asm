;Author: Phoenix Cushman (Diet-Gameboy on GitHub)
;File Name menu.asm
;Date Created: 6/16/2025 5:17pm
;Last Modified: 6/17/2025
;Description: This file contains the defines and tables utilized by the menu_screen function and its
;	accompanying sub functions which render the menu pages, run the save system, or exit the game. 

;************************************************************************************************************
; Game Menu Functions and Data
;************************************************************************************************************

#define MENU_WAIT_SHORT (1)
#define MENU_WAIT_LONG (2)
#define MENU_TABLE_EOT ($FF)

menu_screen_page_table:
	.dw menu_screen_items_background, menu_screen_items_checker, menu_screen_items_keycheck
	.dw menu_screen_equipment_background, menu_screen_equipment_checker, menu_screen_equipment_keycheck
	.dw menu_screen_mcguffins_background, menu_screen_mcguffins_checker, menu_screen_mcguffins_keycheck
	.dw menu_screen_options_background, menu_screen_options_checker, menu_screen_options_keycheck

menu_screen_items_table: ;conditional value, associated variable, text pointer, text position on screen
	.dw 1, item_flower, menu_screen_text_item_flower, $0203
	.dw 2, item_flower, menu_screen_text_item_check_mark, $0203
	.dw 1, item_lemon, menu_screen_text_item_lemon, $0303
	.dw 2, item_lemon, menu_screen_text_item_lemonade, $0303
	.dw 3, item_lemon, menu_screen_text_item_check_mark, $0303
	.dw 1, item_pumpkin, menu_screen_text_item_pumpkin, $0403
	.dw 2, item_pumpkin, menu_screen_text_item_check_mark, $0403
	.dw 1, item_seagull, menu_screen_text_item_seeds, $0503
	.dw 2, item_seagull, menu_screen_text_item_seagull, $0503
	.dw 3, item_seagull, menu_screen_text_item_check_mark, $0503
	.dw 1, item_bees, menu_screen_text_item_bees_1, $0603
	.dw 2, item_bees, menu_screen_text_item_bees_2, $0603
	.dw 3, item_bees, menu_screen_text_item_bees_3, $0603
	.dw 4, item_bees, menu_screen_text_item_check_mark, $0603
	.dw 1, item_fly, menu_screen_text_item_fly, $0703
	.dw 2, item_fly, menu_screen_text_item_check_mark, $0703
	.db MENU_TABLE_EOT

menu_screen_equipment_table: ;conditional value, associated variable, text pointer, text position on screen
	.dw 1, equip_key, menu_screen_text_equip_key, $0202
	.dw 1, equip_key, menu_screen_text_equip_key_name, $0209
	.dw 2, equip_key, menu_screen_text_equip_key, $0202
	.dw 2, equip_key, menu_screen_text_equip_key_name, $0209
	.dw 1, equip_boots, menu_screen_text_equip_boots, $0205
	.dw 1, equip_boots, menu_screen_text_equip_boots_name, $0309
	.dw 1, equip_oars, menu_screen_text_equip_oars, $0402
	.dw 1, equip_oars, menu_screen_text_equip_oars_name, $0409
	.dw 1, equip_glass, menu_screen_text_equip_glass, $0405
	.dw 1, equip_glass, menu_screen_text_equip_glass_name, $0509
	.dw 1, equip_rod, menu_screen_text_equip_rod, $0602
	.dw 1, equip_rod, menu_screen_text_equip_rod_name, $0609
	.dw 1, equip_oil, menu_screen_text_equip_oil, $0605
	.dw 1, equip_oil, menu_screen_text_equip_oil_name, $0709
	.db MENU_TABLE_EOT

menu_screen_mcguffins_table: ;conditional value, associated variable, text pointer, text position on screen
	.dw 1, mcguffin_bee, menu_screen_text_mcguffin_bee_top, $0203
	.dw 1, mcguffin_bee, menu_screen_text_mcguffin_bee_bottom, $0303
	.dw 1, mcguffin_bog, menu_screen_text_mcguffin_bog_top, $020B
	.dw 1, mcguffin_bog, menu_screen_text_mcguffin_bog_bottom, $030B
	.dw 1, mcguffin_ice, menu_screen_text_mcguffin_ice_top, $0503
	.dw 1, mcguffin_ice, menu_screen_text_mcguffin_ice_bottom, $0603
	.dw 1, mcguffin_fire, menu_screen_text_mcguffin_fire_top, $050B
	.dw 1, mcguffin_fire, menu_screen_text_mcguffin_fire_bottom, $060B
	.db MENU_TABLE_EOT


;**********************************
;Function Name: menu_screen
;Description: This is the main function that runs the menu system. It handles all key
;	inputs, page flips, FILE I/O, and exiting the game. None of its internal sub
;	functions should be called or interacted with seperately.
;Parameters:
;	None
;**********************************
menu_screen:
	ld ix,menu_screen_page_table
	ld a,(menu_page)
	;multiply the page offset by 6
	ld b,a
	add a,b
	add a,b
	sla a
	;create the page offset and add to ix
	ld c,a
	ld b,0
	add ix,bc
	;load the data pointer at (ix:ix+1) into hl and decompress the menu graphics
	ld l,(ix+0)
	ld h,(ix+1)
	ld de,background_buffer
	call rle_decompressor
	call draw_buffer
	;load the data pointer at (ix+2:ix+3) into hl and jump to the menu page init routine
	ld hl,menu_screen_loop
	push hl
	ld l,(ix+2)
	ld h,(ix+3)
	jp (hl)
menu_screen_loop:
	ld a,(exit_game)
	cp 1
	jr z,menu_screen_exit
	bcall(_kdbScan)
	bcall(_GetCSC)
	ld (latest_key),a
	cp skMode ;the key code for 'Mode' when using the GetCSC routine
	jr z,menu_screen_exit
	cp skLeft
	jr z,menu_screen_scroll_left
	cp skRight
	jr z,menu_screen_scroll_right
	;load the extra key routine for the specific page
	ld l,(ix+4)
	ld h,(ix+5)
	jp (hl)
menu_screen_scroll_left:
	ld a,(menu_page)
	dec a
	and %00000011 ;bound the menu_page variable to 0-3
	ld (menu_page),a
	jr menu_screen
menu_screen_scroll_right:
	ld a,(menu_page)
	inc a
	and %00000011 ;bound the menu_page variable to 0-3
	ld (menu_page),a
	jr menu_screen
menu_screen_exit:
	call load_room
	call draw_buffer
	ret

menu_screen_items_keycheck:
menu_screen_equipment_keycheck:
menu_screen_mcguffins_keycheck:
	jp menu_screen_loop

menu_screen_options_keycheck:
	cp sk1 ;1 key
	call z,menu_screen_options_save
	cp sk2 ;2 key
	call z,menu_screen_options_save_quit
	cp sk3 ;3 key
	call z,menu_screen_options_quit
	cp sk4 ;4 key
	call z,menu_screen_options_delete
	jp menu_screen_loop

menu_screen_options_save:
	ld a,DIALOGUE_AUTOSKIP_KEY_VALUE
	ld (latest_key),a
	ld hl,menu_screen_save_dialogue_1 ;"Saving Game...",0
	call dialogue_printer_1_row_no_redraw
	;
	call read_variable_allocation_table
	call c,save_file_create_save
	call save_file_unarchive
	call save_file_push_data
	call save_file_archive
	ld a,MENU_WAIT_LONG
	call wait_time
	;
	ld a,DIALOGUE_AUTOSKIP_KEY_VALUE
	ld (latest_key),a
	ld hl,menu_screen_save_dialogue_2 ;"Save Complete.",0
	call dialogue_printer_1_row_no_redraw
	ld a,MENU_WAIT_SHORT
	call wait_time
	call draw_buffer
	ret
menu_screen_options_save_quit:
	call menu_screen_options_save
menu_screen_options_quit:
	ld a,DIALOGUE_AUTOSKIP_KEY_VALUE
	ld (latest_key),a
	ld hl,menu_screen_exit_dialogue ;"Exiting Game..",0
	call dialogue_printer_1_row_no_redraw
	ld a,MENU_WAIT_SHORT
	call wait_time
	ld a,1
	ld (exit_game),a
	ret
menu_screen_options_delete:
	call read_variable_allocation_table
    jr c,menu_screen_options_delete_no_file ;Skips if file doesn't exist
	;
	ld hl,menu_screen_delete_dialogue_4 ;"Delete File?",0
	call decision_printer_1_row_no_redraw
	cp 0
	jr z,menu_screen_options_exit
	;
	ld a,DIALOGUE_AUTOSKIP_KEY_VALUE
	ld (latest_key),a
	ld hl,menu_screen_delete_dialogue_1 ;"Deleting Save",$D6,"File...",0
	call dialogue_printer_2_row_no_redraw
	;
	call read_variable_allocation_table
    bcall(_DelVarArc)
	call enable_ISR ;DelVarArc is one of the bcalls that switches interrupt mode to 1 so we have to switch it back
	ld a,MENU_WAIT_LONG
	call wait_time
	;
	ld a,DIALOGUE_AUTOSKIP_KEY_VALUE
	ld (latest_key),a
	ld hl,menu_screen_delete_dialogue_2 ;"Save File",$D6,"Deleted.",0
	call dialogue_printer_2_row_no_redraw
	ld a,MENU_WAIT_SHORT
	call wait_time
	jr menu_screen_options_exit
menu_screen_options_delete_no_file:
	ld a,DIALOGUE_AUTOSKIP_KEY_VALUE
	ld (latest_key),a
	ld hl,menu_screen_delete_dialogue_3 ;"No File Found.",0
	call dialogue_printer_1_row_no_redraw
	ld a,MENU_WAIT_SHORT
	call wait_time
menu_screen_options_exit:
	call draw_buffer
	ret

menu_screen_items_checker:
	;first display the money
	ld de,$0805
	ld a,(check_money_count)
	srl a
	srl a
	srl a
	srl a
	add a,L0
	call output_c
	inc e
	ld a,(check_money_count)
	and %00001111
	add a,L0
	call output_c
	;
	push ix
	ld ix, menu_screen_items_table
	jp menu_screen_table_checker_loop

menu_screen_equipment_checker:
	push ix
	ld ix, menu_screen_equipment_table
	jp menu_screen_table_checker_loop

menu_screen_mcguffins_checker:
	push ix
	ld ix, menu_screen_mcguffins_table
	jp menu_screen_table_checker_loop

menu_screen_options_checker:
	ret

menu_screen_table_checker_loop:
	ld l,(ix+2)
	ld h,(ix+3)
	ld a,(hl)
	cp (ix+0)
	jr nz,menu_screen_table_checker_skip
	ld l,(ix+4)
	ld h,(ix+5)
	ld e,(ix+6)
	ld d,(ix+7)
	call output_s
menu_screen_table_checker_skip:
	;increment ix to the next row in the table
	ld de,8
	add ix,de
	ld a,MENU_TABLE_EOT
	cp (ix+0)
	jr nz,menu_screen_table_checker_loop
	pop ix
	ret