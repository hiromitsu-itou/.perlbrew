#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Pod::Parser',
    VERSION_FROM  => 'lib/Pod/Parser.pm',
    ABSTRACT_FROM => 'lib/Pod/Parser.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
