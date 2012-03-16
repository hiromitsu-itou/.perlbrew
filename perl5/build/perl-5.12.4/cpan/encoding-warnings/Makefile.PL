#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'encoding::warnings',
    VERSION_FROM  => 'lib/encoding/warnings.pm',
    ABSTRACT_FROM => 'lib/encoding/warnings.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
