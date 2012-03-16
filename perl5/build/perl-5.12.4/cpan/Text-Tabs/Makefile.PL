#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Text::Tabs',
    VERSION_FROM  => 'lib/Text/Tabs.pm',
    ABSTRACT_FROM => 'lib/Text/Tabs.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
