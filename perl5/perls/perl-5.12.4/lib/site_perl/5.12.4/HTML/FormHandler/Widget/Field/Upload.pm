package HTML::FormHandler::Widget::Field::Upload;
# ABSTRACT: update field rendering widget

use Moose::Role;
use HTML::FormHandler::Render::Util ('process_attrs');

sub render {
    my ( $self, $result ) = @_;

    $result ||= $self->result;
    my $output;
    $output = '<input type="file" name="';
    $output .= $self->html_name . '"';
    $output .= ' id="' . $self->id . '"';
    $output .= process_attrs($self->attributes);
    $output .= ' />';
    return $self->wrap_field($result, $output);
}

use namespace::autoclean;
1;

__END__
=pod

=head1 NAME

HTML::FormHandler::Widget::Field::Upload - update field rendering widget

=head1 VERSION

version 0.36002

=head1 AUTHOR

FormHandler Contributors - see HTML::FormHandler

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Gerda Shank.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

