;Author: Phoenix Cushman (Diet-Gameboy on GitHub)
;File Name dialogue.asm
;Date Created: Fall 2023 (Unknown)
;Last Modified: 6/17/2025
;Description:
;	This file contains all the dialogue text in the game ranging from interface menu text to the npc
;	and actor dialogue. It also contains the compressed ASCII graphics for the Title screen and menu pages.

save_file_name:
	.db AppVarObj,tM,tC,tG,tU,tF,tS,tA,tV

game_battery_low_text:
	.db "Warning: Low",$D6,"Batteries. May","Cause Unsafe",$D6,"Saving & Cause","Save File",$D6,"Corruption.",0
game_memory_insufficent_text:
	.db "Warning: There"," Is Very Low",$D6,"System Memory.You Might Not Be Able To",$D6,"Save The Game.",0
game_save_fail_text:
	.db "File Save Fail",0
game_load_fail_text:
	.db "File Load Fail",0
menu_screen_save_dialogue_1:
	.db "Saving Game...",0
menu_screen_save_dialogue_2:
	.db "Save Complete.",0
menu_screen_exit_dialogue:
	.db "Exiting Game..",0
menu_screen_delete_dialogue_1:
	.db "Deleting Save",$D6,"File...",0
menu_screen_delete_dialogue_2:
	.db "Save File",$D6,"Deleted.",0
menu_screen_delete_dialogue_3:
	.db "No File Found.",0
menu_screen_delete_dialogue_4:
	.db "Delete File?",0
menu_screen_text_item_check_mark:
	.db $10,0
menu_screen_text_item_flower:
	.db "Flower     * ",0
menu_screen_text_item_lemon:
	.db "Lemon  { }   ",0
menu_screen_text_item_lemonade:
	.db "Lemonade \\D/ ",0
menu_screen_text_item_pumpkin:
	.db "Pumpkin  ",$C1,$A9,"] ",0
menu_screen_text_item_seeds:
	.db "Seeds   %%   ",0
menu_screen_text_item_seagull:
	.db "Seagull  W   ",0
menu_screen_text_item_bees:
	.db "Bees:1   O",$F4,"  ",0
menu_screen_text_item_bees_1:
	.db "Bees:1   O",$F4,"  ",0
menu_screen_text_item_bees_2:
	.db "Bees:2   O",$F4,"  ",0
menu_screen_text_item_bees_3:
	.db "Bees:3   O",$F4,"  ",0
menu_screen_text_item_fly:
	.db "Fly   `",$A5,$F4,"    ",0
menu_screen_text_equip_key:
	.db "[",$C4,0
menu_screen_text_equip_key_name:	
	.db "GateKey",0
menu_screen_text_equip_boots:
	.db $BF,$BF,0
menu_screen_text_equip_boots_name:
	.db "MudBoot",0
menu_screen_text_equip_oars:
	.db $9C,$9C,0
menu_screen_text_equip_oars_name:
	.db "BoatOar",0
menu_screen_text_equip_glass:
	.db $C5,$CE,0
menu_screen_text_equip_glass_name:
	.db "Magnify",0
menu_screen_text_equip_rod:
	.db "/",$B9,0
menu_screen_text_equip_rod_name:
	.db "FishRod",0
menu_screen_text_equip_oil:
	.db $C1,"D",0
menu_screen_text_equip_oil_name:
	.db "FishOil",0
menu_screen_text_mcguffin_bee_top:
	.db "_O",$BC,"_",0
menu_screen_text_mcguffin_bee_bottom:
	.db $B7,"--",$B6,0
menu_screen_text_mcguffin_bog_top:
	.db "(*)",$A5,0
menu_screen_text_mcguffin_bog_bottom:
	.db $B7,"--",$B6,0
menu_screen_text_mcguffin_ice_top:
	.db "_/\\_",0
menu_screen_text_mcguffin_ice_bottom:
	.db $B7,"--",$B6,0
menu_screen_text_mcguffin_fire_top:
	.db $BE,"^^",$BE,0
menu_screen_text_mcguffin_fire_bottom:
	.db $B7,$CD,$CD,$B6,0

title_screen_main:
;	.db $0A,"MCGUFFIN-HUNT:",$0A
;	.db "|By:",$CE,$CE,$CE,$CE,$CE,$CE,$CE,$CE,$CE,"_ |"
;	.db "|  / PhoeniX / |"
;	.db "| ( ()     !(  |"
;	.db "|  )  ",$C4,$1A,"-",$1A,$1A,"()) |"
;	.db "| /",$CE,"Cushman_/  |"
;	.db "|              |"
;	.db $0A,"-PRESS-ENTER:-",$0A
	.db $FE
	.db 10
	.db "M"
	.db "C"
	.db "G"
	.db "U"
	.db "F"
	.db "F"
	.db "I"
	.db "N"
	.db "-"
	.db "H"
	.db "U"
	.db "N"
	.db "T"
	.db ":"
	.db 10
	.db "|"
	.db "B"
	.db "y"
	.db ":"
	.db $FD
	.db 9,$CE
	.db $FE
	.db "_"
	.db " "
	.db "|"
	.db "|"
	.db " "
	.db " "
	.db "/"
	.db " "
	.db "P"
	.db "h"
	.db "o"
	.db "e"
	.db "n"
	.db "i"
	.db "X"
	.db " "
	.db "/"
	.db " "
	.db "|"
	.db "|"
	.db " "
	.db "("
	.db " "
	.db "("
	.db ")"
	.db $FD
	.db 5," "
	.db $FE
	.db "!"
	.db "("
	.db " "
	.db " "
	.db "|"
	.db "|"
	.db " "
	.db " "
	.db ")"
	.db " "
	.db " "
	.db $C4
	.db $1A
	.db "-"
	.db $1A
	.db $1A
	.db "("
	.db ")"
	.db ")"
	.db " "
	.db "|"
	.db "|"
	.db " "
	.db "/"
	.db $CE
	.db "C"
	.db "u"
	.db "s"
	.db "h"
	.db "m"
	.db "a"
	.db "n"
	.db "_"
	.db "/"
	.db " "
	.db " "
	.db "|"
	.db "|"
	.db $FD
	.db 14," "
	.db $FE
	.db "|"
	.db 10
	.db "-"
	.db "P"
	.db "R"
	.db "E"
	.db "S"
	.db "S"
	.db "-"
	.db "E"
	.db "N"
	.db "T"
	.db "E"
	.db "R"
	.db ":"
	.db "-"
	.db 10
	.db $FF
title_screen_controls:
;	.db $0A,"--------------",$0A
;	.db "|   CONTROLS:  |"
;	.db "|              |"
;	.db "| Move: Arrows |"
;	.db "| Menu:  Mode  |"
;	.db "| Talk:   2ND  |"
;	.db "|              |"
;	.db $0A,"-PRESS-ENTER:-",$0A
	.db 1,10
	.db 14,"-"
	.db $FE
	.db 10
	.db "|"
	.db $FD
	.db 3," "
	.db $FE
	.db "C"
	.db "O"
	.db "N"
	.db "T"
	.db "R"
	.db "O"
	.db "L"
	.db "S"
	.db ":"
	.db " "
	.db " "
	.db "|"
	.db "|"
	.db $FD
	.db 14," "
	.db 2,"|"
	.db $FE
	.db " "
	.db "M"
	.db "o"
	.db "v"
	.db "e"
	.db ":"
	.db " "
	.db "A"
	.db "r"
	.db "r"
	.db "o"
	.db "w"
	.db "s"
	.db " "
	.db "|"
	.db "|"
	.db " "
	.db "M"
	.db "e"
	.db "n"
	.db "u"
	.db ":"
	.db " "
	.db " "
	.db "M"
	.db "o"
	.db "d"
	.db "e"
	.db " "
	.db " "
	.db "|"
	.db "|"
	.db " "
	.db "T"
	.db "a"
	.db "l"
	.db "k"
	.db ":"
	.db $FD
	.db 3," "
	.db $FE
	.db "2"
	.db "N"
	.db "D"
	.db " "
	.db " "
	.db "|"
	.db "|"
	.db $FD
	.db 14," "
	.db $FE
	.db "|"
	.db 10
	.db "-"
	.db "P"
	.db "R"
	.db "E"
	.db "S"
	.db "S"
	.db "-"
	.db "E"
	.db "N"
	.db "T"
	.db "E"
	.db "R"
	.db ":"
	.db "-"
	.db 10
	.db $FF
title_screen_objective:
;	.db $0A,"--------------",$0A
;	.db "|   MISSION:   |"
;	.db "|              |"
;	.db "|Explore Around|"
;	.db "|& Collect All |"
;	.db "| 4 MCGUFFINS  |"
;	.db "|              |"
;	.db $0A,"-PRESS-ENTER:-",$0A
	.db 1,10
	.db 14,"-"
	.db $FE
	.db 10
	.db "|"
	.db $FD
	.db 3," "
	.db $FE
	.db "M"
	.db "I"
	.db "S"
	.db "S"
	.db "I"
	.db "O"
	.db "N"
	.db ":"
	.db $FD
	.db 3," "
	.db 2,"|"
	.db 14," "
	.db 2,"|"
	.db $FE
	.db "E"
	.db "x"
	.db "p"
	.db "l"
	.db "o"
	.db "r"
	.db "e"
	.db " "
	.db "A"
	.db "r"
	.db "o"
	.db "u"
	.db "n"
	.db "d"
	.db "|"
	.db "|"
	.db "&"
	.db " "
	.db "C"
	.db "o"
	.db "l"
	.db "l"
	.db "e"
	.db "c"
	.db "t"
	.db " "
	.db "A"
	.db "l"
	.db "l"
	.db " "
	.db "|"
	.db "|"
	.db " "
	.db "4"
	.db " "
	.db "M"
	.db "C"
	.db "G"
	.db "U"
	.db "F"
	.db "F"
	.db "I"
	.db "N"
	.db "S"
	.db " "
	.db " "
	.db "|"
	.db "|"
	.db $FD
	.db 14," "
	.db $FE
	.db "|"
	.db 10
	.db "-"
	.db "P"
	.db "R"
	.db "E"
	.db "S"
	.db "S"
	.db "-"
	.db "E"
	.db "N"
	.db "T"
	.db "E"
	.db "R"
	.db ":"
	.db "-"
	.db 10
	.db $FF
menu_screen_items_background:
;	.db $0A,"---<ITEMS:>---",$0A
;	.db "|",$0A,"             |"
;	.db "|",$0A,"             |"
;	.db $CF,$0A,"             ",$05
;	.db $CF,$0A,"             ",$05
;	.db "|",$0A,"             |"
;	.db "|",$0A,"             |"
;	.db $0A,"<",$F2,":00>--------",$0A
	.db 1,10
	.db 3,"-"
	.db $FE
	.db "<"
	.db "I"
	.db "T"
	.db "E"
	.db "M"
	.db "S"
	.db ":"
	.db ">"
	.db $FD
	.db 3,"-"
	.db $FE
	.db 10
	.db "|"
	.db 10
	.db $FD
	.db 13," "
	.db 2,"|"
	.db 1,10
	.db 13," "
	.db $FE
	.db "|"
	.db $CF
	.db 10
	.db $FD
	.db 13," "
	.db $FE
	.db 5
	.db $CF
	.db 10
	.db $FD
	.db 13," "
	.db $FE
	.db 5
	.db "|"
	.db 10
	.db $FD
	.db 13," "
	.db 2,"|"
	.db 1,10
	.db 13," "
	.db $FE
	.db "|"
	.db 10
	.db "<"
	.db $F2
	.db ":"
	.db "0"
	.db "0"
	.db ">"
	.db $FD
	.db 8,"-"
	.db 1,10
	.db $FF
menu_screen_equipment_background:
;	.db $0A,"-<EQUIPMENT:>-",$0A
;	.db "|  !  !",$0A,"       |"
;	.db "|--+--+",$0A,"       |"
;	.db $CF,"  !  !",$0A,"       ",$05
;	.db $CF,"--+--+",$0A,"       ",$05
;	.db "|  !  !",$0A,"       |"
;	.db "|--+--+",$0A,"       |"
;	.db $0A,"--------------",$0A
	.db $FE
	.db 10
	.db "-"
	.db "<"
	.db "E"
	.db "Q"
	.db "U"
	.db "I"
	.db "P"
	.db "M"
	.db "E"
	.db "N"
	.db "T"
	.db ":"
	.db ">"
	.db "-"
	.db 10
	.db "|"
	.db " "
	.db " "
	.db "!"
	.db " "
	.db " "
	.db "!"
	.db 10
	.db $FD
	.db 7," "
	.db 2,"|"
	.db 2,"-"
	.db 1,"+"
	.db 2,"-"
	.db $FE
	.db "+"
	.db 10
	.db $FD
	.db 7," "
	.db $FE
	.db "|"
	.db $CF
	.db " "
	.db " "
	.db "!"
	.db " "
	.db " "
	.db "!"
	.db 10
	.db $FD
	.db 7," "
	.db $FE
	.db 5
	.db $CF
	.db "-"
	.db "-"
	.db "+"
	.db "-"
	.db "-"
	.db "+"
	.db 10
	.db $FD
	.db 7," "
	.db $FE
	.db 5
	.db "|"
	.db " "
	.db " "
	.db "!"
	.db " "
	.db " "
	.db "!"
	.db 10
	.db $FD
	.db 7," "
	.db 2,"|"
	.db 2,"-"
	.db 1,"+"
	.db 2,"-"
	.db $FE
	.db "+"
	.db 10
	.db $FD
	.db 7," "
	.db $FE
	.db "|"
	.db 10
	.db $FD
	.db 14,"-"
	.db 1,10
	.db $FF
menu_screen_mcguffins_background:
;	.db $0A,"-<MCGUFFINS:>-",$0A
;	.db "|              |"
;	.db "| ____    ____ |"
;	.db $CF," bee     bog  ",$05
;	.db $CF,"              ",$05
;	.db "| ____    ____ |"
;	.db "| ice     fire |"
;	.db $0A,"--------------",$0A
	.db $FE
	.db 10
	.db "-"
	.db "<"
	.db "M"
	.db "C"
	.db "G"
	.db "U"
	.db "F"
	.db "F"
	.db "I"
	.db "N"
	.db "S"
	.db ":"
	.db ">"
	.db "-"
	.db 10
	.db "|"
	.db $FD
	.db 14," "
	.db 2,"|"
	.db 1," "
	.db 4,"_"
	.db 4," "
	.db 4,"_"
	.db $FE
	.db " "
	.db "|"
	.db $CF
	.db " "
	.db "b"
	.db "e"
	.db "e"
	.db $FD
	.db 5," "
	.db $FE
	.db "b"
	.db "o"
	.db "g"
	.db " "
	.db " "
	.db 5
	.db $CF
	.db $FD
	.db 14," "
	.db $FE
	.db 5
	.db "|"
	.db " "
	.db $FD
	.db 4,"_"
	.db 4," "
	.db 4,"_"
	.db 1," "
	.db 2,"|"
	.db $FE
	.db " "
	.db "i"
	.db "c"
	.db "e"
	.db $FD
	.db 5," "
	.db $FE
	.db "f"
	.db "i"
	.db "r"
	.db "e"
	.db " "
	.db "|"
	.db 10
	.db $FD
	.db 14,"-"
	.db 1,10
	.db $FF
menu_screen_options_background:
;	.db $0A,"--<OPTIONS:>--",$0A
;	.db "|              |"
;	.db "|1",$0A,"Save Game   |"
;	.db $CF,"2",$0A,"Save & Quit ",$05
;	.db $CF,"3",$0A,"Quit        ",$05
;	.db "|","4",$0A,"Delete Save |"
;	.db "|              |"
;	.db $0A,"--------------",$0A
	.db 1,10
	.db 2,"-"
	.db $FE
	.db "<"
	.db "O"
	.db "P"
	.db "T"
	.db "I"
	.db "O"
	.db "N"
	.db "S"
	.db ":"
	.db ">"
	.db "-"
	.db "-"
	.db 10
	.db "|"
	.db $FD
	.db 14," "
	.db 2,"|"
	.db $FE
	.db "1"
	.db 10
	.db "S"
	.db "a"
	.db "v"
	.db "e"
	.db " "
	.db "G"
	.db "a"
	.db "m"
	.db "e"
	.db $FD
	.db 3," "
	.db $FE
	.db "|"
	.db $CF
	.db "2"
	.db 10
	.db "S"
	.db "a"
	.db "v"
	.db "e"
	.db " "
	.db "&"
	.db " "
	.db "Q"
	.db "u"
	.db "i"
	.db "t"
	.db " "
	.db 5
	.db $CF
	.db "3"
	.db 10
	.db "Q"
	.db "u"
	.db "i"
	.db "t"
	.db $FD
	.db 8," "
	.db $FE
	.db 5
	.db "|"
	.db "4"
	.db 10
	.db "D"
	.db "e"
	.db "l"
	.db "e"
	.db "t"
	.db "e"
	.db " "
	.db "S"
	.db "a"
	.db "v"
	.db "e"
	.db " "
	.db "|"
	.db "|"
	.db $FD
	.db 14," "
	.db $FE
	.db "|"
	.db 10
	.db $FD
	.db 14,"-"
	.db 1,10
	.db $FF
dialogue_box_1_row:
;	.db $0A,"--------------",$0A
;	.db "|              |"
;	.db $0A,"--------------",$0A
	.db 1,10
	.db 14,"-"
	.db $FE
	.db 10
	.db "|"
	.db $FD
	.db 14," "
	.db $FE
	.db "|"
	.db 10
	.db $FD
	.db 14,"-"
	.db 1,10
	.db $FF
dialogue_box_2_row:
;	.db $0A,"--------------",$0A
;	.db "|              |"
;	.db "|              |"
;	.db $0A,"--------------",$0A
	.db 1,10
	.db 14,"-"
	.db $FE
	.db 10
	.db "|"
	.db $FD
	.db 14," "
	.db 2,"|"
	.db 14," "
	.db $FE
	.db "|"
	.db 10
	.db $FD
	.db 14,"-"
	.db 1,10
	.db $FF
dialogue_box_3_row:
;	.db $0A,"--------------",$0A
;	.db "|              |"
;	.db "|              |"
;	.db "|              |"
;	.db $0A,"--------------",$0A
	.db 1,10
	.db 14,"-"
	.db $FE
	.db 10
	.db "|"
	.db $FD
	.db 14," "
	.db 2,"|"
	.db 14," "
	.db 2,"|"
	.db 14," "
	.db $FE
	.db "|"
	.db 10
	.db $FD
	.db 14,"-"
	.db 1,10
	.db $FF
decision_option_text:
	.db "(1Y/2N)",0

room_2_script_1_dialogue:
	.db " Welcome To",$D6,"   The Game!",0
room_2_script_2_dialogue:
	.db "Bruh, Imagine",$D6," Playing Some",$D6,"  Dude's Game",0
;
room_3_script_1_dialogue:
	.db " +5 Money  ",$F2,"  ","Don't Spend It"," All At Once! ",0
room_3_script_2_dialogue_1:
	.db "Objects That",$D6,"Pop Out Should","Be Checked Out",0
room_3_script_2_dialogue_2:
	.db "Try That Pile",$D6,"To The Right.",0
;
room_4_script_1_dialogue_1:
	.db "I'm Sad I Wish","I Had Somethin","To Cheer Me Up",0
room_4_script_1_dialogue_2:
    .db " Give Flower?",0
room_4_script_1_dialogue_3:
    .db "Oh Thank You!",$D6,"I Feel So Much","Better! Here's","A Gift For You",0
room_4_script_1_dialogue_4:
    .db "+1 Gatekey [-",$C4,0
room_4_script_2_dialogue:
	.db "Tree <-",$1E," Farm  Ruin ",$1F,"-> ??",0
;
room_5_script_1_dialogue_1:
	.db "You Need A Key"," To Open This",0
room_5_script_1_dialogue_2:
	.db " . . . Click!",0
;
room_6_script_shared_dialogue:
	.db "Bzz Bzz! Thank","You Again Bzz!",0
room_6_script_data:
	.db "8O\'"
;
room_7_script_1_dialogue_1:
	.db " Please Help! ","I've Lost 3 Of","  My Bees! O",$F4,0
room_7_script_1_dialogue_2:
    .db "You Still Have","2 Bees to Find",0
room_7_script_1_dialogue_3:
    .db "You Still Have","1 Bee to Find",0
room_7_script_1_dialogue_4:
    .db "Oh Thank You! "," For Finding  ","  All My Bees!",0
room_7_script_1_dialogue_5:
    .db "Here Is A Gift","To Thank You!",0
room_7_script_1_dialogue_6:
    .db "+Bee Mcguffin",0
room_7_script_2_dialogue:
	.db $F1,"It's Honey!",$F1,$F1,0
;
room_8_script_1_dialogue:
	.db " SNIP! SNAP!",0
room_8_script_2_dialogue:
	.db " Squish ",$CE,$CE,$40,$8D,0
;
room_9_script_dialogue_1:
	.db "  Use Seeds?",0
room_9_script_dialogue_2:
	.db " Squak Squak",0
room_9_script_dialogue_3:
	.db "+1 Seagull  W",0
room_9_script_data_1:
	;prev data, prev print position (y then x), seagull position (y then x)
	.db "=", 4, 11 \ .db 3, 11
	.db " ", 3, 11 \ .db 2, 10
	.db "^", 2, 10 \ .db 2, 9
	.db "^", 2, 9 \ .db 2, 8
	.db " ", 2, 8 \ .db 3, 7
	.db "^", 3, 7 \ .db 2, 6
	.db " ", 2, 6 \ .db 1, 5
	.db " ", 1, 5 \ .db 1, 4
	.db "θ", 1, 4 \ .db 2, 3
room_9_script_data_1_end:
;
room_10_script_1_dialogue_1:
    .db "I'm Playing",$D6,"Pirates, ARRG!",0
room_10_script_1_dialogue_2:
    .db "I just Need A ","Pet Parrot Now",0
room_10_script_1_dialogue_3:
    .db "Give Seagull?",0
room_10_script_1_dialogue_4:
    .db "You gave The",$D6,"Kid A S-Parrot"
room_10_script_1_dialogue_5:
    .db "Wow Thank You!","My Own Parrot!"
room_10_script_1_dialogue_6:
    .db "ARR, Have Some","Dabloons Matey",0
room_10_script_1_dialogue_7:
    .db " +5 Money  ",$F2,0
room_10_script_3_dialogue_1:
    .db "You Need Oars "," To Use This",0
room_10_script_3_dialogue_2:
room_31_script_dialogue:
    .db " TOOT!  TOOT!",0
;
room_12_script_dialogue:
    .db " +1 Lemon { }",0
;
;room_13_script_1_dialogue:
;    .db "BEE! BEE! BEE!",0
;room_13_script_2_dialogue:
;    .db "BOO! BOO! BOO!",0
room_13_script_3_dialogue:
    .db "Bah! Bah! Bah!",0
;
room_14_script_1_dialogue:
    .db " +1 Flower *",0
room_14_script_2_dialogue:
    .db "Enter Fridge?",0
;
room_15_script_1_dialogue_1:
    .db "1.Talk 2.Take",0
room_15_script_1_dialogue_2:
    .db "Man Birds Sure","Do Like Seeds!",0
room_15_script_1_dialogue_3:
    .db "HEY! WHAT ARE "," YOU DOING?",0
room_15_script_1_dialogue_4:
    .db "+1 Pumpkin ",$C1,$A9,"]","+Some Seeds %%",0
room_15_script_2_dialogue:
	.db "Hi, We're Corn",0
;
room_16_script_1_dialogue:
room_29_script_2_dialogue:
    .db " Zzz Zzz Zzz",0
room_16_script_2_dialogue_1:
room_30_script_1_dialogue_1:
room_32_script_2_dialogue_1:
    .db " Oh Thank You ","For Saving Me!",0
room_16_script_2_dialogue_2:
room_30_script_1_dialogue_2:
room_32_script_2_dialogue_2:
    .db " +1 Bee    O",$F4,0
room_16_script_3_dialogue:
    .db " Crackle Pop",0
;
room_17_script_dialogue:
    .db "+2 MudBoots ",$BF,$BF,0
;
room_18_script_dialogue:
    .db $21,"CAUTION",$21," Deep","Bog. Use Boots",0
;
room_20_script_dialogue_0:
	.db "It's A Whirlp-","ool. Something","Is Swimming At","The Bottom!",0
room_20_script_dialogue_1:
    .db "Use Fishn Rod?",0
room_20_script_dialogue_2:
    .db "Nothing Bit...",0
room_20_script_dialogue_3:
    .db "Something Bit!",0
room_20_script_dialogue_4:
    .db "Oh Hello! I Am","The Fish King!",0
room_20_script_dialogue_5:
    .db "Here Take This","I Tried to Get","A Tan With It,","But It Didn't ","Work. I Think ","It Blocks Heat",0
room_20_script_dialogue_6:
    .db " +1 Fish Oil",0
room_20_script_data:
    .db "M--V",$B6,$A5,$B7,"/|"," ",$20,$C9,"__",$DE,"|","^^^"
;
room_21_script_1_dialogue:
    .db "I've Been Here","Fishin For The","Monster Of The","Bog For Years!",0
room_21_script_2_dialogue:
    .db "(* ) Town T",$7F,"T",12," (* )---->",12,$EF,12,$EF,0
;
room_22_script_dialogue:
    .db "!..(HALT! None",$17,"O",$19,$13,"_May_Enter",0
;
room_23_script_dialogue:
    .db "Did You Know",$D6,"The King Likes"," To Eat Bugs?",0
;
room_24_script_1_dialogue_1:
    .db "Did You Bring ","A Gift For Me?",0
room_24_script_1_dialogue_2:
    .db "No? Then Leave"," My Presence!",0
room_24_script_1_dialogue_3:
    .db "  Give Fly?",0
room_24_script_1_dialogue_4:
    .db "Why Thank You "," I Love These!","Here's A Gift ","  For You!",0
room_24_script_1_dialogue_5:
    .db "+Bog Mcguffin!",0
room_24_script_1_dialogue_6:
    .db "I Must Again",$D6,"Thank You For ","That Delicious","   Present!",0
room_24_script_2_dialogue:
    .db " THBBPT!   ",$C9,":",0
;
room_25_script_dialogue:
    .db " +1 Fly   `",$A9,$F4,0
;
room_26_script_1_dialogue:
    .db "  Welcome To",$D6,"   My Store",0
room_26_script_2_dialogue:
    .db " +1 Rod    /",$B9,0
room_26_script_3_dialogue:
    .db " +2 Oars  ",$9C,$9C,0
room_26_script_shared_dialogue_1:
    .db "  Price: ",$F2,"10",0
room_26_script_shared_dialogue_2:
    .db "You Don't Have"," Enough Money",0
room_26_script_shared_dialogue_3:
    .db "   Purchase",$D6,"   The Item?",0
;
room_27_script_dialogue:
    .db "*The Flowers *",$BD," Smell Nice ",$1E,0
;
room_28_script_1_dialogue:
    .db "+1 MagnifyG. ",$C5,0
room_28_script_2_dialogue:
    .db "It's Just News",0
;
room_29_script_1_dialogue:
    .db " You Found 5",$F2,0
room_29_script_3_dialogue:
    .db $B6,"O",$B7," Bark!Bark!",0
;
room_30_script_2_dialogue:
    .db "Bubble",$14,"Bubble",$14,0
;
room_32_script_1_dialogue_1:
    .db " Sorry We're",$D6,"Out Of Lemons",0
room_32_script_1_dialogue_2:
    .db " Give Lemon?",0
room_32_script_1_dialogue_3:
    .db "Oh Thank You!",$D6,"  Here, It's",$D6," On The House!",0
room_32_script_1_dialogue_4:
    .db "+1 Lemonade\\D/",0
room_32_script_1_dialogue_5:
room_38_script_1_dialogue_5:
room_7_script_1_dialogue_7:
    .db "Thanks Again!",0
;
room_33_script_dialogue_1:
    .db " It's Way Too",$D6," Hot! You'll",$D6,"Need Something","For Your Skin.",0
room_33_script_dialogue_2:
    .db "Use Fish Oil?",0
room_33_script_dialogue_3:
    .db "Ahh, That Feel","s Much Better!",0
;
room_34_script_dialogue:
    .db "Sizzle  Sizzle",0
;
room_35_script_dialogue_1:
    .db "I Sure Do Feel","Quite Parched!",0
room_35_script_dialogue_2:
    .db "Give Lemonade?",0
room_35_script_dialogue_3:
    .db "Thank You Very","Much! That Hit","The Spot. Here"," Take This.",0
room_35_script_dialogue_4:
    .db "+Fire Mcguffin",0
room_35_script_dialogue_5:
    .db " Thanks Again "," For The Drink",0
;
room_36_script_dialogue:
    .db "Welcome To The"," ",$BE,"V",$C1,"Fridge]V",$BE,0
;
room_37_script_1_dialogue_1:
    .db "Oh Look There",$D6,"Is A Tiny Town",0
room_37_script_1_dialogue_2:
    .db "You Need A Way","To Look Closer",0
room_37_script_1_dialogue_3:
    .db "Use Magnifying","    Glass?",0
room_37_script_1_dialogue_4:
    .db "Looks Like The","y Want To Give","You Something!",0
room_37_script_1_dialogue_5:
    .db "They Gifted 5",$F2,0
room_37_script_1_dialogue_6:
    .db "The Townsfolk ","Are Waving Hi!",0
room_37_script_2_dialogue:
    .db "Have You Seen",$D6," The Tiny Town","Up Above Yet?",0
;
room_38_script_1_dialogue_1:
    .db "Hello I'm King","Bear. I Wish I","Had A Head For","My Snowman.",0
room_38_script_1_dialogue_2:
    .db "Give Pumpkin?",0
room_38_script_1_dialogue_3:
    .db "Thank You Here","Take This Gift",0
room_38_script_1_dialogue_4:
    .db "+Ice McGuffin",0
room_38_script_2_dialogue:
    .db "Hey This Spot ","Isn't Too Bad!",0
;
beat_game_script_dialogue_1:
    .db "Congrats! You",$D6,"Have Gathered "," All Four Of",$D6,"The Mcguffins!",0
;