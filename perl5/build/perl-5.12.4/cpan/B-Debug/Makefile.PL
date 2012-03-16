#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'B::Debug',
    VERSION_FROM  => 'Debug.pm',
    ABSTRACT_FROM => 'Debug.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
