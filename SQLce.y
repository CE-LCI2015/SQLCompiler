%{
void yyerror (char *s);
#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>
void updateSymbolVal(char symbol, int val);
%}

%union {char[] string, int num, double decimal}         /* Yacc definitions */
%start createTable
%token <num> number
%token <string> string


%%

/* descriptions of expected inputs     corresponding actions (in C) */

createTable   :
        ;

%%                     /* C code */

int main (void) {

	return yyparse ( );
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);}

