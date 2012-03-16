#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'IO::Zlib',
    VERSION_FROM  => 'Zlib.pm',
    ABSTRACT_FROM => 'Zlib.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
