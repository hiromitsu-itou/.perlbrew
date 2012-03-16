#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Parse::CPAN::Meta',
    VERSION_FROM  => 'lib/Parse/CPAN/Meta.pm',
    ABSTRACT_FROM => 'lib/Parse/CPAN/Meta.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
