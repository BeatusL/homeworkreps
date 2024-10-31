%{
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"
#include "malloc.h"

#define TRUE 1 
#define FALSE 0

int cur = 0;
int blockCount = 0;
int l = 0;
int r = 0;
char* operator;
int* arr;
int len = 0;

%}

%union {
	char* 	str;
	int 	num; 
};

%token <str> IDENTIFIER AROP INCDEC ARPOINTER COMP CONSTANT
%token IF ELSE ASSIGN LBRACE RBRACE LPAREN RPAREN SEMICOLON

%type <num> arop assigned

%start PROGRAM

%%
PROGRAM: if_statement
	|if_statement PROGRAM
    	;

if_statement:
    	IF condition body
	;

condition:
	LPAREN assigned COMP assigned RPAREN {
				l = $<str>2;
				operator = $<str>3;
				r = $<str>4;
				}
	| LPAREN arop RPAREN	{ 
				printf("ERROR: Wrong syntax\n");
				exit(-1);
				}
	| LPAREN assigned RPAREN	{ 
				printf("ERROR: Wrong syntax\n");
				exit(-1);
				}
	| LPAREN RPAREN	{ 
				printf("ERROR: Wrong syntax\n");
				exit(-1);
				}
    ;

body:
	LBRACE {	
			printf("\nEXECUTE BLOCK %d IF R%d %s R%d == TRUE\n", blockCount, l, operator, r);
			if (len == 0) {
				arr = (int*) malloc(sizeof(int));
				arr[0] = blockCount;
			}
			if (blockCount >= len) {
				arr = (int*) realloc (arr, (len + 1) * sizeof(int));
			}
			arr[blockCount + 1] = cur;
			printf("<START OF BLOCK %d>\n", blockCount++);
			}
	| body operation
	| body RBRACE {
			if (blockCount == 1) {
				cur = arr[0];
			} else if (blockCount != 0) {
				cur = arr[blockCount];
			}
			printf("<END OF BLOCK %d>\n\n", --blockCount);
			}
	;

operation: IDENTIFIER ASSIGN arop SEMICOLON {
			printf("SET %s = R%d\n", $1, $3);
			}
		| CONSTANT ASSIGN arop SEMICOLON {
			printf("ERROR: trying to change constant value\n");
			exit(-1);
		}
		| ARPOINTER ASSIGN arop SEMICOLON {
			printf("ERROR: can't change array elements\n");
			exit(-1);
		}
		;

arop: assigned AROP assigned {
			$$ = cur;
			printf("R%d = R%d %s R%d\n", cur++, $1, $2, $3);
			}
		| assigned INCDEC {
			char* op = $2;
			$$ = cur;
			switch(op[0]) {
				case '+':
					printf("R%d = R%d\n", cur, $1);
					printf("R%d = R%d + 1\n", $1, $1);
				break;
				case '-':
					printf("R%d = R%d\n", cur, $1);
					printf("R%d = R%d - 1\n", $1, $1);
				break;
				cur++;
			}
		}
		| INCDEC assigned {
			char* op = $<str>1;
			$$ = cur;
			switch(op[0]) {
				case '+':
					printf("R%d = R%d + 1\n", $2, $2);
					printf("R%d = R%d\n", cur, $2);
				break;
				case '-':
					printf("R%d = R%d - 1\n", $2, $2);
					printf("R%d = R%d\n", cur, $2);
				break;
			}
			cur++;
		}
		;

assigned: IDENTIFIER {
			$$ = cur;
			printf("R%d = GET %s\n", cur++, $1);
			}
		| CONSTANT {
			$$ = cur;
			printf("R%d = %s\n", cur++, $1);
			}
		| ARPOINTER {
			$$ = cur;
			char* string = $1;
			char* name = (char*) malloc(sizeof(char));
			int i = 0;
			while (string[i] != '[') {
				name = (char*) realloc(name, (i + 1) * sizeof(char));
				name[i] = string[i];
				i++;
			}
			i++;
			int pointer = 0;
			char* arrSize = (char*) malloc(sizeof(char));
			while (string[i] != ']') {
				arrSize = (char*) realloc(arrSize, (pointer + 1) * sizeof(char));
				arrSize[pointer] = string[i];
				i++;
			}
			printf("R%d = GETFROM %s %s ELEMENT\n", cur++, name, arrSize);
			}
		| arop { $$ = cur - 1;}
		;
%%
