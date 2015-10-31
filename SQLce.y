%{
void yyerror (char *s);
#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>
//#include "xml.h"
#define YYDEBUG 1 // Ojo desactivar
#define INTEGER 1
#define BOOLEAN 2

int numberOfTables;

%}

%union {char* txt ; int type;}        /* Yacc definitions */
%start createTable
%token create
%token <type> integer
%token <type> boolean
%token <txt> text
%token notnull
%token null
%token withdefault
%token <txt> text
%type <type> datatype


%%

/* descriptions of expected inputs     corresponding actions (in C) */

createTable : create text '(' tables ')' ';'
;
tables      : table                     {TRACE printf("new table");}
            | table ',' tables          {TRACE printf("new table comma");}
;
table       : text datatype notnull   {TRACE printf("new notnull table");}
            | text datatype null      {TRACE printf("new null table");}
            | text datatype withdefault text     {TRACE printf("integer table");}
;
datatype    : integer      {TRACE ;}// {$$ = datatypes.INTEGER;}
            | boolean     {TRACE ;}// {$$ = datatypes.BOOLEAN;}
%%                     /* C code */

int main (void) {
#if YYDEBUG
        yydebug = 1;
#endif
    numberOfTables = 0;

	return yyparse ( );
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 


