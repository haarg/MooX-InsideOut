package MooX::InsideOut;
use strictures 1;

our $VERSION = '0.001000';
$VERSION = eval $VERSION;

use Moo ();
use Moo::Role ();

sub import {
    my $class = shift;
    my $target = caller;
    unless ($Moo::MAKERS{$target} && $Moo::MAKERS{$target}{is_class}) {
        die "MooX::InsideOut can only be used on Moo classes.";
    }

    Moo::Role->apply_roles_to_object(
      Moo->_accessor_maker_for($target),
      'Method::Generate::Accessor::Role::InsideOut',
    );

    # make sure we have our own constructor
    Moo->_constructor_maker_for($target);
}

1;

__END__

=head1 NAME

MooX::InsideOut - Inside out objects for Moo

=head1 SYNOPSIS

    package MyClass;
    use Moo;
    use MooX::InsideOut;

=head1 DESCRIPTION

MooX::InsideOut causes all accessors generated to be stored outside
the object itself.  This is useful for extending non-Moo classes
whose internals you don't want to change, or which aren't hash
based.

Inside out objects are not recommended for general use aside from
where they are specifically required.

=head1 AUTHOR

haarg - Graham Knop (cpan:HAARG) <haarg@haarg.org>

=head2 CONTRIBUTORS

None so far.

=head1 COPYRIGHT

Copyright (c) 2013 the MooX::InsideOut L</AUTHOR> and L</CONTRIBUTORS>
as listed above.

=head1 LICENSE

This library is free software and may be distributed under the same terms
as perl itself.

=cut
