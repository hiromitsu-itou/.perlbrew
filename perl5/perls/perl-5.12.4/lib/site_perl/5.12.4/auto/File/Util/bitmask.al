# NOTE: Derived from blib/lib/File/Util.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package File::Util;

#line 977 "blib/lib/File/Util.pm (autosplit into blib/lib/auto/File/Util/bitmask.al)"
# --------------------------------------------------------
# File::Util::bitmask()
# --------------------------------------------------------
sub bitmask {
   my($f) = myargs(@_);

   defined $f and -e $f ? sprintf('%04o',(stat($f))[2] & 0777) : undef
}

# end of File::Util::bitmask
1;
