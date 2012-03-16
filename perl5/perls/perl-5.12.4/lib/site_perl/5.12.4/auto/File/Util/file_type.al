# NOTE: Derived from blib/lib/File/Util.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package File::Util;

#line 1127 "blib/lib/File/Util.pm (autosplit into blib/lib/auto/File/Util/file_type.al)"
# --------------------------------------------------------
# File::Util::file_type()
# --------------------------------------------------------
sub file_type {
   my($f) = myargs(@_);

   return undef unless defined $f and -e $f;

   my(@ret) = ();

   push @ret, 'PLAIN'     if (-f $f);   push @ret, 'TEXT'      if (-T $f);
   push @ret, 'BINARY'    if (-B $f);   push @ret, 'DIRECTORY' if (-d $f);
   push @ret, 'SYMLINK'   if (-l $f);   push @ret, 'PIPE'      if (-p $f);
   push @ret, 'SOCKET'    if (-S $f);   push @ret, 'BLOCK'     if (-b $f);
   push @ret, 'CHARACTER' if (-c $f);   push @ret, 'TTY'       if (-t $f);

   push(@ret,'Error: cannot determine file type') unless @ret; @ret
}

# end of File::Util::file_type
1;
