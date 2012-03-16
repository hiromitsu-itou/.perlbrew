#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'if',
    VERSION_FROM  => 'if.pm',
    ABSTRACT_FROM => 'if.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
