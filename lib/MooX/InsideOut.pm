package MooX::InsideOut;
use strictures 1;

use Moo ();
use MooX::InsideOut::Generate::Accessor;

sub import {
    my $class = shift;
    my $target = caller;
    unless ($Moo::MAKERS{$target} && $Moo::MAKERS{$target}{is_class}) {
        die "MooX::InsideOut can only be used on Moo classes.";
    }

    $Moo::MAKERS{$target}{accessor} = MooX::InsideOut::Generate::Accessor->new;

    # make sure we have our own constructor
    Moo->_constructor_maker_for($target);
}

1;
