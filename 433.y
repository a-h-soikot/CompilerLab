%{
#include <stdio.h>
#include <stdlib.h>

int level = 0;
void yyerror(const char *s);
int yylex(void);
%}

%token IF ELSE NUM

%%
program     : statement

statement   : if_stmt
            | /* empty */
            ;

if_stmt     : IF '(' expr ')' '{'          { ++level; }
				 
				    { printf("IF statement with %d at level %d\n", $3, level);}
				    statement
			  '}'                          { --level; }
			  else_if_stmt
			  statement
             ;

else_if_stmt   : ELSE IF '(' expr ')' '{'  { ++level; }
				     statement
			    '}'    					   { --level; }
			     else_if_stmt
				| ELSE '{'                 { ++level; }
				     statement
			    '}'                        { --level; }
				| /* empty */
				;
				
expr : NUM  { $$ = $1; }
	 ;
%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) {
    printf("Enter IF statements:\n");
    yyparse();
    return 0;
}