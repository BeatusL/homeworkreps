#include <stdio.h>

extern int yydebug;
extern int yyparse();

main ()
{
	//yydebug = 1;
	return yyparse();
}

yyerror( char *s )
{
	fprintf( stderr, "?-%s\n", s );
}

