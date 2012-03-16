# NOTE: Derived from blib/lib/File/Util.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package File::Util;

#line 1178 "blib/lib/File/Util.pm (autosplit into blib/lib/auto/File/Util/isbin.al)"
# --------------------------------------------------------
# File::Util::isbin()
# --------------------------------------------------------
sub isbin { my($f) = myargs(@_); defined $f ? -B $f : undef }


# --------------------------------------------------------
# File::Util::last_access()
# --------------------------------------------------------
# end of File::Util::isbin
1;
