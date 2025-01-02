%{
#include <stdlib.h>
#include "52.tab.h"	
%}

%%

[0-9]+ { yylval = atoi(yytext); return NUMBER; }
[ \t]  { } // Ignore Whitespace
[\r\n]+ { return NL; }

. { return yytext[0]; }

%%

int yywrap() {
	return 1;
}