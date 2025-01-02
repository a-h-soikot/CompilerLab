%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void yyerror(const char *msg);
int yylex();
%}

%union {
    int intval;    
    float floatval;
}

%token <floatval> NUMBER
%type <floatval> exp

%token NL SIN COS

%left '+' '-'
%left '*' '/'
%right '^'

%%

stmt : exp NL { printf("Result: %f\nExpression is valid\n", $1); exit(0); }

exp : exp '*' exp		{ $$ = $1 * $3; }
	| exp '/' exp  		{ if($3 == 0) { printf("Error: Division by Zero\n"); exit(0); }
					  	  $$ = $1 / $3; }
	| exp '+' exp  		{ $$ = $1 + $3; }
	| exp '-' exp  		{ $$ = $1 - $3; }
	| '(' exp ')'   	{ $$ = $2; }
	| NUMBER        	{ $$ = $1; }
	| SIN '(' exp ')'   { $$ = sin($3 * 0.01745329251); } // convert to radian
	| COS '(' exp ')'   { $$ = cos($3 * 0.01745329251); }
	| exp '^' exp       { $$ = pow($1, $3); }
	
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