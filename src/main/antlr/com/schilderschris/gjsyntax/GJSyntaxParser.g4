/**
 * Gert-Js Syntax (GJSyntax) acts as a DSL language for writing reusable view code
 * that will eventually be transcribed to HTML.
 *
 * GJSyntax is inspired by SwiftUI and Jetpack Compose where best of both worlds are
 * combined to create a simple DSL for the Gert-Js library.
 *
 * GJSyntax can be recognized by the @GJSyntax decorator on a js/ts function decleration.
 */
parser grammar GJSyntaxParser;

options { tokenVocab = GJSyntaxLexer; }

script 
    : componentDeclaration*
    ;

componentDeclaration
	: COMPONENT ID LPAREN NL* parameters? NL* RPAREN block
	;

parameters
    : parameter (COMMA parameter)* (COMMA lastParameter)?
    | lastParameter
    ;

parameter
    : assignable COLON type (ASSIGNMENT expression)?
    ;

lastParameter
    : SPREAD expression COLON type
    ;

block 
    : LCURL NL* statements* NL* RCURL
    ;

statements 
    : statement+
    ;

statement
    : expressions
    ;

arguments
    : LPAREN (argument (COMMA argument)* COMMA?)? RPAREN
    ;

argument
    : SPREAD? (expression | ID)
    ;

expressions
    : expression (COMMA expression)*
    ;

expression
    : ID
    | expression arguments
    ;

assignable
    : ID
    // | arrayLiteral
    // | objectLiteral
    ;

type
    : ID
    | INT
    | STRING
    | FLOAT
    | DOUBLE
    | DOUBLE2
    ;