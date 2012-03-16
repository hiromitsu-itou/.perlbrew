package HTML::FormHandler::Widget::Wrapper::None;
# ABSTRACT: wrapper that doesn't wrap

use Moose::Role;

sub wrap_field { $_[2] }

use namespace::autoclean;
1;

__END__
=pod

=head1 NAME

HTML::FormHandler::Widget::Wrapper::None - wrapper that doesn't wrap

=head1 VERSION

version 0.36002

=head1 AUTHOR

FormHandler Contributors - see HTML::FormHandler

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Gerda Shank.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

