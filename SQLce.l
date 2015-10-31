%{
#include "y.tab.h"
%}
%option nounput yylineno
%option caseless

%%
[,;\(\)]             {return yytext[0];}
"CREATE TABLE"      return create;
"NOT NULL"          return notnull;
"NULL"              return null;
"WITH DEFAULT"      return withdefault;


int {return num;}
bool {return boolean;}

[_a-zA-Z0-9]+			{yylval.text = yytext;return string;}
["true""false"]			{yylval.b = atoi(yytext) return boolean;}
[0-9]+					{yylval.num = atoi(yytext) return number;}
[ \t\n]					{;}
.					{printf(ECHO); yyerror ("Unexpected character: %c\n",yytext[0]));}

%%

int yywrap(void)
{
	return 1;
}