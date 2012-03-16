#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'B::Lint',
    VERSION_FROM  => 'lib/B/Lint.pm',
    ABSTRACT_FROM => 'lib/B/Lint.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
