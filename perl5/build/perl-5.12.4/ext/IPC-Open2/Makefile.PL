#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'IPC::Open2',
    VERSION_FROM  => 'lib/IPC/Open2.pm',
    ABSTRACT_FROM => 'lib/IPC/Open2.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
