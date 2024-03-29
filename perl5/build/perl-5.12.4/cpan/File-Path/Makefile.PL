#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'File::Path',
    VERSION_FROM  => 'lib/File/Path.pm',
    ABSTRACT_FROM => 'lib/File/Path.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
