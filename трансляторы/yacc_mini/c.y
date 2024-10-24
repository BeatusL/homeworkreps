%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int num_count = 0;
int id_count = 0;
int line_count = 0;
int current_position = 1;

%}


%token NUM
%token ID
%token EOL
%start __list

%%
__list: 
	
	|__list _list


_list: elements EOL
	{
        	printf("Строка %d: чисел - %d, идентефикаторов - %d\n", ++line_count, num_count, id_count);
        	num_count = 0;
        	id_count = 0;
        	current_position = 1;
   	}
	;


elements:
	
	|element elements
	;


element:
	NUM
	{
		if (current_position % 3 == 0) {
			yyerror("Пропущен идентефикатор", current_position);
		}
		num_count++;
		current_position++;
	}
	| ID
	{
		id_count++;
	        current_position++;
	}
	;
		
%%


