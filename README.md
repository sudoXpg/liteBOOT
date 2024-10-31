Here's a comprehensive `README.md` file for your GitHub repository, including a section for the Makefile:

```markdown
# LITEBOOT Bootloader

LITEBOOT is a simple bootloader written in 16-bit assembly language, designed to run on x86 architecture. It serves as a demonstration of basic bootloader functionality, including message display and hardware interrupt handling.

## Features

- **Message Display**: Outputs a welcome message to the screen.
- **Interrupt Handling**: Enables and disables hardware interrupts.
- **Segment Initialization**: Sets up data and stack segments for execution.

## Code Overview

The bootloader is structured as follows:

1. **Entry Point**: The `_start` label marks the beginning of the bootloader execution.
2. **Main Function**: Initializes CPU registers and segments, clears interrupts, and calls the print function.
3. **Print Function**: Iterates over a null-terminated string and calls the `print_char` function to display each character.
4. **Character Printing**: Uses BIOS interrupt `0x10` to output characters to the screen.

### Code Snippet

Here is a snippet of the main components of the bootloader:

```assembly
org 0h                                   ; Set origin to 0x0000 (start of memory)
bits 16                                  ; Indicate that we're working in 16-bit mode

_start:                                  ; Entry point of the bootloader
    jmp main                             ; Jump to the main function to start execution

main:
    cli                                  ; Clear interrupts (disable hardware interrupts)
    mov ax, 0x7C0                        ; Load the segment value (0x7C0) into AX register
    mov ds, ax                           ; Set the Data Segment (DS) to the value in AX
    mov es, ax                           ; Set the Extra Segment (ES) to the same value
    mov ax, 0x0                          ; Clear AX register
    mov ss, ax                           ; Set the Stack Segment (SS) to 0
    mov sp, 0x7C00                       ; Initialize the Stack Pointer (SP) to 0x7C00
    sti                                  ; Set interrupts (enable hardware interrupts)
    mov si, hello_message                ; Load the address of the hello_message
    call print                           ; Call the print function to output the message
    jmp $                                ; Infinite loop to stay in the bootloader

print:                                   ; Function to print a null-terminated string
    ; ...
```

## Makefile

The project includes a `Makefile` to automate the build process. It compiles the bootloader and runs it in a QEMU emulator.

### Makefile Contents

```makefile
all:
	nasm -f bin ./boot.asm -o ./boot.bin
	qemu-system-x86_64 -hda ./boot.bin

clean:
	rm boot.bin
```

### How to Build and Run

### Prerequisites

- An assembler (e.g., NASM) for compiling the assembly code.
- A virtual machine or emulator (e.g., QEMU or Bochs) to run the bootloader.

### Compilation and Execution

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/yourusername/liteboot.git
   cd liteboot
   ```

2. **Build the Bootloader**:
   ```bash
   make
   ```
4. **Clean Up**:
   To remove the compiled binary, run:
   ```bash
   make clean
   ```

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Inspired by educational resources on x86 assembly programming.
- Special thanks to the open-source community for providing tools and documentation.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any enhancements or bug fixes.

## Contact

For inquiries or feedback, please contact [sudoXpg](sudoxpg@gmail.com).
