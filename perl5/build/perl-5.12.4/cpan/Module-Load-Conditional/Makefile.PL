#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Module::Load::Conditional',
    VERSION_FROM  => 'lib/Module/Load/Conditional.pm',
    ABSTRACT_FROM => 'lib/Module/Load/Conditional.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
