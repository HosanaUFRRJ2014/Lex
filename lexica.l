%{
#include <string>

%}

ESPACO [ \t]
DIGITO [0-9]
LETRA [A-Za-z_]

DELIM {ESPACO}+
NUM {DIGITO}+
REAL {NUM}+("."{NUM}+)?
CHAR \'({LETRA}|{NUM})\'
BOOLEAN "true"|"false"
OP_RELACIONAL "<"|">"|"<="|">="|"=="|"!="
ID {LETRA}({LETRA}|{NUM})*

%%

"\n"		{}

{DELIM} 	{}

"main"		{return TK_MAIN;}

"int"		{return TK_TIPO_INT;}

[(){}[\];,]	{ return *yytext; }

[+\-*/]		{ return *yytext; }

"and"		{ yylval.label = "&&"; return TK_OP_LOGICO_BIN;}
"or"		{ yylval.label = "||"; return TK_OP_LOGICO_BIN;}
"not"		{ yylval.label = "!"; return TK_OP_LOGICO_UNA;}

{OP_RELACIONAL} { yylval.label = yytext ; return TK_OP_RELACIONAL; }

{NUM}		{ yylval.label = yytext; yylval.tipo = constante_tipo_inteiro; return TK_NUM; }
{REAL}		{ yylval.label = yytext; yylval.tipo = constante_tipo_real; return TK_NUM; }
{BOOLEAN}	{ yylval.label = yytext; yylval.tipo = constante_tipo_booleano; return TK_BOOL; }
{CHAR}		{ yylval.label = yytext; yylval.tipo = constante_tipo_caracter; return TK_CHAR; }
{ID}		{ yylval.label = yytext; return TK_ID; }

.			{ *yytext; }

%%
