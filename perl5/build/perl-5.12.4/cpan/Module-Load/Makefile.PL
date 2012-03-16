#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Module::Load',
    VERSION_FROM  => 'lib/Module/Load.pm',
    ABSTRACT_FROM => 'lib/Module/Load.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
