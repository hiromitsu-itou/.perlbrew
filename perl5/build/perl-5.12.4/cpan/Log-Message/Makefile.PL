#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Log::Message',
    VERSION_FROM  => 'lib/Log/Message.pm',
    ABSTRACT_FROM => 'lib/Log/Message.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
