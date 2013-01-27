use strict;
use warnings FATAL => 'all';
use ExtUtils::MakeMaker;

(do 'maint/Makefile.PL.include' or die $@) unless -f 'META.yml';

WriteMakefile(
  NAME => 'MooX::NonMoo',
  VERSION_FROM => 'lib/MooX/NonMoo.pm',

  PREREQ_PM => {
    'Moo'               => 0,
    'Package::Variant'  => 0,
    'strictures'        => 0,
  },

  META_MERGE => {
    requires => {
        perl => '5.8',
    },
  },
);
