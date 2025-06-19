;Author: Phoenix Cushman (Diet-Gameboy on GitHub)
;File Name functions.asm
;Date Created: 6/10/2025 12:14am
;Last Modified: 6/17/2025
;Description: This file contains all the functions used by the game that aren't sorted into their own files.

;************************************************************************************************************
; Main Game Functions
;************************************************************************************************************

#define GAME_DEFAULT_PLAYER_X (11)
#define GAME_DEFAULT_PLAYER_Y (5)
#define GAME_DEFAULT_ROOM_NUMBER (1)

;**********************************
;Function Name: load_default_game_vars
;Description: Sets the players default position and room number for
;   a fresh play through of the game. If save data was located this
;   function will not be called.
;Parameters:
;	None
;**********************************
load_default_game_vars:
    ;set starting x position
    ld a,GAME_DEFAULT_PLAYER_X
    ld (x_pos),a
    ld (prev_x_pos),a
    ;set starting y position
    ld a,GAME_DEFAULT_PLAYER_Y
    ld (y_pos),a
    ld (prev_y_pos),a
    ;set the room number
    ld hl,room_number
    ld (hl),GAME_DEFAULT_ROOM_NUMBER
	ret

;**********************************
;Function Name: title_screen
;Description: This function runs the title screen process and steps the player
;   through the three title screen pages before the game starts.
;Parameters:
;	None
;**********************************
title_screen: ;do the intro sequence
	ld hl,title_screen_main
	call title_screen_sub
	ld hl,title_screen_controls
	call title_screen_sub
	ld hl,title_screen_objective
	call title_screen_sub
	ret

;**********************************
;Function Name: title_screen_sub
;Description: This is a sub function that is used by title_screen.
;Parameters:
;	None
;**********************************
title_screen_sub:
	ld de,background_buffer
	call rle_decompressor
	call draw_buffer
title_screen_sub_loop: ;this part blinks a colon cursor at the bottom of the screen
	ld a,(time_counter_animation)
    bit 0,a ;user bit zero as our boolean because it flips every half-second
	jr z, title_screen_sub_disp_colon
title_screen_sub_disp_space:
	ld a,Lspace
	jr title_screen_sub_output
title_screen_sub_disp_colon:
	ld a,Lcolon
title_screen_sub_output:
	ld de,$080E
	call output_c
	bcall(_kdbScan)
	bcall(_GetCSC)
    cp skEnter ;the key code for 'ENTER' when using the GetCSC routine
	jr nz,title_screen_sub_loop
	;cp $38 ;the key code for 'Del' when using the GetCSC routine
	;jr z,title_screen_exit
	ret
;title_screen_exit:
;	pop hl
;	pop hl
;	jp exit

;**********************************
;Function Name: game_loop
;Description: This is the main loop of the game.
;Parameters:
;	None
;**********************************
game_loop:
	ld a,(exit_game)
	cp 1
	ret z
	bcall(_kdbScan)
	bcall(_GetCSC)
	ld (latest_key),a ;store the key press for use by other functions
	cp skMode ;the key code for 'Menu' when using the GetCSC routine
	call z,menu_screen
	call player_move
	call collision_check
    call draw_player_and_background
		;uncomment this block to check if the custom ISR is running
	;ld a,(time_counter_cycles)
	;ld de,$0101
	;call output_c
	;ld a,(time_counter_half_sec)
	;ld de,$0102
	;call output_c
	call set_positions
	call check_win
	jr game_loop
	
;**********************************
;Function Name: player_move
;Description: Updates the player's position based off the keyboard
;Parameters:
;	None
;**********************************
player_move:
	ld a,(latest_key)
	cp skDown ;the key code for Down_Arrow when using the GetCSC routine
	jr z,player_move_down
	cp skLeft ;the key code for Left_Arrow when using the GetCSC routine
	jr z,player_move_left
	cp skRight ;the key code for Right_Arrow when using the GetCSC routine
	jr z,player_move_right
	cp skUp ;the key code for Up_Arrow when using the GetCSC routine
	jr z,player_move_up
	ret
player_move_down:
	ld hl,y_pos
    inc (hl)
	ret
player_move_left:
    ld hl,x_pos
    dec (hl)
	ret
player_move_right:
	ld hl,x_pos
    inc (hl)
	ret
player_move_up:
	ld hl,y_pos
    dec (hl)
	ret

;**********************************
;Function Name: reset_positions
;Description: Used to reset the player's position to the previous
;   values before player_move was called.
;Parameters:
;	None
;**********************************
reset_positions:
	ld a,(prev_x_pos)
	ld (x_pos),a
	ld a,(prev_y_pos)
	ld (y_pos),a
	ret

;**********************************
;Function Name: set_positions
;Description: Used to update the player's previous position
;   variables to hold the current position.
;Parameters:
;	None
;**********************************
set_positions:
	ld a,(x_pos)
	ld (prev_x_pos),a
	ld a,(y_pos)
	ld (prev_y_pos),a
	ret

;**********************************
;Function Name: check_win
;Description: This function checks if the player has collected all four of the mcguffins yet.
;	If they have, a special message displays and they are teleported to the game end.
;Parameters:
;	None
;**********************************
check_win:
	;if the game is already complete or one of the mcguffins is missing just abort and return
	ld a,(game_complete)
	cp 1
	ret z
	ld a,(mcguffin_bee)
    cp 0
    ret z
    ld a,(mcguffin_bog)
    cp 0
    ret z
    ld a,(mcguffin_fire)
    cp 0
    ret z
    ld a,(mcguffin_ice)
    cp 0
    ret z
	;display the game complete message and update the game state
	ld a,1
	ld (game_complete),a
	ld hl,beat_game_script_dialogue_1
	call dialogue_printer_2_row
	ld a,15
	ld (x_pos),a
	ld a,2
	ld (y_pos),a
	ld a,39
	ld (room_number),a
	call load_room
	ret

;**********************************
;Function Name: wait_time
;Description: Uses the custom ISR to wait for a specified number of half seconds
;Parameters:
;	A register - Time to wait in half seconds
;**********************************
wait_time:
	ld hl,time_counter_half_sec
	ld (hl),a
wait_time_loop:
	ld a,(hl)
	cp 0
	jr nz,wait_time_loop
	ret

;************************************************************************************************************
; Graphics and Text Functions
;************************************************************************************************************

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
;Function Name: unload_dialogue_boxes
;Description: This function decompresses the dialogue boxes graphics
;	into their buffers in RAM.
;Parameters:
;	None
;**********************************
unload_dialogue_boxes:
	ld hl,dialogue_box_1_row
	ld de, dialogue_box_1_row_buffer
	call rle_decompressor
	ld hl,dialogue_box_2_row
	ld de, dialogue_box_2_row_buffer
	call rle_decompressor
	ld hl,dialogue_box_3_row
	ld de, dialogue_box_3_row_buffer
	call rle_decompressor
	ret

;**********************************
;Function Name: draw_player_and_background
;Description: This function draws the background pattern onto the screen and then
;   the pi symbol used for the player. It only redraws the background if the player
;   moves but always redraws the player.
;Parameters:
;	None
;**********************************
draw_player_and_background:
    ;check if the player has moved from their previous position
	ld a,(y_pos)
	ld b,a
	ld a,(prev_y_pos)
	cp b
	jr nz,draw_player_and_background_background ;only redraw the background if the player has moved
	ld a,(x_pos)
	ld b,a
	ld a,(prev_x_pos)
	cp b
	jr nz,draw_player_and_background_background ;only redraw the background if the player has moved
draw_player_and_background_player: ;always redraw the player
	ld a,(y_pos)
	ld d,a
	ld a,(x_pos)
	ld e,a
	ld a,Lpi ;TiAscii code for Pi
	call output_c
	ret
draw_player_and_background_background:
	call draw_buffer
	jr draw_player_and_background_player

;**********************************
;Function Name: enter_room
;Description: This function lower the brightness of the screen while a new room is loaded in
;	and then brightens it once the player is in the new room. It's used for stylistic room
;	transitions when the player steps into a loading zone tile.
;Parameters:
;	None
;**********************************
enter_room:
	ld a,FAV_BRIGHTNESS_LEVEL
	ld b,FAV_BRIGHTNESS_LEVEL - PORT10_w_SET_CONTRAST_ib ;16 ;step down 16 brightness levels
enter_fade_out_loop:
	call send_lcd_command
	dec a
	djnz enter_fade_out_loop
	push af
	call load_room
	call draw_buffer
	pop af
	ld b,FAV_BRIGHTNESS_LEVEL - PORT10_w_SET_CONTRAST_ib ;16 ;step back up 16 brightness levels
enter_fade_in_loop:
	call send_lcd_command
	inc a
	djnz enter_fade_in_loop
	ret

;**********************************
;Function Name: draw_buffer
;Description: Draws the background buffer data to the LCD screen.
;Parameters:
;	None
;**********************************
draw_buffer: ;void draw_buffer() | Overwrites all registers	
	ld hl,background_buffer
    ;ld hl,collision_buffer  ;(You can swap out the printed buffer for debug purposes)
	ld b,SCREEN_BUFFER_SIZE
	ld de,$0101 ;load de with the starting screen location
draw_buffer_loop:
	ld a,(hl)
	call output_c
	inc e
	ld a,17
	cp e
	jr nz,draw_buffer_e
	ld e,1					;resets e to 1 once it rolls over 16
	inc d
draw_buffer_e:
	inc hl
	djnz draw_buffer_loop
	ret

;**********************************
;Function Name: output_c
;Description: Outputs a single ASCII character to the screen at a specified position.
;Parameters:
;	A register - The ASCII value to output
;	D register - Row position (1-8)
;	E register - Column position (1-16)
;**********************************
output_c:
	push hl
	push de
	dec d ;has to decrement e and d because the set_screen_position inputs have to index off of zero
	dec e
	push af
	ld a,e
	and a,%00001111
	ld (curCol),a
	ld a,d
	and a,%00000111
	ld (curRow),a
	pop af
	bcall(_PutMap) ;PutMap is $4501 | PutC is $4504 | PutS is $450A
	call enable_ISR ;PutMap disables Interrupts so we have to re-enable ours after a bcall to PutMap
	pop de
	pop hl
	ret

;**********************************
;Function Name: output_s
;Description: Outputs a zero terminated string of ASCII characters
;	to the screen starting at a specified position. (Wraps around)
;Parameters:
;	HL register - Pointer to the zero terminated ASCII string
;	D register - Row position (1-8)
;	E register - Column position (1-16)
;**********************************
output_s:
	push af ;have to push the a register as it is used in the routine
	push de
	ld a,(hl)
output_s_loop:
	;bcall(_PutMap) ;PutMap is $4501 | PutC is $4504 | PutS is $450A
	call output_c
	inc e
	ld a,e
	cp 17
	jr nz,output_s_loop_e
	ld e,1					;resets e to 1 once it rolls over 16
	inc d
output_s_loop_e:
	ld a,d
	cp 9
	jr nz,output_s_loop_d
	ld d,1					;resets d to 1 once it rolls over 8
output_s_loop_d:	
	inc hl
	ld a,(hl)
	cp 0
	jr nz,output_s_loop
	inc hl
	pop de
	pop af
	ret

#define DIALOGUE_AUTOSKIP_KEY_VALUE ($FF)
#define DIALOGUE_MODE_REDRAW_bp (6)
#define DIALOGUE_MODE_DIALOGUE_DECISION_bp (7)
#define DIALOGUE_MODE_1_ROW_bm (%00000000)
#define DIALOGUE_MODE_2_ROW_bm (%00000001)
#define DIALOGUE_MODE_3_ROW_bm (%00000010)
#define DIALOGUE_MODE_REDRAW_bm (%00000000)
#define DIALOGUE_MODE_NO_REDRAW_bm (%01000000)
#define DIALOGUE_MODE_DIALOGUE_bm (%00000000)
#define DIALOGUE_MODE_DECISION_bm (%10000000)

dialogue_printer_table:
	.db 5 \ .dw $0601 \ .dw dialogue_box_1_row_buffer \ .dw $0702
	.db 4 \ .dw $0501 \ .dw dialogue_box_2_row_buffer \ .dw $0602
	.db 3 \ .dw $0401 \ .dw dialogue_box_3_row_buffer \ .dw $0502

;**********************************
;Function Name: dialogue_printer_1_row
;Description: Prints the dialogue string pointed to by HL using a 1 row
;	dialogue box, and re-renders the background in the empty space.
;Parameters:
;	HL register - Pointer to the zero terminated ASCII string of dialogue text.
;**********************************
dialogue_printer_1_row:
	ld c, DIALOGUE_MODE_1_ROW_bm | DIALOGUE_MODE_REDRAW_bm | DIALOGUE_MODE_DIALOGUE_bm
	jr dialogue_printer_master

;**********************************
;Function Name: dialogue_printer_1_row_no_redraw
;Description: Prints the dialogue string pointed to by HL using a 1 row
;	dialogue box. Doesn't re-render the background.
;Parameters:
;	HL register - Pointer to the zero terminated ASCII string of dialogue text.
;**********************************
dialogue_printer_1_row_no_redraw:
	ld c, DIALOGUE_MODE_1_ROW_bm | DIALOGUE_MODE_NO_REDRAW_bm | DIALOGUE_MODE_DIALOGUE_bm
	jr dialogue_printer_master

;**********************************
;Function Name: dialogue_printer_2_row
;Description: Prints the dialogue string pointed to by HL using a 2 row
;	dialogue box, and re-renders the background in the empty space.
;Parameters:
;	HL register - Pointer to the zero terminated ASCII string of dialogue text.
;**********************************
dialogue_printer_2_row:
	ld c, DIALOGUE_MODE_2_ROW_bm | DIALOGUE_MODE_REDRAW_bm | DIALOGUE_MODE_DIALOGUE_bm
	jr dialogue_printer_master

;**********************************
;Function Name: dialogue_printer_2_row_no_redraw
;Description: Prints the dialogue string pointed to by HL using a 2 row
;	dialogue box. Doesn't re-render the background.
;Parameters:
;	HL register - Pointer to the zero terminated ASCII string of dialogue text.
;**********************************
dialogue_printer_2_row_no_redraw:
	ld c, DIALOGUE_MODE_2_ROW_bm | DIALOGUE_MODE_NO_REDRAW_bm | DIALOGUE_MODE_DIALOGUE_bm
	jr dialogue_printer_master

;**********************************
;Function Name: dialogue_printer_3_row
;Description: Prints the dialogue string pointed to by HL using a 3 row
;	dialogue box, and re-renders the background in the empty space.
;Parameters:
;	HL register - Pointer to the zero terminated ASCII string of dialogue text.
;**********************************
dialogue_printer_3_row:
	ld c, DIALOGUE_MODE_3_ROW_bm | DIALOGUE_MODE_REDRAW_bm | DIALOGUE_MODE_DIALOGUE_bm
	jr dialogue_printer_master

;**********************************
;Function Name: dialogue_printer_3_row_no_redraw
;Description: Prints the dialogue string pointed to by HL using a 3 row
;	dialogue box. Doesn't re-render the background.
;Parameters:
;	HL register - Pointer to the zero terminated ASCII string of dialogue text.
;**********************************
dialogue_printer_3_row_no_redraw:
	ld c, DIALOGUE_MODE_3_ROW_bm | DIALOGUE_MODE_NO_REDRAW_bm | DIALOGUE_MODE_DIALOGUE_bm
	jr dialogue_printer_master

;**********************************
;Function Name: decision_printer_1_row
;Description: Prints the dialogue string pointed to by HL using a 1 row
;	dialogue box, but also prints a yes or no decision prompt and returns
;	a boolean with the player's decision. Still Re-renders the background in the empty space.
;Parameters:
;	HL register - Pointer to the zero terminated ASCII string of dialogue text.
;**********************************
decision_printer_1_row:
	ld c, DIALOGUE_MODE_1_ROW_bm | DIALOGUE_MODE_REDRAW_bm | DIALOGUE_MODE_DECISION_bm
	jr dialogue_printer_master

;**********************************
;Function Name: decision_printer_1_row_no_redraw
;Description: Prints the dialogue string pointed to by HL using a 1 row
;	dialogue box, but also prints a yes or no decision prompt and returns
;	a boolean with the player's decision. Doesn't re-render the background.
;Parameters:
;	HL register - Pointer to the zero terminated ASCII string of dialogue text.
;**********************************
decision_printer_1_row_no_redraw:
	ld c, DIALOGUE_MODE_1_ROW_bm | DIALOGUE_MODE_NO_REDRAW_bm | DIALOGUE_MODE_DECISION_bm
	jr dialogue_printer_master

;**********************************
;Function Name: decision_printer_2_row
;Description: Prints the dialogue string pointed to by HL using a 2 row
;	dialogue box, but also prints a yes or no decision prompt and returns
;	a boolean with the player's decision. Still Re-renders the background in the empty space.
;Parameters:
;	HL register - Pointer to the zero terminated ASCII string of dialogue text.
;**********************************
decision_printer_2_row:
	ld c, DIALOGUE_MODE_2_ROW_bm | DIALOGUE_MODE_REDRAW_bm | DIALOGUE_MODE_DECISION_bm
	jr dialogue_printer_master

;**********************************
;Function Name: decision_printer_2_row_no_redraw
;Description: Prints the dialogue string pointed to by HL using a 2 row
;	dialogue box, but also prints a yes or no decision prompt and returns
;	a boolean with the player's decision. Doesn't re-render the background.
;Parameters:
;	HL register - Pointer to the zero terminated ASCII string of dialogue text.
;**********************************
decision_printer_2_row_no_redraw:
	ld c, DIALOGUE_MODE_2_ROW_bm | DIALOGUE_MODE_NO_REDRAW_bm | DIALOGUE_MODE_DECISION_bm
	jr dialogue_printer_master

;**********************************
;Function Name: dialogue_printer_master
;Description: This is the sub function that handles rendering the dialogue
;	boxes, re-rendering the background rows, and the key inputs of the user.
;Parameters:
;	C register - Contains the mode flags for how to render and handle the dialogue.
;**********************************
dialogue_printer_master:
	push hl
	push de
	push ix
	;generate the dialogue table pointer
	ld ix,dialogue_printer_table
	ld a,c
	and %00000011 ;mask out just the bottom two bits so we know how big the dialogue box is
	ld b,a
	sla a
	sla a
	sla a
	sub a,b
	ld e,a
	ld d,0
	add ix,de
	bit DIALOGUE_MODE_REDRAW_bp,c
	jr nz,dialogue_printer_master_draw_box
	;redraw the top 5-3 rows
	ld a,(ix+0)
	call redraw_screen_dialogue
dialogue_printer_master_draw_box:
	;load the draw position and draw the dialogue box
	ld e,(ix+1)
	ld d,(ix+2)
	push hl
	ld l,(ix+3)
	ld h,(ix+4)
	call output_s
	pop hl
	ld d,(ix+6)
dialogue_printer_master_reload_horiz:
	ld e,(ix+5)
dialogue_printer_master_loop:
	ld a,(hl)
	cp 0
	jr z,dialogue_printer_master_exit
	cp Lenter ;carriage return
	jr nz,dialogue_printer_master_skip_cr	
	;set the horizontal position to the last position before rollover
	ld e,15
	jr dialogue_printer_master_increment_values
dialogue_printer_master_skip_cr:
	call output_c
dialogue_printer_master_increment_values:
	inc hl
	inc e
	;check if horizontal position hasn't scrolled too far (16)
	ld a,16
	cp e
	jr nz,dialogue_printer_master_loop
	inc d
	;check if vertical position hasn't scrolled too far (8)
	ld a,8
	cp d
	jr nz,dialogue_printer_master_reload_horiz
	ld a,(hl)
	cp 0
	jr z,dialogue_printer_master_exit
	;print the call to action for a new box
	ld de,$080F
	ld a,Lellipsis
	call output_c
	call dialogue_printer_key_loop
	jr dialogue_printer_master_draw_box
dialogue_printer_master_exit:
	;print the CTA at the end
	bit DIALOGUE_MODE_DIALOGUE_DECISION_bp,c
	jr z,dialogue_printer_master_cta_dialogue
dialogue_printer_master_cta_decision:
	ld de,$0809
	ld hl,decision_option_text
	call output_s
	call decision_printer_key_loop
	jr dialogue_printer_master_return
dialogue_printer_master_cta_dialogue:
	ld de,$080F
	ld a,Lconvert
	call output_c
	call dialogue_printer_key_loop
dialogue_printer_master_return:
	pop ix
	pop de
	pop hl
	ret 

;**********************************
;Function Name: redraw_screen_dialogue
;Description: Renders an amount of rows of the background from top to bottom.
;Parameters:
;	A register - Numbers of rows.
;**********************************
redraw_screen_dialogue:
	cp 0
	ret z
	push hl
	push de
	push bc
	ld hl,background_buffer
	;ld hl,collision_buffer (You can swap out the two loads for debug purposes)
	ld b,a
	ld de, $0101
redraw_screen_dialogue_loop:
	ld a,(hl)
	call output_c
	inc e
	ld a,17
	cp e
	jr nz,redraw_screen_dialogue_skip_e
	ld e,1					;resets e to 1 once it rolls over 16
	inc d
	inc hl
	djnz redraw_screen_dialogue_loop
	call draw_player_and_background_player
	pop bc
	pop de
	pop hl
	ret
redraw_screen_dialogue_skip_e:
	inc hl
	jr redraw_screen_dialogue_loop

;**********************************
;Function Name: dialogue_printer_key_loop
;Description: This jumps to dialogue_printer_key_loop_master in dialogue mode
;Parameters:
;	None
;**********************************
dialogue_printer_key_loop:
	ld b, DIALOGUE_MODE_DIALOGUE_bm
	jr dialogue_printer_key_loop_master

;**********************************
;Function Name: decision_printer_key_loop
;Description: This jumps to dialogue_printer_key_loop_master in decision mode
;Parameters:
;	None
;**********************************
decision_printer_key_loop: ;returns a boolean value in the a register. 0 if no, and 1 if yes.
	ld b, DIALOGUE_MODE_DECISION_bm
	jr dialogue_printer_key_loop_master

;**********************************
;Function Name: dialogue_printer_key_loop_master
;Description: This is the sub function that handles key inputs for
;	the dialogue_printer_master function.
;Parameters:
;	B register - Contains the mode flag for how respond to key inputs
;**********************************
dialogue_printer_key_loop_master:
	ld a,(latest_key)
	cp DIALOGUE_AUTOSKIP_KEY_VALUE
	jr z,dialogue_printer_key_loop_master_override
	push hl
	push bc
	bcall(_kdbScan)
	bcall(_GetCSC)
	pop bc
	pop hl
	bit DIALOGUE_MODE_DIALOGUE_DECISION_bp,b
	jr nz,dialogue_printer_key_loop_master_decision
dialogue_printer_key_loop_master_dialogue:
	cp sk2nd ;the key code for '2nd' when using the GetCSC routine
	ret z
	cp skEnter ;I figured having enter as another option would help players with the controlls
	ret z
	jr dialogue_printer_key_loop_master
dialogue_printer_key_loop_master_decision:
	cp sk1 ;the key code for '1' when using the GetCSC routine
	jr z, dialogue_printer_key_loop_master_ret_yes
	cp sk2 ;the key code for '2' when using the GetCSC routine
	jr z, dialogue_printer_key_loop_master_ret_no
	jr dialogue_printer_key_loop_master
dialogue_printer_key_loop_master_override:
	xor a ;ld a,0
	ld (latest_key),a
	ret
dialogue_printer_key_loop_master_ret_yes:
	ld a,1
	ret
dialogue_printer_key_loop_master_ret_no:
	xor a ;ld a,0
	ret
	
;************************************************************************************************************
; Safety and Memory Functions
;************************************************************************************************************

;**********************************
;Function Name: clean_ram
;Description: This function zeros out the memory ranges located in the plotSScreen
;   and app appBackUpScreen ram locations that are used to store game variables.
;Parameters:
;	None
;**********************************
clean_ram:
	ld hl,ram_location
	ld de,ram_location+1
	ld (hl),0
	ld bc,ram_location_end-ram_location
	ldir ;this uses a trick where we load a zero into the starting location and then use ldir to copy that zero from hl to hl+1 over and over which clears the memory range
	ld hl,buffers_start
	ld de,buffers_start+1
	ld (hl),0
	ld bc,buffers_ends-buffers_start
	ldir
	ret

;**********************************
;Function Name: check_battery
;Description: This function checks the state of the calculator's batteries and prints
;   a message if it detects low power to warn the user to not play on low power.
;Parameters:
;	None
;**********************************
check_battery:
	bcall(_Chk_Batt_Low)
	;call enable_ISR ;Chk_Batt_Low looks like it doesn't disable interrupts so we don't need to call enable_ISR
	ret nz ;Z=1:Batteries are low / Z=0:Batteries are good
	ld hl,game_battery_low_text
	call dialogue_printer_3_row_no_redraw
	ret

;**********************************
;Function Name: check_memory_availability
;Description: This function checks the current available RAM memory in the calculator
;   and prints a message to warn the user if it falls under a certain amount which could
;   affect the ability to save the game.
;Parameters:
;	None
;**********************************
check_memory_availability:
	bcall(_MemChk)
	;call enable_ISR ;MemChk looks like it doesn't disable interrupts so we don't need to call enable_ISR
	ld bc,2*(ram_save_data_end-ram_save_data_beginning) ;This is how big of system memory we will check is available
	or a ;reset the carry flag
	sbc hl,bc
	ret p ;if the subtraction operation is positive then we have enough space and should return, otherwise we must warn the user
	ld hl,game_memory_insufficent_text
	call dialogue_printer_3_row_no_redraw
	ret

;**********************************
;Function Name: read_variable_allocation_table
;Description: This function loads the filename of the save file "MCGUFSAV" into OP1
;   and calls _ChkFindSym to grab the file information on it from the variable
;   allocation table.
;Parameters:
;	None
;**********************************
read_variable_allocation_table:
	ld  hl,save_file_name
    rst rMOV9TOOP1
	bcall(_ChkFindSym)
	;call enable_ISR ;ChkFindSym looks like it doesn't disable interrupts so we don't need to call enable_ISR
	ret

;**********************************
;Function Name: save_file_load_manager
;Description: This function runs the check_memory_availability function on the calculator RAM
;   and then attempts to load the data from the "MCGUFSAV" save file if it exists.
;Parameters:
;	None
;**********************************
save_file_load_manager:
	call check_memory_availability
    call read_variable_allocation_table
    ret c ;we can exit early if no save file was found
	call save_file_unarchive
	call save_file_pull_data
	call save_file_archive
	ret

;**********************************
;Function Name: save_file_create_save
;Description: This function creates a blank "MCGUFSAV" save file in RAM.
;Parameters:
;	None
;**********************************
save_file_create_save:
	ld hl,save_file_name
    rst rMOV9TOOP1
	ld hl,ram_save_data_end-ram_save_data_beginning
	bcall(_CreateAppVar)
	;call enable_ISR ;CreateAppVar looks like it doesn't disable interrupts so we don't need to call enable_ISR
	ret

;**********************************
;Function Name: save_file_push_data
;Description: This function copies the save data from game RAM to the "MCGUFSAVE" save file
;   or prints a message to the user if a failure occurs.
;Parameters:
;	None
;**********************************
save_file_push_data:
	call read_variable_allocation_table
	jr c,save_file_push_data_error
	xor a ;ld a,0
	cp b
	jr nz,save_file_push_data_error
	inc de
	inc de ;iterate past the 2 byte file size header at the beginning of the file and point de to the start of the save data
	ld hl,ram_save_data_beginning
	ld bc,ram_save_data_end-ram_save_data_beginning
	ldir
	ret
save_file_push_data_error:
	ld hl,game_save_fail_text
	call dialogue_printer_1_row_no_redraw
	ret

;**********************************
;Function Name: save_file_pull_data
;Description: This function copies the save data from the "MCGUFSAVE" save file into game RAM
;   or prints a message to the user if a failure occurs.
;Parameters:
;	None
;**********************************
save_file_pull_data: ;Takes de as the location of the save data
	call read_variable_allocation_table
	jr c,save_file_pull_data_error
	xor a ;ld a,0
	cp b
	jr nz,save_file_pull_data_error
	inc de
	inc de ;iterate past the 2 byte file size header at the beginning of the file and point de to the start of the save data
	ex de,hl
	ld de,ram_save_data_beginning
	ld bc,ram_save_data_end-ram_save_data_beginning
	ldir
	ret
save_file_pull_data_error:
	ld hl,game_load_fail_text
	call dialogue_printer_1_row_no_redraw
	ret

;**********************************
;Function Name: save_file_archive
;Description: This function sends the "MCGUFSAVE" save file to archive memory
;Parameters:
;	None
;**********************************
save_file_archive:
	call read_variable_allocation_table
	ret c ;abort if no variable was found
	xor a ;ld a,0
	cp b ;check if the variable is not in ram (not equal to 0)
	ret nz ;abort if already not in ram (archived)
	bcall(_Arc_Unarc)
	call enable_ISR ;Arc_Unarc is one of the bcalls that switches interrupt mode to 1 so we have to switch it back
	ret

;**********************************
;Function Name: save_file_unarchive
;Description: This function retrieves the "MCGUFSAVE" save file from archive memory
;Parameters:
;	None
;**********************************
save_file_unarchive:
	call read_variable_allocation_table
	ret c ;abort if no variable was found
	xor a ;ld a,0
	cp b ;check if the variable is already in ram (equal to 0)
	ret z ;abort if already in ram
	bcall(_Arc_Unarc)
	call enable_ISR ;Arc_Unarc is one of the bcalls that switches interrupt mode to 1 so we have to switch it back
    ret	