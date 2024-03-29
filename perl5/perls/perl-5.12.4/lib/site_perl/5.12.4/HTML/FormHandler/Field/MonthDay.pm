package HTML::FormHandler::Field::MonthDay;
# ABSTRACT: select list 1 to 31

use Moose;
extends 'HTML::FormHandler::Field::IntRange';
our $VERSION = '0.01';

has '+range_start' => ( default => 1 );
has '+range_end'   => ( default => 31 );


__PACKAGE__->meta->make_immutable;
use namespace::autoclean;
1;

__END__
=pod

=head1 NAME

HTML::FormHandler::Field::MonthDay - select list 1 to 31

=head1 VERSION

version 0.36002

=head1 DESCRIPTION

Generates a select list for integers 1 to 31.

=head1 AUTHOR

FormHandler Contributors - see HTML::FormHandler

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Gerda Shank.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

