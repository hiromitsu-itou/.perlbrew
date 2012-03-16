package HTML::FormHandler::Model::Object;
# ABSTRACT: stub for Object model

use Moose::Role;

sub update_model {
    my $self = shift;

    my $item = $self->item;
    return unless $item;
    foreach my $field ( $self->all_fields ) {
        my $name = $field->name;
        next unless $item->can($name);
        $item->$name( $field->value );
    }
}

use namespace::autoclean;
1;

__END__
=pod

=head1 NAME

HTML::FormHandler::Model::Object - stub for Object model

=head1 VERSION

version 0.36002

=head1 AUTHOR

FormHandler Contributors - see HTML::FormHandler

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Gerda Shank.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

