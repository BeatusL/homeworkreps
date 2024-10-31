%{
#include <stdlib.h> 
#include "y.tab.h"
%}

digit           [0-9]
letter          [a-zA-Z_]
identifier      {letter}({letter}|{digit})*
integer         {digit}+

%%
"if"            { return IF; }
"else"          { return ELSE; }
"="             { return ASSIGN; }
"{"             { return LBRACE; }
"}"             { return RBRACE; }
"("             { return LPAREN; }
")"             { return RPAREN; }
";"             { return SEMICOLON; }

\'{letter}\'	{ yylval.str = strdup(yytext); return CONSTANT; }
{integer}       { yylval.str = strdup(yytext); return CONSTANT; }
{identifier}    { yylval.str = strdup(yytext); return IDENTIFIER; }
(\+|\-|\/|\*)   { yylval.str = strdup(yytext); return AROP;}
((\+\+)|(\-\-))	{ yylval.str = strdup(yytext); return INCDEC;}
(>|<|>=|<=|==|!=) { yylval.str = strdup(yytext); return COMP;}
{identifier}\[{digit}+\] { yylval.str = strdup(yytext); return ARPOINTER; }

[ \t\n]         ; /* пропускаем пробелы и символы новой строки */

.               ;
%%

#ifndef yywrap
int yywrap () { return 1; }
#endif
