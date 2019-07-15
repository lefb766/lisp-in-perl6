use v6;

use lib 'lib';
use Test;

use Lisp;

plan 3;

is-deeply(parse("name"), (Lisp::Name.new("name"),), '"name" is a valid name');
is-deeply(parse("name1"), (Lisp::Name.new("name1"),), '"name1" is a valid name');
nok(parse("1name"), '"1name" is not a valid name');
