package Time::Duration::Parse;

use strict;
our $VERSION = '0.06';

use Carp;
use Exporter::Lite;
our @EXPORT = qw( parse_duration );

# This map is taken from Cache and Cache::Cache
# map of expiration formats to their respective time in seconds
my %Units = ( map(($_,             1), qw(s second seconds sec secs)),
              map(($_,            60), qw(m minute minutes min mins)),
              map(($_,         60*60), qw(h hr hour hours)),
              map(($_,      60*60*24), qw(d day days)),
              map(($_,    60*60*24*7), qw(w week weeks)),
              map(($_,   60*60*24*30), qw(M month months)),
              map(($_,  60*60*24*365), qw(y year years)) );

sub parse_duration {
    my $timespec = shift;

    # Treat a plain number as a number of seconds (and parse it later)
    if ($timespec =~ /^\s*(-?\d+(?:[.,]\d+)?)\s*$/) {
        $timespec = "$1s";
    }

    # Convert hh:mm(:ss)? to something we understand
    $timespec =~ s/\b(\d+):(\d\d):(\d\d)\b/$1h $2m $3s/g;
    $timespec =~ s/\b(\d+):(\d\d)\b/$1h $2m/g;

    my $duration = 0;
    while ($timespec =~ s/^\s*(-?\d+(?:[.,]\d+)?)\s*([a-zA-Z]+)(?:\s*(?:,|and)\s*)*//i) {
        my($amount, $unit) = ($1, $2);
        $unit = lc($unit) unless length($unit) == 1;

        if (my $value = $Units{$unit}) {
            $amount =~ s/,/./;
            $duration += $amount * $value;
        } else {
            Carp::croak "Unknown timespec: $1 $2";
        }
    }

    if ($timespec =~ /\S/) {
        Carp::croak "Unknown timespec: $timespec";
    }

    return sprintf "%.0f", $duration;
}

1;
__END__

=head1 NAME

Time::Duration::Parse - Parse string that represents time duration

=head1 SYNOPSIS

  use Time::Duration::Parse;

  my $seconds = parse_duration("2 minutes and 3 seconds"); # 123

=head1 DESCRIPTION

Time::Duration::Parse is a module to parse human readable duration
strings like I<2 minutes and 3 seconds> to seconds.

It does the opposite of I<duration_exact> function in Time::Duration
and is roundtrip safe. So, the following is always true.

  use Time::Duration::Parse;
  use Time::Duration;

  my $seconds = int rand 100000;
  is( parse_duration(duration_exact($seconds)), $seconds );

=head1 FUNCTIONS

=over 4

=item parse_duration

  $seconds = parse_duration($string);

Parses duration string and returns seconds. When it encounters an
error in a given string, it dies an exception saying "Unknown
timespec: blah blah blah". This function is exported by default.

=head1 AUTHOR

Tatsuhiko Miyagawa E<lt>miyagawa@bulknews.netE<gt>

=head1 COPYRIGHT

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

Some internal code is taken from Cache and Cache::Cache modules on
CPAN.

=head1 SEE ALSO

L<Date::Manip>, L<DateTime::Format::Duration>, L<http://use.perl.org/~miyagawa/journal/30310>

=cut
