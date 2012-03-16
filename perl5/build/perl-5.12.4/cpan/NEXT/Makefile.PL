#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'NEXT',
    VERSION_FROM  => 'lib/NEXT.pm',
    ABSTRACT_FROM => 'lib/NEXT.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
