import java.util.HashMap;

%%


%class Lexer                    
%public                       
%standalone                    

%{

    private HashMap<String, Boolean> symbolTable = new HashMap<>();
    
    private void processIdentifier(String id) {
        if (symbolTable.containsKey(id)) {
            System.out.println("identifier \"" + id + "\" already in symbol table");
        } else {
            symbolTable.put(id, true);
            System.out.println("new identifier: " + id);
        }
    }
%}
WhiteSpace = [ \t\r\n]+

LineComment = "//".*

BlockComment = "/*" [^*] ~"*/" | "/*" "*"+ "/"

Integer = [0-9]+

Identifier = [a-zA-Z][a-zA-Z0-9]*

String = \"[^\"]*\"

%%


/* --- COMMENTS  --- */
{BlockComment}      { /* Ignore block comments */ }
{LineComment}       { /* Ignore line comments */ }

/* --- WHITESPACE  --- */
{WhiteSpace}        { /* Ignore whitespace */ }

/* --- KEYWORDS  --- */
"if"                { System.out.println("keyword: if"); }
"then"              { System.out.println("keyword: then"); }
"else"              { System.out.println("keyword: else"); }
"endif"             { System.out.println("keyword: endif"); }
"while"             { System.out.println("keyword: while"); }
"do"                { System.out.println("keyword: do"); }
"endwhile"          { System.out.println("keyword: endwhile"); }
"print"             { System.out.println("keyword: print"); }
"newline"           { System.out.println("keyword: newline"); }
"read"              { System.out.println("keyword: read"); }

/* --- TWO-CHARACTER OPERATORS --- */
"++"                { System.out.println("operator: ++"); }
"--"                { System.out.println("operator: --"); }
">="                { System.out.println("operator: >="); }
"<="                { System.out.println("operator: <="); }
"=="                { System.out.println("operator: =="); }

/* --- SINGLE-CHARACTER OPERATORS --- */
"+"                 { System.out.println("operator: +"); }
"-"                 { System.out.println("operator: -"); }
"*"                 { System.out.println("operator: *"); }
"/"                 { System.out.println("operator: /"); }
"="                 { System.out.println("operator: ="); }
">"                 { System.out.println("operator: >"); }
"<"                 { System.out.println("operator: <"); }

/* --- PUNCTUATION --- */
"("                 { System.out.println("punctuation: ("); }
")"                 { System.out.println("punctuation: )"); }
";"                 { System.out.println("punctuation: ;"); }

/* --- INTEGERS --- */
{Integer}           { System.out.println("integer: " + yytext()); }

/* --- STRINGS --- */
{String}            { System.out.println("string: " + yytext()); }

/* --- IDENTIFIERS --- */
{Identifier}        { processIdentifier(yytext()); }

/* --- ERROR HANDLING --- */
.                   { 
                        System.out.println("ERROR: Invalid character '" + yytext() + "'");
                        System.out.println("Program terminated due to error.");
                        System.exit(1);
                    }