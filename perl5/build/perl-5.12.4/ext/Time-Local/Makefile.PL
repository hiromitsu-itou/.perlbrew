#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Time::Local',
    VERSION_FROM  => 'lib/Time/Local.pm',
    ABSTRACT_FROM => 'lib/Time/Local.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
