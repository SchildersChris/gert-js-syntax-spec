/**
 * Gert-Js Syntax (GJSyntax) acts as a DSL language for writing reusable view code
 * that will eventually be transcribed to HTML.
 *
 * GJSyntax is inspired by SwiftUI and Jetpack Compose where best of both worlds are
 * combined to create a simple DSL for the Gert-Js library.
 *
 * GJSyntax can be recognized by the @GJSyntax decorator on a js/ts function decleration.
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

// Types

INT: 'int';
FLOAT: 'float';
STRING: 'string';
DOUBLE: 'double';


// Identifiers
ID
    : [a-zA-Z_] [a-zA-Z0-9_]*
    ;

// Literals

fragment DecDigit: '0'..'9';
fragment DecDigitNoZero: '1'..'9';
fragment DoubleExponent: [eE] [+-]? DecDigit;

RealLiteral
    : FloatLiteral
    | DoubleLiteral
    ;

FloatLiteral
    : DoubleLiteral [fF]
    | DecDigit [fF]
    ;

DoubleLiteral
    : DecDigit? '.' DecDigit DoubleExponent?
    | DecDigit DoubleExponent
    ;

IntegerLiteral
    : DecDigit
    ;

BooleanLiteral
    : 'true' | 'false'
    ;

NullLiteral
    : 'null'
    ;


// fragment HexDigit: [0-9a-fA-F];


// fragment BinDigit: [01];

//
//LQUOTE
//    : '"' -> pushMode(LineString)
//    ;
//
//mode LineString;
//
//RQUOTE
//    : '"' -> popMode
//    ;