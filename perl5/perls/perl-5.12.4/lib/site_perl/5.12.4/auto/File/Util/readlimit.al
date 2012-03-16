# NOTE: Derived from blib/lib/File/Util.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package File::Util;

#line 1428 "blib/lib/File/Util.pm (autosplit into blib/lib/auto/File/Util/readlimit.al)"
# --------------------------------------------------------
# File::Util::readlimt()
# --------------------------------------------------------
sub readlimit {
   my($arg) = myargs(@_);

   if (defined($arg)) {
      return $this->_throw
         (
            'bad readlimit',
            {
               'bad' => $arg,
            }
         ) if $arg !~ /\D/o;

      $READLIMIT = $arg;
   }

   $READLIMIT
}

# end of File::Util::readlimit
1;
