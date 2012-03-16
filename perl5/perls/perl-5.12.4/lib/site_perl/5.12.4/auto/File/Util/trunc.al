# NOTE: Derived from blib/lib/File/Util.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package File::Util;

#line 1843 "blib/lib/File/Util.pm (autosplit into blib/lib/auto/File/Util/trunc.al)"
sub trunc { $_[0]->write_file('mode' => 'trunc', 'file' => $_[1]) }


# --------------------------------------------------------
# File::Util::use_flock()
# --------------------------------------------------------
# end of File::Util::trunc
1;
