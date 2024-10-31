org 0h                                  ; Set origin to 0x0000 (start of memory)
bits 16                                 ; Indicate that we're working in 16-bit mode

_start:                                 ; Entry point of the bootloader
    jmp main                            ; Jump to the main function to start execution

main:
cli                                     ; Clear interrupts (disable hardware interrupts)
    
    mov ax, 0x7C0                       ; Load the segment value (0x7C0) into AX register
    mov ds, ax                          ; Set the Data Segment (DS) to the value in AX
    mov es, ax                          ; Set the Extra Segment (ES) to the same value (optional for this example)

    mov ax, 0x0                         ; Clear AX register by moving 0 into it
    mov ss, ax                          ; Set the Stack Segment (SS) to 0 (this is usually not ideal)
    mov sp, 0x7C00                      ; Initialize the Stack Pointer (SP) to 0x7C00, the address of the bootloader code

sti                                     ; Set interrupts (enable hardware interrupts)

    mov si, hello_message               ; Load the address of the hello_message into the Source Index (SI) register
    call print                          ; Call the print function to output the message

    jmp $                               ; Infinite loop to prevent the program from falling through (stay in the bootloader)

print:                                  ; Function to print a null-terminated string
    mov bx, 0                           ; Initialize BX register (used for setting the background color)

.loop:                                  ; Loop to read and print each character of the string
    lodsb                               ; Load byte from DS:SI into AL and increment SI
    cmp al, 0                           ; Compare the value in AL with 0 (null terminator)
    je .done                            ; If the null terminator is found, jump to done
    call print_char                     ; Call print_char to display the character in AL
    jmp .loop                           ; Repeat the loop for the next character

.done:                                  ; Label for the end of the print function
    ret                                 ; Return from the print function to the caller

print_char:                             ; Function to print a character in AL to the screen
    mov ah, 0Eh                         ; Set AH to 0Eh (BIOS teletype function for character output)
    int 0x10                            ; Call BIOS interrupt 0x10 to print the character in AL
    ret                                 ; Return from print_char to the caller

hello_message db "Welcome to LITEBOOT!", 0        ; String to display, followed by a null byte (0)

times 510 - ($ - $$) db 0               ; Fill the remaining bytes up to 510 with 0s

dw 0xAA55                               ; Boot signature (0xAA55) indicating this is a bootable sector
