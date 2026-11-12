%%
%public
%class Lexer
%unicode
%standalone
%line
%column

%{
    private void token(String tipo) {
        System.out.printf(
            "TOKEN: %-24s LEXEMA: %-16s LINHA: %d COLUNA: %d%n",
            tipo,
            yytext(),
            yyline + 1,
            yycolumn + 1
        );
    }

    private void erro(String mensagem) {
        System.out.printf(
            "ERRO LEXICO: %-16s LINHA: %d COLUNA: %d%n",
            mensagem,
            yyline + 1,
            yycolumn + 1
        );
    }
%}

DIGITO      = [0-9]
LETRA       = [a-zA-Z_]
IDENT       = {LETRA}({LETRA}|{DIGITO})*
INTEIRO     = {DIGITO}+
REAL        = {DIGITO}+"."{DIGITO}+

%%

/* Palavras reservadas: mantenha estas regras antes de IDENT. */
"int"       { token("PALAVRA_RESERVADA"); }
"float"     { token("PALAVRA_RESERVADA"); }
"void"      { token("PALAVRA_RESERVADA"); }
"if"        { token("PALAVRA_RESERVADA"); }
"else"      { token("PALAVRA_RESERVADA"); }
"while"     { token("PALAVRA_RESERVADA"); }
"for"       { token("PALAVRA_RESERVADA"); }
"return"    { token("PALAVRA_RESERVADA"); }

/* Operadores com dois caracteres antes dos operadores simples. */
"=="        { token("OPERADOR_IGUALDADE"); }
"!="        { token("OPERADOR_DIFERENTE"); }
">="        { token("OPERADOR_MAIOR_IGUAL"); }
"<="        { token("OPERADOR_MENOR_IGUAL"); }
"&&"        { token("OPERADOR_E_LOGICO"); }
"||"        { token("OPERADOR_OU_LOGICO"); }
"++"        { token("OPERADOR_INCREMENTO"); }
"--"        { token("OPERADOR_DECREMENTO"); }

{REAL}      { token("NUMERO_REAL"); }
{INTEIRO}   { token("NUMERO_INTEIRO"); }
{IDENT}     { token("IDENTIFICADOR"); }

"+"         { token("OPERADOR_SOMA"); }
"-"         { token("OPERADOR_SUBTRACAO"); }
"*"         { token("OPERADOR_MULTIPLICACAO"); }
"/"         { token("OPERADOR_DIVISAO"); }
"="         { token("ATRIBUICAO"); }
">"         { token("MAIOR_QUE"); }
"<"         { token("MENOR_QUE"); }
"!"         { token("NEGACAO"); }

"("         { token("ABRE_PARENTESE"); }
")"         { token("FECHA_PARENTESE"); }
"{"         { token("ABRE_CHAVES"); }
"}"         { token("FECHA_CHAVES"); }
";"         { token("PONTO_VIRGULA"); }
","         { token("VIRGULA"); }

/* Comentários são ignorados pelo analisador. */
"//".*      { /* comentário de linha */ }
"/*"([^*]|\*+[^*/])*\*+"/" { /* comentário de bloco */ }

[ \t\f\r\n]+ { /* espaços em branco */ }

.           { erro("'" + yytext() + "'"); }
