use strict;
use warnings;
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

{
  package MooBase;
  use Moo;

  has dallas => (is => 'rw');
}

{
  package MooInsideOutFromMoo;
  use Moo;
  use MooX::InsideOut;
  extends 'MooBase';

  has sallad => ( is => 'rw' );
}

my $o2 = MooInsideOutFromMoo->new;
$o2->dallas(1);
$o2->sallad(2);
is $o2->dallas, 1, 'inherit from normal moo: base class accessors work';
is $o2->sallad, 2, 'inherit from normal moo: subclass attributes work';
is $o2->{sallad}, undef, 'inherit from normal moo: insideout attributes not directly accessible';

done_testing;
