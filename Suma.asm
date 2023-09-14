section .data
    ; Define los números que deseas sumar
    num1 dq 50
    num2 dq 20
    resultado db "El resultado es: ", 0

section .text
global _start

_start:
    ; Cargar num1 en RAX
    mov rax, [num1]

    ; Sumar num2 a RAX
    add rax, [num2]

    ; Convertir el resultado a una cadena
    mov rdi, rax
    mov rsi, resultado
    call int_to_str

    ; Llamar a la función de escritura para mostrar el resultado
    mov rax, 1                  ; Código de la syscall para escribir (1)
    mov rdi, 1                  ; Descriptor de archivo estándar de salida (1)
    lea rsi, [resultado]        ; Dirección de la cadena resultante
    mov rdx, 64                 ; Longitud máxima de la cadena (ajusta según sea necesario)
    syscall                     ; Llamar a la syscall para imprimir el resultado

    ; Salir del programa
    mov rax, 60                 ; Código de la syscall para salir (60)
    xor rdi, rdi                ; Código de salida (0)
    syscall                     ; Llamar a la syscall para salir

int_to_str:
    ; Esta función convierte un número entero en una cadena
    ; Entradas: RDI - Número entero
    ;           RSI - Puntero a la cadena resultante
    ; Salidas:  Ninguna

    push rbx
    push rcx
    push rdx

    mov rcx, 10                 ; Inicializar el contador (número de dígitos)
    mov rbx, 10                 ; Divisor para obtener dígitos (base 10)
    add rsi, 63                 ; Apuntar al último carácter de la cadena (64 - 1)
    mov byte [rsi], 0           ; Terminar la cadena con un carácter nulo

convert_loop:
    dec rsi                     ; Moverse al siguiente carácter en la cadena
    xor rdx, rdx                ; Limpiar DX para la división
    div rbx                     ; Dividir RDI por 10, resultado en RDI, residuo en RDX
    add dl, '0'                 ; Convertir el residuo en un dígito ASCII
    mov [rsi], dl               ; Almacenar el dígito en la cadena

    dec rcx                     ; Decrementar el contador de dígitos
    jnz convert_loop            ; Repetir hasta que se procesen todos los dígitos

    pop rdx
    pop rcx
    pop rbx
    ret