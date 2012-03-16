package HTML::FormHandler::Page;
# ABSTRACT: used in Wizard

use Moose;
with 'HTML::FormHandler::Pages';

has 'name' => ( is => 'ro', isa => 'Str' );

has 'form'      => (
    isa => 'HTML::FormHandler',
    is => 'rw',
    weak_ref => 1,
    predicate => 'has_form',
);

has 'fields' => (
    traits     => ['Array'],
    isa        => 'ArrayRef[Str]',
    is         => 'rw',
    default    => sub { [] },
    handles   => {
        all_fields => 'elements',
        clear_fields => 'clear',
        push_field => 'push',
        num_fields => 'count',
        has_fields => 'count',
    }
);

sub field {
    my ( $self, $field_name ) = @_;

    return $self->form->field($field_name);
}


1;

__END__
=pod

=head1 NAME

HTML::FormHandler::Page - used in Wizard

=head1 VERSION

version 0.36002

=head1 AUTHOR

FormHandler Contributors - see HTML::FormHandler

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Gerda Shank.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

