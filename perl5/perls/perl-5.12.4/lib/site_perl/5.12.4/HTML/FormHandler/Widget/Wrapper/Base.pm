package HTML::FormHandler::Widget::Wrapper::Base;
# ABSTRACT: commong methods for widget wrappers

use Moose::Role;
use HTML::FormHandler::Render::Util ('process_attrs');

sub render_label {
    my $self = shift;
    my $attrs = process_attrs($self->label_attributes);
    my $label = $self->html_filter($self->loc_label);
    $label .= ": " unless $self->get_tag('label_no_colon');
    return qq{<label$attrs for="} . $self->id . qq{">$label</label>};
}

# this is not actually used any more, but is left here for compatibility
# with user created widgets
sub render_class {
    my ( $self, $result ) = @_;

    $result ||= $self->result;

    my %attr = %{$self->wrapper_attr};

    if( ! exists $attr{class} && $self->css_class ) {
        $attr{class} = $self->css_class;
    }
    if( $result->has_errors ) {
        if( ref $attr{class} eq 'ARRAY' ) {
            push @{$attr{class}}, 'error';
        }
        else {
            $attr{class} .= $attr{class} ? ' error' : 'error';
        }
    }
    my $output = process_attrs(\%attr);
    return $output;
}

use namespace::autoclean;
1;

__END__
=pod

=head1 NAME

HTML::FormHandler::Widget::Wrapper::Base - commong methods for widget wrappers

=head1 VERSION

version 0.36002

=head1 AUTHOR

FormHandler Contributors - see HTML::FormHandler

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Gerda Shank.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

