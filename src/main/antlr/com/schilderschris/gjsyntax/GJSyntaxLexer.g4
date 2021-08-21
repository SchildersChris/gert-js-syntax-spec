/**
 * Gert-Js Syntax (GJSyntax) acts as a DSL language for writing reusable view code
 * that will eventually be transcribed to HTML.
 *
 * GJSyntax is inspired by SwiftUI and Jetpack Compose where best of both worlds are
 * combined to create a simple DSL for the Gert-Js library.
 *
 * GJSyntax can be recognized by the `component` declerations inside a js/ts file.
 */
lexer grammar GJSyntaxLexer;

// General

WS
    : [ \t\r\n]+ -> channel(HIDDEN)
    ;

NL
    : '\n' | '\r' '\n'?
    ;

// Seperators and Operators

SPREAD: '...';
LPAREN: '(';
RPAREN: ')';
LSQUARE: '[';
RSQUARE: ']';
LCURL: '{';
RCURL: '}';
MULT: '*';
MOD: '%';
DIV: '/';
ADD: '+';
SUB: '-';
INCR: '++';
DECR: '--';
CONJ: '&&';
DISJ: '||';
EXCL: '!';
DOT: '.';
COMMA: ',';
COLON: ':';
SEMICOLON: ';';
ASSIGNMENT: '=';
ADD_ASSIGNMENT: '+=';
SUB_ASSIGNMENT: '-=';
MULT_ASSIGNMENT: '*=';
DIV_ASSIGNMENT: '/=';
MOD_ASSIGNMENT: '%=';
QUEST: '?';
LANGLE: '<';
RANGLE: '>';
LE: '<=';
GE: '>=';
EXCL_EQ: '!=';
EXCL_EQEQ: '!==';
EQEQ: '==';
EQEQEQ: '===';
AT: '@';

// Keywords

COMPONENT: 'component';
ANY: 'any';

// Types

NUMBER: 'number';
STRING: 'string';
OBJECT: 'object';

// Identifiers

ID
    : [a-zA-Z_] [a-zA-Z0-9_]*
    ;

// Literals

fragment DecDigit: '0'..'9';
fragment DoubleExponent: [eE] [+-]? DecDigit;

StringLiteral
    : LQUOTE STRING_CONTENT* RQUOTE
    ;

NumericLiteral
    : DoubleLiteral
    | IntegerLiteral
    ;

fragment DoubleLiteral
    : DecDigit? '.' DecDigit DoubleExponent?
    | DecDigit DoubleExponent
    ;

fragment IntegerLiteral
    : DecDigit
    ;

BooleanLiteral
    : 'true' | 'false'
    ;

NullLiteral
    : 'null'
    ;

LQUOTE
    : '"' -> pushMode(InString)
    ;

mode InString;

RQUOTE
    : '"' -> popMode
    ;

STRING_CONTENT
    : ~('\\' | '"')+
    ;
