%{
#include "y.tab.h"
%}
%option nounput yylineno

%%
[,\(\)]           	   {return yytext[0];}
"CREATE TABLE"			return create;

"NOT NULL"			return notnull;
"NULL"				return null;
"WITH"				return with;
"DEFAULT"           return default;

int|long|double|float|string|char|bool {yyval.name = yytext; return datatype;}

[a-zA-Z][_a-zA-Z0-9]*	{yyval.name = yytext;return names;}
[0-9]+					{yyval.int = atoi(yytext) return number;}
[0-9]+(.[0-9]+)*					{yyval.decimal = atoi(yytext) return number;}
[ \t\n]					;
.					{printf(ECHO; yyerror ("Unexpected character: %c\n",yytext[0]));}

%%

int yywrap(void)
{
	return 1;
}