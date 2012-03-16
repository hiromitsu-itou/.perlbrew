#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'ExtUtils::CBuilder',
    VERSION_FROM  => 'lib/ExtUtils/CBuilder.pm',
    ABSTRACT_FROM => 'lib/ExtUtils/CBuilder.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
