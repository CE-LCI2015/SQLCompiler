%{
void yyerror (char *s);
#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>
#include "xml.h"
#define YYDEBUG 0 // Ojo desactivar
#define true  1
#define false 0

List cols;
char* currentTable;
void addTable(char* name);
struct column* createColumn(char* name, char* type, int required, char* defaultValue);

%}



%union {char* txt ; char* type;}        /* Yacc definitions */
%start db
%token create
%token <type> datatype
%token <txt> text
%token notnull
%token null
%token withdefault




%%


db 			: table {;}
			| db table {;}
table : create text '(' columns ')' ';' {addTable($2);}
;

columns      : column                     {;}
            | column ',' columns          {;}
;


column      : text datatype notnull   {cols.add(createColumn($1,$2,true,NULL));}
            | text datatype null      {cols.add(createColumn($1,$2,false,NULL));}
            | text datatype withdefault text {cols.add(createColumn($1,$2,false,$4));}
;


%%                     /* C code */

int main (void) {
#if YYDEBUG
        yydebug = 1;
#endif
	if(! yyparse ( ))
	{
        //Agregar ultima tabla
        create(currentTable, cols)

	}
	else {return 1;}
}

void addTable(char* name)
{
    if(currentTable) //if it's not the first table
    {
        create(currentTable, cols)
    }
    currentTable = malloc(sizeof(char) * strlen(name));
    strcpy(currentTable,name);

}
struct column* createColumn(char* name, char* type, int required, char* defaultValue) {
    struct column* col = malloc(sizeof(struct column));
    col->name=(xmlChar*)name;
    col->type=(xmlChar*)type;
    col->required=(xmlChar*)required;
    col->defaultValue=(xmlChar*)defaultValue;
    return col;
}
void yyerror (char *s) 
{
	fprintf (stderr, "%s\n", s);
} 
