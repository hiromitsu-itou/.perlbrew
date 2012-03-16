# NOTE: Derived from blib/lib/File/Util.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package File::Util;

#line 1038 "blib/lib/File/Util.pm (autosplit into blib/lib/auto/File/Util/existent.al)"
# --------------------------------------------------------
# File::Util::existent()
# --------------------------------------------------------
sub existent { my($f) = myargs(@_); defined $f ? -e $f : undef }


# --------------------------------------------------------
# File::Util::touch()
# --------------------------------------------------------
# end of File::Util::existent
1;
