#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'constant',
    VERSION_FROM  => 'lib/constant.pm',
    ABSTRACT_FROM => 'lib/constant.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
