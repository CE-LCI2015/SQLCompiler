%{
void yyerror (char *s);
#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>
void updateSymbolVal(char symbol, int val);
%}

%union {char[] string, int num, long largeNum, double dec}         /* Yacc definitions */
%start createTable
%token create
%token datatype
%token modifier
%token <num> number
%token <string> string
%token <largeNum> largeNumber
%token <dec> decimal


%%

/* descriptions of expected inputs     corresponding actions (in C) */

createTable : create string '('  ')' tables ';'
;
tables      : table
            | table ',' tables
;
table       : string datatype modifier
%%                     /* C code */

int main (void) {

	return yyparse ( );
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);}

