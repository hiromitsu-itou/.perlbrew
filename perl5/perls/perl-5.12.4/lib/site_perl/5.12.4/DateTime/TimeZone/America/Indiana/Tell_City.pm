# This file is auto-generated by the Perl DateTime Suite time zone
# code generator (0.07) This code generator comes with the
# DateTime::TimeZone module distribution in the tools/ directory

#
# Generated from ../DateTime/data/Olson/2011n/northamerica.  Olson data version 2011n
#
# Do not edit this file directly.
#
package DateTime::TimeZone::America::Indiana::Tell_City;
{
  $DateTime::TimeZone::America::Indiana::Tell_City::VERSION = '1.42';
}

use strict;

use Class::Singleton;
use DateTime::TimeZone;
use DateTime::TimeZone::OlsonDB;

@DateTime::TimeZone::America::Indiana::Tell_City::ISA = ( 'Class::Singleton', 'DateTime::TimeZone' );

my $spans =
[
    [
DateTime::TimeZone::NEG_INFINITY,
59418036000,
DateTime::TimeZone::NEG_INFINITY,
59418015177,
-20823,
0,
'LMT'
    ],
    [
59418036000,
60502406400,
59418014400,
60502384800,
-21600,
0,
'CST'
    ],
    [
60502406400,
60520546800,
60502388400,
60520528800,
-18000,
1,
'CDT'
    ],
    [
60520546800,
60533856000,
60520525200,
60533834400,
-21600,
0,
'CST'
    ],
    [
60533856000,
60551996400,
60533838000,
60551978400,
-18000,
1,
'CDT'
    ],
    [
60551996400,
61255468800,
60551974800,
61255447200,
-21600,
0,
'CST'
    ],
    [
61255468800,
61366287600,
61255450800,
61366269600,
-18000,
1,
'CWT'
    ],
    [
61366287600,
61370290800,
61366269600,
61370272800,
-18000,
1,
'CPT'
    ],
    [
61370290800,
61378322400,
61370269200,
61378300800,
-21600,
0,
'CST'
    ],
    [
61378322400,
61388438400,
61378300800,
61388416800,
-21600,
0,
'CST'
    ],
    [
61388438400,
61401740400,
61388420400,
61401722400,
-18000,
1,
'CDT'
    ],
    [
61401740400,
61609190400,
61401718800,
61609168800,
-21600,
0,
'CST'
    ],
    [
61609190400,
61622492400,
61609172400,
61622474400,
-18000,
1,
'CDT'
    ],
    [
61622492400,
61640640000,
61622470800,
61640618400,
-21600,
0,
'CST'
    ],
    [
61640640000,
61653942000,
61640622000,
61653924000,
-18000,
1,
'CDT'
    ],
    [
61653942000,
61672687200,
61653920400,
61672665600,
-21600,
0,
'CST'
    ],
    [
61672687200,
61685391600,
61672669200,
61685373600,
-18000,
1,
'CDT'
    ],
    [
61685391600,
61704144000,
61685370000,
61704122400,
-21600,
0,
'CST'
    ],
    [
61704144000,
61717446000,
61704126000,
61717428000,
-18000,
1,
'CDT'
    ],
    [
61717446000,
61735593600,
61717424400,
61735572000,
-21600,
0,
'CST'
    ],
    [
61735593600,
61748895600,
61735575600,
61748877600,
-18000,
1,
'CDT'
    ],
    [
61748895600,
61767043200,
61748874000,
61767021600,
-21600,
0,
'CST'
    ],
    [
61767043200,
61780345200,
61767025200,
61780327200,
-18000,
1,
'CDT'
    ],
    [
61780345200,
61798492800,
61780323600,
61798471200,
-21600,
0,
'CST'
    ],
    [
61798492800,
61811794800,
61798474800,
61811776800,
-18000,
1,
'CDT'
    ],
    [
61811794800,
61829942400,
61811773200,
61829920800,
-21600,
0,
'CST'
    ],
    [
61829942400,
61846268400,
61829924400,
61846250400,
-18000,
1,
'CDT'
    ],
    [
61846268400,
61861996800,
61846246800,
61861975200,
-21600,
0,
'CST'
    ],
    [
61861996800,
61874694000,
61861978800,
61874676000,
-18000,
1,
'CDT'
    ],
    [
61874694000,
61893446400,
61874672400,
61893424800,
-21600,
0,
'CST'
    ],
    [
61893446400,
61909167600,
61893428400,
61909149600,
-18000,
1,
'CDT'
    ],
    [
61909167600,
61924896000,
61909146000,
61924874400,
-21600,
0,
'CST'
    ],
    [
61924896000,
61940617200,
61924878000,
61940599200,
-18000,
1,
'CDT'
    ],
    [
61940617200,
61956345600,
61940595600,
61956324000,
-21600,
0,
'CST'
    ],
    [
61956345600,
62104165200,
61956327600,
62104147200,
-18000,
0,
'EST'
    ],
    [
62104165200,
62114194800,
62104147200,
62114176800,
-18000,
0,
'EST'
    ],
    [
62114194800,
62129916000,
62114180400,
62129901600,
-14400,
1,
'EDT'
    ],
    [
62129916000,
62145644400,
62129898000,
62145626400,
-18000,
0,
'EST'
    ],
    [
62145644400,
62161365600,
62145630000,
62161351200,
-14400,
1,
'EDT'
    ],
    [
62161365600,
62167237200,
62161347600,
62167219200,
-18000,
0,
'EST'
    ],
    [
62167237200,
63279644400,
62167219200,
63279626400,
-18000,
0,
'EST'
    ],
    [
63279644400,
63297788400,
63279626400,
63297770400,
-18000,
1,
'CDT'
    ],
    [
63297788400,
63309283200,
63297766800,
63309261600,
-21600,
0,
'CST'
    ],
    [
63309283200,
63329842800,
63309265200,
63329824800,
-18000,
1,
'CDT'
    ],
    [
63329842800,
63340732800,
63329821200,
63340711200,
-21600,
0,
'CST'
    ],
    [
63340732800,
63361292400,
63340714800,
63361274400,
-18000,
1,
'CDT'
    ],
    [
63361292400,
63372182400,
63361270800,
63372160800,
-21600,
0,
'CST'
    ],
    [
63372182400,
63392742000,
63372164400,
63392724000,
-18000,
1,
'CDT'
    ],
    [
63392742000,
63404236800,
63392720400,
63404215200,
-21600,
0,
'CST'
    ],
    [
63404236800,
63424796400,
63404218800,
63424778400,
-18000,
1,
'CDT'
    ],
    [
63424796400,
63435686400,
63424774800,
63435664800,
-21600,
0,
'CST'
    ],
    [
63435686400,
63456246000,
63435668400,
63456228000,
-18000,
1,
'CDT'
    ],
    [
63456246000,
63467136000,
63456224400,
63467114400,
-21600,
0,
'CST'
    ],
    [
63467136000,
63487695600,
63467118000,
63487677600,
-18000,
1,
'CDT'
    ],
    [
63487695600,
63498585600,
63487674000,
63498564000,
-21600,
0,
'CST'
    ],
    [
63498585600,
63519145200,
63498567600,
63519127200,
-18000,
1,
'CDT'
    ],
    [
63519145200,
63530035200,
63519123600,
63530013600,
-21600,
0,
'CST'
    ],
    [
63530035200,
63550594800,
63530017200,
63550576800,
-18000,
1,
'CDT'
    ],
    [
63550594800,
63561484800,
63550573200,
63561463200,
-21600,
0,
'CST'
    ],
    [
63561484800,
63582044400,
63561466800,
63582026400,
-18000,
1,
'CDT'
    ],
    [
63582044400,
63593539200,
63582022800,
63593517600,
-21600,
0,
'CST'
    ],
    [
63593539200,
63614098800,
63593521200,
63614080800,
-18000,
1,
'CDT'
    ],
    [
63614098800,
63624988800,
63614077200,
63624967200,
-21600,
0,
'CST'
    ],
    [
63624988800,
63645548400,
63624970800,
63645530400,
-18000,
1,
'CDT'
    ],
    [
63645548400,
63656438400,
63645526800,
63656416800,
-21600,
0,
'CST'
    ],
    [
63656438400,
63676998000,
63656420400,
63676980000,
-18000,
1,
'CDT'
    ],
    [
63676998000,
63687888000,
63676976400,
63687866400,
-21600,
0,
'CST'
    ],
    [
63687888000,
63708447600,
63687870000,
63708429600,
-18000,
1,
'CDT'
    ],
    [
63708447600,
63719337600,
63708426000,
63719316000,
-21600,
0,
'CST'
    ],
    [
63719337600,
63739897200,
63719319600,
63739879200,
-18000,
1,
'CDT'
    ],
    [
63739897200,
63751392000,
63739875600,
63751370400,
-21600,
0,
'CST'
    ],
    [
63751392000,
63771951600,
63751374000,
63771933600,
-18000,
1,
'CDT'
    ],
    [
63771951600,
63782841600,
63771930000,
63782820000,
-21600,
0,
'CST'
    ],
    [
63782841600,
63803401200,
63782823600,
63803383200,
-18000,
1,
'CDT'
    ],
];

sub olson_version { '2011n' }

sub has_dst_changes { 35 }

sub _max_year { 2021 }

sub _new_instance
{
    return shift->_init( @_, spans => $spans );
}

sub _last_offset { -21600 }

my $last_observance = bless( {
  'format' => 'C%sT',
  'gmtoff' => '-6:00',
  'local_start_datetime' => bless( {
    'formatter' => undef,
    'local_rd_days' => 732403,
    'local_rd_secs' => 7200,
    'offset_modifier' => 0,
    'rd_nanosecs' => 0,
    'tz' => bless( {
      'name' => 'floating',
      'offset' => 0
    }, 'DateTime::TimeZone::Floating' ),
    'utc_rd_days' => 732403,
    'utc_rd_secs' => 7200,
    'utc_year' => 2007
  }, 'DateTime' ),
  'offset_from_std' => 0,
  'offset_from_utc' => -21600,
  'until' => [],
  'utc_start_datetime' => bless( {
    'formatter' => undef,
    'local_rd_days' => 732403,
    'local_rd_secs' => 25200,
    'offset_modifier' => 0,
    'rd_nanosecs' => 0,
    'tz' => bless( {
      'name' => 'floating',
      'offset' => 0
    }, 'DateTime::TimeZone::Floating' ),
    'utc_rd_days' => 732403,
    'utc_rd_secs' => 25200,
    'utc_year' => 2007
  }, 'DateTime' )
}, 'DateTime::TimeZone::OlsonDB::Observance' )
;
sub _last_observance { $last_observance }

my $rules = [
  bless( {
    'at' => '2:00',
    'from' => '2007',
    'in' => 'Mar',
    'letter' => 'D',
    'name' => 'US',
    'offset_from_std' => 3600,
    'on' => 'Sun>=8',
    'save' => '1:00',
    'to' => 'max',
    'type' => undef
  }, 'DateTime::TimeZone::OlsonDB::Rule' ),
  bless( {
    'at' => '2:00',
    'from' => '2007',
    'in' => 'Nov',
    'letter' => 'S',
    'name' => 'US',
    'offset_from_std' => 0,
    'on' => 'Sun>=1',
    'save' => '0',
    'to' => 'max',
    'type' => undef
  }, 'DateTime::TimeZone::OlsonDB::Rule' )
]
;
sub _rules { $rules }


1;

