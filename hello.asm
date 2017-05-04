        global  _start

section .bss
        buffer: resb 10000

section .text

        ; print a byte to stdout
        ; param rcx -> byte to print
_print_byte:
        push    rsi
        push    rdi
        push    rcx                     ; push byte to stack
        mov     rsi, rsp                ; adress to stack
        mov     rax, 1                  ; system call 1 is write
        mov     rdi, 1                  ; file fandle 1 is stdout
        mov     rdx, 1                  ; number of bytes to print
        syscall                         ; call OS system call
        pop     rcx
        pop     rdi
        pop     rsi
        ret


        ; read a byte from stdin
        ; ret rcx <- byte readed from stdin
_read_byte:
        push    rsi
        push    rdi
        sub     rsp, 8                  ; grow stack
        mov     rsi, rsp                ; buf address
        mov     rdi, 0                  ; file handler 0 is stdin
        mov     rax, 0                  ; syscall 0 is read
        mov     rdx, 1                  ; number of bytes
        syscall                         ; call OS system call
        pop     rcx
        pop     rdi
        pop     rsi
        ret


_start:
        mov      r9,  buffer
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        jmp      _loop0
_cloop0:
        add      r9,   8
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        add      r9,   8
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        add      r9,   8
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        add      r9,   8
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        sub      r9,   8
        sub      r9,   8
        sub      r9,   8
        sub      r9,   8
        mov byte r10b, [r9]
        sub      r10b, 1
        mov byte [r9], r10b
_loop0:
        mov byte cl, [r9]
        cmp      cl,  0
        jne      _cloop0
        add      r9,   8
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov cl,  [r9]
        call     _print_byte
        add      r9,   8
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov cl,  [r9]
        call     _print_byte
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov cl,  [r9]
        call     _print_byte
        mov cl,  [r9]
        call     _print_byte
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov cl,  [r9]
        call     _print_byte
        add      r9,   8
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov cl,  [r9]
        call     _print_byte
        sub      r9,   8
        sub      r9,   8
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov cl,  [r9]
        call     _print_byte
        add      r9,   8
        mov cl,  [r9]
        call     _print_byte
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov cl,  [r9]
        call     _print_byte
        mov byte r10b, [r9]
        sub      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        sub      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        sub      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        sub      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        sub      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        sub      r10b, 1
        mov byte [r9], r10b
        mov cl,  [r9]
        call     _print_byte
        mov byte r10b, [r9]
        sub      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        sub      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        sub      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        sub      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        sub      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        sub      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        sub      r10b, 1
        mov byte [r9], r10b
        mov byte r10b, [r9]
        sub      r10b, 1
        mov byte [r9], r10b
        mov cl,  [r9]
        call     _print_byte
        add      r9,   8
        mov byte r10b, [r9]
        add      r10b, 1
        mov byte [r9], r10b
        mov cl,  [r9]
        call     _print_byte
        add      r9,   8
        mov cl,  [r9]
        call     _print_byte

        ; exit(0)
        mov      eax, 60                 ; system call 60 is exit
        xor      rdi, rdi                ; exit code 0
        syscall                         ; invoke operating system to exit
