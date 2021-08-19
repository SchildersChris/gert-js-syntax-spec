"use strict"

module.exports.evaluateLexerPredicate = function (lexer, ruleIndex, predIndex, predicate) {
    return eval(predicate);
}

module.exports.evaluateParserPredicate = function (parser, ruleIndex, predIndex, predicate) {
    return eval(predicate);
}