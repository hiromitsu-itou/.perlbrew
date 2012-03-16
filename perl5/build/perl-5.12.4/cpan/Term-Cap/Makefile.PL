#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Term::Cap',
    VERSION_FROM  => 'Cap.pm',
    ABSTRACT_FROM => 'Cap.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
