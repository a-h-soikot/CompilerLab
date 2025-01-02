%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *msg);

float val = 0.0;
%}

%token ZERO ONE NL DOT

%%

decimal : integer_part DOT fractional_part NL { printf("Decimal value = %f\n", 1.0 * $1 + val); exit(0); }
		| integer_part NL		{ printf("Decimal value = %d\n", $1); exit(0); }
		;


integer_part : integer_part binary_digit 	{ $$ = $1 * 2 + $2; }
			 | /* empty */ { $$ = 0; }
			 ;

	
fractional_part : binary_digit fractional_part { val = (1.0 * $1 + val) / 2.0; }
				| /* empty */ { val = 0.0; }
			    ;

binary_digit : ZERO		 { $$ = 0; }
			 | ONE		 { $$ = 1; }
			;   
			
%%

void yyerror(const char *msg) {
	printf("Invalid input\n"); exit(0);
}

int main() 
{
	printf("Enter binary number:\n");
	yyparse();
	return 0;
}