# NOTE: Derived from blib/lib/File/Util.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package File::Util;

#line 1187 "blib/lib/File/Util.pm (autosplit into blib/lib/auto/File/Util/last_access.al)"
sub last_access {
   my($f) = myargs(@_); $f ||= '';

   return undef unless -e $f;

   # return the last accessed time of $f
   $^T - ((-A $f) * 60 * 60 * 24)
}

# end of File::Util::last_access
1;
