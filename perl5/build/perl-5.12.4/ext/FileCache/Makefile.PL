#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'FileCache',
    VERSION_FROM  => 'lib/FileCache.pm',
    ABSTRACT_FROM => 'lib/FileCache.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
