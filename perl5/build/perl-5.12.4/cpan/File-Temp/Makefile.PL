#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'File::Temp',
    VERSION_FROM  => 'Temp.pm',
    ABSTRACT_FROM => 'Temp.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
