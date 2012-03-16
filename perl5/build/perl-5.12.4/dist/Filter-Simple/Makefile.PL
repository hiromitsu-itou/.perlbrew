#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Filter::Simple',
    VERSION_FROM  => 'lib/Filter/Simple.pm',
    ABSTRACT_FROM => 'lib/Filter/Simple.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
