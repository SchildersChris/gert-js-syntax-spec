/**
 * Gert-Js Syntax (GJSyntax) acts as a DSL language for writing reusable view code
 * that will eventually be transcribed to HTML.
 *
 * GJSyntax is inspired by SwiftUI and Jetpack Compose where best of both worlds are
 * combined to create a simple DSL for the Gert-Js library.
 *
 * GJSyntax can be recognized by the `component` declerations inside a js/ts file.
 */
parser grammar GJSyntaxParser;

options { tokenVocab = GJSyntaxLexer; }


// Rules

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
    | variableStatements
    ;

arguments
    : LPAREN (argument (COMMA argument)* COMMA?)? RPAREN
    ;

argument
    : SPREAD? (expression | ID)
    ;

expressions
    : expression+
    ;

expression
    : callExpression
    | StringLiteral
    | NumericLiteral
    | objectLiteral
    | arrayLiteral
    ;

variableStatements
    : variableStatement+
    ;

variableStatement
    : variableModifiers variableDeclaration (COMMA variableDeclaration)*
    ;

variableDeclaration
    : assignable (ASSIGNMENT expression)? // ECMAScript 6: Array & Object Matching
    ;

callExpression
    : ID arguments
    | ID block
    | ID arguments block
    ;

assignable
    : ID
    | arrayLiteral
    | objectLiteral
    ;

type
    : ID
    | NUMBER
    | STRING
    | OBJECT
    | ANY
    | COMPONENT
    ;

variableModifiers
    : VAR
    | LET
    | CONST
    ;


// Object Literals

arrayLiteral
    : (LSQUARE elementList RSQUARE)
    ;

objectLiteral
    : LCURL (propertyAssignment (COMMA propertyAssignment)* COMMA?)? RCURL
    ;

elementList
    : COMMA* arrayElement? (COMMA+ arrayElement)* COMMA*
    ;

arrayElement
    : SPREAD? expression
    ;

propertyAssignment
    : propertyName COLON expression
    | LSQUARE expression RSQUARE COLON expression
    ;

propertyName
    : ID
    | StringLiteral
    | LSQUARE expression RSQUARE
    ;