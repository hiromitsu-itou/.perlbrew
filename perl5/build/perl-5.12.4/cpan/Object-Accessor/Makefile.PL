#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Object::Accessor',
    VERSION_FROM  => 'lib/Object/Accessor.pm',
    ABSTRACT_FROM => 'lib/Object/Accessor.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
