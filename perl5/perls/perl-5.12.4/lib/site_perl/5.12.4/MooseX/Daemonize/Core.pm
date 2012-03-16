package MooseX::Daemonize::Core;
use strict;         # cause Perl::Critic errors are annoying
use MooseX::Getopt; # to load the NoGetopt metaclass
use Moose::Role;

our $VERSION   = '0.13';

use POSIX ();

has is_daemon => (
    # NOTE:
    # this should never be accessible
    # from the command line
    # - SL
    metaclass => 'NoGetopt',
    isa       => 'Bool',
    is        => 'rw',
    default   => sub { 0 },
);

has ignore_zombies => (
    metaclass => 'Getopt',
    isa       => 'Bool',
    is        => 'rw',
    default   => sub { 0 },
);

has no_double_fork => (
    metaclass => 'Getopt',
    isa       => 'Bool',
    is        => 'rw',
    default   => sub { 0 },
);

has dont_close_all_files => (
    metaclass => 'Getopt',
    isa       => 'Bool',
    is        => 'rw',
    default   => sub { 0 },
);

sub _get_options {
    my ($self, %options) = @_;
    # backwards compability.. old code might be calling daemon_fork/_detach with options
    foreach my $opt (qw( ignore_zombies no_double_fork dont_close_all_files )) {
        $self->$opt( $options{ $opt } ) if ( defined $options{ $opt } );
    }
}


sub daemon_fork {
    my ($self, %options) = @_;

    $self->_get_options( %options );

    $SIG{CHLD} = 'IGNORE'
        if $self->ignore_zombies;;

    if (my $pid = fork) {
        return $pid;
    }
    else {
        $self->is_daemon(1);
        return;
    }
}

sub daemon_detach {
    my ($self, %options) = @_;

    return unless $self->is_daemon; # return if parent ...

    $self->_get_options( %options );
    # now we are in the daemon ...

    (POSIX::setsid)  # set session id
        || confess "Cannot detach from controlling process";

    unless ( $self->no_double_fork ) {
        $SIG{'HUP'} = 'IGNORE';
        fork && exit;
    }

    chdir '/';      # change to root directory
    umask 0;        # clear the file creation mask

    unless ( $self->dont_close_all_files ) {
        # get the max numnber of possible file descriptors
        my $openmax = POSIX::sysconf( &POSIX::_SC_OPEN_MAX );
        $openmax = 64 if !defined($openmax) || $openmax < 0;

        # close them all
        POSIX::close($_) foreach (0 .. $openmax);
    }

    # fixup STDIN ...

    open(STDIN, "+>/dev/null")
        or confess "Could not redirect STDOUT to /dev/null";

    # fixup STDOUT ...

    if (my $stdout_file = $ENV{MX_DAEMON_STDOUT}) {
        open STDOUT, ">", $stdout_file
            or confess "Could not redirect STDOUT to $stdout_file : $!";
    }
    else {
        open(STDOUT, "+>&STDIN")
            or confess "Could not redirect STDOUT to /dev/null";
    }

    # fixup STDERR ...

    if (my $stderr_file = $ENV{MX_DAEMON_STDERR}) {
        open STDERR, ">", $stderr_file
            or confess "Could not redirect STDERR to $stderr_file : $!";
    }
    else {
        open(STDERR, "+>&STDIN")
            or confess "Could not redirect STDERR to /dev/null";        ;
    }

    # do a little house cleaning ...

    # Avoid 'stdin reopened for output'
    # warning with newer perls
    open( NULL, '/dev/null' );
    <NULL> if (0);

    # return success
    return 1;
}

sub daemonize {
    my ($self, %options) = @_;
    $self->daemon_fork(%options);
    $self->daemon_detach(%options);
}

1;

__END__

=pod

=head1 NAME

MooseX::Daemonize::Core - A Role with the core daemonization features

=head1 SYNOPSIS

  package My::Daemon;
  use Moose;

  with 'MooseX::Daemonize::Core';

  sub start {
      my $self = shift;
      # daemonize me ...
      $self->daemonize;
      # return from the parent,...
      return unless $self->is_daemon;
      # but continue on in the child (daemon)
  }

=head1 DESCRIPTION

This is the basic daemonization Role, it provides a few methods (see
below) and the minimum features needed to properly daemonize your code.

=head2 Important Notes

None of the methods in this role will exit the parent process for you,
it only forks and detaches your child (daemon) process. It is your
responsibility to exit the parent process in some way.

There is no PID or PID file management in this role, that is your
responsibility (see some of the other roles in this distro for that).

=head1 ATTRIBUTES

=over

=item I<is_daemon (is => rw, isa => Bool)>

This attribute is used to signal if we are within the
daemon process or not.

=item I<no_double_fork (is => rw, isa => Bool)>

Setting this attribute to true will cause this method to not perform the
typical double-fork, which is extra added protection from your process
accidentally aquiring a controlling terminal. More information can be
found above, and by Googling "double fork daemonize".

If you the double-fork behavior off, you might want to enable the
I<ignore_zombies>.

=item I<ignore_zombies (is => rw, isa => Bool)>

Setting this attribute to a true value will result in setting the C<$SIG{CHLD}>
handler to C<IGNORE>. This tells perl to clean up zombie processes. By
default, and for the most part you don't I<need> it, only when you turn off
the double fork behavior (with the I<no_double_fork> attribute)
do you sometimes want this behavior.

=item I<dont_close_all_files (is => rw, isa => Bool)>

Setting this attribute to true will cause it to skip closing all the
filehandles. This is useful if you are opening things like sockets
and such in the pre-fork.

=back

=head1 METHODS

=over

=item B<daemon_fork (?%options)>

This forks off the child process to be daemonized. Just as with
the built in fork, it returns the child pid to the parent process,
0 to the child process. It will also set the is_daemon flag
appropriately.

The C<%options> argument remains for backwards compatability, but
it is suggested that you use the attributes listed above instead.

=item B<daemon_detach (?%options)>

This detaches the new child process from the terminal by doing
the following things.

The C<%options> argument remains for backwards compatability, but
it is suggested that you use the attributes listed above instead.

=over 4

=item Becomes a session leader

This detaches the program from the controlling terminal, it is
accomplished by calling POSIX::setsid.

=item Performing the double-fork

See below for information on how to change this part of the process.

=item Changes the current working directory to "/"

This is standard daemon behavior, if you want a different working
directory then simply change it later in your daemons code.

=item Clears the file creation mask.

=item Closes all open file descriptors.

See the I<dont_close_all_files> attribute for information on how to
change this part of the process.

=item Reopen STDERR, STDOUT & STDIN to /dev/null

This behavior can be controlled slightly though the MX_DAEMON_STDERR
and MX_DAEMON_STDOUT environment variables. It will look for a filename
in either of these variables and redirect STDOUT and/or STDERR to those
files. This is useful for debugging and/or testing purposes.

B<NOTE>

If called from within the parent process (the is_daemon flag is set to
false), this method will simply return and do nothing.

=item B<daemonize (?%options)>

This will simply call C<daemon_fork> followed by C<daemon_detach>.

The C<%options> argument remains for backwards compatability, but
it is suggested that you use the attributes listed above instead.

=item meta()

The C<meta()> method from L<Class::MOP::Class>

=back

=head1 STUFF YOU SHOULD READ

=over 4

=item Note about double fork

Taken from L<http://aspn.activestate.com/ASPN/Cookbook/Python/Recipe/66012>
in a comment entitled I<The second fork _is_ necessary by Jonathan Bartlett>,
it is not the definitive statement on the issue, but it's clear and well
written enough so I decided to reproduce it here.

  The first fork accomplishes two things - allow the shell to return,
  and allow you to do a setsid().

  The setsid() removes yourself from your controlling terminal. You
  see, before, you were still listed as a job of your previous process,
  and therefore the user might accidentally send you a signal. setsid()
  gives you a new session, and removes the existing controlling terminal.

  The problem is, you are now a session leader. As a session leader, if
  you open a file descriptor that is a terminal, it will become your
  controlling terminal (oops!). Therefore, the second fork makes you NOT
  be a session leader. Only session leaders can acquire a controlling
  terminal, so you can open up any file you wish without worrying that
  it will make you a controlling terminal.

  So - first fork - allow shell to return, and permit you to call setsid()

  Second fork - prevent you from accidentally reacquiring a controlling
  terminal.

That said, you don't always want this to be the behavior, so you are
free to specify otherwise using the I<no_double_fork> attribute.

=item Note about zombies

Doing the double fork (see above) tends to get rid of your zombies since
by the time you have double forked your daemon process is then owned by
the init process. However, sometimes the double-fork is more than you
really need, and you want to keep your daemon processes a little closer
to you. In this case you have to watch out for zombies, you can avoid then
by just setting the I<ignore_zombies> attribute (see above).

=back

=head1 ENVIRONMENT VARIABLES

These variables are best just used for debugging and/or testing, but
not used for actual logging. For that, you should reopen STDOUT/ERR on
your own.

=over 4

=item B<MX_DAEMON_STDOUT>

A filename to redirect the daemon STDOUT to.

=item B<MX_DAEMON_STDERR>

A filename to redirect the daemon STDERR to.

=back

=head1 DEPENDENCIES

L<Moose::Role>, L<POSIX>

=head1 INCOMPATIBILITIES

None reported.

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests to
C<bug-acme-dahut-call@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.

=head1 SEE ALSO

L<Proc::Daemon>

This code is based B<HEAVILY> on L<Proc::Daemon>, we originally
depended on it, but we needed some more flexibility, so instead
we just stole the code.

=head1 AUTHOR

Stevan Little  C<< <stevan.little@iinteractive.com> >>

=head1 LICENCE AND COPYRIGHT

Copyright (c) 2007-2011, Chris Prather C<< <perigrin@cpan.org> >>. All rights
reserved.

Portions heavily borrowed from L<Proc::Daemon> which is copyright Earl Hood.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.

=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.

=cut
