#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Getopt::Long',
    VERSION_FROM  => 'lib/Getopt/Long.pm',
    ABSTRACT_FROM => 'lib/Getopt/Long.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
