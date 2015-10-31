%{
void yyerror (char *s);
#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>
//#include "xml.h"
typedef enum {INTEGER, BOOLEAN} datatypes;
struct Table
{
    char*  name;
    datatypes  type;
    bool notnull;
    void* default;
}tablestruct;
int numberOfTables;
struct Table tablesArray[40];
%}

%union {char[] text, int num, bool b, datatypes d, tablestruct t}         /* Yacc definitions */
%start createTable
%token create
%token <d> integer
%token <d> boolean
%token notnull
%token null
%token withdefault
%token <num> number
%token <string> text
%type <d> datatype
%type <t> table

%%

/* descriptions of expected inputs     corresponding actions (in C) */

createTable : create text '(' tables ')' ';'
;
tables      : table                     {printf("new table");}
            | table ',' tables          {printf("new table comma");}
;
table       : text datatype notnull   {printf("new notnull table");}
            | text datatype null      {printf("new null table");}
            | text integer withdefault number     {printf("integer table");}
            | text boolean withdefault boolean    {printf("new boolean table");}
;
datatype    : integer       {$$ = datatypes.INTEGER;}
            | boolean      {$$ = datatypes.BOOLEAN;}
%%                     /* C code */

int main (void) {
    numberOfTables = 0;

	return yyparse ( );
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);}

tablestruct createTable(char* name, datatypes type, boolean notnull, boolean default, int data)
{
    tablestruct table;
    table.name  = name; table.type = type; table.null = notnull;
    if(default)
    {table.default = malloc(sizeof(int));
        *(table.default) = data;}
    else{table.default = NULL;}
}
tablestruct createTable(char* name, datatypes type, boolean notnull, boolean default, boolean data)
{
    tablestruct table;
    table.name  = name; table.type = type; table.null = notnull;
    if(default)
    {table.default = malloc(sizeof(bool));
        *(table.default) = data;}
    else{table.default = NULL;}
}
