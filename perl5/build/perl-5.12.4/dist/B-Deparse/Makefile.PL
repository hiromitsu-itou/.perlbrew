#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'B::Deparse',
    VERSION_FROM  => 'Deparse.pm',
    ABSTRACT_FROM => 'Deparse.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
