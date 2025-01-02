%{
#include "541.tab.h"
%}

%%

0		{ return ZERO; }
1		{ return ONE; }
[\r\n]+	{ return NL; }
.		{ if(yytext[0] == '.') return DOT; return yytext[0]; }

%%

int yywrap() {
	return 1;
}