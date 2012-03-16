###########################################################################
#
# This file is auto-generated by the Perl DateTime Suite locale
# generator (0.05).  This code generator comes with the
# DateTime::Locale distribution in the tools/ directory, and is called
# generate-from-cldr.
#
# This file as generated from the CLDR XML locale data.  See the
# LICENSE.cldr file included in this distribution for license details.
#
# This file was generated from the source file fi_FI.xml
# The source file version number was 1.49, generated on
# 2009/05/05 23:06:36.
#
# Do not edit this file directly.
#
###########################################################################

package DateTime::Locale::fi_FI;

use strict;
use warnings;
use utf8;

use base 'DateTime::Locale::fi';

sub cldr_version { return "1\.7\.1" }

{
    my $first_day_of_week = "1";
    sub first_day_of_week { return $first_day_of_week }
}

{
    my $glibc_date_format = "\%d\.\%m\.\%Y";
    sub glibc_date_format { return $glibc_date_format }
}

{
    my $glibc_date_1_format = "\%a\ \%\-d\.\%\-m\.\%Y\ \%H\.\%M\.\%S\ \%z";
    sub glibc_date_1_format { return $glibc_date_1_format }
}

{
    my $glibc_datetime_format = "\%a\ \%e\.\ \%Bta\ \%Y\ \%H\.\%M\.\%S";
    sub glibc_datetime_format { return $glibc_datetime_format }
}

{
    my $glibc_time_format = "\%H\.\%M\.\%S";
    sub glibc_time_format { return $glibc_time_format }
}

1;

__END__


=pod

=encoding utf8

=head1 NAME

DateTime::Locale::fi_FI

=head1 SYNOPSIS

  use DateTime;

  my $dt = DateTime->now( locale => 'fi_FI' );
  print $dt->month_name();

=head1 DESCRIPTION

This is the DateTime locale package for Finnish Finland.

=head1 DATA

This locale inherits from the L<DateTime::Locale::fi> locale.

It contains the following data.

=head2 Days

=head3 Wide (format)

  maanantaina
  tiistaina
  keskiviikkona
  torstaina
  perjantaina
  lauantaina
  sunnuntaina

=head3 Abbreviated (format)

  ma
  ti
  ke
  to
  pe
  la
  su

=head3 Narrow (format)

  M
  T
  K
  T
  P
  L
  S

=head3 Wide (stand-alone)

  maanantai
  tiistai
  keskiviikko
  torstai
  perjantai
  lauantai
  sunnuntai

=head3 Abbreviated (stand-alone)

  ma
  ti
  ke
  to
  pe
  la
  su

=head3 Narrow (stand-alone)

  M
  T
  K
  T
  P
  L
  S

=head2 Months

=head3 Wide (format)

  tammikuuta
  helmikuuta
  maaliskuuta
  huhtikuuta
  toukokuuta
  kesäkuuta
  heinäkuuta
  elokuuta
  syyskuuta
  lokakuuta
  marraskuuta
  joulukuuta

=head3 Abbreviated (format)

  tammikuuta
  helmikuuta
  maaliskuuta
  huhtikuuta
  toukokuuta
  kesäkuuta
  heinäkuuta
  elokuuta
  syyskuuta
  lokakuuta
  marraskuuta
  joulukuuta

=head3 Narrow (format)

  T
  H
  M
  H
  T
  K
  H
  E
  S
  L
  M
  J

=head3 Wide (stand-alone)

  tammikuu
  helmikuu
  maaliskuu
  huhtikuu
  toukokuu
  kesäkuu
  heinäkuu
  elokuu
  syyskuu
  lokakuu
  marraskuu
  joulukuu

=head3 Abbreviated (stand-alone)

  tammi
  helmi
  maalis
  huhti
  touko
  kesä
  heinä
  elo
  syys
  loka
  marras
  joulu

=head3 Narrow (stand-alone)

  T
  H
  M
  H
  T
  K
  H
  E
  S
  L
  M
  J

=head2 Quarters

=head3 Wide (format)

  1. neljännes
  2. neljännes
  3. neljännes
  4. neljännes

=head3 Abbreviated (format)

  1. nelj.
  2. nelj.
  3. nelj.
  4. nelj.

=head3 Narrow (format)

  1
  2
  3
  4

=head3 Wide (stand-alone)

  1. neljännes
  2. neljännes
  3. neljännes
  4. neljännes

=head3 Abbreviated (stand-alone)

  1. nelj.
  2. nelj.
  3. nelj.
  4. nelj.

=head3 Narrow (stand-alone)

  1
  2
  3
  4

=head2 Eras

=head3 Wide

  ennen Kristuksen syntymää
  jälkeen Kristuksen syntymän

=head3 Abbreviated

  eKr.
  jKr.

=head3 Narrow

  eKr.
  jKr.

=head2 Date Formats

=head3 Full

   2008-02-05T18:30:30 = tiistaina 5. helmikuuta 2008
   1995-12-22T09:05:02 = perjantaina 22. joulukuuta 1995
  -0010-09-15T04:44:23 = lauantaina 15. syyskuuta -10

=head3 Long

   2008-02-05T18:30:30 = 5. helmikuuta 2008
   1995-12-22T09:05:02 = 22. joulukuuta 1995
  -0010-09-15T04:44:23 = 15. syyskuuta -10

=head3 Medium

   2008-02-05T18:30:30 = 5.2.2008
   1995-12-22T09:05:02 = 22.12.1995
  -0010-09-15T04:44:23 = 15.9.-010

=head3 Short

   2008-02-05T18:30:30 = 5.2.2008
   1995-12-22T09:05:02 = 22.12.1995
  -0010-09-15T04:44:23 = 15.9.-010

=head3 Default

   2008-02-05T18:30:30 = 5.2.2008
   1995-12-22T09:05:02 = 22.12.1995
  -0010-09-15T04:44:23 = 15.9.-010

=head2 Time Formats

=head3 Full

   2008-02-05T18:30:30 = 18.30.30 UTC
   1995-12-22T09:05:02 = 9.05.02 UTC
  -0010-09-15T04:44:23 = 4.44.23 UTC

=head3 Long

   2008-02-05T18:30:30 = 18.30.30 UTC
   1995-12-22T09:05:02 = 9.05.02 UTC
  -0010-09-15T04:44:23 = 4.44.23 UTC

=head3 Medium

   2008-02-05T18:30:30 = 18.30.30
   1995-12-22T09:05:02 = 9.05.02
  -0010-09-15T04:44:23 = 4.44.23

=head3 Short

   2008-02-05T18:30:30 = 18.30
   1995-12-22T09:05:02 = 9.05
  -0010-09-15T04:44:23 = 4.44

=head3 Default

   2008-02-05T18:30:30 = 18.30.30
   1995-12-22T09:05:02 = 9.05.02
  -0010-09-15T04:44:23 = 4.44.23

=head2 Datetime Formats

=head3 Full

   2008-02-05T18:30:30 = tiistaina 5. helmikuuta 2008 18.30.30 UTC
   1995-12-22T09:05:02 = perjantaina 22. joulukuuta 1995 9.05.02 UTC
  -0010-09-15T04:44:23 = lauantaina 15. syyskuuta -10 4.44.23 UTC

=head3 Long

   2008-02-05T18:30:30 = 5. helmikuuta 2008 18.30.30 UTC
   1995-12-22T09:05:02 = 22. joulukuuta 1995 9.05.02 UTC
  -0010-09-15T04:44:23 = 15. syyskuuta -10 4.44.23 UTC

=head3 Medium

   2008-02-05T18:30:30 = 5.2.2008 18.30.30
   1995-12-22T09:05:02 = 22.12.1995 9.05.02
  -0010-09-15T04:44:23 = 15.9.-010 4.44.23

=head3 Short

   2008-02-05T18:30:30 = 5.2.2008 18.30
   1995-12-22T09:05:02 = 22.12.1995 9.05
  -0010-09-15T04:44:23 = 15.9.-010 4.44

=head3 Default

   2008-02-05T18:30:30 = 5.2.2008 18.30.30
   1995-12-22T09:05:02 = 22.12.1995 9.05.02
  -0010-09-15T04:44:23 = 15.9.-010 4.44.23

=head2 Available Formats

=head3 d (d)

   2008-02-05T18:30:30 = 5
   1995-12-22T09:05:02 = 22
  -0010-09-15T04:44:23 = 15

=head3 EEEd (EEE d.)

   2008-02-05T18:30:30 = ti 5.
   1995-12-22T09:05:02 = pe 22.
  -0010-09-15T04:44:23 = la 15.

=head3 HHmmss (HH.mm.ss)

   2008-02-05T18:30:30 = 18.30.30
   1995-12-22T09:05:02 = 09.05.02
  -0010-09-15T04:44:23 = 04.44.23

=head3 Hm (H.mm)

   2008-02-05T18:30:30 = 18.30
   1995-12-22T09:05:02 = 9.05
  -0010-09-15T04:44:23 = 4.44

=head3 hm (h.mm a)

   2008-02-05T18:30:30 = 6.30 ip.
   1995-12-22T09:05:02 = 9.05 ap.
  -0010-09-15T04:44:23 = 4.44 ap.

=head3 Hms (H:mm:ss)

   2008-02-05T18:30:30 = 18:30:30
   1995-12-22T09:05:02 = 9:05:02
  -0010-09-15T04:44:23 = 4:44:23

=head3 hms (h.mm.ss a)

   2008-02-05T18:30:30 = 6.30.30 ip.
   1995-12-22T09:05:02 = 9.05.02 ap.
  -0010-09-15T04:44:23 = 4.44.23 ap.

=head3 M (L)

   2008-02-05T18:30:30 = 2
   1995-12-22T09:05:02 = 12
  -0010-09-15T04:44:23 = 9

=head3 Md (d.M.)

   2008-02-05T18:30:30 = 5.2.
   1995-12-22T09:05:02 = 22.12.
  -0010-09-15T04:44:23 = 15.9.

=head3 MEd (E d.M.)

   2008-02-05T18:30:30 = ti 5.2.
   1995-12-22T09:05:02 = pe 22.12.
  -0010-09-15T04:44:23 = la 15.9.

=head3 MMM (LLL)

   2008-02-05T18:30:30 = helmi
   1995-12-22T09:05:02 = joulu
  -0010-09-15T04:44:23 = syys

=head3 MMMd (d. MMM)

   2008-02-05T18:30:30 = 5. helmikuuta
   1995-12-22T09:05:02 = 22. joulukuuta
  -0010-09-15T04:44:23 = 15. syyskuuta

=head3 MMMEd (E d. MMM)

   2008-02-05T18:30:30 = ti 5. helmikuuta
   1995-12-22T09:05:02 = pe 22. joulukuuta
  -0010-09-15T04:44:23 = la 15. syyskuuta

=head3 MMMMd (d. MMMM)

   2008-02-05T18:30:30 = 5. helmikuuta
   1995-12-22T09:05:02 = 22. joulukuuta
  -0010-09-15T04:44:23 = 15. syyskuuta

=head3 MMMMEd (E d. MMMM)

   2008-02-05T18:30:30 = ti 5. helmikuuta
   1995-12-22T09:05:02 = pe 22. joulukuuta
  -0010-09-15T04:44:23 = la 15. syyskuuta

=head3 ms (mm.ss)

   2008-02-05T18:30:30 = 30.30
   1995-12-22T09:05:02 = 05.02
  -0010-09-15T04:44:23 = 44.23

=head3 y (y)

   2008-02-05T18:30:30 = 2008
   1995-12-22T09:05:02 = 1995
  -0010-09-15T04:44:23 = -10

=head3 yM (L.yyyy)

   2008-02-05T18:30:30 = 2.2008
   1995-12-22T09:05:02 = 12.1995
  -0010-09-15T04:44:23 = 9.-010

=head3 yMEd (EEE d.M.yyyy)

   2008-02-05T18:30:30 = ti 5.2.2008
   1995-12-22T09:05:02 = pe 22.12.1995
  -0010-09-15T04:44:23 = la 15.9.-010

=head3 yMMM (LLL y)

   2008-02-05T18:30:30 = helmi 2008
   1995-12-22T09:05:02 = joulu 1995
  -0010-09-15T04:44:23 = syys -10

=head3 yMMMEd (EEE d. MMM y)

   2008-02-05T18:30:30 = ti 5. helmikuuta 2008
   1995-12-22T09:05:02 = pe 22. joulukuuta 1995
  -0010-09-15T04:44:23 = la 15. syyskuuta -10

=head3 yMMMM (LLLL y)

   2008-02-05T18:30:30 = helmikuu 2008
   1995-12-22T09:05:02 = joulukuu 1995
  -0010-09-15T04:44:23 = syyskuu -10

=head3 yMMMMccccd (cccc, d. MMMM y)

   2008-02-05T18:30:30 = tiistai, 5. helmikuuta 2008
   1995-12-22T09:05:02 = perjantai, 22. joulukuuta 1995
  -0010-09-15T04:44:23 = lauantai, 15. syyskuuta -10

=head3 yQ (Q/yyyy)

   2008-02-05T18:30:30 = 1/2008
   1995-12-22T09:05:02 = 4/1995
  -0010-09-15T04:44:23 = 3/-010

=head3 yQQQ (QQQ y)

   2008-02-05T18:30:30 = 1. nelj. 2008
   1995-12-22T09:05:02 = 4. nelj. 1995
  -0010-09-15T04:44:23 = 3. nelj. -10

=head3 yyMM (M/yy)

   2008-02-05T18:30:30 = 2/08
   1995-12-22T09:05:02 = 12/95
  -0010-09-15T04:44:23 = 9/-10

=head3 yyMMM (MMM yy)

   2008-02-05T18:30:30 = helmikuuta 08
   1995-12-22T09:05:02 = joulukuuta 95
  -0010-09-15T04:44:23 = syyskuuta -10

=head3 yyQ (Q/yy)

   2008-02-05T18:30:30 = 1/08
   1995-12-22T09:05:02 = 4/95
  -0010-09-15T04:44:23 = 3/-10

=head3 yyyyM (M/yyyy)

   2008-02-05T18:30:30 = 2/2008
   1995-12-22T09:05:02 = 12/1995
  -0010-09-15T04:44:23 = 9/-010

=head3 yyyyMEEEd (EEE d.M.yyyy)

   2008-02-05T18:30:30 = ti 5.2.2008
   1995-12-22T09:05:02 = pe 22.12.1995
  -0010-09-15T04:44:23 = la 15.9.-010

=head3 yyyyMMMM (LLLL y)

   2008-02-05T18:30:30 = helmikuu 2008
   1995-12-22T09:05:02 = joulukuu 1995
  -0010-09-15T04:44:23 = syyskuu -10

=head3 yyyyQQQQ (QQQQ y)

   2008-02-05T18:30:30 = 1. neljännes 2008
   1995-12-22T09:05:02 = 4. neljännes 1995
  -0010-09-15T04:44:23 = 3. neljännes -10

=head2 Miscellaneous

=head3 Prefers 24 hour time?

Yes

=head3 Local first day of the week

maanantaina


=head1 SUPPORT

See L<DateTime::Locale>.

=head1 AUTHOR

Dave Rolsky <autarch@urth.org>

=head1 COPYRIGHT

Copyright (c) 2008 David Rolsky. All rights reserved. This program is
free software; you can redistribute it and/or modify it under the same
terms as Perl itself.

This module was generated from data provided by the CLDR project, see
the LICENSE.cldr in this distribution for details on the CLDR data's
license.

=cut