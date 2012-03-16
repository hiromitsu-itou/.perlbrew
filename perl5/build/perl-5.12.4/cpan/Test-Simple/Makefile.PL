#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Test::Simple',
    VERSION_FROM  => 'lib/Test/Simple.pm',
    ABSTRACT_FROM => 'lib/Test/Simple.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
