package HTML::FormHandler::Fields;
# ABSTRACT: internal role for form and compound fields

use Moose::Role;
use HTML::FormHandler::TraitFor::Types;


has 'fields' => (
    traits     => ['Array'],
    isa        => 'ArrayRef[HTML::FormHandler::Field]',
    is         => 'rw',
    default    => sub { [] },
    auto_deref => 1,
    handles   => {
        all_fields => 'elements',
        clear_fields => 'clear',
        add_field => 'push',
        push_field => 'push',
        num_fields => 'count',
        has_fields => 'count',
        set_field_at => 'set',
    }
);

# compatibility wrappers for result errors
sub error_fields {
    my $self = shift;
    return map { $_->field_def } @{ $self->result->error_results };
}
sub has_error_fields { shift->result->has_error_results }

sub add_error_field {
    my ( $self, $field ) = @_;
    $self->result->add_error_result( $field->result );
}
sub num_error_fields { shift->result->num_error_results }

has 'field_name_space' => (
    isa     => 'HFH::ArrayRefStr',
    is      => 'rw',
    traits  => ['Array'],
    lazy    => 1,
    default => '',
    coerce  => 1,
    handles => {
        add_field_name_space => 'push',
    },
);

sub field_index {
    my ( $self, $name ) = @_;
    my $index = 0;
    for my $field ( $self->all_fields ) {
        return $index if $field->name eq $name;
        $index++;
    }
    return;
}

sub field {
    my ( $self, $name, $die, $f ) = @_;

    my $index;
    # if this is a full_name for a compound field
    # walk through the fields to get to it
    return undef unless ( defined $name );
    if ( $name =~ /\./ ) {
        my @names = split /\./, $name;
        $f ||= $self->form || $self;
        foreach my $fname (@names) {
            $f = $f->field($fname);
            return unless $f;
        }
        return $f;
    }
    else    # not a compound name
    {
        for my $field ( $self->all_fields ) {
            return $field if ( $field->name eq $name );
        }
    }
    return unless $die;
    die "Field '$name' not found in '$self'";
}

sub sorted_fields {
    my $self = shift;

    my @fields = sort { $a->order <=> $b->order }
        grep { $_->is_active } $self->all_fields;
    return wantarray ? @fields : \@fields;
}

#  the routine for looping through and processing each field
sub _fields_validate {
    my $self = shift;

    return unless $self->has_fields;
    # validate all fields
    my %value_hash;
    foreach my $field ( $self->all_fields ) {
        next if ( $field->is_inactive || !$field->has_result );
        # Validate each field and "inflate" input -> value.
        $field->validate_field;    # this calls the field's 'validate' routine
        $value_hash{ $field->accessor } = $field->value
            if ( $field->has_value && !$field->noupdate );
    }
    $self->_set_value( \%value_hash );
}

sub fields_set_value {
    my $self = shift;
    my %value_hash;
    foreach my $field ( $self->all_fields ) {
        next if ( $field->is_inactive || !$field->has_result );
        $value_hash{ $field->accessor } = $field->value
            if ( $field->has_value && !$field->noupdate );
    }
    $self->_set_value( \%value_hash );
}

sub fields_fif {
    my ( $self, $result, $prefix ) = @_;

    $result ||= $self->result;
    return unless $result;
    $prefix ||= '';
    if ( $self->isa('HTML::FormHandler') ) {
        $prefix = $self->name . "." if $self->html_prefix;
    }
    my %params;
    foreach my $fld_result ( $result->results ) {
        my $field = $fld_result->field_def;
        next if ( $field->is_inactive || $field->password );
        my $fif = $fld_result->fif;
        next if ( !defined $fif || (ref $fif eq 'ARRAY' && ! scalar @{$fif} ) );
        if ( $fld_result->has_results ) {
            my $next_params = $fld_result->fields_fif( $prefix . $field->name . '.' );
            next unless $next_params;
            %params = ( %params, %{$next_params} );
        }
        else {
            $params{ $prefix . $field->name } = $fif;
        }
    }
    return if !%params;
    return \%params;
}

sub clear_data {
    my $self = shift;
    $self->clear_result;
    $self->clear_active;
    $_->clear_data for $self->all_fields;
}

sub get_error_fields {
    my $self = shift;

    my @error_results;
    foreach my $field ( $self->sorted_fields ) {
        next unless $field->has_result;
        if ( $field->has_fields ) {
            $field->get_error_fields;
            push @error_results, @{ $field->result->error_results }
                if $field->result->has_error_results;
        }
        push @error_results, $field->result if $field->result->has_errors;
    }
    $self->result->add_error_result(@error_results) if scalar @error_results;
}

sub dump_fields { shift->dump(@_) }

sub dump {
    my $self = shift;

    warn "HFH: ------- fields for ", $self->name, "-------\n";
    for my $field ( $self->sorted_fields ) {
        $field->dump;
    }
    warn "HFH: ------- end fields -------\n";
}

sub dump_validated {
    my $self = shift;
    warn "HFH: fields validated:\n";
    foreach my $field ( $self->all_fields ) {
        $field->dump_validated if $field->can('dump_validated');
        my $message = $field->has_errors ? join( ' | ', $field->all_errors) : 'validated';
        warn "HFH: ", $field->name, ": $message\n";
    }
}

use namespace::autoclean;
1;

__END__
=pod

=head1 NAME

HTML::FormHandler::Fields - internal role for form and compound fields

=head1 VERSION

version 0.36002

=head1 SYNOPSIS

A role to implement field attributes, accessors, etc. To be applied
to L<HTML::FormHandler> and L<HTML::FormHandler::Field::Compound>.

=head2 fields

The field definitions as built from the field_list and the 'has_field'
declarations. This provides clear_fields, add_field, remove_last_field,
num_fields, has_fields, and set_field_at methods.

=head2 field( $full_name )

Return the field objct with the full_name passed. Will return undef
if the field is not found, or will die if passed a second parameter.

=head2 field_index

Convenience function for use with 'set_field_at'. Pass in 'name' of field
(not full_name)

=head2 sorted_fields

Calls fields and returns them in sorted order by their "order"
value. Non-sorted fields are retrieved with 'fields'.

=head2 clear methods

  clear_data
  clear_fields
  clear_error_fields

=head2 Dump information

   dump - turn verbose flag on to get this output
   dump_validated - shorter version

=head1 AUTHOR

FormHandler Contributors - see HTML::FormHandler

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Gerda Shank.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

