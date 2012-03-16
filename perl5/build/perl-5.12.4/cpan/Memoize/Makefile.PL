#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Memoize',
    VERSION_FROM  => 'Memoize.pm',
    ABSTRACT_FROM => 'Memoize.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
