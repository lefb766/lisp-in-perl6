unit module Lisp::Grammar;

use Lisp;

grammar LispGrammar is export {
    rule TOP {
        <expression> +
    }

    rule list {
        '(' <expression>+ ')'
    }

    rule expression {
        <list>
        | <name>
        | <number>
    }

    token name {
        <.alpha> <.alnum>*
    }

    token number {
        <.digit>+
    }
}

class LispActions is export {
    method TOP($/) {
        make map(-> $e { $e.made }, $<expression>);
    }

    method expression($/) {
        my $found = $<name> // $<number> // $<list>;

        make $found.made;
    }

    method list($/) {
        my @elements = map(-> $e { $e.made }, $<expression>);
        my $head = @elements.shift;
        my @tail = @elements;

        make List.new(
            head => $head,
            tail => @tail
        );
    }

    method name($/) {
        make Name.new($/.Str);
    }

    method number($/) {
        make Number.new($/.Int);
    }
}
