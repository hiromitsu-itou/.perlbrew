#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Tie::File',
    VERSION_FROM  => 'lib/Tie/File.pm',
    ABSTRACT_FROM => 'lib/Tie/File.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
