#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'PerlIO::via::QuotedPrint',
    VERSION_FROM  => 'lib/PerlIO/via/QuotedPrint.pm',
    ABSTRACT_FROM => 'lib/PerlIO/via/QuotedPrint.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
