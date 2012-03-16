package HTML::FormHandler::Widget::Form::Table;
# ABSTRACT: render a form with a table layout

use Moose::Role;
with 'HTML::FormHandler::Widget::Form::Simple' =>
    { -excludes => [ 'render_start', 'render_end', 'render_form_errors' ] };


sub render_start {
    my $self   = shift;
    return $self->html_form_tag . "<table>\n";
}

sub render_form_errors {
    my ( $self, $form, $result ) = @_;

    return '' unless $result->has_form_errors;
    my $output = "\n<tr class=\"form_errors\"><td colspan=\"2\">";
    $output .= qq{\n<span class="error_message">$_</span>}
        for $result->all_form_errors;
    $output .= "\n</td></tr>";
    return $output;
}

sub render_end {
    my $self = shift;
    my $output .= "</table>\n";
    $output .= "</form>\n";
    return $output;
}

use namespace::autoclean;
1;


__END__
=pod

=head1 NAME

HTML::FormHandler::Widget::Form::Table - render a form with a table layout

=head1 VERSION

version 0.36002

=head1 SYNOPSIS

Set in your form:

   has '+widget_form' => ( default => 'Table' );

Use in a template:

   [% form.render %]

=head1 AUTHOR

FormHandler Contributors - see HTML::FormHandler

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Gerda Shank.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

