%{
#include "42.tab.h"
%}

%%
[0-9]+ { return NUMBER; }
[a-zA-Z][a-zA-Z0-9_]* { return ID; }
[\r\n]+ { return NL ;}
[ \t]+    { /* Ignore whitespace */ }
. { return yytext[0]; }
%%

int yywrap() {
    return 1;  // Indicates no more input.
}