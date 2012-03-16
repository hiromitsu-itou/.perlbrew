#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Text::Balanced',
    VERSION_FROM  => 'lib/Text/Balanced.pm',
    ABSTRACT_FROM => 'lib/Text/Balanced.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
