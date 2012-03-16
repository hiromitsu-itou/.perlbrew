# NOTE: Derived from blib/lib/File/Util.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package File::Util;

#line 1269 "blib/lib/File/Util.pm (autosplit into blib/lib/auto/File/Util/make_dir.al)"
# --------------------------------------------------------
# File::Util::make_dir()
# --------------------------------------------------------
sub make_dir {
   my($this) = shift(@_);
   my($opts) = $this->shave_opts(\@_);
   my($dir,$bitmask) = @_; $bitmask = _bitmaskify($bitmask) || 0777;

   if ($$opts{'--if-not-exists'}) {
      if (-e $dir) {
         return $dir if -d $dir;

         return $this->_throw(
            'called mkdir on a file',
            {
               'filename'  => $dir,
               'dirname'   => join(SL,(split(/$DIRSPLIT/,$dir))[0 .. -1]) . SL
            }
         );
      }
   }
   else {
      if (-e $dir) {
         return $this->_throw(
            'called mkdir on a file',
            {
               'filename'  => $dir,
               'dirname'   => join(SL,(split(/$DIRSPLIT/,$dir))[0 .. -1]) . SL
            }
         ) unless -d $dir;

         return $this->_throw(
            'make_dir target exists',
            {
               'dirname'  => $dir,
               'filetype'  => [ $this->file_type($dir) ],
            }
         );
      }
   }

   # if the call to this method didn't include a directory name to create,
   # then complain about it
   return $this->_throw(
      'no input',
      {
         'meth'      => 'make_dir',
         'missing'   => 'a directory name',
      }
   ) unless (defined($dir) && length($dir));

   # if prospective directory name contains 2+ dir separators in sequence then
   # this is a syntax error we need to whine about
   return $this->_throw(
      'bad chars',
      {
         'string'    => $dir,
         'purpose'   => 'the name of a directory',
      }
   ) if ($dir =~ /$DIRSPLIT{2,}/);

   $dir =~ s/$DIRSPLIT$// unless $dir eq $DIRSPLIT;

   my(@dirs_in_path) = split(/$DIRSPLIT/, $dir);

   # for absolute pathnames
   if (substr($dir,0,1) eq SL) {
      $dirs_in_path[0] = SL;
   }

   for (my($i) = 0; $i < scalar @dirs_in_path; ++$i) {
      next if $i == 0 && $dirs_in_path[$i] eq SL;

      # if prospective directory name contains illegal chars then complain
      return $this->_throw(
         'bad chars',
         {
            'string'    => $dirs_in_path[$i],
            'purpose'   => 'the name of a directory',
         }
      ) unless $this->valid_filename($dirs_in_path[$i])
   }

   # qualify each subdir in @dirs_in_path by prepending its preceeding dir
   # names to it. Above, "/foo/bar/baz" becomes ("/", "foo", "bar", "baz")
   # and below it becomes ("/", "/foo", "/foo/bar", "/foo/bar/baz")

   if (scalar(@dirs_in_path) > 1) {
      for (my($depth) = 1; $depth < scalar @dirs_in_path; ++$depth) {
         if ($dirs_in_path[$depth-1] eq SL) {
            $dirs_in_path[$depth] = SL . $dirs_in_path[$depth]
         }
         else {
            $dirs_in_path[$depth] = join(SL, @dirs_in_path[($depth-1)..$depth])
         }
      }
   }

   my($i) = 0;

   foreach (@dirs_in_path) {
      my($dir) = $_;
      my($up)    = ($i > 0) ? $dirs_in_path[$i-1] : '..';

      ++$i;

      if (-e $dir and !-d $dir) {
         return $this->_throw(
            'called mkdir on a file',
            {
               'filename'  => $dir,
               'dirname'   => $up . SL,
            }
         );
      }

      next if -e $dir;

      # it's good to know beforehand whether or not we have permission to
      # create dirs here, which allows us to handle such an exception
      # before it handles us.
      return $this->_throw(
         'cant dcreate',
         {
            'dirname'  => $dir,
            'parentd'   => $up,
         }
      ) unless -w $up;

      mkdir($dir, $bitmask) or
         return $this->_throw(
            'bad make_dir',
            {
               'exception' => $!,
               'dirname'   => $dir,
               'bitmask'   => $bitmask,
            }
         );
   }

   $dir;
}

# end of File::Util::make_dir
1;
