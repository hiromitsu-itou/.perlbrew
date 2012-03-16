#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'ExtUtils::ParseXS',
    VERSION_FROM  => 'lib/ExtUtils/ParseXS.pm',
    ABSTRACT_FROM => 'lib/ExtUtils/ParseXS.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
