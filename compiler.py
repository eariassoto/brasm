# -----------------------------------------------------------------------------
# Compiler.py
#
# This program takes a brainfuck program an compiles it to x64 Assembly code.
# The compiler needs a assembly template and a dictionary of "compiled"
# instructions.
# -----------------------------------------------------------------------------

###        This is the code for the brainfuck -> assembly compiler           ###

instr_spacing = 8 * ' '
asm_instr = {'>': instr_spacing + 'add      r9,   8\n',
             '<': instr_spacing + 'sub      r9,   8\n',
             '+': instr_spacing + 'mov byte r10b, [r9]\n' +
                  instr_spacing + 'add      r10b, 1\n' +
                  instr_spacing + 'mov byte [r9], r10b\n',
             '-': instr_spacing + 'mov byte r10b, [r9]\n' +
                  instr_spacing + 'sub      r10b, 1\n' +
                  instr_spacing + 'mov byte [r9], r10b\n',
             '.': instr_spacing + 'mov cl,  [r9]\n' +
                  instr_spacing + 'call     _print_byte\n',
             ',': instr_spacing + 'call     _read_byte\n' +
                  instr_spacing + 'mov byte [r9], cl\n'}

loop_instr = (instr_spacing + 'jmp      _loop{0}\n' +
              '_cloop{0}:\n' +
              '[placeholder]' +
              '_loop{0}:\n' +
              instr_spacing + 'mov byte cl, [r9]\n' +
              instr_spacing + 'cmp      cl,  0\n' +
              instr_spacing + 'jne      _cloop{0}\n')

# constants
INSTR_OBJ_PROP_TYPE = 'type'
INSTR_OBJ_PROP_PAYLOAD = 'payload'

BF_INSTR_TYPE_LOOP = 'loop'
BF_INSTR_TYPE_OP = 'op'
BF_INSTR_TYPE_LOOP = 'loop'

TEMPLATE_PLACEHOLDER = '[placeholder]'
TEMPLATE_FILENAME = 'template.asm'

COMPILED_FILENAME = 'a'

# global variables
global_loop_count = 0
global_compiled_filename = COMPILED_FILENAME


def make_instruction_action(type, payload):
    """ Wraps the instruction content into a struct """
    obj = {}
    obj[INSTR_OBJ_PROP_TYPE] = type
    obj[INSTR_OBJ_PROP_PAYLOAD] = payload
    return obj


def get_loop_body(instr_body):
    """ Created a new loop with unique tags

    A loops in assembly code needs two unique tags, one to inmediatedly jump
    to the condition and another to jump to its body. A global variable is used
    to give a index to the tags.
    """
    global global_loop_count
    loop_body = loop_instr.format(global_loop_count)
    global_loop_count = global_loop_count + 1
    return loop_body.replace(TEMPLATE_PLACEHOLDER, instr_body)


def get_program_instr(list_expr):
    """ Transforms a list of brainfuck instructions to assembly code """
    program_str = '';
    for e in list_expr:
        if e[INSTR_OBJ_PROP_TYPE] == BF_INSTR_TYPE_OP:
            program_str += asm_instr[e[INSTR_OBJ_PROP_PAYLOAD]]
        elif e[INSTR_OBJ_PROP_TYPE] == BF_INSTR_TYPE_LOOP:
            program_str += get_loop_body(get_program_instr(e[INSTR_OBJ_PROP_PAYLOAD]))
    return program_str


def compile_program(list_expr):
    """ Parse the processed brainfuck program into assembly code

    This function takes the parsed program, transforms it into assembly code
    and write the assembly program to a file.
    """
    try:
        program_str = get_program_instr(list_expr)
        f = open(TEMPLATE_FILENAME, 'r')
        out = open('%s.asm' % global_compiled_filename, 'w')
        template = f.read()
        final_program = template.replace(TEMPLATE_PLACEHOLDER, program_str)
        out.write(final_program)
        out.close()
        f.close()
    except IOError:
        sys.exit('Error trying to output assembly file!')

###              This is the code for the LEX-YACC parser                    ###

tokens = (
    'INCR_PTR',
    'DECR_PTR',
    'INCR_VAL',
    'DECR_VAL',
    'WRITE',
    'READ',
    'LB',
    'RB'
)


# Tokens
t_INCR_PTR = r'\>'
t_DECR_PTR = r'\<'
t_INCR_VAL = r'\+'
t_DECR_VAL = r'\-'
t_WRITE    = r'\.'
t_READ     = r'\,'
t_LB       = r'\['
t_RB       = r'\]'


# Ignored characters
t_ignore = " \t"


def t_newline(t):
    r'\n+'
    t.lexer.lineno += t.value.count("\n")


def t_error(t):
    """ Ignore all other characters """
    t.lexer.skip(1)


# Build the lexer
import ply.lex as lex
lex.lex()


def p_program(p):
    ''' program : instructions '''
    global global_success
    compile_program(p[1])
    global_success = True


def p_instructions(p):
    ''' instructions : simpleInstruction
    | loop_instruction
    '''
    p[0] = p[1]


def p_instructions_expansion(p):
    ''' instructions : simpleInstruction instructions
    | loop_instruction instructions
    '''
    p[0] = p[1] + p[2]


def p_loop_instruction(p):
    ''' loop_instruction : LB instructions RB
    '''
    action = make_instruction_action('loop', p[2])
    p[0] = [action]


def p_simple_instruction(p):
    '''simpleInstruction : INCR_PTR
        | DECR_PTR
        | INCR_VAL
        | DECR_VAL
        | WRITE
        | READ
        '''
    action = make_instruction_action('op', p[1])
    p[0] = [action]


def p_error(p):
    if p:
        print("Syntax error at '%s'" % p.value)
    else:
        print("Error, input program empty.")


import ply.yacc as yacc

# Build the parser
yacc.yacc(write_tables=False,debug=False)


import argparse
import sys


def main():
    global global_compiled_filename
    parser = argparse.ArgumentParser()
    parser.add_argument("file", help="brainfuck input file to pe parsed")
    parser.add_argument("-o", help="file name for the output assembly code")
    args = parser.parse_args()
    if args.o:
        global_compiled_filename = args.o
    try:
        f = open(args.file, 'r')
        program_str = f.read()
        f.close()
        result = yacc.parse(program_str)

        if(global_success):
            print("Program compiled. To build the executable run:\
            \n\tnasm -f elf64 {0}.asm && ld {0}.o".format(global_compiled_filename))
    except IOError:
        sys.exit('Error, input file not found!')


if __name__ == "__main__":
    main()
