#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'CGI',
    VERSION_FROM  => 'lib/CGI.pm',
    ABSTRACT_FROM => 'lib/CGI.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
