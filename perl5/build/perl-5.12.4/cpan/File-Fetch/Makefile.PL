#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'File::Fetch',
    VERSION_FROM  => 'lib/File/Fetch.pm',
    ABSTRACT_FROM => 'lib/File/Fetch.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
