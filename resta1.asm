section .data
    resultado db 0

section .text
global _start

_start:
    ; Cargar 20 en eax y 8 en ebx
    mov eax, 20
    mov ebx, 8

    ; Restar ebx (8) de eax (20)
    sub eax, ebx

    ; Guardar el resultado en la variable resultado
    mov [resultado], al

    ; Mostrar el resultado en la consola (int 0x80)
    mov eax, 4           ; Código de la syscall para sys_write (4)
    mov ebx, 1           ; Descriptor de archivo para la salida estándar (1)
    lea ecx, [resultado] ; Puntero al resultado
    mov edx, 1           ; Longitud del resultado (1 byte)
    int 0x80

    ; Mostrar un salto de línea
    mov eax, 4           ; Código de la syscall para sys_write (4)
    lea ecx, [newline]   ; Puntero a una cadena de nueva línea
    mov edx, 1           ; Longitud de la cadena (1 byte)
    int 0x80

    ; Salir del programa (int 0x80)
    mov eax, 1           ; Código de la syscall para sys_exit (1)
    xor ebx, ebx         ; Código de retorno (0)
    int 0x80

section .data
    newline db 10        ; Carácter de nueva línea ('\n')