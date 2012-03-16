#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Math::Complex',
    VERSION_FROM  => 'lib/Math/Complex.pm',
    ABSTRACT_FROM => 'lib/Math/Complex.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
