#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Tie::Memoize',
    VERSION_FROM  => 'lib/Tie/Memoize.pm',
    ABSTRACT_FROM => 'lib/Tie/Memoize.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
