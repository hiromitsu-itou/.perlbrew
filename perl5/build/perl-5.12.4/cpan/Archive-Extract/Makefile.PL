#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Archive::Extract',
    VERSION_FROM  => 'lib/Archive/Extract.pm',
    ABSTRACT_FROM => 'lib/Archive/Extract.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
