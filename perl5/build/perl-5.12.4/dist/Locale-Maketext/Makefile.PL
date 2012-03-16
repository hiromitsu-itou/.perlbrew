#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Locale::Maketext',
    VERSION_FROM  => 'lib/Locale/Maketext.pm',
    ABSTRACT_FROM => 'lib/Locale/Maketext.pod',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
