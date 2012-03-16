package Catalyst::View::Download::XML;

use strict;
use warnings;
use base qw( Catalyst::View );

use XML::Simple;

=head1 NAME

Catalyst::View::Download::XML

=head1 VERSION

0.02

=cut

our $VERSION = "0.02";

__PACKAGE__->config( 'stash_key' => 'xml' );

sub process {
    my $self = shift;
    my ($c) = @_;

    my $template = $c->stash->{ 'template' };
    my $content = $self->render( $c, $template, $c->stash );

    $c->res->headers->header( "Content-Type" => "text/xml" )
      if ( $c->res->headers->header("Content-Type") eq "" );
    $c->res->body( $content );
}

sub render {
    my $self = shift;
    my ( $c, $template, $args ) = @_;

    my $content;

    my $stash_key = $self->config->{ 'stash_key' };

    $content = $c->stash->{ $stash_key }{ 'data' } || $c->response->body;

    if(ref($content) =~ /HASH/) {
      my $xs = new XML::Simple( keeproot => 1, XMLDecl => "<?xml version='1.0' ?>" );
      $content = $xs->XMLout( $content );
    }

    return $content;
}

1;
__END__

=head1 SYNOPSIS

  # lib/MyApp/View/Download/XML.pm
  package MyApp::View::Download::XML;
  use base qw( Catalyst::View::Download::XML );
  1;

  # lib/MyApp/Controller/SomeController.pm
  sub example_action_1 : Local {
    my ($self, $c) = @_;
	
    # supported content can be an xml document 
		my $content = "<?xml version="1.0"?>\n<root>\n<text>Some Text\n</text>\n</root>";
    
    # supported content can also be a hashref which will converted into xml using XMLout from L<XML::Simple>
    $content = {
      'root' => {
        'text' => 'Some Text'
      }
    };
  
    # To output your data just pass your content into the 'xml' key of the stash
    $c->stash->{'xml'} = {
			data => $content
		};
		
		# Or into the body of the response for this action
		$c->response->body($content);

    # Finally forward processing to the XML View
    $c->forward('MyApp::View::Download::XML');
  }
	
=head1 DESCRIPTION

Takes content and outputs the content as html text.

=head1 SUBROUTINES

=head2 process

This method will be called by Catalyst if it is asked to forward to a component without a specified action.

=head2 render

Allows others to use this view for much more fine-grained content generation.

=head3 XMLout

If a hashref is passed as content it will be converted using the XMLout function from the L<XML::Simple> module. The following options are used to instantiate the L<XML::Simple> object.

=over 4

=item keeproot => 1

=item XMLDecl => "<?xml version='1.0' ?>"

=back

=head1 CONFIG

=over 4

=item stash_key

Determines the key in the stash this view will look for when attempting to retrieve content to process. If this key isn't found it will then look at $c->response->body for content. Content when passed via the stash must be passed in a hashref in the key labeled 'data'

  $c->view('MyApp::View::Download::XML')->config->{'stash_key'} = 'content';

=back

=head1 AUTHOR

Travis Chase, C<< <gaudeon at cpan.org> >>

=head1 SEE ALSO

L<Catalyst> L<Catalyst::View> L<Catalyst::View::Download> L<XML::Simple>

=head1 COPYRIGHT & LICENSE

Copyright 2011 Travis Chase.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
