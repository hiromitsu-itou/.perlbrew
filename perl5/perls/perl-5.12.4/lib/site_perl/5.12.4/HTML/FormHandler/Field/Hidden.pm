package HTML::FormHandler::Field::Hidden;
# ABSTRACT: hidden field

use Moose;
extends 'HTML::FormHandler::Field::Text';
our $VERSION = '0.01';

has '+widget' => ( default => 'hidden' );
has '+widget_wrapper' => ( default => 'None' );


__PACKAGE__->meta->make_immutable;
use namespace::autoclean;
1;

__END__
=pod

=head1 NAME

HTML::FormHandler::Field::Hidden - hidden field

=head1 VERSION

version 0.36002

=head1 DESCRIPTION

This is a text field that uses the 'hidden' widget type, for HTML
of type 'hidden'.

=head1 AUTHOR

FormHandler Contributors - see HTML::FormHandler

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Gerda Shank.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

