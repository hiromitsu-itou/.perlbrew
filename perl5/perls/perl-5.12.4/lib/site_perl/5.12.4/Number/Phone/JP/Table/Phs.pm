package Number::Phone::JP::Table::Phs;

use strict;
use warnings;

our $VERSION = '0.20120105';

# Table last modified: 2012-01-05
our %TEL_TABLE = (
    # Pref => q<Assoc-Pref-Regex>,
    70 => '(?:(?:6(?:3[0-6]|[124-69]\d|8[0-5])|5(?:0[1-9]|[1-6]\d|81))\d{5})',
);

1;
__END__
