
grammar Lisp {
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

class Name {
    has $.value;
}

class Number {
    has $.value;
}

class Functions {
    method add(@args) {
        return sum(@args);
    }
}

class List {
    has $.head;
    has @.tail;

    method eval() {
        Functions."$!head"(@!tail);
    }
}

class LispActions {
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
        make $/.Str;
    }

    method number($/) {
        make $/.Int;
    }
}

my $parsed = Lisp.parse('(add 1 2)', actions => LispActions.new);

for $parsed.made -> $list {
    say $list.eval
}
