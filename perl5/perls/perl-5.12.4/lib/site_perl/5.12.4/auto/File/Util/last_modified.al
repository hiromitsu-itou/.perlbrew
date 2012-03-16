# NOTE: Derived from blib/lib/File/Util.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package File::Util;

#line 1197 "blib/lib/File/Util.pm (autosplit into blib/lib/auto/File/Util/last_modified.al)"
# --------------------------------------------------------
# File::Util::last_modified()
# --------------------------------------------------------
sub last_modified {
   my($f) = myargs(@_); $f ||= '';

   return undef unless -e $f;

   # return the last modified time of $f
   $^T - ((-M $f) * 60 * 60 * 24)
}

# end of File::Util::last_modified
1;
