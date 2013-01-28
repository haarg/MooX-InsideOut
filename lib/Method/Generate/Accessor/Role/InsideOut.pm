package Method::Generate::Accessor::Role::InsideOut;
use Moo::Role;

use Hash::Util::FieldHash::Compat qw(fieldhash);
use B qw(perlstring);

fieldhash our %FIELDS;

around generate_method => sub {
    my $orig = shift;
    my $self = shift;
    # would like a better way to disable XS
    local $Method::Generate::Accessor::CAN_HAZ_XS = 0;
    $self->$orig(@_);
};

sub _generate_simple_has {
    my ($self, $me, $name) = @_;
    my $name_str = perlstring $name;
    $self->{captures}{'$FIELDS'} = \\%FIELDS;
    "exists \$FIELDS->{${me}}->{${$name_str}}";
}

sub _generate_simple_clear {
    my ($self, $me, $name) = @_;
    my $name_str = perlstring $name;
    $self->{captures}{'$FIELDS'} = \\%FIELDS;
    "    delete \$FIELDS->{${me}}->{${name_str}}";
}

sub _generate_simple_get {
    my ($self, $me, $name) = @_;
    my $name_str = perlstring $name;
    $self->{captures}{'$FIELDS'} = \\%FIELDS;
    "\$FIELDS->{${me}}->{${name_str}}";
}

sub _generate_core_set {
    my ($self, $me, $name, $spec, $value) = @_;
    my $name_str = perlstring $name;
    $self->{captures}{'$FIELDS'} = \\%FIELDS;
    "\$FIELDS->{${me}}->{${name_str}} = ${value}";
}

sub _generate_xs {
    die "Can't generate XS accessors for inside out objects";
}

sub default_construction_string { '\(my $s)' }

1;
