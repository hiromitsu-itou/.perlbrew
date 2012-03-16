# NOTE: Derived from blib/lib/File/Util.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package File::Util;

#line 1147 "blib/lib/File/Util.pm (autosplit into blib/lib/auto/File/Util/flock_rules.al)"
# --------------------------------------------------------
# File::Util::flock_rules()
# --------------------------------------------------------
sub flock_rules {
   my($this)   = shift(@_);
   my(@rules)  = myargs(@_);

   return @ONLOCKFAIL unless defined scalar @rules;

   my(%valid) = qw/
      NOBLOCKEX   NOBLOCKEX
      NOBLOCKSH   NOBLOCKSH
      BLOCKEX     BLOCKEX
      BLOCKSH     BLOCKSH
      FAIL        FAIL
      WARN        WARN
      IGNORE      IGNORE
      UNDEF       UNDEF
      ZERO        ZERO /;

   map {
      return $this->_throw('bad flock rules', { 'bad' => $_, 'all' => \@rules })
      unless exists $valid{ $_ }
   } @rules;

   @ONLOCKFAIL = @rules;

   @ONLOCKFAIL
}

# end of File::Util::flock_rules
1;
