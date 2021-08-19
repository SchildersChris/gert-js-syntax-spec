/**
 * Gert-Js Syntax (GJSyntax) acts as a DSL language for writing reusable view code
 * that will eventually be transcribed to HTML.
 *
 * GJSyntax is inspired by SwiftUI and Jetpack Compose where best of both worlds are
 * combined to create a simple DSL for the Gert-Js library.
 *
 * GJSyntax can be recognized by the @GJSyntax decorator on a js/ts function decleration.
 */
grammar GJSyntax;

start : '1112' ID ID2 ID3 ;

ID : [a-z]+ ;

ID2 : [0-9]+ ;

ID3 : [A-Z]+ ;

WS : [ \t\r\n]+ -> skip ;