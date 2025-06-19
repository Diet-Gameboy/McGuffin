;Author: Phoenix Cushman (Diet-Gameboy on GitHub)
;File Name rle.asm
;Date Created: 6/16/2025 7:51pm
;Last Modified: 6/17/2025
;Description: This file contains all the defines and the functions and sub functions for the rle decompression
;   system used by the game background, and collision maps.

;************************************************************************************************************
; Run Length Encoding Decompressor Function and Sub Functions
;************************************************************************************************************

;bit 7 will denote the compression mode, bit 1 will denote background or collision mode, bit 0 will denote the nibble offset in memory
#define RLE_STATUS_COMPRESSION_MODE_bp (7)
#define RLE_STATUS_BACKGROUND_COLLISION_bp (1)
#define RLE_STATUS_NIBBLE_OFFSET_bp (0)
#define RLE_DATA_FULL_BYTE_SIZE_bp (7)
#define RLE_STATUS_RLE_COMPRESSION_MODE_bm (%00000000)
#define RLE_STATUS_STREAM_COMPRESSION_MODE_bm (%10000000)
#define RLE_STATUS_BACKGROUND_MODE_bm (%00000000)
#define RLE_STATUS_COLLISION_MODE_bm (%00000010)
#define RLE_STATUS_NO_OFFSET_bm (%00000000)
#define RLE_STATUS_NIBBLE_OFFSET_bm (%00000001)

#define RLE_EOT_MARKER ($FF)
#define RLE_STREAM_MODE_MARKER ($FE)
#define RLE_COMPRESS_MODE_MARKER ($FD)

;**********************************
;Function Name: rle_decompressor
;Description: Decompresses the RLE encoded ascii values (usually game backgrounds) from the
;   source pointer into the destination buffer.
;Parameters:
;	HL register - The 16-bit source address (data)
;   DE register - The 16-bit destination address (buffer)
;**********************************
rle_decompressor:
	push de
	push bc
	ld c, RLE_STATUS_RLE_COMPRESSION_MODE_bm | RLE_STATUS_BACKGROUND_MODE_bm | RLE_STATUS_NO_OFFSET_bm
    jr rle_decompressor_c_loop

;**********************************
;Function Name: rle_decompressor_c
;Description: Decompresses the custom-RLE encoded collision data from the
;   source pointer into the destination buffer. A different encoding method
;   is used for this data where it works in nibbles instead of bytes.
;Parameters:
;	HL register - The 16-bit source address (data)
;   DE register - The 16-bit destination address (buffer)
;**********************************
rle_decompressor_c: ;hl input location, de output location
	push de
	push bc
	ld c, RLE_STATUS_RLE_COMPRESSION_MODE_bm | RLE_STATUS_COLLISION_MODE_bm | RLE_STATUS_NO_OFFSET_bm
rle_decompressor_c_loop:
	call rle_decompressor_c_sub_read_byte
	cp RLE_EOT_MARKER ;stop execution
	jr z,rle_decompressor_c_exit
	cp RLE_STREAM_MODE_MARKER ;set to single mode
	jr z,rle_decompressor_c_set_single
	cp RLE_COMPRESS_MODE_MARKER ;set to double mode
	jr z,rle_decompressor_c_set_double
	push hl
	ld hl,buffers_ends
	sbc hl,de
	bit 7,h
	jr nz,rle_decompressor_c_overflow_exit
	pop hl
	bit RLE_STATUS_COMPRESSION_MODE_bp,c
	jr nz,rle_decompressor_c_single
    bit RLE_STATUS_BACKGROUND_COLLISION_bp,c
    jr z,rle_decompressor_c_read_background_size
    bit RLE_DATA_FULL_BYTE_SIZE_bp,a ;if bit 7 of the size parameter in a is set we know that it is a full byte size, otherwise the size is a nibble (0-7)
    jr nz,rle_decompressor_c_read_full_size
rle_decompressor_c_read_half_size:
    call rle_div_a_4
    ld b,a
    call rle_decompressor_c_sub_step_half_byte
    jr rle_decompressor_c_finish_size_read
rle_decompressor_c_read_full_size:
    and a,%01111111
rle_decompressor_c_read_background_size:
    ld b,a
	call rle_decompressor_c_sub_step_whole_byte
rle_decompressor_c_finish_size_read:
    call rle_decompressor_c_sub_read_byte
    bit RLE_STATUS_BACKGROUND_COLLISION_bp,c
    jr z,rle_decompressor_c_double_loop
    call rle_div_a_4
    add a,'0'
rle_decompressor_c_double_loop:
	ld (de),a
	inc de
	djnz rle_decompressor_c_double_loop
	call rle_decompressor_c_sub_step_half_byte
	jr rle_decompressor_c_loop
rle_decompressor_c_single:
    bit RLE_STATUS_BACKGROUND_COLLISION_bp,c
    jr z,rle_decompressor_c_single_skip_shift
    call rle_div_a_4
    add a,'0'
rle_decompressor_c_single_skip_shift:
	ld (de),a
    call rle_decompressor_c_sub_step_half_byte
	inc de
	jr rle_decompressor_c_loop
rle_decompressor_c_set_double:
	res RLE_STATUS_COMPRESSION_MODE_bp,c
	call rle_decompressor_c_sub_step_whole_byte
	jr rle_decompressor_c_loop
rle_decompressor_c_set_single:
	set RLE_STATUS_COMPRESSION_MODE_bp,c
	call rle_decompressor_c_sub_step_whole_byte
	jr rle_decompressor_c_loop
rle_decompressor_c_overflow_exit:
	pop hl
rle_decompressor_c_exit:
	pop bc
	pop de
	ret

rle_decompressor_c_sub_step_whole_byte:
    call rle_decompressor_c_sub_step_half_byte
    bit RLE_STATUS_BACKGROUND_COLLISION_bp,c
    ret z ;just run half_byte once if in background mode to increment hl and leave
    call rle_decompressor_c_sub_step_half_byte
    ret

rle_decompressor_c_sub_step_half_byte:
    bit RLE_STATUS_BACKGROUND_COLLISION_bp,c
    jr z,rle_decompressor_c_sub_step_half_byte_background ;just increment hl and leave if in background mode
    bit RLE_STATUS_NIBBLE_OFFSET_bp,c
    jr z,rle_decompressor_c_sub_step_half_byte_set
    res RLE_STATUS_NIBBLE_OFFSET_bp,c
    inc hl
    jr rle_decompressor_c_sub_step_half_byte_exit
rle_decompressor_c_sub_step_half_byte_set:
    set RLE_STATUS_NIBBLE_OFFSET_bp,c
    jr rle_decompressor_c_sub_step_half_byte_exit
rle_decompressor_c_sub_step_half_byte_background:
    inc hl
rle_decompressor_c_sub_step_half_byte_exit:
    ret

rle_decompressor_c_sub_read_byte:
    push bc
    ld a,(hl)
    bit RLE_STATUS_BACKGROUND_COLLISION_bp,c
    jr z,rle_decompressor_c_sub_read_byte_load_shift_skip ;leave if we're in background mode as we only need (hl)
    bit RLE_STATUS_NIBBLE_OFFSET_bp,c
    jr z,rle_decompressor_c_sub_read_byte_load_shift_skip
rle_decompressor_c_sub_read_byte_load_shift:
    inc hl
    ld b,(hl)
    dec hl
    sla b
    rl a
    sla b
    rl a
    sla b
    rl a
    sla b
    rl a
rle_decompressor_c_sub_read_byte_load_shift_skip:
    pop bc
    ret

rle_div_a_4:
    srl a
    srl a
    srl a
    srl a
    ret