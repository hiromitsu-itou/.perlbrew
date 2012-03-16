#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'parent',
    VERSION_FROM  => 'lib/parent.pm',
    ABSTRACT_FROM => 'lib/parent.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
