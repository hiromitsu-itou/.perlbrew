package HTML::FormHandler::Render::Util;
# ABSTRACT: rendering utility

use Sub::Exporter;
Sub::Exporter::setup_exporter({ exports => [ 'process_attrs' ] } );

# this is a function for processing various attribute flavors
sub process_attrs {
    my ($attrs) = @_;

    my @use_attrs;
    for my $attr( sort keys %$attrs ) {
        my $value = '';
        if( defined $attrs->{$attr} ) {
            if( ref $attrs->{$attr} eq 'ARRAY' ) {
                $value = join (' ', @{$attrs->{$attr}} );
            }
            else {
                $value = $attrs->{$attr};
            }
        }
        push @use_attrs, sprintf( '%s="%s"', $attr, $value );
    }
    my $output = join( ' ', @use_attrs );
    $output = " $output" if length $output;
    return $output;
}


1;

__END__
=pod

=head1 NAME

HTML::FormHandler::Render::Util - rendering utility

=head1 VERSION

version 0.36002

=head1 AUTHOR

FormHandler Contributors - see HTML::FormHandler

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Gerda Shank.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

