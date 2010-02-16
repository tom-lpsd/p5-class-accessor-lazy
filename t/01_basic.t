use strict;
use warnings;
use Test::More tests => 5;

{
    package Foo;
    use strict;
    use warnings;
    use base qw/Class::Accessor::Lazy/;

    __PACKAGE__->mk_accessors(qw(foo bar));

    my $counter = 0;

    sub _build_foo {
        return $counter++;
    }

    sub _build_bar {
        return $counter++;
    }
}

my $foo = Foo->new();
is($foo->foo, 0);
is($foo->bar, 1);
is($foo->foo, 0);

$foo = Foo->new({
    foo => 100,
    bar => 200,
});
is($foo->foo, 100);
is($foo->bar, 200);
