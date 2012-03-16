package HTML::FormHandler::Widget::Field::Role::HTMLAttributes;
# ABSTRACT: apply HTML attributes

use Moose::Role;

# TODO: replace some of this with the eqivalent of the template process_attrs(field.attributes)
sub _add_html_attributes {
    my $self = shift;
    if ($self->form->has_flag('is_html5')) {
        $self->set_html_attr('required' => 'required') if ($self->required);
        my %attributes = (
            range_start => 'min',
            range_end => 'max',
        );
        foreach my $attr (keys %attributes) {
            $self->set_html_attr($attributes{$attr} => $self->$attr) if ($self->meta->find_attribute_by_name($attr) && defined $self->$attr);
        }
    }
    my $output = q{};
    my $html_attr = { %{$self->html_attr} };
    for my $attr ( 'readonly', 'disabled', 'style', 'title', 'tabindex' ) {
        $html_attr->{$attr} = $self->$attr if !exists $html_attr->{$attr} && $self->$attr;
    }
    foreach my $attr ( sort keys %$html_attr ) {
        $output .= qq{ $attr="} . $html_attr->{$attr} . qq{"};
    }
    $output .= ($self->javascript ? ' ' . $self->javascript : '');
    if( $self->input_class ) {
        $output .= ' class="' . $self->input_class . '"';
    }
    return $output;
}

1;

__END__
=pod

=head1 NAME

HTML::FormHandler::Widget::Field::Role::HTMLAttributes - apply HTML attributes

=head1 VERSION

version 0.36002

=head1 AUTHOR

FormHandler Contributors - see HTML::FormHandler

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Gerda Shank.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

