#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'ExtUtils::Manifest',
    VERSION_FROM  => 'lib/ExtUtils/Manifest.pm',
    ABSTRACT_FROM => 'lib/ExtUtils/Manifest.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
