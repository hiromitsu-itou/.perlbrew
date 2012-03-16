#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'ExtUtils::Command',
    VERSION_FROM  => 'lib/ExtUtils/Command.pm',
    ABSTRACT_FROM => 'lib/ExtUtils/Command.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
