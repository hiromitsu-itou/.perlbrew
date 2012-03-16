# NOTE: Derived from blib/lib/File/Util.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package File::Util;

#line 996 "blib/lib/File/Util.pm (autosplit into blib/lib/auto/File/Util/can_read.al)"
sub can_read  { my($f) = myargs(@_); defined $f ? -r $f : undef }
# end of File::Util::can_read
1;
