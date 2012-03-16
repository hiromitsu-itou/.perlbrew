#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Thread::Semaphore',
    VERSION_FROM  => 'lib/Thread/Semaphore.pm',
    ABSTRACT_FROM => 'lib/Thread/Semaphore.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
