# McGuffin π

Phoenix Cushman's MCGuffin.
Produced from Summer 2020 - Summer 2025.

McGuffin is an adventure game using an ASCII art style. The goal of the game is to explore the world traveling through different zones and collecting items. You use the various items to complete quests with the locals until you recover the sacred McGuffins from the four rulers of the zones. Once all four McGuffins have been collected you win!

# Assembling

To assemble the main mcguffin.8xk file first clone the repository.
Then add an "asm" folder to the main directory with your assembler of choice inside, an empty "build" folder to the main directory, and then tweak the makefile accordingly.
You can then run the makefile to build the application

    make mcguffin
There is also a clock demo and level viewer app which can be assembled like so

    make clock_demo

    make level_viewer
Or you can make all of them in one go
    
    make all

I recommend spasm-ng and have a link below in the resources.

# Acknowledgements

- Special Thanks to Brandon Wilson for the ti83plus.inc include file!

- Special Thanks to the folks at WikiTI for all their amazing documentation and calculator specifications!

- Special Thanks to Spencer Putt and Don Straney for the SPASM-ng Z80 Assembler!

# Recommended Resources

- Z80 CPU Opcode Table [https://clrhome.org/table/](https://clrhome.org/table/)

- WikiTI BCalls [https://wikiti.brandonw.net/index.php?title=Category:83Plus:BCALLs](https://wikiti.brandonw.net/index.php?title=Category:83Plus:BCALLs)

- WikiTI Ports [https://wikiti.brandonw.net/index.php?title=Category:83:Ports](https://wikiti.brandonw.net/index.php?title=Category:83:Ports)

- TI83 Font Map [http://tibasicdev.wikidot.com/83lgfont](http://tibasicdev.wikidot.com/83lgfont)

- Spasm-ng Assembler [https://github.com/alberthdev/spasm-ng.git](https://github.com/alberthdev/spasm-ng.git)

- Cemetech Online IDE [https://www.cemetech.net/sc/](https://www.cemetech.net/sc/)

- Z80 CPU Manual [https://www.zilog.com/docs/z80/ps0178.pdf](https://www.zilog.com/docs/z80/ps0178.pdf)

- TI-83 Plus Developer Guide [https://education.ti.com/html/eguides/discontinued/computer-software/EN/SDK-TI-83-Developer-Guide_EN.pdf](https://education.ti.com/html/eguides/discontinued/computer-software/EN/SDK-TI-83-Developer-Guide_EN.pdf)

- Wabbitemu TI Emulator [http://wabbitemu.org](http://wabbitemu.org)

# Copyright/License

This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.

[![License: CC BY-NC-SA 4.0](https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-sa/4.0/)
