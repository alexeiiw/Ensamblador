section .data
    hello db 'Hola, Mundo Alex!',0  ; Definir una cadena de caracteres 'Hola, Mundo!' con un byte nulo al final

section .text
global _start

_start:
    ; Escribir la cadena en la salida estándar (en este caso, la consola)
    mov rax, 1            ; Código de la syscall para sys_write (1)
    mov rdi, 1            ; Descriptor de archivo para la salida estándar (1)
    mov rsi, hello        ; Dirección de la cadena a imprimir
    mov rdx, 17           ; Longitud de la cadena (número de bytes)
    syscall              ; Llamar al kernel

    ; Salir del programa
    mov rax, 60           ; Código de la syscall para sys_exit (60)
    xor rdi, rdi          ; Código de retorno (0)
    syscall              ; Llamar al kernel