#-*- buffer-read-only: t -*-

# This Makefile.PL was written by make_ext.pl.
# It will be deleted automatically by make realclean

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'I18N::LangTags',
    VERSION_FROM  => 'lib/I18N/LangTags.pm',
    ABSTRACT_FROM => 'lib/I18N/LangTags.pm',
    realclean     => {FILES => 'Makefile.PL'},
);

# ex: set ro:
