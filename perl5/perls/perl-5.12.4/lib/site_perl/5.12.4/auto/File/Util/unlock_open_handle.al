# NOTE: Derived from blib/lib/File/Util.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package File::Util;

#line 1813 "blib/lib/File/Util.pm (autosplit into blib/lib/auto/File/Util/unlock_open_handle.al)"
# --------------------------------------------------------
# File::Util::unlock_open_handle()
# --------------------------------------------------------
sub unlock_open_handle {
   my($this,$fh) = @_;

   return 1 if !$USE_FLOCK;

   return($this->_throw('not a filehandle.', {'argtype' => ref(\$fh||'')}))
      unless ($fh && ref(\$fh||'') eq 'GLOB');

   if ($CAN_FLOCK) { return flock($fh, &Fcntl::LOCK_UN) } 1;
}

# end of File::Util::unlock_open_handle
1;
