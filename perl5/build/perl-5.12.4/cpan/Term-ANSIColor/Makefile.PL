#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Term::ANSIColor',
    VERSION_FROM  => 'ANSIColor.pm',
    ABSTRACT_FROM => 'ANSIColor.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
