#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Module::Loaded',
    VERSION_FROM  => 'lib/Module/Loaded.pm',
    ABSTRACT_FROM => 'lib/Module/Loaded.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
