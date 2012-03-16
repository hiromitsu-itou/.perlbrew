#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Params::Check',
    VERSION_FROM  => 'lib/Params/Check.pm',
    ABSTRACT_FROM => 'lib/Params/Check.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
