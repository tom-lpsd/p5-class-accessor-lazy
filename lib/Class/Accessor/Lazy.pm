package Class::Accessor::Lazy;
use strict;
use warnings;
use base 'Class::Accessor';

our $VERSION = '0.01';

sub make_accessor {
    my($class, $field) = @_;
    my $builder = $class->builder_name_for($field);

    return sub {
        if (@_ == 1) {
            if (exists $_[0]->{$field}) {
                return $_[0]->{$field};
            }
            else {
                return $_[0]->{$field} = $_[0]->$builder;
            }
        }
        return $_[0]->{$field} = $_[1] if @_ == 2;
        return (shift)->{$field} = \@_;
    };
}


sub make_ro_accessor {
    my($class, $field) = @_;
    my $builder = $class->builder_name_for($field);

    return sub {
        if (@_ == 1) {
            if (exists $_[0]->{$field}) {
                return $_[0]->{$field};
            }
            else {
                return $_[0]->{$field} = $_[0]->$builder;
            }
        }
        my $caller = caller;
        $_[0]->_croak("'$caller' cannot alter the value of '$field' on objects of class '$class'");
    };
}


sub make_wo_accessor {
    my($class, $field) = @_;

    return sub {
        if (@_ == 1) {
            my $caller = caller;
            $_[0]->_croak("'$caller' cannot access the value of '$field' on objects of class '$class'");
        }
        else {
            return $_[0]->{$field} = $_[1] if @_ == 2;
            return (shift)->{$field} = \@_;
        }
    };
}

sub builder_name_for {
    my ($class, $field) = @_;
    return "_build_$field";
}

1;
__END__

=head1 NAME

Class::Accessor::Lazy - generate lazy accessors

=head1 SYNOPSIS

  package Foo;
  use base qw/Class::Accessor::Lazy/;
  
  __PACKAGE__->mk_accessors(qw(foo bar));
  
  sub _build_foo {
      return fib(100000);
  }
  
  package main;
  my $foo = Foo->new();
  $foo->foo # get fib(100000)

=head1 DESCRIPTION

Class::Accessor::Lazy is accessor generator based on Class::Accessor.
Using this module, you can create lazy attributes. `lazy' means the
value of attribute is calculated on demand instead of in the
constructor.

=head1 AUTHOR

Tom Tsuruhara E<lt>tom.lpsd@gmail.comE<gt>

with plenty of code borrowed from Class::Accessor::Fast

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
