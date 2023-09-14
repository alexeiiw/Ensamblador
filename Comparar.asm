section .data
    ; Define dos cadenas para la comparación
    str1 db "Hola ", 0
    str2 db "Hola", 0
    igual db "Las cadenas son iguales.", 0
    diferente db "Las cadenas son diferentes.", 0

section .text
global _start

_start:
    ; Comparar las cadenas str1 y str2
    mov rdi, str1    ; RDI apunta a str1
    mov rsi, str2    ; RSI apunta a str2
    call compare_strings

    ; Verificar el resultado de la comparación
    cmp rax, 0       ; Comprobar si rax es igual a 0 (cadenas iguales)
    je cadenas_iguales
    jmp cadenas_diferentes

cadenas_iguales:
    ; Llamar a la función de escritura para mostrar que las cadenas son iguales
    mov rax, 1                  ; Código de la syscall para escribir (1)
    mov rdi, 1                  ; Descriptor de archivo estándar de salida (1)
    lea rsi, [igual]            ; Dirección de la cadena "Las cadenas son iguales."
    mov rdx, 64                 ; Longitud máxima de la cadena (ajusta según sea necesario)
    syscall                     ; Llamar a la syscall para imprimir el resultado
    jmp salir

cadenas_diferentes:
    ; Llamar a la función de escritura para mostrar que las cadenas son diferentes
    mov rax, 1                  ; Código de la syscall para escribir (1)
    mov rdi, 1                  ; Descriptor de archivo estándar de salida (1)
    lea rsi, [diferente]        ; Dirección de la cadena "Las cadenas son diferentes."
    mov rdx, 64                 ; Longitud máxima de la cadena (ajusta según sea necesario)
    syscall                     ; Llamar a la syscall para imprimir el resultado

salir:
    ; Salir del programa
    mov rax, 60                 ; Código de la syscall para salir (60)
    xor rdi, rdi                ; Código de salida (0)
    syscall                     ; Llamar a la syscall para salir

compare_strings:
    ; Esta función compara dos cadenas
    ; Entradas: RDI - Puntero a la primera cadena
    ;           RSI - Puntero a la segunda cadena
    ; Salidas:  RAX - Resultado de la comparación (0 si son iguales, otro valor si son diferentes)

    push rbx
    push rcx

    xor rax, rax                ; Inicializar rax en 0 (cadenas iguales)
    xor rcx, rcx                ; Inicializar rcx en 0 (índice del carácter actual)

comparar_bucles:
    mov al, byte [rdi + rcx]   ; Cargar el byte de la primera cadena en AL
    cmp al, byte [rsi + rcx]   ; Comparar con el byte correspondiente de la segunda cadena
    jne cadenas_diferentes      ; Si son diferentes, saltar a "cadenas_diferentes"
    cmp al, 0                   ; Comprobar si se alcanzó el final de la cadena (byte nulo)
    je fin_comparacion          ; Si se alcanzó el final de ambas cadenas, salir del bucle
    inc rcx                     ; Avanzar al siguiente carácter
    jmp comparar_bucles         ; Continuar comparando

fin_comparacion:
    ; Comparar las longitudes de las cadenas
    mov al, byte [rdi + rcx]   ; Cargar el byte siguiente de la primera cadena en AL
    cmp al, byte [rsi + rcx]   ; Comparar con el byte siguiente de la segunda cadena
    je igual_longitud           ; Si son iguales, las cadenas tienen la misma longitud
    jmp cadenas_diferentes      ; Si son diferentes, saltar a "cadenas_diferentes"

igual_longitud:
    xor rax, rax                ; Las cadenas tienen la misma longitud, establecer rax en 0 (cadenas iguales)

    pop rcx
    pop rbx
    ret