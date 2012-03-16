package HTML::FormHandler::Widget::Wrapper::Fieldset;
# ABSTRACT: fieldset field wrapper

use Moose::Role;
use namespace::autoclean;

with 'HTML::FormHandler::Widget::Wrapper::Base';


sub wrap_field {
    my ( $self, $result, $rendered_widget ) = @_;

    my $output .= '<fieldset class="' . $self->html_name . '">';
    $output .= '<legend>' . $self->loc_label . '</legend>';

    $output .= $rendered_widget;

    $output .= qq{\n<span class="error_message">$_</span>}
        for $result->all_errors;
    $output .= '</fieldset>';

    return "$output\n";
}

1;

__END__
=pod

=head1 NAME

HTML::FormHandler::Widget::Wrapper::Fieldset - fieldset field wrapper

=head1 VERSION

version 0.36002

=head1 SYNOPSIS

Wraps a single field in a fieldset.

=head1 NAME

HTML::FormHandler::Widget::Wrapper::Fieldset - fieldset field wrapper

=head1 AUTHOR

FormHandler Contributors - see HTML::FormHandler

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Gerda Shank.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

