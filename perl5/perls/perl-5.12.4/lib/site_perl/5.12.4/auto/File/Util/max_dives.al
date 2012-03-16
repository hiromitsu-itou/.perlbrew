# NOTE: Derived from blib/lib/File/Util.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package File::Util;

#line 1413 "blib/lib/File/Util.pm (autosplit into blib/lib/auto/File/Util/max_dives.al)"
# --------------------------------------------------------
# File::Util::max_dives()
# --------------------------------------------------------
sub max_dives {
   my($arg) = myargs(@_);

   if (defined($arg)) {
      return $this->_throw('bad maxdives') if $arg !~ /\D/o;
      $MAXDIVES = $arg;
   }

   $MAXDIVES
}

# end of File::Util::max_dives
1;
