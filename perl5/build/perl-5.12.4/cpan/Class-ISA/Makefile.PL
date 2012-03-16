#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Class::ISA',
    VERSION_FROM  => 'lib/Class/ISA.pm',
    ABSTRACT_FROM => 'lib/Class/ISA.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
