package HTML::FormHandler::Widget::Field::Compound;
# ABSTRACT: compound field widget

use Moose::Role;

sub render_subfield {
    my ( $self, $result, $subfield ) = @_;
    my $subresult = $result->field( $subfield->name );

    return "" unless $subresult;
    return $subfield->render( $subresult );
}

sub render {
    my ( $self, $result ) = @_;

    $result ||= $self->result;
    my $output = '';
    foreach my $subfield ( $self->sorted_fields ) {
        $output .= $self->render_subfield( $result, $subfield );
    }
    return $self->wrap_field( $result, $output );
}

use namespace::autoclean;
1;

__END__
=pod

=head1 NAME

HTML::FormHandler::Widget::Field::Compound - compound field widget

=head1 VERSION

version 0.36002

=head1 AUTHOR

FormHandler Contributors - see HTML::FormHandler

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Gerda Shank.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

