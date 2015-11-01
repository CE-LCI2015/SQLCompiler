%{
void yyerror (char *s);
#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>
#include "xml.h"
#define YYDEBUG 0 // Ojo desactivar
#define true  1
#define false 0

void initDocument();
void parseXML();
void addColumn(char* columnname, char* dtype, int required, int wdefault, char* defaultdata);


%}

%union {char* txt ; char* type;}        /* Yacc definitions */
%start createTable
%token create
%token <type> datatype
%token <txt> text
%token notnull
%token null
%token withdefault
%token <txt> text


%%

/* descriptions of expected inputs     corresponding actions (in C) */

createTable : create text '(' tables ')' ';'
;
columns      : column                     {;}
            | columns ',' columns          {;}
;
columns       : text datatype notnull   {addColumn($1,$2,true,false,NULL);}
            | text datatype null      {addColumn($1,$2,false,false,NULL);}
            | text datatype withdefault text {addColumn($1,$2,false,true,$4);}
;

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

}

void parseXML()
{

}
void addColumn(char* columnname, char* dtype, int required, int wdefault, char* defaultdata)
{
	printf("ColumnName: %s\n",columnname);
	printf("Type: %s\n",dtype);
}
void yyerror (char *s) 
{
	fprintf (stderr, "%s\n", s);
} 
