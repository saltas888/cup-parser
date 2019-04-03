import java_cup.runtime.*;

%%
/* ----------------- Options and Declarations Section----------------- */

/*
   The name of the class JFlex will create will be Scanner.
   Will write the code to the file Scanner.java.
*/
%class Scanner

/*
  The current line number can be accessed with the variable yyline
  and the current column number with the variable yycolumn.
*/
%line
%column

/*
   Will switch to a CUP compatibility mode to interface with a CUP
   generated parser.
*/
%cup
%unicode

/*
  Declarations

  Code between %{ and %}, both of which must be at the beginning of a
  line, will be copied letter to letter into the lexer class source.
  Here you declare member variables and functions that are used inside
  scanner actions.
*/

%{
    /**
        The following two methods create java_cup.runtime.Symbol objects
    **/
    StringBuffer string = new StringBuffer();
    private Symbol symbol(int type) {
       return new Symbol(type, yyline, yycolumn);
    }
    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }
%}

/*
  Macro Declarations

  These declarations are regular expressions that will be used latter
  in the Lexical Rules Section.
*/


/* A literal integer is is a number beginning with a number between
   one and nine followed by zero or more numbers between zero and nine
   or just a zero.  */

Identifier = [a-zA-Z$_] [a-zA-Z0-9$_]*
LineTerminator = \r|\n|\r\n;
WhiteSpace = {LineTerminator} | [ \t\f]

%state STRING

%%
/* ------------------------Lexical Rules Section---------------------- */

<YYINITIAL>{
/* keywords */
"if"              { return symbol(sym.IF); }
"else"            { return symbol(sym.ELSE); }
"prefix"          { return symbol(sym.PREFIX); }
"suffix"          { return symbol(sym.SUFFIX); }

/* names */
{Identifier}           { return symbol(sym.ID, yytext()); }

/* separators */
  \"                { string.setLength(0); yybegin(STRING); }
","               { return symbol(sym.COMMA); }
"("               { return symbol(sym.LPAR); }
")"               { return symbol(sym.RPAR); }
"{"               { return symbol(sym.BEGIN); }
"}"               { return symbol(sym.END); }
"+"               { return symbol(sym.PLUS); }

{WhiteSpace} { /* just skip what was found, do nothing */ }

}

<STRING> {
  \"                             { yybegin(YYINITIAL);
                                       return symbol(sym.STRING_LITERAL, string.toString()); }
  [^\n\r\"\\]+                   { string.append( yytext() ); }
  \\t                            { string.append('\t'); }
  \\n                            { string.append('\n'); }

  \\r                            { string.append('\r'); }
  \\\"                           { string.append('\"'); }
  \\                             { string.append('\\'); }
}



/* No token was found for the input so through an error.  Print out an
   Illegal character message with the illegal character that was found. */
[^]                    { throw new Error("Illegal character <"+yytext()+">"); }
