;Author: Phoenix Cushman (Diet-Gameboy on GitHub)
;File Name data.asm
;Date Created: 3/3/2024
;Last Modified: 6/7/2025
;Description:
;	This file contains the RLE encoded background "images" for
;	each of the MCGuffin game levels as well as the graphic bitmaps
;	and lookup table for the background indexing.

background_lookup_table:
	.dw room_0_background
	.dw room_1_background
	.dw room_2_background
	.dw room_3_background
	.dw room_4_background
	.dw room_5_background
	.dw room_6_background
	.dw room_7_background
	.dw room_8_background
	.dw room_9_background
	.dw room_10_background
	.dw room_11_background
	.dw room_12_background
	.dw room_13_background
	.dw room_14_background
	.dw room_15_background
	.dw room_16_background
	.dw room_17_background
	.dw room_18_background
	.dw room_19_background
	.dw room_20_background
	.dw room_21_background
	.dw room_22_background
	.dw room_23_background
	.dw room_24_background
	.dw room_25_background
	.dw room_26_background
	.dw room_27_background
	.dw room_28_background
	.dw room_29_background
	.dw room_30_background
	.dw room_31_background
	.dw room_32_background
	.dw room_33_background
	.dw room_34_background
	.dw room_35_background
	.dw room_36_background
	.dw room_37_background
	.dw room_38_background
	.dw room_39_background
background_lookup_table_end:

right_arrow_graphic:
	.db %00000000
	.db %00111111
	.db %01000000
	.db %01001000
	.db %01001100
	.db %01001010
	.db %01001001
	.db %01001010
	.db %01001100
	.db %01001000
	.db %01000000
	.db %01001000
	.db %01001100
	.db %01001010
	.db %01001001
	.db %01001010
	.db %01001100
	.db %01001000
	.db %01000000
	.db %00111111
	.db %00000000
right_arrow_graphic_end:

left_arrow_graphic:
	.db %00000000
	.db %11111100
	.db %00000010
	.db %00010010
	.db %00110010
	.db %01010010
	.db %10010010
	.db %01010010
	.db %00110010
	.db %00010010
	.db %00000010
	.db %00010010
	.db %00110010
	.db %01010010
	.db %10010010
	.db %01010010
	.db %00110010
	.db %00010010
	.db %00000010
	.db %11111100
	.db %00000000
left_arrow_graphic_end:

number_field_graphic:
	.db %11111111,%11111110
	.db %00000000,%00000001
	.db %00000000,%00000001
	.db %00000000,%00000001
	.db %00000000,%00000001
	.db %00000000,%00000001
	.db %00000000,%00000001
	.db %00000000,%00000001
	.db %11111111,%11111110
number_field_graphic_end:

room_0_background:
;	.db "****************"
;	.db "*   MCGuffin   *"
;	.db "* Level Viewer *"
;	.db "*  By: Phoenix *"
;	.db "*     Cushman  *"
;	.db "*  Press Down  *"
;	.db "*   To Exit!   *"
;	.db "****************"
	.db 17,"*"
	.db 3," "
	.db $FE
	.db "MCGuffin"
	.db $FD
	.db 3," "
	.db 2,"*"
	.db $FE
	.db " Level Viewer **  By: Phoenix **"
	.db $FD
	.db 5," "
	.db $FE
	.db "Cushman  **  Press Down  **"
	.db $FD
	.db 3," "
	.db $FE
	.db "To Exit!"
	.db $FD
	.db 3," "
	.db 17,"*"
	.db $FF

room_1_background: ;"Entrance-Start"
;	.db "DDDDDDDDDDDDDDDD"
;	.db ": ",12," ",12,12,"  ",12," ",12,12," ",12," D"
;	.db ":  ",12,"  ",12," .+++",$BD," ",12,"D"
;	.db "DDDDDD .++.++",$BD," D"
;	.db "D( )DD ",12,"+++.+ ",12,"D"
;	.db "DDDDDD",12," ",$BD,"+.++",12," D"
;	.db "DD( )D ",12," +++",12," ",12,"D"
;	.db "DDDDDDDDDDDDDDDD"
	.db 16,"D"
	.db $FE
	.db ": ",12," ",12,12,"  ",12," ",12,12," ",12," D"
	.db ":  ",12,"  ",12," .+++",$BD," ",12
	.db $FD
	.db 7,"D"
	.db $FE
	.db " .++.++",$BD," D"
	.db "D( )DD ",12,"+++.+ ",12
	.db $FD
	.db 7,"D"
	.db $FE
	.db 12," ",$BD,"+.++",12," D"
	.db "DD( )D ",12," +++",12," ",12
	.db $FD
	.db 17,"D"
	.db $FF

room_2_background: ;"Entrance-Garden"
;	.db "DD..DDDDDDDDDDDD"
;	.db "D ",12,"  ",12,12,12,"  ",12,12," ",12,12,":" ;12 = $0C which is the TiAscii value of '·'
;	.db "D  ",12,"  ",12,"  ",12,"  ",12," ",12,":"
;	.db "D",12," (()) ",12,"( ) ",12,12,"D"
;	.db "D",12,"((()))",12,12,12,12,12,$C4,12,"D"
;	.db "D",12,12,12,"||",12,12,12,12,"( ) ",12,"D"
;	.db "D",12," ",12,"''",12,12,$C4,12,12,12,12,12,12,"D"
;	.db "DDDDDDDDDDDDDDDD"
	.db 2,"D"
	.db 2,"."
	.db 13,"D"
	.db $FE
	.db " ",12,"  ",12,12,12,"  ",12,12," ",12,12,":"
	.db "D  ",12,"  ",12,"  ",12,"  ",12," ",12,":"
	.db "D",12," (()) ",12,"( ) "
	.db $FD
	.db 2,12
	.db 2,"D"
	.db 1,12
	.db 3,"("
	.db 3,")"
	.db 5,12
	.db 1,$C4
	.db 1,12
	.db 2,"D"
	.db 3,12
	.db 2,"|"
	.db 4,12
	.db $FE
	.db "( ) ",12,"D"
	.db "D",12," ",12
	.db $FD
	.db 2,"'"
	.db 2,12
	.db 1,$C4
	.db 6,12
	.db 17,"D"
	.db $FF

room_3_background: ;"Entrance-Stairs"
;	.db "DDDDDDD..DDDDDDD"
;	.db "DDDDDDD--DDDDDDD"
;	.db "D () ",12,12," ",12,"      D"
;	.db "D ",$C4," ",12,12,12,12,"   ",$C1,"/] D"
;	.db "D  ",12," ",12,12,"   ",$C1,9,"]. D"
;	.db "D ",12,12,12,12,"()    ",$C1,"/]D"
;	.db "D ",12,12,12,"          D"
;	.db "DD..DDDDDDDDDDDD"
	.db 7,"D"
	.db 2,"."
	.db 14,"D"
	.db 2,"-"
	.db 8,"D"
	.db $FE
	.db " "
	.db "("
	.db ")"
	.db " "
	.db 12
	.db 12
	.db " "
	.db 12
	.db $FD
	.db 6," "
	.db 2,"D"
	.db $FE
	.db " "
	.db $C4
	.db " "
	.db $FD
	.db 4,12
	.db 3," "
	.db $FE
	.db $C1
	.db "/"
	.db "]"
	.db " "
	.db "D"
	.db "D"
	.db " "
	.db " "
	.db 12
	.db " "
	.db 12
	.db 12
	.db $FD
	.db 3," "
	.db $FE
	.db $C1
	.db 9
	.db "]"
	.db "."
	.db " "
	.db "D"
	.db "D"
	.db " "
	.db $FD
	.db 4,12
	.db $FE
	.db "("
	.db ")"
	.db $FD
	.db 4," "
	.db $FE
	.db $C1
	.db "/"
	.db "]"
	.db "D"
	.db "D"
	.db " "
	.db $FD
	.db 3,12
	.db 10," "
	.db 3,"D"
	.db 2,"."
	.db 12,"D"
	.db $FF

room_4_background: ;"Crossroad"
;	.db "[[[[[[[..[[[[[[[" ;I use '[' a lot because it has the Ascii value $5B which is the same value for the 'θ' character in TiAscii so I have to use '[' as a substitute
;	.db "[[",$C4,12,"[[[",12,12,"[[[[[[["  ;12 = $0C which is the TiAscii value of '·'
;	.db "[[",12,"  ",12,12,12,12,12," ",12,"  [["
;	.db ":",12," ",12,12,12,$C1,"=",$18,"]",12,12,12," ",12,":"
;	.db ":",12,12," ",12,12,"'",12,12,"'",12," ",12,12,12,":"
;	.db "[[     ",12,12,"   [ [["
;	.db "[[[[[DD",12,12,"DD[[[[["
;	.db "[[[[[[D..D[[[[[["
	.db 7,"["
	.db 2,"."
	.db 9,"["
	.db $FE
	.db $C4
	.db 12
	.db $FD
	.db 3,"["
	.db 2,12
	.db 9,"["
	.db 1,12
	.db 2," "
	.db 5,12
	.db $FE
	.db " "
	.db 12
	.db " "
	.db " "
	.db "["
	.db "["
	.db ":"
	.db 12
	.db " "
	.db $FD
	.db 3,12
	.db $FE
	.db $C1
	.db "="
	.db $18
	.db "]"
	.db $FD
	.db 3,12
	.db $FE
	.db " "
	.db 12
	.db ":"
	.db ":"
	.db 12
	.db 12
	.db " "
	.db 12
	.db 12
	.db "'"
	.db 12
	.db 12
	.db "'"
	.db 12
	.db " "
	.db $FD
	.db 3,12
	.db 1,":"
	.db 2,"["
	.db 5," "
	.db 2,12
	.db 3," "
	.db $FE
	.db "["
	.db " "
	.db $FD
	.db 7,"["
	.db 2,"D"
	.db 2,12
	.db 2,"D"
	.db 11,"["
	.db 1,"D"
	.db 2,"."
	.db 1,"D"
	.db 6,"["
	.db $FF

room_5_background: ;"Big-Tree"
;	.db "[[[( (  )[[[[[[["
;	.db "[ ( (  ) ) !   ["
;	.db "[  (_||_)",12,12,":",12,12," ["
;	.db "[",12,12,12,12,"|O ",12,$BD,12,"!",12,12,12,":"
;	.db "[",12,$BD,12,12,"||",12,12,12,12,"!",12," ",12,":"
;	.db "[",12,12,12,"/",$D9,$D9,$C2,12,12,12,"! ",12," ["
;	.db "[",12,12,12,12,12,12,12,12,$BD,12,"!   ["
;	.db "[[[[[[[[[[[[..[["
	.db 3,"["
	.db $FE
	.db "("
	.db " "
	.db "("
	.db " "
	.db " "
	.db ")"
	.db $FD
	.db 8,"["
	.db $FE
	.db " "
	.db "("
	.db " "
	.db "("
	.db " "
	.db " "
	.db ")"
	.db " "
	.db ")"
	.db " "
	.db "!"
	.db $FD
	.db 3," "
	.db 2,"["
	.db 2," "
	.db $FE
	.db "("
	.db "_"
	.db "|"
	.db "|"
	.db "_"
	.db ")"
	.db 12
	.db 12
	.db ":"
	.db 12
	.db 12
	.db " "
	.db "["
	.db "["
	.db $FD
	.db 4,12
	.db $FE
	.db "|"
	.db "O"
	.db " "
	.db 12
	.db $BD
	.db 12
	.db "!"
	.db $FD
	.db 3,12
	.db $FE
	.db ":"
	.db "["
	.db 12
	.db $BD
	.db 12
	.db 12
	.db "|"
	.db "|"
	.db $FD
	.db 4,12
	.db $FE
	.db "!"
	.db 12
	.db " "
	.db 12
	.db ":"
	.db "["
	.db $FD
	.db 3,12
	.db 1,"/"
	.db 2,$D9
	.db 1,$C2
	.db 3,12
	.db $FE
	.db "!"
	.db " "
	.db 12
	.db " "
	.db "["
	.db "["
	.db $FD
	.db 8,12
	.db $FE
	.db $BD
	.db 12
	.db "!"
	.db $FD
	.db 3," "
	.db 13,"["
	.db 2,"."
	.db 2,"["
	.db $FF

room_6_background: ;"Treehive"
;	.db "|!|!",$B6,"\\!/",$B7,$B6,"\\|!!|!"
;	.db "|!/",$B6,"       ",$B7,$B6,"\\!|"
;	.db "!|    (--)    .!"
;	.db "!/  .(----)    |"
;	.db "!    (-()-).  /!"
;	.db "|\\     ",$EE,$EE,"     |!"
;	.db "!!^\\   ",$EE,$EE,"    /!|"
;	.db "!|!!^......^^!!|"
	.db $FE
	.db "|"
	.db "!"
	.db "|"
	.db "!"
	.db $B6
	.db "\\"
	.db "!"
	.db "/"
	.db $B7
	.db $B6
	.db "\\"
	.db "|"
	.db "!"
	.db "!"
	.db "|"
	.db "!"
	.db "|"
	.db "!"
	.db "/"
	.db $B6
	.db $FD
	.db 7," "
	.db $FE
	.db $B7
	.db $B6
	.db "\\"
	.db "!"
	.db "|"
	.db "!"
	.db "|"
	.db $FD
	.db 4," "
	.db 1,"("
	.db 2,"-"
	.db 1,")"
	.db 4," "
	.db 1,"."
	.db 2,"!"
	.db 1,"/"
	.db 2," "
	.db $FE
	.db "."
	.db "("
	.db $FD
	.db 4,"-"
	.db 1,")"
	.db 4," "
	.db $FE
	.db "|"
	.db "!"
	.db $FD
	.db 4," "
	.db $FE
	.db "("
	.db "-"
	.db "("
	.db ")"
	.db "-"
	.db ")"
	.db "."
	.db " "
	.db " "
	.db "/"
	.db "!"
	.db "|"
	.db "\\"
	.db $FD
	.db 5," "
	.db 2,$EE
	.db 5," "
	.db 1,"|"
	.db 3,"!"
	.db $FE
	.db "^"
	.db "\\"
	.db $FD
	.db 3," "
	.db 2,$EE
	.db 4," "
	.db $FE
	.db "/"
	.db "!"
	.db "|"
	.db "!"
	.db "|"
	.db "!"
	.db "!"
	.db "^"
	.db $FD
	.db 6,"."
	.db 2,"^"
	.db 2,"!"
	.db 1,"|"
	.db $FF

room_7_background: ;"Beehive"
;	.db "U U QUEEN BEE UU"
;	.db " UXXX  Moo XXXU "
;	.db "UXX   (%)",$DE,"-  XXU"
;	.db "XX=== ' '' ===XX"
;	.db "XX|-|      |-|XX"
;	.db "XX|",$F1,"|",$11,"    ",$1A,"|",$F1,"|XU"
;	.db "XX===      ===XX"
;	.db "UXXXXX....XXXXXU"
	.db $FE
	.db "U"
	.db " "
	.db "U"
	.db " "
	.db "Q"
	.db "U"
	.db "E"
	.db "E"
	.db "N"
	.db " "
	.db "B"
	.db "E"
	.db "E"
	.db " "
	.db "U"
	.db "U"
	.db " "
	.db "U"
	.db $FD
	.db 3,"X"
	.db 2," "
	.db 1,"M"
	.db 2,"o"
	.db 1," "
	.db 3,"X"
	.db $FE
	.db "U"
	.db " "
	.db "U"
	.db "X"
	.db "X"
	.db $FD
	.db 3," "
	.db $FE
	.db "("
	.db "%"
	.db ")"
	.db $DE
	.db "-"
	.db " "
	.db " "
	.db "X"
	.db "X"
	.db "U"
	.db "X"
	.db "X"
	.db $FD
	.db 3,"="
	.db $FE
	.db " "
	.db "'"
	.db " "
	.db "'"
	.db "'"
	.db " "
	.db $FD
	.db 3,"="
	.db 4,"X"
	.db $FE
	.db "|"
	.db "-"
	.db "|"
	.db $FD
	.db 6," "
	.db $FE
	.db "|"
	.db "-"
	.db "|"
	.db $FD
	.db 4,"X"
	.db $FE
	.db "|"
	.db $F1
	.db "|"
	.db $11
	.db $FD
	.db 4," "
	.db $FE
	.db $1A
	.db "|"
	.db $F1
	.db "|"
	.db "X"
	.db "U"
	.db "X"
	.db "X"
	.db $FD
	.db 3,"="
	.db 6," "
	.db 3,"="
	.db 2,"X"
	.db 1,"U"
	.db 5,"X"
	.db 4,"."
	.db 5,"X"
	.db 1,"U"
	.db $FF

room_8_background: ;"Crab-Beach"
;	.db "      /[[[[[..[["
;	.db "^^^  (",12,12,12,"@",$8D,"    ["
;	.db "      )",12,12,12,"     ["
;	.db "=",$18,$18,"=",$18,$18,"==",12,12,12,"    ["
;	.db " !! !!)",12,12,12," V",$BA,$BA," ["
;	.db "     /",12,12,12,"  `",$C4,$C4,"<["
;	.db " ^^^(",12,12,12,12,12,"     ["
;	.db "     )",12,12,12,12,12,12,12,12,12,"["
	.db 6," "
	.db 1,"/"
	.db 5,"["
	.db 2,"."
	.db 2,"["
	.db 3,"^"
	.db 2," "
	.db 1,"("
	.db 3,12
	.db 1,"@"
	.db 1,$8D
	.db 4," "
	.db 1,"["
	.db 6," "
	.db 1,")"
	.db 3,12
	.db 5," "
	.db 1,"["
	.db 1,"="
	.db 2,$18
	.db 1,"="
	.db 2,$18
	.db 2,"="
	.db 3,12
	.db 4," "
	.db 1,"["
	.db 1," "
	.db 2,"!"
	.db 1," "
	.db 2,"!"
	.db 1,")"
	.db 3,12
	.db 1," "
	.db 1,"V"
	.db 2,$BA
	.db 1," "
	.db 1,"["
	.db 5," "
	.db 1,"/"
	.db 3,12
	.db 2," "
	.db 1,"`"
	.db 2,$C4
	.db 1,"<"
	.db 1,"["
	.db 1," "
	.db 3,"^"
	.db 1,"("
	.db 5,12
	.db 5," "
	.db 1,"["
	.db 5," "
	.db 1,")"
	.db 9,12
	.db 1,"["
	.db $FF

room_9_background: ;"Seagull-Dock"
;	.db "[[[[            "
;	.db "[[[     ^^^     "
;	.db "W[  ^^^         "
;	.db "[         =",$18,$18,"=",$18,$18
;	.db "  ^^^      !! !!"
;	.db "     ^^^        "
;	.db "          ^^^   "
;	.db " ^^^            "
	.db 4,"["
	.db 12," "
	.db 3,"["
	.db 5," "
	.db 3,"^"
	.db 5," "
	.db 1,"W"
	.db 1,"["
	.db 2," "
	.db 3,"^"
	.db 9," "
	.db 1,"["
	.db 9," "
	.db 1,"="
	.db 2,$18
	.db 1,"="
	.db 2,$18
	.db 2," "
	.db 3,"^"
	.db 6," "
	.db 2,"!"
	.db 1," "
	.db 2,"!"
	.db 5," "
	.db 3,"^"
	.db 18," "
	.db 3,"^"
	.db 4," "
	.db 3,"^"
	.db 12," "
	.db $FF

room_10_background: ;"Beach-South"
;	.db "^^  /",12,12,12,12,12,12,12,12,12,12,"["
;	.db "   (",12,12,"         ["
;	.db "^^^ )",12,12,"    ",$BA,">  ["
;	.db "   /",12,12,"   \\",$C4,"|.  ["
;	.db "^ (",12,12,12,12,12,12,12,"@@@ ",12,"["
;	.db "   ",$B7,"----_",12,12,12,12,12,"/ "
;	.db "^^^ (II] ",$B7,"---",$B6,"^^"
;	.db "    ",$B8,$B8,$B8,$B8,"  ^^^   "
	.db 2,"^"
	.db 2," "
	.db 1,"/"
	.db 10,12
	.db 1,"["
	.db 3," "
	.db 1,"("
	.db 2,12
	.db 9," "
	.db 1,"["
	.db 3,"^"
	.db $FE
	.db " "
	.db ")"
	.db 12
	.db 12
	.db $FD
	.db 4," "
	.db $FE
	.db $BA
	.db ">"
	.db " "
	.db " "
	.db "["
	.db $FD
	.db 3," "
	.db 1,"/"
	.db 2,12
	.db 3," "
	.db $FE
	.db "\\"
	.db $C4
	.db "|"
	.db "."
	.db " "
	.db " "
	.db "["
	.db "^"
	.db " "
	.db "("
	.db $FD
	.db 7,12
	.db 3,"@"
	.db $FE
	.db " "
	.db 12
	.db "["
	.db $FD
	.db 3," "
	.db 1,$B7
	.db 4,"-"
	.db 1,"_"
	.db 5,12
	.db $FE
	.db "/"
	.db " "
	.db $FD
	.db 3,"^"
	.db $FE
	.db " "
	.db "("
	.db "I"
	.db "I"
	.db "]"
	.db " "
	.db $B7
	.db $FD
	.db 3,"-"
	.db 1,$B6
	.db 2,"^"
	.db 4," "
	.db 4,$B8
	.db 2," "
	.db 3,"^"
	.db 3," "
	.db $FF

room_11_background: ;"Spot-Puzzle"
;	.db "[[[[[[[[[[[[[[[["
;	.db "[",12,12,12," ",12,12,12,12,12," ",12,12,12," ["
;	.db "[",12,12,12,12,12,12,12,12,12,12,12,12," ",12,"["
;	.db ":",12," ",12,"SP0T",12,"THE",12,12,12,"["
;	.db ":",12,12,"DIFFERENCE",12,12,"["
;	.db "[",12,12,12,12,12,12,12,12,12,12,12,12,12,12,"["
;	.db "[",$BD,12,12," ",12," ",12,12,"   ",12,12,$BD,"["
;	.db "[[[[[[[[[[[[[[[["
	.db 17,"["
	.db 3,12
	.db 1," "
	.db 5,12
	.db 1," "
	.db 3,12
	.db 1," "
	.db 2,"["
	.db 12,12
	.db $FE
	.db " ",12,"["
	.db ":",12," ",12,"SP0T",12,"THE",12,12,12,"["
	.db ":",12,12,"DIFFERENCE"
	.db $FD
	.db 2,12
	.db 2,"["
	.db 14,12
	.db 2,"["
	.db 1,$BD
	.db 2,12
	.db 1," "
	.db 1,12
	.db 1," "
	.db 2,12
	.db 3," "
	.db 2,12
	.db 1,$BD
	.db 17,"["
	.db $FF

room_12_background: ;"Lemon-Chest"
;	.db "DDDDDDDDDDDDDDDD"
;	.db "DD",8,8," ",8,"  ",8," ",8,8,8,8,"DD"
;	.db "D ",8," />>>>> ",8," ",8," D"
;	.db "D",8," (/ ../     ",8,"D"
;	.db "D",8," +-+---+    ",8,"D"
;	.db "D  | |   |     D"
;	.db "DD +-+---+     D"
;	.db "DDDDDDDDDDD...DD"
	.db 18,"D"
	.db 2,8
	.db $FE
	.db " "
	.db 8
	.db " "
	.db " "
	.db 8
	.db " "
	.db $FD
	.db 4,8
	.db 3,"D"
	.db $FE
	.db " "
	.db 8
	.db " "
	.db "/"
	.db $FD
	.db 5,">"
	.db $FE
	.db " "
	.db 8
	.db " "
	.db 8
	.db " "
	.db "D"
	.db "D"
	.db 8
	.db " "
	.db "("
	.db "/"
	.db " "
	.db "."
	.db "."
	.db "/"
	.db $FD
	.db 5," "
	.db 1,8
	.db 2,"D"
	.db $FE
	.db 8
	.db " "
	.db "+"
	.db "-"
	.db "+"
	.db $FD
	.db 3,"-"
	.db 1,"+"
	.db 4," "
	.db 1,8
	.db 2,"D"
	.db 2," "
	.db $FE
	.db "|"
	.db " "
	.db "|"
	.db $FD
	.db 3," "
	.db 1,"|"
	.db 5," "
	.db 3,"D"
	.db $FE
	.db " "
	.db "+"
	.db "-"
	.db "+"
	.db $FD
	.db 3,"-"
	.db 1,"+"
	.db 5," "
	.db 12,"D"
	.db 3,"."
	.db 2,"D"
	.db $FF

room_13_background: ;"Sheep-Pen"
;	.db $18,"[[[[[[[[/",$D2,$D2,$D2,"\\[["
;	.db ":",12,12,12,"()O",12,"/-----\\["
;	.db ":",12,12,12,12,"''",12,"|",$C1,"]",$BE,$C1,"]!["
;	.db "!O()",12,$18,"=",$18,"|__",$7F,"__|["
;	.db "!",12,"''",12,"!",12," ",$BD,"    ",$BD," ["
;	.db "!()O",12,":",12,12,"  ",$BD,"    ["
;	.db "!''",12,$BD,"! ",12,12,"    ",$BD," ["
;	.db $18,"[[[[[[..[[[[[[["
	.db 1,$18
	.db 8,"["
	.db 1,"/"
	.db 3,$D2
	.db 1,"\\"
	.db 2,"["
	.db 1,":"
	.db 3,12
	.db $FE
	.db "("
	.db ")"
	.db "O"
	.db 12
	.db "/"
	.db $FD
	.db 5,"-"
	.db $FE
	.db "\\"
	.db "["
	.db ":"
	.db $FD
	.db 3,12
	.db 2,"'"
	.db 2,12
	.db $FE
	.db "|"
	.db $C1
	.db "]"
	.db $BE
	.db $C1
	.db "]"
	.db "!"
	.db "["
	.db "!"
	.db "("
	.db ")"
	.db "O"
	.db 12
	.db $18
	.db "="
	.db $18
	.db "|"
	.db "_","_"
	.db $7F
	.db "_","_"
	.db "|"
	.db "["
	.db "!"
	.db "'"
	.db "'"
	.db 12
	.db 12
	.db "!"
	.db 12
	.db " "
	.db $BD
	.db $FD
	.db 4," "
	.db $FE
	.db $BD
	.db " "
	.db "["
	.db "!"
	.db "O"
	.db "("
	.db ")"
	.db 12
	.db ":"
	.db 12,12
	.db " "," "
	.db $BD
	.db $FD
	.db 4," "
	.db $FE
	.db "["
	.db "!"
	.db 12
	.db "'"
	.db "'"
	.db $BD
	.db "!"
	.db " "
	.db 12,12
	.db $FD
	.db 4," "
	.db $FE
	.db $BD
	.db " "
	.db "["
	.db $18
	.db $FD
	.db 6,"["
	.db 2,"."
	.db 7,"["
	.db $FF

room_14_background: ;"House-Sheep"
;	.db "+--------------+"
;	.db "|",$C1,"/]-",$C1,"/]-",$C1,$1A,"]---|"
;	.db "|--",$C1,$CB,$CB,$CB,$CB,"]",$C1,$1A,"]---|"
;	.db "|              |"
;	.db "| L ",12,"-.-",12,"      |"
;	.db "| H !---!      |"
;	.db "|              |"
;	.db "+---------...--+"
	.db 1,"+"
	.db 14,"-"
	.db $FE
	.db "+"
	.db "|"
	.db $C1
	.db "/"
	.db "]"
	.db "-"
	.db $C1
	.db "/"
	.db "]"
	.db "-"
	.db $C1
	.db $1A
	.db "]"
	.db $FD
	.db 3,"-"
	.db 2,"|"
	.db 2,"-"
	.db 1,$C1
	.db 4,$CB
	.db $FE
	.db "]"
	.db $C1
	.db $1A
	.db "]"
	.db $FD
	.db 3,"-"
	.db 2,"|"
	.db 14," "
	.db 2,"|"
	.db $FE
	.db " "
	.db "L"
	.db " "
	.db 12
	.db "-"
	.db "."
	.db "-"
	.db 12
	.db $FD
	.db 6," "
	.db 2,"|"
	.db $FE
	.db " "
	.db "H"
	.db " "
	.db "!"
	.db $FD
	.db 3,"-"
	.db 1,"!"
	.db 6," "
	.db 2,"|"
	.db 14," "
	.db 1,"|"
	.db 1,"+"
	.db 9,"-"
	.db 3,"."
	.db $FE
	.db "-","-"
	.db "+"
	.db $FF

room_15_background: ;"Farm"
;	.db "[[[[[[[..[[[[[[",$18
;	.db "[   ",$BD,$D9,"[  [",$D9,$C2,"   :"
;	.db "[_",$C4,"_           :"
;	.db "[ |    *  *    ",$18
;	.db "[",$1A,"U",$11," * O  O *  !"
;	.db "[",$CE,"|",$CE,$CE,"O",$CE,$BD,$CE,$CE,$BD,$CE,$A5,$CE,$CE,"!"
;	.db "[",$CE,$CE,$CE,$CE,$BD,$CE,$CE,$CE,$CE,$CE,$CE,$BD,$CE,$CE,"!"
;	.db "[[[[[[[[[[[[[[[",$18
	.db 7,"["
	.db 2,"."
	.db 6,"["
	.db $FE
	.db $18
	.db "["
	.db " "," "," "
	.db $BD
	.db $D9
	.db "["
	.db " "," "
	.db "["
	.db $D9
	.db $C2
	.db " "," "," "
	.db ":"
	.db "["
	.db "_"
	.db $C4
	.db "_"
	.db $FD
	.db 11," "
	.db $FE
	.db ":"
	.db "["
	.db " "
	.db "|"
	.db " "," "," "," "
	.db "*"
	.db " "," "
	.db "*"
	.db " "," "," "," "
	.db $18
	.db "["
	.db $1A
	.db "U"
	.db $11
	.db " "
	.db "*"
	.db " "
	.db "O"
	.db " "," "
	.db "O"
	.db " "
	.db "*"
	.db " "," "
	.db "!"
	.db "["
	.db $CE
	.db "|"
	.db $CE,$CE
	.db "O"
	.db $CE
	.db $BD
	.db $CE,$CE
	.db $BD
	.db $CE
	.db $A5
	.db $CE,$CE
	.db "!"
	.db "["
	.db $CE,$CE,$CE,$CE
	.db $BD
	.db $FD
	.db 6,$CE
	.db 1,$BD
	.db 2,$CE
	.db 1,"!"
	.db 15,"["
	.db 1,$18
	.db $FF

room_16_background: ;"Camp"
;	.db "[[[[[[[..[[[[[[["
;	.db "[      ",12,12,"  /|\\ ["
;	.db "[ (()) ",12,12," /.|.\\["
;	.db "[((()))",12,"       ["
;	.db "[  ||. ",12,12," (",$DE,")O ["
;	.db "[  ",$C9,"|   ",12,"  ",$BE,"^",$BE," ["
;	.db "[  ''  ",12,12,"  ",$CD,$CD,$CD," ["
;	.db "[[[[[[[..[[[[[[["
	.db 7,"["
	.db 2,"."
	.db 8,"["
	.db 6," "
	.db $FE
	.db 12,12
	.db " "," "
	.db "/"
	.db "|"
	.db "\\"
	.db " "
	.db "[","["
	.db " "
	.db "(","("
	.db ")",")"
	.db " "
	.db 12,12
	.db " "
	.db "/"
	.db "."
	.db "|"
	.db "."
	.db "\\"
	.db "[","["
	.db $FD
	.db 3,"("
	.db 3,")"
	.db 1,12
	.db 7," "
	.db $FE
	.db "[","["
	.db " "," "
	.db "|","|"
	.db "."
	.db " "
	.db 12,12
	.db " "
	.db "("
	.db $DE
	.db ")"
	.db "O"
	.db " "
	.db "[","["
	.db " "," "
	.db $C9
	.db "|"
	.db " "," "," "
	.db 12
	.db " "," "
	.db $BE
	.db "^"
	.db $BE
	.db " "
	.db "[","["
	.db " "," "
	.db "'","'"
	.db " "," "
	.db 12,12
	.db " "," "
	.db $FD
	.db 3,$CD
	.db 1," "
	.db 8,"["
	.db 2,"."
	.db 7,"["
	.db $FF

room_17_background: ;"Tent"
;	.db "------------\\   "
;	.db "||",$B7," ",$B7,".. ",$B7," ",$B7,"||\\  "
;	.db "||--",$C1,$CB,$CB,"]---|||  "
;	.db "||         || \\ "
;	.db "||######()",$DE,")| | "
;	.db ": #####()()",$DE,")\\ \\"
;	.db ": ######      \\|"
;	.db "================"
	.db 12,"-"
	.db 1,"\\"
	.db 3," "
	.db 2,"|"
	.db $FE
	.db $B7
	.db " "
	.db $B7
	.db "."
	.db "."
	.db " "
	.db $B7
	.db " "
	.db $B7
	.db "|"
	.db "|"
	.db "\\"
	.db " "
	.db " "
	.db "|"
	.db "|"
	.db "-"
	.db "-"
	.db $C1
	.db $CB
	.db $CB
	.db "]"
	.db $FD
	.db 3,"-"
	.db 3,"|"
	.db 2," "
	.db 2,"|"
	.db 9," "
	.db 2,"|"
	.db $FE
	.db " "
	.db "\\"
	.db " "
	.db "|"
	.db "|"
	.db $FD
	.db 6,"#"
	.db $FE
	.db "("
	.db ")"
	.db $DE
	.db ")"
	.db "|"
	.db " "
	.db "|"
	.db " "
	.db ":"
	.db " "
	.db $FD
	.db 5,"#"
	.db $FE
	.db "("
	.db ")"
	.db "("
	.db ")"
	.db $DE
	.db ")"
	.db "\\"
	.db " "
	.db "\\"
	.db ":"
	.db " "
	.db $FD
	.db 6,"#"
	.db 6," "
	.db $FE
	.db "\\"
	.db "|"
	.db $FD
	.db 16,"="
	.db $FF

room_18_background: ;"Bog-Entrance"
;	.db "[[[[[[[(     (*)"
;	.db "[[",$BD,"  (     (*)  "
;	.db "[     (        )"
;	.db "[    ",$C1,"=](_    )["
;	.db "[ ",$BD,"  ' ' (___)",$BD,"["
;	.db "[          ",$BD,"   ["
;	.db "[[  ",$BD,"         [["
;	.db "[[[[[[[..[[[[[[["
	.db 7,"["
	.db 1,"("
	.db 5," "
	.db $FE
	.db "("
	.db "*"
	.db ")"
	.db "["
	.db "["
	.db $BD
	.db " "
	.db " "
	.db "("
	.db $FD
	.db 5," "
	.db $FE
	.db "("
	.db "*"
	.db ")"
	.db " "
	.db " "
	.db "["
	.db $FD
	.db 5," "
	.db 1,"("
	.db 8," "
	.db $FE
	.db ")"
	.db "["
	.db $FD
	.db 4," "
	.db $FE
	.db $C1
	.db "="
	.db "]"
	.db "("
	.db "_"
	.db $FD
	.db 4," "
	.db 1,")"
	.db 2,"["
	.db $FE
	.db " "
	.db $BD
	.db " "
	.db " "
	.db "'"
	.db " "
	.db "'"
	.db " "
	.db "("
	.db $FD
	.db 3,"_"
	.db $FE
	.db ")"
	.db $BD
	.db "["
	.db "["
	.db $FD
	.db 10," "
	.db 1,$BD
	.db 3," "
	.db 3,"["
	.db 2," "
	.db 1,$BD
	.db 9," "
	.db 9,"["
	.db 2,"."
	.db 7,"["
	.db $FF

room_19_background: ;"Bog-Cave"
;	.db "//////OOOO//////"
;	.db "//",$BD,"//OOVVOO/////"
;	.db "[[[[[OO..OO-----"
;	.db "[[[( ",$B8,$B8,"  ",$B8,$B8,"  (*)"
;	.db $BD,"[(        (*)  "
;	.db "[[[(    (*)     "
;	.db "[",$BD,"[[[(          "
;	.db "[[[[",$BD,"[[(        "
	.db 6,"/"
	.db 4,"O"
	.db 8,"/"
	.db 1,$BD
	.db 2,"/"
	.db 2,"O"
	.db 2,"V"
	.db 2,"O"
	.db 5,"/"
	.db 5,"["
	.db 2,"O"
	.db 2,"."
	.db 2,"O"
	.db 5,"-"
	.db 3,"["
	.db $FE
	.db "("
	.db " "
	.db $B8
	.db $B8
	.db " "
	.db " "
	.db $B8
	.db $B8
	.db " "
	.db " "
	.db "("
	.db "*"
	.db ")"
	.db $BD
	.db "["
	.db "("
	.db $FD
	.db 8," "
	.db $FE
	.db "("
	.db "*"
	.db ")"
	.db " "
	.db " "
	.db $FD
	.db 3,"["
	.db 1,"("
	.db 4," "
	.db $FE
	.db "("
	.db "*"
	.db ")"
	.db $FD
	.db 5," "
	.db $FE
	.db "["
	.db $BD
	.db $FD
	.db 3,"["
	.db 1,"("
	.db 10," "
	.db 4,"["
	.db 1,$BD
	.db 2,"["
	.db 1,"("
	.db 8," "
	.db $FF

room_20_background: ;"Bog-Whirlpool"
;	.db "////////////////"
;	.db "///_-----_///",$BD,"//"
;	.db "--",$B6,"       ",$B7,"[[[[["
;	.db "   (^",12,"-",12,"^)  )[[["
;	.db "  (^^!@/^^)   )["
;	.db "   (^^-",$B6,"^)   ",$BD,")["
;	.db "            )[[["
;	.db " (*) (*)  )[[[[["
	.db 19,"/"
	.db 1,"_"
	.db 5,"-"
	.db 1,"_"
	.db 3,"/"
	.db 1,$BD
	.db 2,"/"
	.db 2,"-"
	.db 1,$B6
	.db 7," "
	.db 1,$B7
	.db 5,"["
	.db 3," "
	.db $FE
	.db "("
	.db "^"
	.db 12
	.db "-"
	.db 12
	.db "^"
	.db ")"
	.db " "
	.db " "
	.db ")"
	.db $FD
	.db 3,"["
	.db 2," "
	.db 1,"("
	.db 2,"^"
	.db $FE
	.db "!"
	.db "@"
	.db "/"
	.db "^"
	.db "^"
	.db ")"
	.db $FD
	.db 3," "
	.db $FE
	.db ")"
	.db "["
	.db $FD
	.db 3," "
	.db 1,"("
	.db 2,"^"
	.db $FE
	.db "-"
	.db $B6
	.db "^"
	.db ")"
	.db $FD
	.db 3," "
	.db $FE
	.db $BD
	.db ")"
	.db "["
	.db $FD
	.db 12," "
	.db 1,")"
	.db 3,"["
	.db $FE
	.db " "
	.db "("
	.db "*"
	.db ")"
	.db " "
	.db "("
	.db "*"
	.db ")"
	.db " "
	.db " "
	.db ")"
	.db $FD
	.db 5,"["
	.db $FF

room_21_background: ;"Bog-Dock"
;	.db "      (*) ([[[[["
;	.db "  (*)      )[[[["
;	.db ")    _    ( ",$C1,"=]["
;	.db "[)   |\\",$C4,"   )' '["
;	.db "[[)  ",$B9," =",$18,"=",$18,"=   :"
;	.db "[(      ! !)   :"
;	.db "[[(_______/  [[["
;	.db "[[[[[[[[[[[[[[[["
	.db 6," "
	.db $FE
	.db "("
	.db "*"
	.db ")"
	.db " "
	.db "("
	.db $FD
	.db 5,"["
	.db 2," "
	.db $FE
	.db "("
	.db "*"
	.db ")"
	.db $FD
	.db 6," "
	.db 1,")"
	.db 4,"["
	.db 1,")"
	.db 4," "
	.db 1,"_"
	.db 4," "
	.db $FE
	.db "("
	.db " "
	.db $C1
	.db "="
	.db "]"
	.db "["
	.db "["
	.db ")"
	.db $FD
	.db 3," "
	.db $FE
	.db "|"
	.db "\\"
	.db $C4
	.db $FD
	.db 3," "
	.db $FE
	.db ")"
	.db "'"
	.db " "
	.db "'"
	.db $FD
	.db 3,"["
	.db 1,")"
	.db 2," "
	.db $FE
	.db $B9
	.db " "
	.db "="
	.db $18
	.db "="
	.db $18
	.db "="
	.db $FD
	.db 3," "
	.db $FE
	.db ":"
	.db "["
	.db "("
	.db $FD
	.db 6," "
	.db $FE
	.db "!"
	.db " "
	.db "!"
	.db ")"
	.db $FD
	.db 3," "
	.db 1,":"
	.db 2,"["
	.db 1,"("
	.db 7,"_"
	.db 1,"/"
	.db 2," "
	.db 19,"["
	.db $FF

room_22_background: ;"Cave-Entrance"
;	.db "|",$BA,"//..|##|..///|"
;	.db "|",$BA,"-",$17,"O",$19,"|##|",$17,"O",$19,"--|"
;	.db "|`)_  ",12," ",12,12,"     |"
;	.db "|   ) ",12,12,12,12,"     |"
;	.db "|(*) )",12,12," ",12," ",$C1,9,"] :"
;	.db "| (*))",12," ",12,$C1,9,"]",$C1,9,"]|"
;	.db "|____)",12,12,12,12,"     |"
;	.db "+-----....-----+"
	.db $FE
	.db "|"
	.db $BA
	.db "/"
	.db "/"
	.db "."
	.db "."
	.db "|"
	.db "#"
	.db "#"
	.db "|"
	.db "."
	.db "."
	.db $FD
	.db 3,"/"
	.db 2,"|"
	.db $FE
	.db $BA
	.db "-"
	.db $17
	.db "O"
	.db $19
	.db "|"
	.db "#"
	.db "#"
	.db "|"
	.db $17
	.db "O"
	.db $19
	.db "-"
	.db "-"
	.db "|"
	.db "|"
	.db "`"
	.db ")"
	.db "_"
	.db " "
	.db " "
	.db 12
	.db " "
	.db 12
	.db 12
	.db $FD
	.db 5," "
	.db 2,"|"
	.db 3," "
	.db $FE
	.db ")"
	.db " "
	.db $FD
	.db 4,12
	.db 5," "
	.db 2,"|"
	.db $FE
	.db "("
	.db "*"
	.db ")"
	.db " "
	.db ")"
	.db 12
	.db 12
	.db " "
	.db 12
	.db " "
	.db $C1
	.db 9
	.db "]"
	.db " "
	.db ":"
	.db "|"
	.db " "
	.db "("
	.db "*"
	.db ")"
	.db ")"
	.db 12
	.db " "
	.db 12
	.db $C1
	.db 9
	.db "]"
	.db $C1
	.db 9
	.db "]"
	.db "|"
	.db "|"
	.db $FD
	.db 4,"_"
	.db 1,")"
	.db 4,12
	.db 5," "
	.db $FE
	.db "|"
	.db "+"
	.db $FD
	.db 5,"-"
	.db 4,"."
	.db 5,"-"
	.db 1,"+"
	.db $FF

room_23_background: ;"Cave-Secret"
;	.db "VVVVVVVVV//VVVVV"
;	.db "|///VVV//////V/|"
;	.db "|----V---..----|"
;	.db ":",12,12,12,12,12,12,12," ",$17,"()",$19,"  |"
;	.db "|",$BD,"( ) ",12,12,"",$BD,"|''|/ |"
;	.db "|(___)",12,12,"|''|'| |"
;	.db ":",12,12,12,12,12,12,$B6,$B6,$B6,$B6,"'",$B7,$B7,$B7,"|"
;	.db "+--------------+"
	.db 9,"V"
	.db 2,"/"
	.db 5,"V"
	.db 1,"|"
	.db 3,"/"
	.db 3,"V"
	.db 6,"/"
	.db $FE
	.db "V"
	.db "/"
	.db "|"
	.db "|"
	.db $FD
	.db 4,"-"
	.db 1,"V"
	.db 3,"-"
	.db 2,"."
	.db 4,"-"
	.db $FE
	.db "|"
	.db ":"
	.db $FD
	.db 7,12
	.db $FE
	.db " "
	.db $17
	.db "("
	.db ")"
	.db $19
	.db " "
	.db " "
	.db "|"
	.db "|"
	.db $BD
	.db "("
	.db " "
	.db ")"
	.db " "
	.db 12
	.db 12
	.db $BD
	.db "|"
	.db "'"
	.db "'"
	.db "|"
	.db "/"
	.db " "
	.db "|"
	.db "|"
	.db "("
	.db $FD
	.db 3,"_"
	.db 1,")"
	.db 2,12
	.db 1,"|"
	.db 2,"'"
	.db $FE
	.db "|"
	.db "'"
	.db "|"
	.db " "
	.db "|"
	.db ":"
	.db $FD
	.db 6,12
	.db 4,$B6
	.db 1,"'"
	.db 3,$B7
	.db $FE
	.db "|"
	.db "+"
	.db $FD
	.db 14,"-"
	.db 1,"+"
	.db $FF

room_24_background: ;"Cave-Chamber"
;	.db "[-King-Frog-II-["
;	.db "[//////",$14,$BE,$14,"/////["
;	.db "[---..",$17,"(",$1A,")",$19,"----["
;	.db "[(`(",$14,")  (*)  ) ["
;	.db "[ (_  (*)  _)  |"
;	.db "[   (_____)    ["
;	.db "[              ["
;	.db "[[[[[[....[[[[[["
	.db $FE
	.db "["
	.db "-"
	.db "K"
	.db "i"
	.db "n"
	.db "g"
	.db "-"
	.db "F"
	.db "r"
	.db "o"
	.db "g"
	.db "-"
	.db "I"
	.db "I"
	.db "-"
	.db "["
	.db "["
	.db $FD
	.db 6,"/"
	.db $FE
	.db $14
	.db $BE
	.db $14
	.db $FD
	.db 5,"/"
	.db 2,"["
	.db 3,"-"
	.db 2,"."
	.db $FE
	.db $17
	.db "("
	.db $1A
	.db ")"
	.db $19
	.db $FD
	.db 4,"-"
	.db 2,"["
	.db $FE
	.db "("
	.db "`"
	.db "("
	.db $14
	.db ")"
	.db " "
	.db " "
	.db "("
	.db "*"
	.db ")"
	.db " "
	.db " "
	.db ")"
	.db " "
	.db "["
	.db "["
	.db " "
	.db "("
	.db "_"
	.db " "
	.db " "
	.db "("
	.db "*"
	.db ")"
	.db " "
	.db " "
	.db "_"
	.db ")"
	.db " "
	.db " "
	.db "|"
	.db "["
	.db $FD
	.db 3," "
	.db 1,"("
	.db 5,"_"
	.db 1,")"
	.db 4," "
	.db 2,"["
	.db 14," "
	.db 7,"["
	.db 4,"."
	.db 6,"["
	.db $FF

room_25_background: ;"Town-Shop"
;	.db $BA,9,9,9,9,9,9,9,9,9,9,9,"..",9,$BA
;	.db $BA,$C1,"FISH_SHOP]",12,12,9,$BA
;	.db "[_|",$BA,"]__",$BA,"_]| ",12,12," ["
;	.db "[U|__",$7F,$7F,"___| ",12,12," ["
;	.db ":",12,12,12,12,12,12,12," ",12,12,12,12,"_ ["
;	.db ":",12,12,12,12,12,12,12,12,12,12,$C1,$7F,".]["
;	.db "[",$BD," ",$BD," ",12,12,"  ",$BE,$BD,"!--!["
;	.db "[[[[[..[[[[[[[[["
	.db 1,$BA
	.db 11,9
	.db 2,"."
	.db 1,9
	.db 2,$BA
	.db $FE
	.db $C1
	.db "F"
	.db "I"
	.db "S"
	.db "H"
	.db "_"
	.db "S"
	.db "H"
	.db "O"
	.db "P"
	.db "]"
	.db 12
	.db 12
	.db 9
	.db $BA
	.db "["
	.db "_"
	.db "|"
	.db $C1
	.db "]"
	.db "_"
	.db "_"
	.db $C1
	.db "_"
	.db "]"
	.db "|"
	.db " "
	.db 12
	.db 12
	.db " "
	.db "["
	.db "["
	.db "U"
	.db "|"
	.db "_"
	.db "_"
	.db $7F
	.db $7F
	.db $FD
	.db 3,"_"
	.db $FE
	.db "|"
	.db " "
	.db 12
	.db 12
	.db " "
	.db "["
	.db ":"
	.db $FD
	.db 7,12
	.db 1," "
	.db 4,12
	.db $FE
	.db "_"
	.db " "
	.db "["
	.db ":"
	.db $FD
	.db 10,12
	.db $FE
	.db $C1
	.db $7F
	.db "."
	.db "]"
	.db "["
	.db "["
	.db $BD
	.db " "
	.db $BD
	.db " "
	.db 12
	.db 12
	.db " "
	.db " "
	.db $BE
	.db $BD
	.db "!"
	.db "-"
	.db "-"
	.db "!"
	.db $FD
	.db 6,"["
	.db 2,"."
	.db 9,"["
	.db $FF

room_26_background: ;"House-Shop"
;	.db "+-U----------U-+"
;	.db "|",$B6,"'",$B7,"__ ",$C4," ___",$B6,"'",$B7,"|"
;	.db "|-| ..",$B7,"-",$B6,".. |--|"
;	.db "|\\!---------!/ |"
;	.db "|\\!---------! /|"
;	.db "| ) )( ",$B7,$B6," )( ( |"
;	.db "|/ /  ",$B7,"--",$B6,"  \\ \\|"
;	.db "+----....------+"
	.db $FE
	.db "+"
	.db "-"
	.db "U"
	.db $FD
	.db 10,"-"
	.db $FE
	.db "U"
	.db "-"
	.db "+"
	.db "|"
	.db $B6
	.db "'"
	.db $B7
	.db "_"
	.db "_"
	.db " "
	.db $C4
	.db " "
	.db $FD
	.db 3,"_"
	.db $FE
	.db $B6
	.db "'"
	.db $B7
	.db "|"
	.db "|"
	.db "-"
	.db "|"
	.db " "
	.db "."
	.db "."
	.db $B7
	.db "-"
	.db $B6
	.db "."
	.db "."
	.db " "
	.db "|"
	.db "-"
	.db "-"
	.db "|"
	.db "|"
	.db "\\"
	.db "!"
	.db $FD
	.db 9,"-"
	.db $FE
	.db "!"
	.db "/"
	.db " "
	.db "|"
	.db "|"
	.db "\\"
	.db "!"
	.db $FD
	.db 9,"-"
	.db $FE
	.db "!"
	.db " "
	.db "/"
	.db "|"
	.db "|"
	.db " "
	.db ")"
	.db " "
	.db ")"
	.db "("
	.db " "
	.db $B7
	.db $B6
	.db " "
	.db ")"
	.db "("
	.db " "
	.db "("
	.db " "
	.db "|"
	.db "|"
	.db "/"
	.db " "
	.db "/"
	.db " "
	.db " "
	.db $B7
	.db "-"
	.db "-"
	.db $B6
	.db " "
	.db " "
	.db "\\"
	.db " "
	.db "\\"
	.db "|"
	.db "+"
	.db $FD
	.db 4,"-"
	.db 4,"."
	.db 6,"-"
	.db 1,"+"
	.db $FF

room_27_background: ;"Town-South"
;	.db "[[[[[..[[[[[[[[["
;	.db "[[[[ ",12,12,"   _",$13,"__[["
;	.db "[[_",$13,"__",12,12," /____\\["
;	.db "[/____\\",12,12,$BA,$C1,"]",$C1,"]",$BA,"["
;	.db "[",$BA,$C1,"]",$C1,"]",$BA,12,12,"|__",$7F,"_|["
;	.db "[|_",$7F,"__|",12,12,12,12,12,12,"*",12,"["
;	.db "[[",12,12,12,12,12,12,12,12,$BD,$BD,$BD,$C9,12,"["
;	.db "[[[[[[[[[",$C1,"----]["
	.db 5,"["
	.db 2,"."
	.db 13,"["
	.db 1," "
	.db 2,12
	.db 3," "
	.db $FE
	.db "_"
	.db $13
	.db "_"
	.db "_"
	.db $FD
	.db 4,"["
	.db $FE
	.db "_"
	.db $13
	.db "_"
	.db "_"
	.db 12
	.db 12
	.db " "
	.db "/"
	.db $FD
	.db 4,"_"
	.db 1,"\\"
	.db 2,"["
	.db 1,"/"
	.db 4,"_"
	.db 1,"\\"
	.db 2,12
	.db $FE
	.db $BA
	.db $C1
	.db "]"
	.db $C1
	.db "]"
	.db $BA
	.db "["
	.db "["
	.db $BA
	.db $C1
	.db "]"
	.db $C1
	.db "]"
	.db $BA
	.db 12
	.db 12
	.db "|"
	.db "_"
	.db "_"
	.db $7F
	.db "_"
	.db "|"
	.db "["
	.db "["
	.db "|"
	.db "_"
	.db $7F
	.db "_"
	.db "_"
	.db "|"
	.db $FD
	.db 6,12
	.db $FE
	.db "*"
	.db 12
	.db $FD
	.db 3,"["
	.db 8,12
	.db 3,4
	.db $FE
	.db $1E
	.db 12
	.db $FD
	.db 10,"["
	.db 1,$C1
	.db 4,$CB
	.db $FE
	.db "]"
	.db "["
	.db $FF

room_28_background: ;"House-Left"
;	.db "+--------------+"
;	.db "| ",$BA," )/( ",$BA," ",$C1,"/]  |"
;	.db "|-!)///(!",$C1,$CB,$CB,$CB,"]-|"
;	.db "|   ___  '   ' |"
;	.db "|  /",12,"_",11,"\\  ",12,"-.-",12,"|"
;	.db "| (",11,"(_)",12,") !---!|"
;	.db "|  \\___/  '   '|"
;	.db "+--...---------+"
	.db 1,"+"
	.db 14,"-"
	.db $FE
	.db "+"
	.db "|"
	.db " "
	.db $BA
	.db " "
	.db ")"
	.db "/"
	.db "("
	.db " "
	.db $BA
	.db " "
	.db $C1
	.db "/"
	.db "]"
	.db " "
	.db " "
	.db "|"
	.db "|"
	.db "-"
	.db "!"
	.db ")"
	.db $FD
	.db 3,"/"
	.db $FE
	.db "("
	.db "!"
	.db $C1
	.db $FD
	.db 3,$CB
	.db $FE
	.db "]"
	.db "-"
	.db "|"
	.db "|"
	.db $FD
	.db 3," "
	.db 3,"_"
	.db 2," "
	.db 1,"'"
	.db 3," "
	.db $FE
	.db "'"
	.db " "
	.db "|"
	.db "|"
	.db " "
	.db " "
	.db "/"
	.db 12
	.db "_"
	.db 11
	.db "\\"
	.db " "
	.db " "
	.db 12
	.db "-"
	.db "."
	.db "-"
	.db 12
	.db "|"
	.db "|"
	.db " "
	.db "("
	.db 11
	.db "("
	.db "_"
	.db ")"
	.db 12
	.db ")"
	.db " "
	.db "!"
	.db $FD
	.db 3,"-"
	.db 1,"!"
	.db 2,"|"
	.db 2," "
	.db 1,"\\"
	.db 3,"_"
	.db 1,"/"
	.db 2," "
	.db 1,"'"
	.db 3," "
	.db $FE
	.db "'"
	.db "|"
	.db "+"
	.db "-"
	.db "-"
	.db $FD
	.db 3,"."
	.db 9,"-"
	.db 1,"+"
	.db $FF

room_29_background: ;"House-Right"
;	.db "+------------U-+"
;	.db "|     ",$BA,")/(",$BA," ",$B6,"'",$B7,"|"
;	.db "|O( )-!)/(!-",$C1,$1A,"]|"
;	.db "|",$C1,"---]-----_' '|"
;	.db "|   ( `(",$B6,"O",$B7," )  |"
;	.db "|",$C1,9,"](  '''  )  |"
;	.db "|",$C1,9,"]]",$B7,"-----",$B6,"   |"
;	.db "+---------...--+"
	.db 1,"+"
	.db 12,"-"
	.db $FE
	.db "U"
	.db "-"
	.db "+"
	.db "|"
	.db $FD
	.db 5," "
	.db $FE
	.db $BA
	.db ")"
	.db "/"
	.db "("
	.db $BA
	.db " "
	.db $B6
	.db "'"
	.db $B7
	.db "|"
	.db "|"
	.db "O"
	.db "("
	.db " "
	.db ")"
	.db "-"
	.db "!"
	.db ")"
	.db "/"
	.db "("
	.db "!"
	.db "-"
	.db $C1
	.db $1A
	.db "]"
	.db "|"
	.db "|"
	.db $C1
	.db $FD
	.db 3,"-"
	.db 1,"]"
	.db 5,"-"
	.db $FE
	.db "_"
	.db "'"
	.db " "
	.db "'"
	.db "|"
	.db "|"
	.db $FD
	.db 3," "
	.db $FE
	.db "("
	.db " "
	.db "`"
	.db "("
	.db $B6
	.db "O"
	.db $B7
	.db " "
	.db ")"
	.db " "
	.db " "
	.db "|"
	.db "|"
	.db $C1
	.db 9
	.db "]"
	.db "("
	.db " "
	.db " "
	.db $FD
	.db 3,"'"
	.db 2," "
	.db 1,")"
	.db 2," "
	.db 2,"|"
	.db $FE
	.db $C1
	.db 9
	.db "]"
	.db "]"
	.db $B7
	.db $FD
	.db 5,"-"
	.db 1,$B6
	.db 3," "
	.db $FE
	.db "|"
	.db "+"
	.db $FD
	.db 9,"-"
	.db 3,"."
	.db 2,"-"
	.db 1,"+"
	.db $FF

room_30_background: ;"Town-Fountain"
;	.db "[(())[[[[[[(())["
;	.db "((())) ",$BD,$BD," ((()))"
;	.db "[",12,"|",$C9,12,12,$C1,"==]",12,12,"|!.["
;	.db "[",12,"''++",$BD,"|!",$BD,"++''",12,"["
;	.db "[",12,12,"++",$C1,"====]++",12,12,"["
;	.db "[",12,12,"++++++++++",12,12,"["
;	.db "[",12,12,12,12,12,12,12,12,12,12,12,12,12,12,"["
;	.db $BA,9,9,9,9,9,9,9,9,9,9,9,"..",9,$BA
	.db 1,"["
	.db 2,"("
	.db 2,")"
	.db 6,"["
	.db 2,"("
	.db 2,")"
	.db 1,"["
	.db 3,"("
	.db 3,")"
	.db 1," "
	.db 2,$BD
	.db 1," "
	.db 3,"("
	.db 3,")"
	.db $FE
	.db "["
	.db 12
	.db "|"
	.db $C9
	.db 12
	.db 12
	.db $C1
	.db "="
	.db "="
	.db "]"
	.db 12
	.db 12
	.db "|"
	.db "!"
	.db "."
	.db "["
	.db "["
	.db 12
	.db "'"
	.db "'"
	.db "+"
	.db "+"
	.db $BD
	.db "|"
	.db "!"
	.db $BD
	.db "+"
	.db "+"
	.db "'"
	.db "'"
	.db 12
	.db "["
	.db "["
	.db 12
	.db 12
	.db "+"
	.db "+"
	.db $C1
	.db $FD
	.db 4,"="
	.db 1,"]"
	.db 2,"+"
	.db 2,12
	.db 2,"["
	.db 2,12
	.db 10,"+"
	.db 2,12
	.db 2,"["
	.db 14,12
	.db $FE
	.db "["
	.db $BA
	.db $FD
	.db 11,9
	.db 2,"."
	.db $FE
	.db 9
	.db $BA
	.db $FF

room_31_background: ;"Volcano-Beach"
;	.db "\\ \\!",12,12,12,12,12,") ^^^  "
;	.db "\\  !  ",12,12,"(      ^"
;	.db " \\!",$B7,"   ",12,12,")  ^^^ "
;	.db "\\ !:  ",12,12,"(",$C1,"II)   "
;	.db " \\!:   ",12,12,"\\",$B8,$B8,$B8,"   "
;	.db "\\  ",$B7,"    ",12,12,")  ^^^"
;	.db "\\ \\!  ",12,12,12,"/ ^^^  "
;	.db " \\ !",$D9,$D9,$D9,$D9,"(     ^^"
	.db $FE
	.db "\\"
	.db " "
	.db "\\"
	.db "!"
	.db $FD
	.db 5,12
	.db $FE
	.db ")"
	.db " "
	.db $FD
	.db 3,"^"
	.db 2," "
	.db 1,"\\"
	.db 2," "
	.db 1,"!"
	.db 2," "
	.db 2,12
	.db 1,"("
	.db 6," "
	.db $FE
	.db "^"
	.db " "
	.db "\\"
	.db "!"
	.db $B7
	.db $FD
	.db 3," "
	.db 2,12
	.db 1,")"
	.db 2," "
	.db 3,"^"
	.db $FE
	.db " "
	.db "\\"
	.db " "
	.db "!"
	.db ":"
	.db " "
	.db " "
	.db 12
	.db 12
	.db "("
	.db $C1
	.db "I"
	.db "I"
	.db ")"
	.db $FD
	.db 4," "
	.db $FE
	.db "\\"
	.db "!"
	.db ":"
	.db $FD
	.db 3," "
	.db 2,12
	.db 1,"\\"
	.db 3,$B8
	.db 3," "
	.db 1,"\\"
	.db 2," "
	.db 1,$B7
	.db 4," "
	.db 2,12
	.db 1,")"
	.db 2," "
	.db 3,"^"
	.db $FE
	.db "\\"
	.db " "
	.db "\\"
	.db "!"
	.db " "
	.db " "
	.db $FD
	.db 3,12
	.db $FE
	.db "/"
	.db " "
	.db $FD
	.db 3,"^"
	.db 3," "
	.db $FE
	.db "\\"
	.db " "
	.db "!"
	.db $FD
	.db 4,$D9
	.db 1,"("
	.db 5," "
	.db 2,"^"
	.db $FF

room_32_background: ;"Volcano-Stand"
;	.db " \\_____  _",$13,$1A,"v",$1A,"\\_"
;	.db "\\",$C1,"DRINK]",$13,"__/X\\__"
;	.db "\\|",$C1,"~] ",$C4,"|",12,$B6,"-//",$B7,"-",$B7
;	.db "\\`====='",12,12,$13,"/.   "
;	.db "\\ ",$14,$B8,$B8,$B8,$14,"  ",$13,$13,12,") ^^"
;	.db "\\\\       ",12,12,"/    "
;	.db "\\ \\     ",12,12,"/ ^^  "
;	.db "\\ \\!",12,12,12,12,12,"(   ^^^"
	.db $FE
	.db " "
	.db "\\"
	.db $FD
	.db 5,"_"
	.db 2," "
	.db $FE
	.db "_"
	.db $13
	.db $1A
	.db "v"
	.db $1A
	.db "\\"
	.db "_"
	.db "\\"
	.db $C1
	.db "D"
	.db "R"
	.db "I"
	.db "N"
	.db "K"
	.db "]"
	.db $13
	.db "_"
	.db "_"
	.db "/"
	.db "X"
	.db "\\"
	.db "_"
	.db "_"
	.db "\\"
	.db "|"
	.db $C1
	.db "~"
	.db "]"
	.db " "
	.db $C4
	.db "|"
	.db 12
	.db $B6
	.db "-"
	.db "/"
	.db "/"
	.db $B7
	.db "-"
	.db $B7
	.db "\\"
	.db "`"
	.db $FD
	.db 5,"="
	.db 1,"'"
	.db 2,12
	.db $FE
	.db $13
	.db "/"
	.db "."
	.db $FD
	.db 3," "
	.db $FE
	.db "\\"
	.db " "
	.db $14
	.db $FD
	.db 3,$B8
	.db 1,$14
	.db 2," "
	.db 2,$13
	.db $FE
	.db 12
	.db ")"
	.db " "
	.db "^"
	.db "^"
	.db "\\"
	.db "\\"
	.db $FD
	.db 7," "
	.db 2,12
	.db 1,"/"
	.db 4," "
	.db $FE
	.db "\\"
	.db " "
	.db "\\"
	.db $FD
	.db 5," "
	.db 2,12
	.db $FE
	.db "/"
	.db " "
	.db "^"
	.db "^"
	.db " "
	.db " "
	.db "\\"
	.db " "
	.db "\\"
	.db "!"
	.db $FD
	.db 5,12
	.db 1,"("
	.db 3," "
	.db 3,"^"
	.db $FF

room_33_background: ;"Volcano-Bridge"
;	.db "/VVV/VVVVVVV//VV"
;	.db "--V---VVV-V----V"
;	.db "^ !    V   /\\  !"
;	.db "===",$1E,12," ",12," ",12,"  ",12,12,12," :"
;	.db "===",$1E," ",12," ",12,12," ",12," ",12," ",12,":"
;	.db "^ !  /",$B7,$B6,"\\      !"
;	.db " ^! ",$B6,$B7," ^ ",$B7,"     !"
;	.db "^ `------------+"
	.db 1,"/"
	.db 3,"V"
	.db 1,"/"
	.db 7,"V"
	.db 2,"/"
	.db 2,"V"
	.db 2,"-"
	.db 1,"V"
	.db 3,"-"
	.db 3,"V"
	.db $FE
	.db "-"
	.db "V"
	.db $FD
	.db 4,"-"
	.db $FE
	.db "V"
	.db "^"
	.db " "
	.db "!"
	.db $FD
	.db 4," "
	.db 1,"V"
	.db 3," "
	.db $FE
	.db "/"
	.db "\\"
	.db " "
	.db " "
	.db "!"
	.db $FD
	.db 3,"="
	.db $FE
	.db $1E
	.db 12
	.db " "
	.db 12
	.db " "
	.db 12
	.db " "
	.db " "
	.db $FD
	.db 3,12
	.db $FE
	.db " "
	.db ":"
	.db $FD
	.db 3,"="
	.db $FE
	.db $1E
	.db " "
	.db 12
	.db " "
	.db 12
	.db 12
	.db " "
	.db 12
	.db " "
	.db 12
	.db " "
	.db 12
	.db ":"
	.db "^"
	.db " "
	.db "!"
	.db " "
	.db " "
	.db "/"
	.db $B7
	.db $B6
	.db "\\"
	.db $FD
	.db 6," "
	.db $FE
	.db "!"
	.db " "
	.db "^"
	.db "!"
	.db " "
	.db $B6
	.db $B7
	.db " "
	.db "^"
	.db " "
	.db $B7
	.db $FD
	.db 5," "
	.db $FE
	.db "!"
	.db "^"
	.db " "
	.db "`"
	.db $FD
	.db 12,"-"
	.db 1,"+"
	.db $FF

room_34_background: ;"Volcano-Lobby"
;	.db "VVV",$BE,"/|VV|//",$BE,"VVV/"
;	.db "VV",$BE,"%",$BE,"|..|-",$BE,"%",$BE,"V--"
;	.db "V ",$B6," ",$B7," ",12,12,"  ",$B6," ",$B7,"! ^"
;	.db "!",$BD,"    ",12," ",12,12,12,12,$1E,"==="
;	.db "!  ",$BE,"   ",12,12," ",12," ",$1E,"==="
;	.db "! ",$BE,"%",$BE,"   ",$BD,"    !^ "
;	.db "\\ ",$B6," ",$B7,"     ",$BD,"  ' ^"
;	.db $B6,$B6,"\\---^^----",$B6," ^ "
	.db 3,"V"
	.db $FE
	.db $BE
	.db "/"
	.db "|"
	.db "V"
	.db "V"
	.db "|"
	.db "/"
	.db "/"
	.db $BE
	.db $FD
	.db 3,"V"
	.db 1,"/"
	.db 2,"V"
	.db $FE
	.db $BE
	.db "%"
	.db $BE
	.db "|"
	.db "."
	.db "."
	.db "|"
	.db "-"
	.db $BE
	.db "%"
	.db $BE
	.db "V"
	.db "-"
	.db "-"
	.db "V"
	.db " "
	.db $B6
	.db " "
	.db $B7
	.db " "
	.db 12
	.db 12
	.db " "
	.db " "
	.db $B6
	.db " "
	.db $B7
	.db "!"
	.db " "
	.db "^"
	.db "!"
	.db $BD
	.db $FD
	.db 4," "
	.db $FE
	.db 12
	.db " "
	.db $FD
	.db 4,12
	.db 1,$1E
	.db 3,"="
	.db 1,"!"
	.db 2," "
	.db 1,$BE
	.db 3," "
	.db 2,12
	.db $FE
	.db " "
	.db 12
	.db " "
	.db $1E
	.db $FD
	.db 3,"="
	.db $FE
	.db "!"
	.db " "
	.db $BE
	.db "%"
	.db $BE
	.db $FD
	.db 3," "
	.db 1,$BD
	.db 4," "
	.db $FE
	.db "!"
	.db "^"
	.db " "
	.db "\\"
	.db " "
	.db $B6
	.db " "
	.db $B7
	.db $FD
	.db 5," "
	.db 1,$BD
	.db 2," "
	.db $FE
	.db "'"
	.db " "
	.db "^"
	.db $B6
	.db $B6
	.db "\\"
	.db $FD
	.db 3,"-"
	.db 2,"^"
	.db 4,"-"
	.db $FE
	.db $B6
	.db " "
	.db "^"
	.db " "
	.db $FF

room_35_background: ;"Volcano-Throne"
;	.db "V/PrincessPyro\\V"
;	.db "VV//// M",$BE," ////VV"
;	.db "V/// ^",$BE,"^^",$BE,"^ ///V"
;	.db "[/ _--\\_^/--__[["
;	.db "[[/",12," ",12,$B6,"  ",$B7," ",$BD,12," \\["
;	.db "[(",12,$BD,12,"  ",12,12," ",12,"  ",12," )"
;	.db "[[\\ ",12,"    ",12," ",12,$BD,"_/["
;	.db "[[[",$B7,"-....---",$B6,"[[["
	.db $FE
	.db "V"
	.db "/"
	.db "P"
	.db "r"
	.db "i"
	.db "n"
	.db "c"
	.db "e"
	.db "s"
	.db "s"
	.db "P"
	.db "y"
	.db "r"
	.db "o"
	.db "\\"
	.db $FD
	.db 3,"V"
	.db 4,"/"
	.db $FE
	.db " "
	.db "M"
	.db $BE
	.db " "
	.db $FD
	.db 4,"/"
	.db 3,"V"
	.db 3,"/"
	.db $FE
	.db " "
	.db "^"
	.db $BE
	.db "^"
	.db "^"
	.db $BE
	.db "^"
	.db " "
	.db $FD
	.db 3,"/"
	.db $FE
	.db "V"
	.db "["
	.db "/"
	.db " "
	.db "_"
	.db "-"
	.db "-"
	.db "\\"
	.db "_"
	.db "^"
	.db "/"
	.db "-"
	.db "-"
	.db "_"
	.db "_"
	.db $FD
	.db 4,"["
	.db $FE
	.db "/"
	.db 12
	.db " "
	.db 12
	.db $B6
	.db " "
	.db " "
	.db $B7
	.db " "
	.db $BD
	.db 12
	.db " "
	.db "\\"
	.db "["
	.db "["
	.db "("
	.db 12
	.db $BD
	.db 12
	.db " "
	.db " "
	.db 12
	.db 12
	.db " "
	.db 12
	.db " "
	.db " "
	.db 12
	.db " "
	.db ")"
	.db "["
	.db "["
	.db "\\"
	.db " "
	.db 12
	.db $FD
	.db 4," "
	.db $FE
	.db 12
	.db " "
	.db 12
	.db $BD
	.db "_"
	.db "/"
	.db $FD
	.db 4,"["
	.db $FE
	.db $B7
	.db "-"
	.db $FD
	.db 4,"."
	.db 3,"-"
	.db 1,$B6
	.db 3,"["
	.db $FF

room_36_background: ;"Fridge-Entrance"
;	.db "|-VVVVVVV-V--VV|"
;	.db "|--V...V-",$14,$C1,"\\]-V|"
;	.db "|   ",12," ",12,12,$14,$14,$14,$C1,"/] |"
;	.db "|",$C1,"\\] ",12,12,12,12," ",12," ",12,12," |"
;	.db "|  _",$C4,"_ ",12," ",12,12,12,12,12,12,":"
;	.db "| V(%)   ",$C1,"\\] ",12,12,":"
;	.db "| ",$C9,"(:)",$14," ",$C1,"/]",$C1,"/] |"
;	.db "+--------------+"
	.db $FE
	.db "|"
	.db "-"
	.db $FD
	.db 7,"V"
	.db $FE
	.db "-"
	.db "V"
	.db "-"
	.db "-"
	.db "V"
	.db "V"
	.db "|"
	.db "|"
	.db "-"
	.db "-"
	.db "V"
	.db $FD
	.db 3,"."
	.db $FE
	.db "V"
	.db "-"
	.db $14
	.db $C1
	.db "\\"
	.db "]"
	.db "-"
	.db "V"
	.db "|"
	.db "|"
	.db $FD
	.db 3," "
	.db $FE
	.db 12
	.db " "
	.db 12
	.db 12
	.db $FD
	.db 3,$14
	.db $FE
	.db $C1
	.db "/"
	.db "]"
	.db " "
	.db "|"
	.db "|"
	.db $C1
	.db "\\"
	.db "]"
	.db " "
	.db $FD
	.db 4,12
	.db $FE
	.db " "
	.db 12
	.db " "
	.db 12
	.db 12
	.db " "
	.db "|"
	.db "|"
	.db " "
	.db " "
	.db "_"
	.db $C4
	.db "_"
	.db " "
	.db 12
	.db " "
	.db $FD
	.db 6,12
	.db $FE
	.db ":"
	.db "|"
	.db " "
	.db "V"
	.db "("
	.db "%"
	.db ")"
	.db $FD
	.db 3," "
	.db $FE
	.db $C1
	.db "\\"
	.db "]"
	.db " "
	.db 12
	.db 12
	.db ":"
	.db "|"
	.db " "
	.db $C9
	.db "("
	.db ":"
	.db ")"
	.db $14
	.db " "
	.db $C1
	.db "/"
	.db "]"
	.db $C1
	.db "/"
	.db "]"
	.db " "
	.db "|"
	.db "+"
	.db $FD
	.db 14,"-"
	.db 1,"+"
	.db $FF

room_37_background: ;"Fridge-Town"
;	.db "|VVV-VVVVVVVVV-V"
;	.db "|-V---V-V...V--|"
;	.db "|/",$DD,"\\",10,6,6,"   ",12,12,"  ",$14,"|"
;	.db "|",$DD," ",$DD,$BE,$EF,11," ",12,12," ",12,"/",$DD,"\\|"
;	.db "|",$DD,"   ",12," ",12,"_",$C4,"_ ",$DD," ",$DD,"|"
;	.db "|",$DD,$14,"  ",12,12," (%)V  ",$DD,"|"
;	.db "|",$14,$14,$14,"  ",12,$14,"(:)",$C9," ",$14,$DD,"|"
;	.db "+---...--------+"
	.db 1,"|"
	.db 3,"V"
	.db 1,"-"
	.db 9,"V"
	.db $FE
	.db "-"
	.db "V"
	.db "|"
	.db "-"
	.db "V"
	.db $FD
	.db 3,"-"
	.db $FE
	.db "V"
	.db "-"
	.db "V"
	.db $FD
	.db 3,"."
	.db 1,"V"
	.db 2,"-"
	.db 2,"|"
	.db $FE
	.db "/"
	.db $DD
	.db "\\"
	.db 10
	.db 6
	.db 6
	.db $FD
	.db 3," "
	.db 2,12
	.db 2," "
	.db 1,$14
	.db 2,"|"
	.db $FE
	.db $DD
	.db " "
	.db $DD
	.db $BE
	.db $EF
	.db 11
	.db " "
	.db 12
	.db 12
	.db " "
	.db 12
	.db "/"
	.db $DD
	.db "\\"
	.db "|"
	.db "|"
	.db $DD
	.db $FD
	.db 3," "
	.db $FE
	.db 12
	.db " "
	.db 12
	.db "_"
	.db $C4
	.db "_"
	.db " "
	.db $DD
	.db " "
	.db $DD
	.db "|"
	.db "|"
	.db $DD
	.db $14
	.db " "
	.db " "
	.db 12
	.db 12
	.db " "
	.db "("
	.db "%"
	.db ")"
	.db "V"
	.db " "
	.db " "
	.db $DD
	.db "|"
	.db "|"
	.db $FD
	.db 3,$14
	.db 2," "
	.db $FE
	.db 12
	.db $14
	.db "("
	.db ":"
	.db ")"
	.db $C9
	.db " "
	.db $14
	.db $DD
	.db "|"
	.db "+"
	.db $FD
	.db 3,"-"
	.db 3,"."
	.db 8,"-"
	.db 1,"+"
	.db $FF

room_38_background: ;"Fridge-Throne"
;	.db "VV-King-Bear--VV"
;	.db "V-/\\-o_oMo--/\\-V"
;	.db "|/vV\\(_(",$A5,") /Vv\\|"
;	.db "|    ' '",$14,"'",$B6,"  /\\|"
;	.db "|/",$DD,"\\ /\\     _",$C4,"_|"
;	.db "|",$DD," ",$DD,"/Vv\\     | |"
;	.db "|",$DD," /    \\   (:)|"
;	.db "+--------...---+"
	.db 2,"V"
	.db $FE
	.db "-"
	.db "K"
	.db "i"
	.db "n"
	.db "g"
	.db "-"
	.db "B"
	.db "e"
	.db "a"
	.db "r"
	.db "-"
	.db "-"
	.db $FD
	.db 3,"V"
	.db $FE
	.db "-"
	.db "/"
	.db "\\"
	.db "-"
	.db "o"
	.db "_"
	.db "o"
	.db "M"
	.db "o"
	.db "-"
	.db "-"
	.db "/"
	.db "\\"
	.db "-"
	.db "V"
	.db "|"
	.db "/"
	.db "v"
	.db "V"
	.db "\\"
	.db "("
	.db "_"
	.db "("
	.db $A5
	.db ")"
	.db " "
	.db "/"
	.db "V"
	.db "v"
	.db "\\"
	.db "|"
	.db "|"
	.db $FD
	.db 4," "
	.db $FE
	.db "'"
	.db " "
	.db "'"
	.db $14
	.db "'"
	.db $B6
	.db " "
	.db " "
	.db "/"
	.db "\\"
	.db "|"
	.db "|"
	.db "/"
	.db $DD
	.db "\\"
	.db " "
	.db "/"
	.db "\\"
	.db $FD
	.db 5," "
	.db $FE
	.db "_"
	.db $C4
	.db "_"
	.db "|"
	.db "|"
	.db $DD
	.db " "
	.db $DD
	.db "/"
	.db "V"
	.db "v"
	.db "\\"
	.db $FD
	.db 5," "
	.db $FE
	.db "|"
	.db " "
	.db "|"
	.db "|"
	.db $DD
	.db " "
	.db "/"
	.db $FD
	.db 4," "
	.db 1,"\\"
	.db 3," "
	.db $FE
	.db "("
	.db ":"
	.db ")"
	.db "|"
	.db "+"
	.db $FD
	.db 8,"-"
	.db 3,"."
	.db 3,"-"
	.db 1,"+"
	.db $FF

room_39_background: ;"Entrance-Finale"
;	.db "DDDDDDDDDDDDDDDD"
;	.db "D ",12," ",12,12,"  ",12," ",12,12," ",12," D"
;	.db "D  THANK YOU   D"
;	.db "D",12,"FOR PLAYING! D"
;	.db "D  +.+ ",12,"+++.+ ",12,"D"
;	.db "D ++.+",12," ",$BD,"+.++",12," D"
;	.db "D  ++ ",12,12," ",12,"  ",12," ",12,"D"
;	.db "DDDDDDDDD...DDDD"
	.db 17,"D"
	.db $FE
	.db " "
	.db 12
	.db " "
	.db 12
	.db 12
	.db " "
	.db " "
	.db 12
	.db " "
	.db 12
	.db 12
	.db " "
	.db 12
	.db " "
	.db "D"
	.db "D"
	.db " "
	.db " "
	.db "T"
	.db "H"
	.db "A"
	.db "N"
	.db "K"
	.db " "
	.db "Y"
	.db "O"
	.db "U"
	.db $FD
	.db 3," "
	.db 2,"D"
	.db $FE
	.db 12
	.db "F"
	.db "O"
	.db "R"
	.db " "
	.db "P"
	.db "L"
	.db "A"
	.db "Y"
	.db "I"
	.db "N"
	.db "G"
	.db "!"
	.db " "
	.db "D"
	.db "D"
	.db " "
	.db " "
	.db "+"
	.db "."
	.db "+"
	.db " "
	.db 12
	.db $FD
	.db 3,"+"
	.db $FE
	.db "."
	.db "+"
	.db " "
	.db 12
	.db "D"
	.db "D"
	.db " "
	.db "+"
	.db "+"
	.db "."
	.db "+"
	.db 12
	.db " "
	.db $BD
	.db "+"
	.db "."
	.db "+"
	.db "+"
	.db 12
	.db " "
	.db "D"
	.db "D"
	.db " "
	.db " "
	.db "+"
	.db "+"
	.db " "
	.db 12
	.db 12
	.db " "
	.db 12
	.db " "
	.db " "
	.db 12
	.db " "
	.db 12
	.db $FD
	.db 10,"D"
	.db 3,"."
	.db 4,"D"
	.db $FF