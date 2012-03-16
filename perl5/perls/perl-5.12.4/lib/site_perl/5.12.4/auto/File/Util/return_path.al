# NOTE: Derived from blib/lib/File/Util.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package File::Util;

#line 1828 "blib/lib/File/Util.pm (autosplit into blib/lib/auto/File/Util/return_path.al)"
# --------------------------------------------------------
# File::Util::return_path()
# --------------------------------------------------------
sub return_path { my($f) = myargs(@_); $f =~ s/(^.*)$DIRSPLIT.*/$1/o; $f }


# --------------------------------------------------------
# File::Util::size()
# --------------------------------------------------------
# end of File::Util::return_path
1;
