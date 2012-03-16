package HTML::FormHandler::Widget::Field::Captcha;
# ABSTRACT: Captcha field rendering widget

use Moose::Role;
use namespace::autoclean;
use HTML::FormHandler::Render::Util ('process_attrs');

sub render {
    my $self = shift;
    my $result = shift || $self->result;
    return '' if $self->widget eq 'no_widget';

    my $output .= '<img src="' . $self->form->captcha_image_url . '"/>';
    $output .= '<input id="' . $self->id . '" name="';
    $output .= $self->html_name . '">';

    return $self->wrap_field( $result, $output );
}

1;

__END__
=pod

=head1 NAME

HTML::FormHandler::Widget::Field::Captcha - Captcha field rendering widget

=head1 VERSION

version 0.36002

=head1 AUTHOR

FormHandler Contributors - see HTML::FormHandler

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Gerda Shank.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

