%{
void yyerror (char *s);
#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>
#include "xml.h"

#define YYDEBUG 0 // Ojo desactivar
#define true  1
#define false 0

struct list cols;
void addTable(char* name);
struct column* createColumn(char* name, char* type, int required, char* defaultValue);

%}



%union {char* txt ; char* type;}        /* Yacc definitions */
%start db
%token createtable
%token <type> datatype
%token <txt> text
%token notnull
%token null
%token withdefault




%%


db 			: table {;}
			| db table {;}
table : createtable text '(' columns ')' ';' {addTable($2);}
;

columns      : column                     {;}
            | column ',' columns          {;}
;


column      : text datatype notnull   {addToList(&cols, createColumn($1,$2,true,NULL));}
            | text datatype null      {addToList(&cols, createColumn($1,$2,false,NULL));}
            | text datatype withdefault text {addToList(&cols, createColumn($1,$2,false,$4));}
;


%%                     /* C code */

int main (void) {
#if YYDEBUG
        yydebug = 1;
#endif
	return yyparse ( );
}

void addTable(char* name)
{
   create(name, &cols);

}
struct column* createColumn(char* name, char* type, int required, char* defaultValue) {
    printf("%s\n",strtok(name, " "));
    printf("%s\n",strtok(type, " "));
    struct column* col = malloc(sizeof(struct column));
    col->name=(xmlChar*)strtok(name, " ");
    col->type=(xmlChar*)strtok(type, " ");
    if(required) col->required=(xmlChar*)"true";
    else col->required=(xmlChar*)"false";
    col->defaultValue=(xmlChar*)defaultValue;
    return col;
}
void yyerror (char *s) 
{
	fprintf (stderr, "%s\n", s);
} 
