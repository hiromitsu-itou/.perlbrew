# NOTE: Derived from blib/lib/File/Util.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package File::Util;

#line 1210 "blib/lib/File/Util.pm (autosplit into blib/lib/auto/File/Util/last_changed.al)"
# --------------------------------------------------------
# File::Util::last_changed()
# --------------------------------------------------------
sub last_changed {
   my($f) = myargs(@_); $f ||= '';

   return undef unless -e $f;

   # return the last changed time of $f
   $^T - ((-C $f) * 60 * 60 * 24)
}

# end of File::Util::last_changed
1;
