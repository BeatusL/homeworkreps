%{
#include <stdlib.h>
#include "y.tab.h"

#define YYSTYPE int
extern YYSTYPE yylval;    
%}
      
%%
[0-9]+  { return NUM; }
[a-zA-Z_][a-zA-Z0-9_]*   { return ID; }
\n      { return EOL; } 
[ \t]                    {}
.       return yytext[0];
%%

#ifndef yywrap
int yywrap () { return 1; }
#endif

