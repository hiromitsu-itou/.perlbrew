package HTML::FormHandler::Widget::Field::Repeatable;
# ABSTRACT: repeatable field widget

use Moose::Role;
with 'HTML::FormHandler::Widget::Field::Compound';

sub render_subfield {
    my ( $self, $result, $subfield ) = @_;
    my $subresult = $result->field( $subfield->name );

    return "" unless $subresult
        or ( $self->has_flag( "is_repeatable")
            and $subfield->name < $self->num_when_empty
        );

    return $subfield->render($subresult);
}

use namespace::autoclean;
1;

__END__
=pod

=head1 NAME

HTML::FormHandler::Widget::Field::Repeatable - repeatable field widget

=head1 VERSION

version 0.36002

=head1 AUTHOR

FormHandler Contributors - see HTML::FormHandler

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Gerda Shank.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

