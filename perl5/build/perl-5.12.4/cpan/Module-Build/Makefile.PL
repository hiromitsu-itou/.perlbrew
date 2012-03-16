#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Module::Build',
    VERSION_FROM  => 'lib/Module/Build.pm',
    ABSTRACT_FROM => 'lib/Module/Build.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
