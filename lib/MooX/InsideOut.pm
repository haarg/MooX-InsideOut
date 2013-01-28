package MooX::InsideOut;
use strictures 1;

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
