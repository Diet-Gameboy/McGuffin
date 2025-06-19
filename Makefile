#Author: Phoenix Cushman (Diet-Gameboy on GitHub)
#Makefile for the McGuffin Game and other programs
AS=spasm64.exe#assembler exe name
ASFLAGS=-I "./inc" -T

mcguffin:
	@echo "------MCGuffin-App-------"
	@echo "Starting Assembly..."
	@echo "|"
	./asm/$(AS) -I "./src/mcguffin" $(ASFLAGS) "./src/mcguffin/main.asm" "./build/mcguffin.8xk"
	@echo "|"
	@echo "Assembly Done"

level_viewer:
	@echo "------Level-Viewer-App-------"
	@echo "Starting Assembly..."
	@echo "|"
	./asm/$(AS) -I "./src/level_viewer" $(ASFLAGS) "./src/level_viewer/main.asm" "./build/level_app.8xk"
	@echo "|"
	@echo "Assembly Done"

clock_demo:
	@echo "-------Clock-Demo-App--------"
	@echo "Starting Assembly..."
	@echo "|"
	./asm/$(AS) -I "./src/clock_demo" $(ASFLAGS) "./src/clock_demo/main.asm" "./build/clock_app.8xk"
	@echo "|"
	@echo "Assembly Done"

all: mcguffin level_viewer clock_demo