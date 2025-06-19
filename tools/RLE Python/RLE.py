#Author: Phoenix Cushman (Diet-Gameboy on GitHub)
#File Name RLE.py
#Date Created: 5/15/2025 5:50pm
#Last Modified: 6/12/2025
#Description: This python script takes in the assembly source code version of the level backgrounds
#   from the MCGuffin game and uses the RLE algorithm to compress them for use by the rle_decompressor
#   subroutine in the MCGuffin program. It outputs both source code and bin file equivalents.

def main():

    print("+--------------------------------------------------------+")
    print("| Level Background Run Length Encoder (RLE) for MCGuffin |")
    print("| By: Phoenix Cushman                                    |")
    print("+--------------------------------------------------------+")

    #read file
    read_data = file_to_string()

    #parse data string
    parsed_data = parse_string_to_data(read_data)

    #RLE
    compressed_data = rle_compress_data(parsed_data)

    #optimize
    optimized_data = rle_optimize_data(compressed_data)

    #export
    export_to_asm(optimized_data)
    export_to_bin(optimized_data)

    #print statistics
    print("+----------------------------------------------")
    print(f"|Starting Size: {len(parsed_data)}")
    print(f"|Compressed size: {len(optimized_data)}")
    print(f"|Bytes saved: {len(parsed_data) - len(optimized_data)}")
    if (len(parsed_data) == 0):
        print(f"|Compression Ratio: 100%")
    else:
        print(f"|Compression Ratio: {100 * (len(optimized_data) / len(parsed_data))}%")
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
            #Handle commas between pieces of data
            elif (read_data[i] == ","):
                print("{,}",end="")
                i += 1
            #Handle decimal values
            elif ('0' <= read_data[i] and read_data[i] <= '9'):
                print("{dec:}",end="")
                temp_num_string = ""
                while(i < len(read_data) and '0' <= read_data[i] and read_data[i] <= '9'):
                    temp_num_string += read_data[i]
                    i += 1
                chr_from_stoi = chr(int(temp_num_string))
                data_list += chr_from_stoi
                print(f"{temp_num_string}",end="")
                #print(f"{temp_num_string}='",end="")
                #print(chr_from_stoi,end="")
                #print("'",end="")
            #Handle hexadecimal values
            elif (read_data[i] == '$'):
                i += 1
                print("{hex:}",end="")
                temp_num_string = ""
                while(i < len(read_data) and (('0' <= read_data[i] and read_data[i] <= '9') or ('A' <= read_data[i] and read_data[i] <= 'F') or ('a' <= read_data[i] and read_data[i] <= 'f'))):
                    temp_num_string += read_data[i]
                    i += 1
                chr_from_stoi = chr(int(temp_num_string, 16))
                data_list += chr_from_stoi
                print(f"${temp_num_string}",end="")
                #print(f"${temp_num_string}='",end="")
                #print(chr_from_stoi,end="")
                #print("'",end="")
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

def export_to_asm(optimized_data):

    print("Opening output.txt File...")

    output_file = open("./output.txt","w",encoding="utf-8")

    print("Exporting to output.txt File...")

    i = 0
    cur_mode = 0
    while(i < len(optimized_data)):
        if (optimized_data[i] == '\xFD'):
            cur_mode = 0
            output_file.write("\t.db $FD")
        elif (optimized_data[i] == '\xFE'):
            cur_mode = 1
            output_file.write("\t.db $FE")
        else:
            output_file.write("\t.db ")

            if (cur_mode == 0): #$FD
                output_file.write(str(ord(optimized_data[i])))
                i += 1
                output_file.write(",")

                if (0 <= ord(optimized_data[i]) and ord(optimized_data[i]) < 16):
                    output_file.write(str(ord(optimized_data[i])))
                            
                elif (32 <= ord(optimized_data[i]) and ord(optimized_data[i]) < 127):
                    output_file.write("\"")
                    if (optimized_data[i] == '\\'):
                        output_file.write("\\\\")
                    else:
                        output_file.write(optimized_data[i])
                    output_file.write("\"")

                else:
                    output_file.write("$")
                    output_file.write(str(hex(ord(optimized_data[i])))[2:4].upper())

            else: #$FE

                while(i < len(optimized_data) and optimized_data[i] != '\xFD'):

                    if (0 <= ord(optimized_data[i]) and ord(optimized_data[i]) < 16):
                        output_file.write(str(ord(optimized_data[i])))
                        
                    elif (32 <= ord(optimized_data[i]) and ord(optimized_data[i]) < 127):
                        output_file.write("\"")
                        while(i < len(optimized_data) and 32 <= ord(optimized_data[i]) and ord(optimized_data[i]) < 127):
                            if (optimized_data[i] == '\\'):
                                output_file.write("\\\\")
                            else:
                                output_file.write(optimized_data[i])
                            i += 1
                        output_file.write("\"")
                        i -= 1
                    
                    else:
                        output_file.write("$")
                        output_file.write(str(hex(ord(optimized_data[i])))[2:4].upper())

                    i += 1
                    if (i < len(optimized_data) and optimized_data[i] != '\xFD'):
                        output_file.write(",")
                i -= 1

        output_file.write("\n")
        i += 1
    output_file.write("\t.db $FF")
    output_file.close()

    print("Export Complete...")

    return


def export_to_bin(optimized_data):

    print("Opening output.bin File...")

    output_file = open("./output.bin","wb")

    print("Exporting to output.bin File...")

    for b in optimized_data:
        output_file.write(ord(b).to_bytes(1))
    output_file.write(ord('\xFF').to_bytes(1))
    output_file.close()

    print("Export Complete...")

    return

if __name__ == "__main__":
    main()