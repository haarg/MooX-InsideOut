use strictures 1;
use Test::More;

{
    package MooInsideOut;
    use Moo;
    use MooX::InsideOut;

    has dogs => (is => 'ro');
}

my $io = MooInsideOut->new(dogs => 1);
is $io->dogs, 1, 'insideout accessors work';
is eval { $io->{dogs} }, undef, 'insideout attributes not directly accessible';

{
    package NonMooClass;
    sub new { bless {}, shift }

    sub boggle {
        my $self = shift;
        if (@_) {
            $self->{boggle} = shift;
        }
        else {
            $self->{boggle};
        }
    }
}

{
    package MooInh;
    use Moo;
    use MooX::InsideOut;
    extends 'NonMooClass';

    has guff => (is => 'rw');
}

my $o = MooInh->new;
$o->boggle(1);
$o->guff(2);
is $o->boggle, 1, 'non-moo methods still work';
is $o->guff, 2, 'insideout attributes work for hashref class';
is $o->{guff}, undef, 'insideout attributes not directly accessible for hashref class';

done_testing;
