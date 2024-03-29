package MooseX::Getopt::GLD;
BEGIN {
  $MooseX::Getopt::GLD::AUTHORITY = 'cpan:STEVAN';
}
{
  $MooseX::Getopt::GLD::VERSION = '0.38';
}
# ABSTRACT: A Moose role for processing command line options with Getopt::Long::Descriptive

use MooseX::Role::Parameterized;

use Getopt::Long::Descriptive 0.081;

with 'MooseX::Getopt::Basic';

parameter getopt_conf => (
    isa => 'ArrayRef[Str]',
    default => sub { [] },
);

role {

    my $p = shift;
    my $getopt_conf = $p->getopt_conf;

    has usage => (
        is => 'rw', isa => 'Getopt::Long::Descriptive::Usage',
        traits => ['NoGetopt'],
    );

    # captures the options: --help --usage --?
    has help_flag => (
        is => 'ro', isa => 'Bool',
        traits => ['Getopt'],
        cmd_flag => 'help',
        cmd_aliases => [ qw(usage ?) ],
        documentation => 'Prints this usage information.',
    );

    around _getopt_spec => sub {
        shift;
        shift->_gld_spec(@_);
    };

    around _getopt_get_options => sub {
        shift;
        my ($class, $params, $opt_spec) = @_;
        # Check if a special args hash were already passed, or create a new one
        my $args = ref($opt_spec->[-1]) eq 'HASH' ? pop @$opt_spec : {};
        unshift @{$args->{getopt_conf}}, @$getopt_conf;
        push @$opt_spec, $args;
        return Getopt::Long::Descriptive::describe_options($class->_usage_format(%$params), @$opt_spec);
    };

    method _gld_spec => sub {
        my ( $class, %params ) = @_;

        my ( @options, %name_to_init_arg );

        my $constructor_params = $params{params};

        foreach my $opt ( @{ $params{options} } ) {
            push @options, [
                $opt->{opt_string},
                $opt->{doc} || ' ', # FIXME new GLD shouldn't need this hack
                {
                    ( ( $opt->{required} && !exists($constructor_params->{$opt->{init_arg}}) ) ? (required => $opt->{required}) : () ),
                    # NOTE:
                    # remove this 'feature' because it didn't work
                    # all the time, and so is better to not bother
                    # since Moose will handle the defaults just
                    # fine anyway.
                    # - SL
                    #( exists $opt->{default}  ? (default  => $opt->{default})  : () ),
                },
            ];

            my $identifier = lc($opt->{name});
            $identifier =~ s/\W/_/g; # Getopt::Long does this to all option names

            $name_to_init_arg{$identifier} = $opt->{init_arg};
        }

        return ( \@options, \%name_to_init_arg );
    }
};


1;


__END__
=pod

=encoding utf-8

=head1 NAME

MooseX::Getopt::GLD - A Moose role for processing command line options with Getopt::Long::Descriptive

=head1 SYNOPSIS

  ## In your class
  package My::App;
  use Moose;

  with 'MooseX::Getopt::GLD';

  # or

  with 'MooseX::Getopt::GLD' => { getopt_conf => [ 'pass_through', ... ] };

  has 'out' => (is => 'rw', isa => 'Str', required => 1);
  has 'in'  => (is => 'rw', isa => 'Str', required => 1);

  # ... rest of the class here

  ## in your script
  #!/usr/bin/perl

  use My::App;

  my $app = My::App->new_with_options();
  # ... rest of the script here

  ## on the command line
  % perl my_app_script.pl -in file.input -out file.dump

=head1 OPTIONS

This role is a parameterized role. It accepts one configuration parameter,
C<getopt_conf>. This parameter is an ArrayRef of strings, which are
L<Getopt::Long> configuraion options (see "Configuring Getopt::Long" in
L<Getopt::Long>)

=head1 AUTHORS

=over 4

=item *

Stevan Little <stevan@iinteractive.com>

=item *

Brandon L. Black <blblack@gmail.com>

=item *

Yuval Kogman <nothingmuch@woobling.org>

=item *

Ryan D Johnson <ryan@innerfence.com>

=item *

Drew Taylor <drew@drewtaylor.com>

=item *

Tomas Doran <bobtfish@bobtfish.net>

=item *

Florian Ragwitz <rafl@debian.org>

=item *

Dagfinn Ilmari Mannsåker <ilmari@ilmari.org>

=item *

Ævar Arnfjörð Bjarmason <avar@cpan.org>

=item *

Chris Prather <perigrin@cpan.org>

=item *

Karen Etheridge <ether@cpan.org>

=item *

Jonathan Swartz <swartz@pobox.com>

=back

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Infinity Interactive, Inc.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

