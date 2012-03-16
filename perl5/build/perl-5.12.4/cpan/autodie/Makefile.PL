#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'autodie',
    VERSION_FROM  => 'lib/autodie.pm',
    ABSTRACT_FROM => 'lib/autodie.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
