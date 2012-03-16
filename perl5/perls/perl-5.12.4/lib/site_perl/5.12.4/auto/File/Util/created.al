# NOTE: Derived from blib/lib/File/Util.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package File::Util;

#line 1003 "blib/lib/File/Util.pm (autosplit into blib/lib/auto/File/Util/created.al)"
sub created {
   my($f) = myargs(@_);

   defined $f and -e $f ? $^T - ((-M $f) * 60 * 60 * 24) : undef
}

# end of File::Util::created
1;
