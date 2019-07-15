use v6;

use lib 'lib';
use Test;

use Lisp;

plan 2;

subtest {
    plan 2;

    my @src = [
        Lisp::Name.new("name"),
        Lisp::Number.new(1),
        Lisp::Number.new(2)
    ];

    my $expected = Lisp::List.new(
        head => Lisp::Name.new("name"),
        tail => Lisp::List.new(
            head => Lisp::Number.new(1),
            tail => Lisp::Number.new(2)
        )
    );

    my $actual = Lisp::List.from_array(@src);

    is-deeply($actual, $expected, "List.from_array");
    is-deeply($actual.flatten, @src, "List.flatten");
}

subtest {
    plan 1;

    my $actual = Lisp::List.from_array([
        Lisp::Name.new("add"),
        Lisp::Number.new(1),
        Lisp::Number.new(2)
    ]).eval(Lisp::Functions);

    is-deeply($actual, Lisp::Number.new(3), "List evaluates to a function call")
}
