#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'AutoLoader',
    VERSION_FROM  => 'lib/AutoLoader.pm',
    ABSTRACT_FROM => 'lib/AutoLoader.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
