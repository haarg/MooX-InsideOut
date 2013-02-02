use strict;
use warnings FATAL => 'all';
use ExtUtils::MakeMaker;

(do 'maint/Makefile.PL.include' or die $@) unless -f 'META.yml';

WriteMakefile(
  NAME => 'MooX::InsideOut',
  VERSION_FROM => 'lib/MooX/InsideOut.pm',

  PREREQ_PM => {
    'Moo' => 0,
    'Hash::Util::FieldHash::Compat' => 0,
    'strictures' => 0,
  },
  'BUILD_REQUIRES' => {
    'Test::More' => 0.94,
  },

  META_MERGE => {
    requires => {
      perl => '5.8',
    },
    dynamic_config => 0,
    resources => {
      repository => 'git://github.com/haarg/MooX-InsideOut.git',
      homepage => 'http://github.com/haarg/MooX-InsideOut',
    },
  },
);
