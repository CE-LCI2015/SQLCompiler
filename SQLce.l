%{
#include "y.tab.h"
%}
%option nounput yylineno
%option caseless

%%
[,;\(\)]             {return yytext[0];}
"CREATE TABLE"      return createtable;
"NOT NULL"          return notnull;
"NULL"              return null;
"WITH DEFAULT"      return withdefault;


int(eger)?|bool(ean)?|varchar([0-9]+)|char(acter)?|decimal|double		{yylval.type =yytext; return datatype;}


[_a-zA-Z0-9˜]+			{yylval.txt=yytext; return text;}
[ \t\n]					{;}
.					{ECHO; yyerror ("Unexpected character");}

%%

int yywrap(void)
{
	return 1;
}
