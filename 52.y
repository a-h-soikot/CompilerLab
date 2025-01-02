%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *msg);
int yylex();
%}

%token NUMBER NL
%left '+' '-'
%left '*' '/'

%%

stmt : exp NL { printf("Result: %d\nExpression is valid\n", $1); exit(0); }

exp : exp '*' exp	{ $$ = $1 * $3; }
	| exp '/' exp  	{ if($3 == 0) { printf("Error: Division by Zero\n"); exit(0); }
					  $$ = $1 / $3; }
	| exp '+' exp  	{ $$ = $1 + $3; }
	| exp '-' exp  	{ $$ = $1 - $3; }
	| '(' exp ')'   { $$ = $2; }
	| NUMBER        { $$ = $1; }

%%

void yyerror(const char *msg) {
	printf("Expression is invalid\n");
	exit(0);
}

int main ()
{	
	printf("Enter the expression:\n");
	yyparse();
	return 0;
}