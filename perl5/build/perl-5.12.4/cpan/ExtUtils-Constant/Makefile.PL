#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'ExtUtils::Constant',
    VERSION_FROM  => 'lib/ExtUtils/Constant.pm',
    ABSTRACT_FROM => 'lib/ExtUtils/Constant.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
