package DBIx::Class::Schema::Loader::DBI::ADO::Microsoft_SQL_Server;

use strict;
use warnings;
use base qw/
    DBIx::Class::Schema::Loader::DBI::ADO
    DBIx::Class::Schema::Loader::DBI::MSSQL
/;
use mro 'c3';

our $VERSION = '0.07017';

=head1 NAME

DBIx::Class::Schema::Loader::DBI::ADO::Microsoft_SQL_Server - ADO wrapper for
L<DBIx::Class::Schema::Loader::DBI::MSSQL>

=head1 DESCRIPTION

Proxy for L<DBIx::Class::Schema::Loader::DBI::MSSQL> when using L<DBD::ADO>.

See L<DBIx::Class::Schema::Loader::Base> for usage information.

=cut

sub _table_comment {
    local $^W = 0; # invalid object warnings
    shift->next::method(@_);
}

sub _column_comment {
    local $^W = 0; # invalid object warnings
    shift->next::method(@_);
}

=head1 SEE ALSO

L<DBIx::Class::Schema::Loader::DBI::ADO>,
L<DBIx::Class::Schema::Loader::DBI::MSSQL>,
L<DBIx::Class::Schema::Loader>, L<DBIx::Class::Schema::Loader::Base>,
L<DBIx::Class::Schema::Loader::DBI>

=head1 AUTHOR

See L<DBIx::Class::Schema::Loader/AUTHOR> and L<DBIx::Class::Schema::Loader/CONTRIBUTORS>.

=head1 LICENSE

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut

1;
