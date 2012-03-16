# NOTE: Derived from blib/lib/File/Util.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package File::Util;

#line 997 "blib/lib/File/Util.pm (autosplit into blib/lib/auto/File/Util/can_write.al)"
sub can_write { my($f) = myargs(@_); defined $f ? -w $f : undef }


# --------------------------------------------------------
# File::Util::created()
# --------------------------------------------------------
# end of File::Util::can_write
1;
