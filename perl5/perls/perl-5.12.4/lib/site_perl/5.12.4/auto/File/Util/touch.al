# NOTE: Derived from blib/lib/File/Util.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package File::Util;

#line 1047 "blib/lib/File/Util.pm (autosplit into blib/lib/auto/File/Util/touch.al)"
sub touch {
   my($this) = shift(@_); my($opts) = $this->shave_opts(\@_);
   my($in) = $this->coerce_array(@_); my(@dirs) = ();
   my($file) = ''; my($path) = '';
   my($mode) = 'read';

   $file = shift(@_)||'';

   @dirs = split(/$DIRSPLIT/, $file);

   if (scalar(@dirs) > 0) {

      $file = pop(@dirs); $path = join(SL, @dirs);
   }

   if (length($path) > 0) {
      $path = '.' . SL . $path if ($path !~ /(?:^\/)|(?:^\w\:)/o);
   }
   else { $path = '.'; }

   return $this->_throw(
         'no input',
         {
            'meth'      => 'touch',
            'missing'   => 'a file name or file handle reference',
            'opts'      => $opts,
         }
      ) if (length($path . SL . $file) == 0);

   # see if the file exists already and is a directory
   return $this->_throw(
      'cant touch on a dir',
      {
         'filename'  => $path . SL . $file,
         'dirname'   => $path . SL,
         'opts'      => $opts,
      }
   ) if (-e $path . SL . $file && -d $path . SL . $file);

   # if the path doesn't exist, make it
   $this->make_dir($path) unless -e $path . SL;

   # it's good to know beforehand whether or not we have permission to open
   # and read from this file allowing us to handle such an exception before
   # it handles us.

   # first check the readability of the file's housing dir
   return $this->_throw(
      'cant dread',
      {
         'filename'  => $path . SL . $file,
         'dirname'   => $path . SL,
         'opts'      => $opts,
      }
   ) unless (-r $path . SL);

   # now check the writability of the file itself
   return $this->_throw(
      'cant fwrite',
      {
         'filename'  => $path . SL . $file,
         'dirname'   => $path . SL,
         'opts'      => $opts,
      }
   ) if (-e $path . SL . $file && !-w $path . SL . $file);

   # create the file if it doesn't exist (like the *nix touch command does)
   $this->write_file(
      'filename' => $path . SL . $file,
      'content'  => '',
      '--empty-writes-OK'
   ) if !-e $path . SL . $file;

   my($now) = time();

   # return
   return utime $now, $now, $path . SL . $file;
}

# end of File::Util::touch
1;
