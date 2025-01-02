%{
#include "433.tab.h"
%}

%%
if          { return IF; }
else        { return ELSE; }
[0-9]+      { yylval = atoi(yytext); return NUM; }
[ \t\n]     ; /* Skip whitespace */
.           { return yytext[0]; }
%%

int yywrap(void) {
    return 1;
}