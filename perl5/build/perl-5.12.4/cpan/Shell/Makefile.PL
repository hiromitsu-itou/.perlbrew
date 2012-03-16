#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Shell',
    VERSION_FROM  => 'Shell.pm',
    ABSTRACT_FROM => 'Shell.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
