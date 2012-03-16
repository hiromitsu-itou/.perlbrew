# NOTE: Derived from blib/lib/File/Util.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package File::Util;

#line 1223 "blib/lib/File/Util.pm (autosplit into blib/lib/auto/File/Util/load_dir.al)"
# --------------------------------------------------------
# File::Util::load_dir()
# --------------------------------------------------------
sub load_dir {
   my($this) = shift(@_); my($opts) = $this->shave_opts(\@_);
   my($dir)  = shift(@_)||''; my(@files) = ();
   my($dir_hash) = {}; my($dir_list) = [];

   return $this->_throw
      (
         'no input',
         {
            'meth'      => 'load_dir',
            'missing'   => 'a directory name',
            'opts'      => $opts,
         }
      )
   unless length($dir);

   @files = $this->list_dir($dir,'--files-only');

   # map the content of each file into a hash key-value element where the
   # key name for each file is the name of the file
   if (!$opts->{'--as-list'} and !$opts->{'--as-listref'}) {

      foreach (@files) {

         $dir_hash->{ $_ } = $this->load_file( $dir . SL . $_ );
      }

      return($dir_hash);
   }
   else {

      foreach (@files) {

         push(@{$dir_list},$this->load_file( $dir . SL . $_ ));
      }

      return($dir_list) if ($opts->{'--as-listref'}); return(@{$dir_list});
   }

   $dir_hash;
}

# end of File::Util::load_dir
1;
