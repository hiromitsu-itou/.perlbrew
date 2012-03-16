package HTML::FormHandler::Render::Table;
# ABSTRACT: render a form with a table layout

use Moose::Role;

with 'HTML::FormHandler::Render::Simple' =>
    { -excludes => [ 'render', 'render_field_struct', 'render_end', 'render_start' ] };


sub render {
    my $self = shift;

    my $output = $self->render_start;
    $output .= $self->render_form_errors;
    foreach my $field ( $self->sorted_fields ) {
        $output .= $self->render_field($field);
    }
    $output .= $self->render_end;
    return $output;
}

sub render_start {
    my $self   = shift;

    return $self->html_form_tag . "<table>\n";
}

sub render_form_errors {
    my $self = shift;

    return '' unless $self->has_form_errors;
    my $output = "\n<tr class=\"form_errors\"><td colspan=\"2\">";
    $output .= qq{\n<span class="error_message">$_</span>}
        for $self->all_form_errors;
    $output .= "\n</td></tr>";
    return $output;
}

sub render_end {
    my $self = shift;
    my $output .= "</table>\n";
    $output .= "</form>\n";
    return $output;
}

sub render_field_struct {
    my ( $self, $field, $rendered_field, $class ) = @_;
    my $output = qq{\n<tr$class>};
    my $l_type =
        defined $self->get_label_type( $field->widget ) ?
        $self->get_label_type( $field->widget ) :
        '';
    if ( $l_type eq 'label' ) {
        $output .= '<td>' . $self->_label($field) . '</td>';
    }
    elsif ( $l_type eq 'legend' ) {
        $output .= '<td>' . $self->_label($field) . '</td></tr>';
    }
    if ( $l_type ne 'legend' ) {
        $output .= '<td>';
    }
    $output .= $rendered_field;
    $output .= qq{\n<span class="error_message">$_</span>} for $field->all_errors;
    if ( $l_type ne 'legend' ) {
        $output .= "</td></tr>\n";
    }
    return $output;
}

use namespace::autoclean;
1;


__END__
=pod

=head1 NAME

HTML::FormHandler::Render::Table - render a form with a table layout

=head1 VERSION

version 0.36002

=head1 SYNOPSIS

Include this role in a form:

   package MyApp::Form::User;
   use Moose;
   with 'HTML::FormHandler::Render::Table';

Use in a template:

   [% form.render %]

=head1 AUTHOR

FormHandler Contributors - see HTML::FormHandler

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Gerda Shank.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

