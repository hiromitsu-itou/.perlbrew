#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Log::Message::Simple',
    VERSION_FROM  => 'lib/Log/Message/Simple.pm',
    ABSTRACT_FROM => 'lib/Log/Message/Simple.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
