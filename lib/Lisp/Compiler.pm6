unit module Lisp::Compiler;

use Lisp::Grammar;

sub parse($source) is export {
    return LispGrammar.parse($source, actions => LispActions.new).made;
}
