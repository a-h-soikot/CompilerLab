%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *msg);
int yylex();
%}

%token NUMBER ID NL
%left '+' '-'
%left '*' '/'

%%

stmt : exp NL { printf("Valid Expression"); exit(0);}
;
exp : exp '+' exp
	| exp '-' exp
	| exp '*' exp
	| exp '/' exp
	| '(' exp ')'
	| ID {printf("Found an id\n");}
	| NUMBER {printf("Found a number\n");}
	;
	
%%

void yyerror(const char *msg)
{
	printf("Invalid Expression\n");
	exit(0);
}

int main ()
{
printf("Enter the expression\n");
yyparse();
return 0;
}