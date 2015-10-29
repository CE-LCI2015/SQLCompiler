%{
void yyerror (char *s);
#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>

struct Table
{
    char*  name;
    char*  datatype;
    bool notnull;
    bool null;
    void* default;
};
int numberOfTables;
struct Table tablesArray[40];
%}

%union {char[] string, int num, bool boolean}         /* Yacc definitions */
%start createTable
%token create
%token int
%token boolean
%token notnull
%token null
%token default
%token <num> number
%token <boolean> boolean


%%

/* descriptions of expected inputs     corresponding actions (in C) */

createTable : create string '(' tables ')' ';'
;
tables      : table
            | table ',' tables
;
table       : string datatype notnull
            | string datatype null
            | string
;
datatype    : int
            | bool
%%                     /* C code */

int main (void) {
    numberOfTables = 0;

	return yyparse ( );
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);}

