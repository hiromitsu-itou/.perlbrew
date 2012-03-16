package Number::Phone::JP::Table::United;

use strict;
use warnings;

our $VERSION = '0.20120105';

# Table last modified: 2012-01-05
our %TEL_TABLE = (
    # Pref => q<Assoc-Pref-Regex>,
    570 => '(?:(?:5(?:7[0-2]|5[05])|1(?:0[0-2]|11)|2(?:00|22)|3(?:00|33)|7(?:77|83)|88[128]|9[19]9|0\d{2}|666)\d{3})',
);

1;
__END__
