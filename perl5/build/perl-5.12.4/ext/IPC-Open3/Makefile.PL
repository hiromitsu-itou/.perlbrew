#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'IPC::Open3',
    VERSION_FROM  => 'lib/IPC/Open3.pm',
    ABSTRACT_FROM => 'lib/IPC/Open3.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
