#Author: Phoenix Cushman (Diet-Gameboy on GitHub)
#File Name RLE_C.py
#Date Created: 6/12/2025 7:25pm
#Last Modified: 6/12/2025
#Description: This python script takes in the assembly source code version of the level collision masks
#   from the MCGuffin game and uses the RLE algorithm to compress them for use by the rle_decompressor_collision
#   subroutine in the MCGuffin program. It outputs both source code and bin file equivalents. It also compresses
#   the original source data from whole byte ascii representations of the data into nibble sized collision
#   codes to reduce the overall footprint of the data.

def main():

    print("+-------------------------------------------------------+")
    print("| Level Collision Run Length Encoder (RLE) for MCGuffin |")
    print("| By: Phoenix Cushman                                   |")
    print("+-------------------------------------------------------+")

    #read file
    read_data = file_to_string()

    #parse data string
    parsed_data = parse_string_to_data(read_data)

    #RLE
    compressed_data = rle_compress_data(parsed_data)

    #optimize
    optimized_data = rle_optimize_data(compressed_data)

    #bitstream
    bitstring = bytes_to_bitstring(optimized_data)

    #export
    export_to_asm(bitstring)
    export_to_bin(bitstring)

    #print statistics
    print("+----------------------------------------------")
    print(f"|Starting Size (bytes): {len(parsed_data)}")
    print(f"|Compressed size (bytes): {len(optimized_data)}")
    print(f"|Bitstring size (bytes): {len(bitstring) // 8}")
    print(f"|Bytes saved: {len(parsed_data) - (len(bitstring) // 8)}")
    if (len(parsed_data) == 0):
        print(f"|Compression Ratio: 100%")
    else:
        print(f"|Compression Ratio: {100 * ((len(bitstring) // 8) / len(parsed_data))}%")
    print("+----------------------------------------------")

    print("Done!")
    #input("Press Any Key To Exit...")

    return

########################################
# Program Functions Below
########################################

def file_to_string():
    read_data = ""

    print("Opening input.txt File...")
    input_file = open("input.txt",'r',encoding="utf-8")
    print("File opened...")

    print("Reading File...")
    read_data = input_file.read()
    print(read_data)

    return read_data

def parse_string_to_data(read_data):

    data_list = list([])

    print("Parsing Data...")

    i = 0
    while(i < len(read_data)):
        while(i < len(read_data) and read_data[i:i+5] != '\t.db '):
            #Handle Line Comments
            if (read_data[i] == ';'):
                print("{comment}",end="")
                while(i < len(read_data) and read_data[i] != '\n'):
                    print(read_data[i],end="")
                    i += 1
                print("{/comment}",end="")
                print("{\\n}")
            #Default iteration to keep going
            i += 1
        i += 5 #skip the "\t.db "
        while(i < len(read_data) and read_data[i] != '\n'):
            #Handle ASCII strings
            if (read_data[i] == '"'):
                print("{\"}",end="")
                i += 1
                while(i < len(read_data) and read_data[i] != '"'):
                    data_list += [read_data[i]]
                    print(read_data[i],end="")
                    i += 1
                i += 1
                print("{\"}",end="")
            #Handle Comments
            elif (read_data[i] == ";"):
                print("{comment}",end="")
                while(i < len(read_data) and read_data[i] != '\n'):
                    print(read_data[i],end="")
                    i += 1
                print("{/comment}",end="")
            #Default iteration to keep going
            else:
                i += 1
        #End of line
        print("{\\n}")
                
    print("Printing Parsed Data...")
    print(data_list)

    return data_list

def rle_compress_data(data_list):

    rle_data = list([])

    print("Compressing Data (RLE)...")

    i = 0
    count = 1
    while(i < len(data_list)):
        curr_value = data_list[i]
        while(i < len(data_list)-1 and curr_value == data_list[i+1]):
            count += 1
            i += 1
        rle_data += [chr(count)]
        rle_data += [curr_value]
        count = 1
        i += 1

    print("Printing Compressed Data...")
    print(rle_data)

    return rle_data

def rle_optimize_data(rle_data):

    opt_data = list([])

    print("Optimizing RLE Data...")

    cur_mode = 0
    i = 0
    while (i < len(rle_data)):
        if (i + 2 < len(rle_data) and cur_mode == 0): #$FD
            if (rle_data[i] == '\x01' and rle_data[i + 2] == '\x01'):
                cur_mode = 1 #$FE
                opt_data += ['\xFE']
        if (cur_mode == 1): #$FE
            if (ord(rle_data[i]) > 2):
                cur_mode = 0 #$FD
                opt_data += ['\xFD']

        if (cur_mode == 1): #$FE
            j = 0
            while(j < ord(rle_data[i])):
                opt_data += [rle_data[i+1]]
                j += 1

        if (cur_mode == 0): #$FD
            opt_data += [rle_data[i]]
            opt_data += [rle_data[i+1]]

        i += 2

    print("Printing Optimized Data...")
    print("[",end="")
    for i in range(0,len(opt_data)-1):
        print(f"{opt_data[i:i+1]}={hex(ord(opt_data[i]))}",end=", ")
    if (len(opt_data) > 1):
        print(f"{opt_data[-1:]}={hex(ord(opt_data[-1]))}",end="")
    print("]")

    return opt_data

def bytes_to_bitstring(optimized_data):

    print("Converting Data to Optimized Bitstring...")

    bitstring_list = list([])
    i = 0
    cur_mode = 0
    while(i < len(optimized_data)):
        if (optimized_data[i] == '\xFD'):
            bitstring_list += ["11111101"]
            cur_mode = 0
        elif (optimized_data[i] == '\xFE'):
            bitstring_list += ["11111110"]
            cur_mode = 1
        else:
            if (cur_mode == 0):
                if (ord(optimized_data[i]) >= 125):
                    bitstring_list += ["1" + format(125 & 0x7F, '07b')]
                    bitstring_list += [format(ord(optimized_data[i+1]) & 0xF, '04b')]
                    
                    if ((ord(optimized_data[i]) - 125) >= 8):
                        bitstring_list += ["1" + format((ord(optimized_data[i]) - 125) & 0x7F, '07b')]
                    else:
                        bitstring_list += [format((ord(optimized_data[i]) - 125) & 0x7, '04b')]

                elif (ord(optimized_data[i]) >= 8):
                    bitstring_list += ["1" + format(ord(optimized_data[i]) & 0x7F, '07b')]
                else:
                    bitstring_list += [format(ord(optimized_data[i]) & 0x7, '04b')]
                i += 1
                bitstring_list += [format(ord(optimized_data[i]) & 0xF, '04b')]
            else:
                bitstring_list += [format(ord(optimized_data[i]) & 0xF, '04b')]

        i += 1
    bitstring_list += ["11111111"]

    bitstring_final = ""

    for bitstring in bitstring_list:
        bitstring_final += bitstring

    if ((len(bitstring_final) % 8) != 0):
        bitstring_final += "0000"

    print("Printing Final Bitstring...")
    print(bitstring_final)

    return bitstring_final
    

def export_to_asm(bitstring):

    print("Opening output.txt File...")

    output_file = open("./output.txt","w",encoding="utf-8")

    print("Exporting to output.txt File...")

    i = 0
    while(i < len(bitstring)):
        output_file.write(f"\t.db %{bitstring[i:i+8]}")
        i += 8
        if (i < (len(bitstring))):
            output_file.write(f",%{bitstring[i:i+8]}")
            i += 8
        if (i < (len(bitstring))):
            output_file.write(f",%{bitstring[i:i+8]}")
            i += 8
        if (i < (len(bitstring))):
            output_file.write("\n")

    output_file.close()

    print("Export Complete...")

    return


def export_to_bin(bitstring):

    print("Opening output.bin File...")

    output_file = open("./output.bin","wb")

    print("Exporting to output.bin File...")

    i = 0
    while(i < len(bitstring)):
        output_file.write(int(str(bitstring[i:i+8]), 2).to_bytes(1, byteorder='big'))
        i += 8

    output_file.close()

    print("Export Complete...")

    return

if __name__ == "__main__":
    main()