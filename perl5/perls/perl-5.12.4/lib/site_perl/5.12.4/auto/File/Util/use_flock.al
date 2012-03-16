# NOTE: Derived from blib/lib/File/Util.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package File::Util;

#line 1849 "blib/lib/File/Util.pm (autosplit into blib/lib/auto/File/Util/use_flock.al)"
sub use_flock {
   my($arg) = myargs(@_);

   if (defined($arg)) { $USE_FLOCK = $arg }

   $USE_FLOCK
}

# end of File::Util::use_flock
1;
