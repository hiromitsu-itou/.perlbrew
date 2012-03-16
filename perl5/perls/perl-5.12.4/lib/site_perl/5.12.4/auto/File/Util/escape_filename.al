# NOTE: Derived from blib/lib/File/Util.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package File::Util;

#line 1019 "blib/lib/File/Util.pm (autosplit into blib/lib/auto/File/Util/escape_filename.al)"
sub escape_filename {
   my($opts) = shave_opts(\@_);
   my($file,$escape,$also) = myargs(@_);

   return '' unless defined $file;

   $escape = '_' if !defined($escape);

   $file = strip_path($file) if $opts->{'--strip-path'};

   if ($also) { $file =~ s/\Q$also\E/$escape/g }

   $file =~ s/$ILLEGAL_CHR/$escape/g;
   $file =~ s/$DIRSPLIT/$escape/g;

   $file
}

# end of File::Util::escape_filename
1;
