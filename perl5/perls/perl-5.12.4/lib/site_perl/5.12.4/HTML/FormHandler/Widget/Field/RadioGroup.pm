package HTML::FormHandler::Widget::Field::RadioGroup;
# ABSTRACT: radio group rendering widget

use Moose::Role;
use namespace::autoclean;
use HTML::FormHandler::Render::Util ('process_attrs');

sub render {
    my $self = shift;
    my $result = shift || $self->result;
    my $id = $self->id;
    my $output = " <br />";
    my $index  = 0;

    my $fif = $result->fif;
    foreach my $option ( @{ $self->options } ) {
        my $value = $option->{value};
        $output .= qq{<label for="$id.$index"><input type="radio" value="}
            . $self->html_filter($value) . '" name="'
            . $self->html_name . qq{" id="$id.$index"};
        $output .= ' checked="checked"'
            if $fif eq $value;
        $output .= process_attrs($self->attributes);
        $output .= ' />';
        $output .= $self->html_filter($option->{label}) . '</label><br />';
        $index++;
    }
    return $self->wrap_field( $result, $output );
}

1;

__END__
=pod

=head1 NAME

HTML::FormHandler::Widget::Field::RadioGroup - radio group rendering widget

=head1 VERSION

version 0.36002

=head1 AUTHOR

FormHandler Contributors - see HTML::FormHandler

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Gerda Shank.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

