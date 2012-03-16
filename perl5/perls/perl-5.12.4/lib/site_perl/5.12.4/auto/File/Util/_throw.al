# NOTE: Derived from blib/lib/File/Util.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package File::Util;

#line 1858 "blib/lib/File/Util.pm (autosplit into blib/lib/auto/File/Util/_throw.al)"
# --------------------------------------------------------
# File::Util::_throw
# --------------------------------------------------------
sub _throw {
   my($this) = shift(@_); my($opts) = $this->shave_opts(\@_);
   my(%fatal_rules) = ();

   # fatalality-handling rules passed to the failing caller trump the
   # rules set up in the attributes of the object; the mechanism below
   # also allows for the implicit handling of '--fatals-are-fatal'
   map { $fatal_rules{ $_ } = $_ }
   grep(/^--fatals/o, values %$opts);

   unless (scalar keys %fatal_rules) {
      map { $fatal_rules{ $_ } = $_ }
      grep(/^--fatals/o, keys %{ $this->{'opts'} })
   }

   return(0) if $fatal_rules{'--fatals-as-status'};

   $this->{'expt'}||={};

   unless (UNIVERSAL::isa($this->{'expt'},'Exception::Handler')) {
      require Exception::Handler;
      $this->{'expt'} = Exception::Handler->new();
   }

   my($error) = ''; my($in) = {};

   if (@_ == 1) {

      if (defined($_[0])) { $error = 'plain error'; goto PLAIN_ERRORS }
   }
   else { $error = shift(@_) || 'empty error' }

   $in = shift(@_)||{}; $in->{'_pak'} = __PACKAGE__;

   map { $_ = defined($_) ? $_ : 'undefined value' } keys(%$in);

   PLAIN_ERRORS:

   my($bad_news) =
      CORE::eval
         (
            q{<<__ERRORBLOCK__}
            . &NL . &_errors($error)
            . &NL . q{__ERRORBLOCK__}
         );

## for debugging only
#   if ($@) { return $this->{'expt'}->trace($@) }

   if ($fatal_rules{'--fatals-as-warning'}) {

      warn($this->{'expt'}->trace(($@ || $bad_news))) and return
   }
   elsif ( $fatal_rules{'--fatals-as-errmsg'} || $opts->{'--return'}) {

      return($this->{'expt'}->trace(($@ || $bad_news)))
   }

   foreach (keys(%{$in})) {

      next if ($_ eq 'opts');

      $bad_news .= qq[ARG   $_ = $in->{$_}] . $NL;
   }

   if ($in->{'opts'}) {

      foreach (keys(%{$$in{'opts'}})) {

         $_ = (defined($_)) ? $_  : 'empty value';

         $bad_news .= qq[OPT   $_] . $NL;
      }
   }

   warn($this->{'expt'}->trace(($@ || $bad_news))) if ($opts->{'--warn-also'});

   $this->{'expt'}->fail(($@ || $bad_news));

   '';
}

# end of File::Util::_throw
1;
