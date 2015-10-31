SQLce: lex.yy.c y.tab.c
	gcc -g lex.yy.c y.tab.c -o SQLce

lex.yy.c: y.tab.c SQLce.l
	lex SQLce.l

y.tab.c: SQLce.y
	yacc -d SQLce.y

clean: 
	rm -f lex.yy.c y.tab.c y.tab.h SQLce