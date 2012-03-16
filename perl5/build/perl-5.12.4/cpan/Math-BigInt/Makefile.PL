#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Math::BigInt',
    VERSION_FROM  => 'lib/Math/BigInt.pm',
    ABSTRACT_FROM => 'lib/Math/BigInt.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
