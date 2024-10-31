rm -f y.* a.out lex.yy.c
yacc -d *.y
lex -s *.l
cc *.c
