#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'CPAN',
    VERSION_FROM  => 'lib/CPAN.pm',
    ABSTRACT_FROM => 'lib/CPAN.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
