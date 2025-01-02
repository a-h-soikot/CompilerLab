%{
#include <stdlib.h>
#include "542.tab.h"	
%}

%%

sin   { return SIN; }
cos	   { return COS; }

[0-9]+(\.[0-9]+)?([E][+-]*[0-9]+)? { yylval.floatval = atof(yytext); return NUMBER; }

[ \t]  { } // Ignore Whitespace
[\r\n]+ { return NL; }

. { return yytext[0]; }

%%

int yywrap() {
	return 1;
}