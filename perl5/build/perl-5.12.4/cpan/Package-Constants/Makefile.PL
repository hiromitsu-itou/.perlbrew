#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Package::Constants',
    VERSION_FROM  => 'lib/Package/Constants.pm',
    ABSTRACT_FROM => 'lib/Package/Constants.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
