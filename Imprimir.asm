section .data
    hello db "El número es: ", 0
    len equ $ - hello
    num db "0x2A",0

section .text
global _start

_start:
    ; Imprimir el mensaje "El número es: "
    mov rax, 1                  ; Código de la syscall para escribir (4)
    mov rdi, 1                  ; Descriptor de archivo estándar de salida (1)
    mov rsi, hello              ; Dirección del mensaje
    mov rdx, len                ; Longitud del mensaje
    syscall                     ; Llamar a la syscall

    ; Imprimir el número
    mov rax, 1                  ; Código de la syscall para escribir (1)
    mov rdi, 1                  ; Descriptor de archivo estándar de salida (1)
    mov rsi, num                ; Dirección del número
    mov rdx, 5                  ; Longitud del número (2 bytes)
    syscall                     ; Llamar a la syscall

    ; Salir del programa
    mov rax, 60                 ; Código de la syscall para salir del programa (60)
    xor rdi, rdi                ; Código de salida (0)
    syscall                     ; Llamar a la syscall