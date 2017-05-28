        global  _start

section .bss
        buffer: resb 10000

section .text

        ; print a byte to stdout
        ; param rcx -> byte to print
_print_byte:
        push    rcx                     ; push byte to stack
        mov     rsi, rsp                ; adress to stack
        mov     rax, 1                  ; system call 1 is write
        mov     rdi, 1                  ; file fandle 1 is stdout
        mov     rdx, 1                  ; number of bytes to print
        syscall                         ; call OS system call
        pop     rcx
        ret


        ; read a byte from stdin
        ; ret rcx <- byte readed from stdin
_read_byte:
        sub     rsp, 8                  ; grow stack
        mov     rsi, rsp                ; buf address
        mov     rdi, 0                  ; file handler 0 is stdin
        mov     rax, 0                  ; syscall 0 is read
        mov     rdx, 1                  ; number of bytes
        syscall                         ; call OS system call
        pop     rcx
        ret


_start:
        mov      r9,  buffer
[placeholder]
        ; exit(0)
        mov      eax, 60                 ; system call 60 is exit
        xor      rdi, rdi                ; exit code 0
        syscall                         ; invoke operating system to exit
