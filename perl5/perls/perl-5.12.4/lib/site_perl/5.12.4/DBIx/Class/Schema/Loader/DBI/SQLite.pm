package DBIx::Class::Schema::Loader::DBI::SQLite;

use strict;
use warnings;
use base qw/
    DBIx::Class::Schema::Loader::DBI::Component::QuotedDefault
    DBIx::Class::Schema::Loader::DBI
/;
use mro 'c3';
use DBIx::Class::Schema::Loader::Table ();

our $VERSION = '0.07017';

=head1 NAME

DBIx::Class::Schema::Loader::DBI::SQLite - DBIx::Class::Schema::Loader::DBI SQLite Implementation.

=head1 DESCRIPTION

See L<DBIx::Class::Schema::Loader> and L<DBIx::Class::Schema::Loader::Base>.

=head1 METHODS

=head2 rescan

SQLite will fail all further commands on a connection if the underlying schema
has been modified.  Therefore, any runtime changes requiring C<rescan> also
require us to re-connect to the database.  The C<rescan> method here handles
that reconnection for you, but beware that this must occur for any other open
sqlite connections as well.

=cut

sub _setup {
    my $self = shift;

    $self->next::method(@_);

    if (not defined $self->preserve_case) {
        $self->preserve_case(0);
    }
    
    if ($self->db_schema) {
        warn <<'EOF';
db_schema is not supported on SQLite, the option is implemented only for qualify_objects testing.
EOF
        if ($self->db_schema->[0] eq '%') {
            $self->db_schema(undef);
        }
    }
}

sub rescan {
    my ($self, $schema) = @_;

    $schema->storage->disconnect if $schema->storage;
    $self->next::method($schema);
}

sub _columns_info_for {
    my $self = shift;
    my ($table) = @_;

    my $result = $self->next::method(@_);

    local $self->dbh->{FetchHashKeyName} = 'NAME_lc';

    my $sth = $self->dbh->prepare(
      "pragma table_info(" . $self->dbh->quote_identifier($table) . ")"
    );
    $sth->execute;
    my $cols = $sth->fetchall_hashref('name');

    my ($num_pk, $pk_col) = (0);
    # SQLite doesn't give us the info we need to do this nicely :(
    # If there is exactly one column marked PK, and its type is integer,
    # set it is_auto_increment. This isn't 100%, but it's better than the
    # alternatives.
    while (my ($col_name, $info) = each %$result) {
      if ($cols->{$col_name}{pk}) {
        $num_pk ++;
        if (lc($cols->{$col_name}{type}) eq 'integer') {
          $pk_col = $col_name;
        }
      }
    }

    while (my ($col, $info) = each %$result) {
        if ((eval { ${ $info->{default_value} } }||'') eq 'CURRENT_TIMESTAMP') {
            ${ $info->{default_value} } = 'current_timestamp';
        }
        if ($num_pk == 1 and defined $pk_col and $pk_col eq $col) {
          $info->{is_auto_increment} = 1;
        }
    }

    return $result;
}

sub _table_fk_info {
    my ($self, $table) = @_;

    my $sth = $self->dbh->prepare(
        "pragma foreign_key_list(" . $self->dbh->quote_identifier($table) . ")"
    );
    $sth->execute;

    my @rels;
    while (my $fk = $sth->fetchrow_hashref) {
        my $rel = $rels[ $fk->{id} ] ||= {
            local_columns => [],
            remote_columns => undef,
            remote_table => DBIx::Class::Schema::Loader::Table->new(
                loader => $self,
                name   => $fk->{table},
                ($self->db_schema ? (
                    schema        => $self->db_schema->[0],
                    ignore_schema => 1,
                ) : ()),
            ),
        };

        push @{ $rel->{local_columns} }, $self->_lc($fk->{from});
        push @{ $rel->{remote_columns} }, $self->_lc($fk->{to}) if defined $fk->{to};
        warn "This is supposed to be the same rel but remote_table changed from ",
            $rel->{remote_table}->name, " to ", $fk->{table}
            if $rel->{remote_table}->name ne $fk->{table};
    }
    $sth->finish;
    return \@rels;
}

sub _table_uniq_info {
    my ($self, $table) = @_;

    my $sth = $self->dbh->prepare(
        "pragma index_list(" . $self->dbh->quote($table) . ")"
    );
    $sth->execute;

    my @uniqs;
    while (my $idx = $sth->fetchrow_hashref) {
        next unless $idx->{unique};

        my $name = $idx->{name};

        my $get_idx_sth = $self->dbh->prepare("pragma index_info(" . $self->dbh->quote($name) . ")");
        $get_idx_sth->execute;
        my @cols;
        while (my $idx_row = $get_idx_sth->fetchrow_hashref) {
            push @cols, $self->_lc($idx_row->{name});
        }
        $get_idx_sth->finish;

        # Rename because SQLite complains about sqlite_ prefixes on identifiers
        # and ignores constraint names in DDL.
        $name = (join '_', @cols) . '_unique';

        push @uniqs, [ $name => \@cols ];
    }
    $sth->finish;
    return \@uniqs;
}

sub _tables_list {
    my ($self, $opts) = @_;

    my $sth = $self->dbh->prepare("SELECT * FROM sqlite_master");
    $sth->execute;
    my @tables;
    while ( my $row = $sth->fetchrow_hashref ) {
        next unless $row->{type} =~ /^(?:table|view)\z/i;
        next if $row->{tbl_name} =~ /^sqlite_/;
        push @tables, DBIx::Class::Schema::Loader::Table->new(
            loader => $self,
            name   => $row->{tbl_name},
            ($self->db_schema ? (
                schema        => $self->db_schema->[0],
                ignore_schema => 1, # for qualify_objects tests
            ) : ()),
        );
    }
    $sth->finish;
    return $self->_filter_tables(\@tables, $opts);
}

=head1 SEE ALSO

L<DBIx::Class::Schema::Loader>, L<DBIx::Class::Schema::Loader::Base>,
L<DBIx::Class::Schema::Loader::DBI>

=head1 AUTHOR

See L<DBIx::Class::Schema::Loader/AUTHOR> and L<DBIx::Class::Schema::Loader/CONTRIBUTORS>.

=head1 LICENSE

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut

1;
