package Catalyst::View::Download::Plain;

use strict;
use warnings;
use base qw( Catalyst::View );

=head1 NAME

Catalyst::View::Download::Plain

=head1 VERSION

0.03

=cut

our $VERSION = "0.03";

__PACKAGE__->config( 'stash_key' => 'plain' );

sub process {
    my $self = shift;
    my ($c) = @_;

    my $template = $c->stash->{ 'template' };
    my $content = $self->render( $c, $template, $c->stash );

    $c->res->headers->header( "Content-Type" => "text/plain" )
      if ( $c->res->headers->header( "Content-Type" ) eq "" );
    $c->res->body( $content );
}

sub render {
    my $self = shift;
    my ( $c, $template, $args ) = @_;

    my $content;

    my $stash_key = $self->config->{ 'stash_key' };

    $content = $c->stash->{ $stash_key }{ 'data' } || $c->response->body;

    return $content;
}

1;
__END__

=head1 SYNOPSIS

  # lib/MyApp/View/Download/Plain.pm
  package MyApp::View::Download::Plain;
  use base qw( Catalyst::View::Download::Plain );
  1;

  # lib/MyApp/Controller/SomeController.pm
  sub example_action_1 : Local {
    my ($self, $c) = @_;
		
		my $content = "Some Text";
  
    # To output your data just pass your content into the 'plain' key of the stash
    $c->stash->{'plain'} = {
			data => $content
		};
		
		# Or into the body of the response for this action
		$c->response->body($content);

    # Finally forward processing to the Plain View
    $c->forward('MyApp::View::Download::Plain');
  }
	
=head1 DESCRIPTION

Takes content and outputs the content as plain text.

=head1 SUBROUTINES

=head2 process

This method will be called by Catalyst if it is asked to forward to a component without a specified action.

=head2 render

Allows others to use this view for much more fine-grained content generation.

=head1 CONFIG

=over 4

=item stash_key

Determines the key in the stash this view will look for when attempting to retrieve content to process. If this key isn't found it will then look at $c->response->body for content. Content when passed via the stash must be passed in a hashref in the key labeled 'data'

  $c->view('MyApp::View::Download::Plain')->config->{'stash_key'} = 'content';

=back

=head1 AUTHOR

Travis Chase, C<< <gaudeon at cpan.org> >>

=head1 SEE ALSO

L<Catalyst> L<Catalyst::View> L<Catalyst::View::Download>

=head1 COPYRIGHT & LICENSE

Copyright 2011 Travis Chase.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
