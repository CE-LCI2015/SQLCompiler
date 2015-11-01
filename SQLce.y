%{
void yyerror (char *s);
#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>
#include "xml.h"
#define YYDEBUG 0 // Ojo desactivar
#define true  1
#define false 0

List columns;

void initDocument();
void parseXML();
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
%token <txt> text
%type <t>


%%

/* descriptions of expected inputs     corresponding actions (in C) */
db 			: table {;}
			| db table {;}
table : create text '(' columns ')' ';' {addTable($2)}
;
columns      : column                     {;}
            | columns ',' columns          {;}
;
columns       : text datatype notnull   {columns.add(createColumn($1,$2,true,NULL));}
            | text datatype null      {columns.add(createColumn($1,$2,false,NULL));}
            | text datatype withdefault text {columns.add(createColumn($1,$2,false,$4));}
;

/**NOTA:
 * falta: create(tableName, columns);
 */

%%                     /* C code */

int main (void) {
#if YYDEBUG
        yydebug = 1;
#endif
	initDocument();

	if(! yyparse ( ))
	{
		parseXML();
	}
	else {return 1;}
}


void initDocument()
{
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
