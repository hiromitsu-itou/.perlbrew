# NOTE: Derived from blib/lib/File/Util.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package File::Util;

#line 1459 "blib/lib/File/Util.pm (autosplit into blib/lib/auto/File/Util/open_handle.al)"
sub open_handle {
   my($this)      = shift(@_);
   my($opts)      = $this->shave_opts(\@_);
   my($in)        = $this->coerce_array(@_);
   my($filename)  = $in->{'file'}      || $in->{'filename'} || '';
   my($mode)      = $in->{'mode'}      || 'write';
   my($bitmask)   = _bitmaskify($in->{'bitmask'}) || 0777;
   my($fh)        = undef;
   my($path)      = '';
   my(@dirs)      = ();

   $path = $filename;

   # begin user input validation/sanitation sequence

   # if the call to this method didn't include a filename to which the caller
   # wants us to write, then complain about it
   return $this->_throw(
      'no input',
      {
         'meth'      => 'open_handle',
         'missing'   => 'a file name to create, write, read/write, or append',
         'opts'      => $opts,
      }
   ) unless length($filename);

   # if prospective filename contains 2+ dir separators in sequence then
   # this is a syntax error we need to whine about
   return $this->_throw(
      'bad chars',
      {
         'string'    => $filename,
         'purpose'   => 'the name of a file or directory',
         'opts'      => $opts,
      }
   ) if ($filename =~ /(?:$DIRSPLIT){2,}/);

   # remove trailing directory seperator
   $filename =~ s/$DIRSPLIT$//;

   # determine existance of the file path, make directory(ies) for the
   # path if the full directory path doesn't exist
   @dirs = split(/$DIRSPLIT/, $filename);

   # if prospective file name has illegal chars then complain
   foreach (@dirs) {
      return $this->_throw(
         'bad chars',
         {
            'string'    => $_,
            'purpose'   => 'the name of a file or directory',
            'opts'      => $opts,
         }
      ) if (!$this->valid_filename($_));
   }

   # make sure that open mode is a valid mode
   if (
      !exists($opts->{'--use-sysopen'}) &&
      !defined($opts->{'--use-sysopen'})
   ) {
      # native Perl open modes
      unless (
         exists($$MODES{'popen'}{ $mode }) &&
         defined($$MODES{'popen'}{ $mode })
      ) {
         return $this->_throw(
            'bad openmode popen',
            {
               'meth'      => 'open_handle',
               'filename'  => $filename,
               'badmode'   => $mode,
               'opts'      => $opts,
            }
         )
      }
   }
   else {
      # system open modes
      unless (
         exists($$MODES{'sysopen'}{ $mode }) &&
         defined($$MODES{'sysopen'}{ $mode })
      ) {
         return $this->_throw(
            'bad openmode sysopen',
            {
               'meth'      => 'open_handle',
               'filename'  => $filename,
               'badmode'   => $mode,
               'opts'      => $opts,
            }
         )
      }
   }

   if (scalar(@dirs) > 0) { $filename = pop(@dirs); $path = join(SL, @dirs); }

   if (length($path) > 0) {
      $path = '.' . SL . $path if ($path !~ /(?:^\/)|(?:^\w\:)/o);
   }
   else { $path = '.'; }

   # create path preceding file if path doesn't exist
   $this->make_dir(
      $path,
      exists $in->{'dbitmask'} ? _bitmaskify($in->{'dbitmask'}) : 0777
   ) unless -e $path;

   my($openarg) = qq[$path$SL$filename];

   # sanity checks based on requested mode
   if (
         $mode eq 'write'     ||
         $mode eq 'append'    ||
         $mode eq 'rwcreate'  ||
         $mode eq 'rwclobber' ||
         $mode eq 'rwappend'
   ) {
      # Check whether or not we have permission to open and perform writes
      # on this file.

      if (-e $openarg) {
         return $this->_throw(
            'cant fwrite',
            {
               'filename'  => $openarg,
               'dirname'   => $path,
               'opts'      => $opts,
            }
         ) unless (-w $openarg);
      }
      else {
         # If file doesn't exist and the path isn't writable, the error is
         # one of unallowed creation.
         return $this->_throw(
            'cant fcreate',
            {
               'filename'  => $openarg,
               'dirname'   => $path,
               'opts'      => $opts,
            }
         ) unless (-w $path . SL);
      }
   }
   elsif ($mode eq 'read' || $mode eq 'rwupdate') {
      # Check whether or not we have permission to open and perform reads
      # on this file, starting with file's housing directory.
      return $this->_throw(
         'cant dread',
         {
            'filename'  => $path . SL . $filename,
            'dirname'   => $path,
            'opts'      => $opts,
         }
      ) unless (-r $path . SL);

      # Seems obvious, but we can't read non-existent files
      return $this->_throw(
         'cant fread not found',
         {
            'filename'  => $path . SL . $filename,
            'dirname'   => $path,
            'opts'      => $opts,
         }
      ) unless (-e $path . SL . $filename);

      # Check the readability of the file itself
      return $this->_throw(
         'cant fread',
         {
            'filename'  => $path . SL . $filename,
            'dirname'   => $path,
            'opts'      => $opts,
         }
      ) unless (-r $path . SL . $filename);
   }
   else {
      return $this->_throw(
         'no input',
         {
            'meth'      => 'open_handle',
            'missing'   => q{a valid IO mode. (eg- 'read', 'write'...)},
            'opts'      => $opts,
         }
      )
   }
   # input validation sequence finished

   # we need a unique filehandle
   do { $fh = int(rand(time)) . $$; $fh = eval('*' . 'OPEN_TO_FH' . $fh) }
   while ( fileno($fh) );

   # if you use the '--no-lock' option you are probably inefficient
   if ($$opts{'--no-lock'} || !$USE_FLOCK) {
      if (
         !exists($opts->{'--use-sysopen'}) &&
         !defined($opts->{'--use-sysopen'})
      ) { # perl open
         # get open mode
         $mode = $$MODES{'popen'}{ $mode };

         open($fh, $mode . $openarg) or
            return $this->_throw(
               'bad open',
               {
                  'filename'  => $openarg,
                  'mode'      => $mode,
                  'exception' => $!,
                  'cmd'       => $mode . $openarg,
                  'opts'      => $opts,
               }
            );
      }
      else { # sysopen
         # get open mode
         $mode = $$MODES{'sysopen'}{ $mode };

         sysopen($fh, $openarg, eval($$MODES{'sysopen'}{ $mode })) or
            return $this->_throw(
               'bad open',
               {
                  'filename'  => $openarg,
                  'mode'      => $mode,
                  'exception' => $!,
                  'cmd'       => qq{$openarg, $$MODES{'sysopen'}{ $mode }},
                  'opts'      => $opts,
               }
            );
      }
   }
   else {
      if (
         !exists($opts->{'--use-sysopen'}) &&
         !defined($opts->{'--use-sysopen'})
      ) { # perl open
         # open read-only first to safely check if we can get a lock.
         if (-e $openarg) {

            open($fh, '<' . $openarg) or
               return $this->_throw(
                  'bad open',
                  {
                     'filename'  => $openarg,
                     'mode'      => 'read',
                     'exception' => $!,
                     'cmd'       => $mode . $openarg,
                     'opts'      => $opts,
                  }
               );

            # lock file before I/O on platforms that support it
            my($lockstat) = $this->_seize($openarg, $fh);

            return($lockstat) unless $lockstat;

            if ($mode ne 'read') {
               open($fh, $$MODES{'popen'}{ $mode } . $openarg) or
                  return $this->_throw(
                     'bad open',
                     {
                        'exception' => $!,
                        'filename'  => $openarg,
                        'mode'      => $mode,
                        'opts'      => $opts,
                        'cmd'       => $$MODES{'popen'}{ $mode } . $openarg,
                     }
                  );
            }
         }
         else {
            open($fh, $$MODES{'popen'}{ $mode } . $openarg) or
               return $this->_throw(
                  'bad open',
                  {
                     'exception' => $!,
                     'filename'  => $openarg,
                     'mode'      => $mode,
                     'opts'      => $opts,
                     'cmd'       => $$MODES{'popen'}{ $mode } . $openarg,
                  }
               );

            # lock file before I/O on platforms that support it
            my($lockstat) = $this->_seize($openarg, $fh);

            return($lockstat) unless $lockstat;
         }
      }
      else { # sysopen
         # open read-only first to safely check if we can get a lock.
         if (-e $openarg) {

            open($fh, '<' . $openarg) or
               return $this->_throw(
                  'bad open',
                  {
                     'filename'  => $openarg,
                     'mode'      => 'read',
                     'exception' => $!,
                     'cmd'       => $mode . $openarg,
                     'opts'      => $opts,
                  }
               );

            # lock file before I/O on platforms that support it
            my($lockstat) = $this->_seize($openarg, $fh);

            return($lockstat) unless $lockstat;

            sysopen($fh, $openarg, eval($$MODES{'sysopen'}{ $mode }))
               or return $this->_throw(
                  'bad open',
                  {
                     'filename'  => $openarg,
                     'mode'      => $mode,
                     'opts'      => $opts,
                     'exception' => $!,
                     'cmd'       => qq{$openarg, $$MODES{'sysopen'}{ $mode }},
                  }
               );
         }
         else { # only non-existent files get bitmask arguments
            sysopen(
               $fh,
               $openarg,
               eval($$MODES{'sysopen'}{ $mode }),
               $bitmask
            ) or return $this->_throw(
               'bad open',
               {
                  'filename'  => $openarg,
                  'mode'      => $mode,
                  'opts'      => $opts,
                  'exception' => $!,
                  'cmd'   => qq{$openarg, $$MODES{'sysopen'}{$mode}, $bitmask},
               }
            );

            # lock file before I/O on platforms that support it
            my($lockstat) = $this->_seize($openarg, $fh);

            return($lockstat) unless $lockstat;
         }
      }
   }

   # call binmode on the filehandle if it was requested
   CORE::binmode($fh) if $in->{'binmode'} || $opts->{'--binmode'};

   # return file handle reference to the caller
   $fh;
}

# end of File::Util::open_handle
1;
