#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Term::UI',
    VERSION_FROM  => 'lib/Term/UI.pm',
    ABSTRACT_FROM => 'lib/Term/UI.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
