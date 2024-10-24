%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yywrap(void) { return 1; }
int error_found = 0;
int op_found = 0;
int int_found = 0;

void convert_to_c_format(char* num) {
    if (num[0] == '.') {
        printf("0%s", num);  
    } else if (num[strlen(num)-1] == '.') {
        printf("%s0", num);  
    } else {
        printf("%s", num);   
    }
}

void print_operator(char *op) {
    if (strcmp(op, ".GT.") == 0) {
        printf(" > ");
    } else if (strcmp(op, ".GE.") == 0) {
        printf(" >= ");
    } else if (strcmp(op, ".LT.") == 0) {
        printf(" < ");
    } else if (strcmp(op, ".LE.") == 0) {
        printf(" <= ");
    } else if (strcmp(op, ".EQ.") == 0) {
        printf(" == ");
    } else if (strcmp(op, ".NE.") == 0) {
        printf(" != ");
    }
}
%}


DIGIT   [0-9]
SIGN    [+-]
DOT     \.

REAL    (({DIGIT}+{DOT}{DIGIT}*)|({DOT}{DIGIT}+))
INTEGER {DIGIT}+
OP      \.(GT|GE|LT|LE|EQ|NE)\.

%%

{SIGN}?({REAL}|{INTEGER}){OP}{SIGN}?({REAL}|{INTEGER})       { 
    	if (!error_found) {
		op_found = 1;	
	
    	}
	REJECT;
}

({INTEGER}{OP})		{
	int_found = 1;
	REJECT
}

{SIGN}                  {
	if (op_found) {
		printf("%s", yytext);
	}
}

{INTEGER} {
	if (op_found) {
		printf("%s", yytext);
		int_found = 0;
	}
}


{REAL} {
	if (op_found && !int_found) {
		convert_to_c_format(yytext);
	}
	if (int_found)	{
		REJECT
	}
}

{OP} {
	if (op_found) {
		print_operator(yytext);
	}
}

	

{SIGN}{SIGN}                      { printf("ERROR: два знака подряд\n"); error_found = 1; }
{SIGN}?{REAL}{DOT}{OP}{SIGN}?({REAL}|{INTEGER})  { printf("ERROR: лишняя точка перед оператором\n"); error_found = 1; }
{SIGN}?({REAL}|{INTEGER}){OP}{SIGN}?{DOT}{REAL} { printf("ERROR: лишняя точка после оператора\n"); error_found = 1; }





[^ \t\n] {
	if (!error_found) { 
		printf("SYNTAX ERROR: %s\n", yytext);
	}
	error_found = 1;
 }

\n       { 
	if (!op_found || error_found) {
		printf("ERROR: операция некорректна");
	}
	op_found = 0;
	error_found = 0;
	printf("\n\n"); 
}

%%
int main(void) {
    yylex();
    return 0;
}