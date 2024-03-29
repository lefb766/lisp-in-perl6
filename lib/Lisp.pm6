unit module Lisp;

class Name is export {
    has $.value;

    method new($value) {
        self.bless(:$value);
    }
}

class Number is export {
    has $.value;

    method new($value) {
        self.bless(:$value);
    }
}

class List is export {
    has $.head;
    has $.tail;

    method from_array(@array) {
        sub infix:<cons> ($a, $b) is assoc<right> {
            return List.new(
                head => $a,
                tail => $b,
            );
        }

        return [cons] @array;
    }

    method flatten {
        my $ref = self;
        my @result = [];

        while $ref.tail.WHAT === List {
            @result.push($ref.head);
            $ref = $ref.tail;
        }

        @result.push($ref.head);
        @result.push($ref.tail);

        return @result;
    }

    method eval($functions) {
        my $name = $!head.value;
        $functions."$name"($!tail);
    }
}

class Functions {
    method add($arg) {
        given $arg {
            when List { Number.new([+] $arg.flatten.map(*.value)) }
            when Number { $arg }
        }
    }
}
