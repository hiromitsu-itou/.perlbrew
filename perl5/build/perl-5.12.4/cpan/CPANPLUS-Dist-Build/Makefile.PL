#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'CPANPLUS::Dist::Build',
    VERSION_FROM  => 'lib/CPANPLUS/Dist/Build.pm',
    ABSTRACT_FROM => 'lib/CPANPLUS/Dist/Build.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
