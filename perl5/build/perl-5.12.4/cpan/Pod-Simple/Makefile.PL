#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Pod::Simple',
    VERSION_FROM  => 'lib/Pod/Simple.pm',
    ABSTRACT_FROM => 'lib/Pod/Simple.pod',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
