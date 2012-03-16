#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'attributes',
    VERSION_FROM  => 'attributes.pm',
    ABSTRACT_FROM => 'attributes.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
