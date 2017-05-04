# Brasm
This project is a simple Brainfuck to Assembly compiler. The output assembly program can be build into an executable.
Lex-Yacc is used to parse the brainfuck program. The compiler outputs x64 Intel syntax assembly code.

# Requirements
+ Python
+ PLY module
+ NASM
+ ld

# How to use Brasm
``` bash
$ python compiler.py hello.bf -h
usage: compiler.py [-h] [-o O] file

positional arguments:
  file        brainfuck input file to pe parsed

optional arguments:
  -h, --help  show this help message and exit
  -o O        file name for the output assembly code

$ python compiler.py hello.bf -o hello
$ nasm -f elf64 hello.asm && ld hello.o -o hello
$ ./hello
```
