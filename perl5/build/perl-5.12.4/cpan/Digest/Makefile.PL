#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Digest',
    VERSION_FROM  => 'Digest.pm',
    ABSTRACT_FROM => 'Digest.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
