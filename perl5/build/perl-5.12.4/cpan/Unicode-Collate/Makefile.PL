#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Unicode::Collate',
    VERSION_FROM  => 'Collate.pm',
    ABSTRACT_FROM => 'Collate.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
