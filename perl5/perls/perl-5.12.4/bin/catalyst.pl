#!/home/ito/.perlbrew/perl5/perls/perl-5.12.4/bin/perl -w

eval 'exec /home/ito/.perlbrew/perl5/perls/perl-5.12.4/bin/perl -w -S $0 ${1+"$@"}'
    if 0; # not running under some shell

use strict;
use Getopt::Long;
use Pod::Usage;
BEGIN {
eval " use Catalyst::Devel 1.0; ";

if ($@) {
  die <<END;
To use the Catalyst development tools including catalyst.pl and the
generated script/myapp_create.pl you need Catalyst::Helper, which is
part of the Catalyst-Devel distribution. Please install this via a
vendor package or by running one of -

  perl -MCPAN -e 'install Catalyst::Devel'
  perl -MCPANPLUS -e 'install Catalyst::Devel'
END

}
};

use Catalyst::Helper;

my $force    = 0;
my $help     = 0;
my $makefile = 0;
my $scripts  = 0;

GetOptions(
    'help|?'      => \$help,
    'force|nonew' => \$force,
    'makefile'    => \$makefile,
    'scripts'     => \$scripts,
);

pod2usage(1) if ( $help || !$ARGV[0] );

my $helper = Catalyst::Helper->new(
    {
        '.newfiles' => !$force,
        'makefile'  => $makefile,
        'scripts'   => $scripts,
        name => $ARGV[0],
    }
);
# Pass $ARGV[0] for compatibility with old ::Devel
pod2usage(1) unless $helper->mk_app( $ARGV[0] );

1;
__END__

=head1 NAME

catalyst - Bootstrap a Catalyst application

=head1 SYNOPSIS

catalyst.pl [options] application-name

'catalyst.pl' creates a skeleton for a new application, and allows you to
upgrade the skeleton of your old application.

 Options:
   -force      don't create a .new file where a file to be created exists
   -help       display this help and exit
   -makefile   only update Makefile.PL
   -scripts    only update helper scripts

 application-name must be a valid Perl module name and can include "::", 
 which will be converted to '-' in the project name.


 Examples:
    catalyst.pl My::App
    catalyst.pl MyApp

 To upgrade your app to a new version of Catalyst:
    catalyst.pl -force -scripts MyApp


=head1 DESCRIPTION

The C<catalyst.pl> script bootstraps a Catalyst application, creating a
directory structure populated with skeleton files.  

The application name must be a valid Perl module name.  The name of the
directory created is formed from the application name supplied, with double
colons replaced with hyphens (so, for example, the directory for C<My::App> is
C<My-App>).

Using the example application name C<My::App>, the application directory will
contain the following items:

=over 4

=item README

a skeleton README file, which you are encouraged to expand on

=item Changes

a changes file with an initial entry for the creation of the application

=item Makefile.PL

Makefile.PL uses the C<Module::Install> system for packaging and distribution
of the application.

=item lib

contains the application module (C<My/App.pm>) and
subdirectories for model, view, and controller components (C<My/App/M>,
C<My/App/V>, and C<My/App/C>).  

=item root

root directory for your web document content.  This is left empty.

=item script

a directory containing helper scripts:

=over 4

=item C<myapp_create.pl>

helper script to generate new component modules

=item C<myapp_server.pl>

runs the generated application within a Catalyst test server, which can be
used for testing without resorting to a full-blown web server configuration.

=item C<myapp_cgi.pl>

runs the generated application as a CGI script

=item C<myapp_fastcgi.pl>

runs the generated application as a FastCGI script

=item C<myapp_test.pl>

runs an action of the generated application from the command line.

=back

=item t

test directory

=back

The application module generated by the C<catalyst.pl> script is functional,
although it reacts to all requests by outputting a friendly welcome screen.

=head1 NOTE

Neither C<catalyst.pl> nor the generated helper script will overwrite existing
files.  In fact the scripts will generate new versions of any existing files,
adding the extension C<.new> to the filename.  The C<.new> file is not created
if would be identical to the existing file.  

This means you can re-run the scripts for example to see if newer versions of
Catalyst or its plugins generate different code, or to see how you may have
changed the generated code (although you do of course have all your code in a
version control system anyway, don't you ...).

=head1 SEE ALSO

L<Catalyst::Manual>, L<Catalyst::Manual::Intro>

=head1 AUTHORS

Catalyst Contributors, see Catalyst.pm

=head1 COPYRIGHT

This library is free software, you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut
