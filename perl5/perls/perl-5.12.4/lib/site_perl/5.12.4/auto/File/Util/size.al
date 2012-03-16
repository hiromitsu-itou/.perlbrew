# NOTE: Derived from blib/lib/File/Util.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package File::Util;

#line 1837 "blib/lib/File/Util.pm (autosplit into blib/lib/auto/File/Util/size.al)"
sub size { my($f) = myargs(@_); $f ||= ''; return undef unless -e $f; -s $f }


# --------------------------------------------------------
# File::Util::trunc()
# --------------------------------------------------------
# end of File::Util::size
1;
