package    # hide from Pause
    HTML::FormHandler::Field::Repeatable::Instance;
# ABSTRACT: used internally by repeatable fields

use Moose;
extends 'HTML::FormHandler::Field::Compound';


__PACKAGE__->meta->make_immutable;
use namespace::autoclean;
1;

__END__
=pod

=head1 NAME

HTML::FormHandler::Field::Repeatable::Instance - used internally by repeatable fields

=head1 VERSION

version 0.36002

=head1 SYNOPSIS

This is a simple container class to hold an instance of a Repeatable field.
It will have a name like '0', '1'... Users should not need to use this class.

=head1 AUTHOR

FormHandler Contributors - see HTML::FormHandler

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Gerda Shank.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

