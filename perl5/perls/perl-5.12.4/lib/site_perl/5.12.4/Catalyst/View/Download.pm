package Catalyst::View::Download;

use Moose;
use namespace::autoclean;

extends 'Catalyst::View';

=head1 NAME

Catalyst::View::Download

=head1 VERSION

0.07

=cut

our $VERSION = "0.07";

__PACKAGE__->config(
    'stash_key'    => 'download',
    'default'      => 'text/plain',
    'content_type' => {
        'text/csv' => {
            'outfile' => 'data.csv',
            'module'  => '+Download::CSV',
        },
        'text/html' => {
            'outfile' => 'data.html',
            'module'  => '+Download::HTML',
        },
        'text/plain' => {
            'outfile' => 'data.txt',
            'module'  => '+Download::Plain',
        },
        'text/xml' => {
            'outfile' => 'data.xml',
            'module'  => '+Download::XML',
        },
    },
);

sub process {
    my $self = shift;
    my ($c) = @_;

    my $content = $self->render( $c, $c->stash->{template}, $c->stash );

    $c->response->body($content);
}

sub render {
    my $self = shift;
    my ( $c, $template, $args ) = @_;
    my $content;

    my $content_type =
         $args->{ $self->config->{'stash_key'} }
      || $c->response->header('Content-Type')
      || $self->config->{'default'};
    my $options = $self->config->{'content_type'}{$content_type}
      || return $c->response->body;

    my $module = $options->{'module'} || return $c->response->body;
    if ( $module =~ /^\+(.*)$/ ) {
        $module = 'Catalyst::View::' . $1;
    }

    $c->response->header( 'Content-Type' => $content_type );
    $c->response->header( 'Content-Disposition' => 'attachment; filename='
          . $options->{'outfile'} );

    Catalyst::Utils::ensure_class_loaded($module);
    my $view = new $module;

    $content = $view->render(@_);

    return $content;
}

1;
__END__

=head1 SYNOPSIS

	# lib/MyApp/View/Download.pm
	package MyApp::View::Download;
	use base qw( Catalyst::View::Download );
	1;

	# lib/MyApp/Controller/SomeController.pm
	sub example_action_1 : Local {
		my ($self, $c) = @_;

    # 'plain', 'csv', 'html', or 'xml'
		my $content_type = $c->request->params->{'content_type'} || 'plain'; 
    
    # Set the content type so Catalyst::View::Download can determine how 
    # to process it.
		$c->header('Content-Type' => 'text/'.$content_type); 

    # Or set the content type in the stash variable 'download' 
    # to process it. (Note: this is configurable)
    $c->stash->{'download'} = 'text/'.$content_type; 

		# Array reference of array references.
		my $data = [
			['col 1','col 2','col ...','col N'], # row 1
			['col 1','col 2','col ...','col N'], # row 2
			['col 1','col 2','col ...','col N'], # row ...
			['col 1','col 2','col ...','col N']  # row N
		];

		# If the chosen content_type is 'csv' then the render function of 
    # Catalyst::View::Download::CSV will be called which uses the 'csv' 
    # stash key
		$c->stash->{'csv'} = {
      data => $data
    };

		use Data::Dumper;

		# For html text in this example we just dump the example array in a basic
    # html document. Catalyst::View::Download::HTML can use either the 'html'
    # stash key or just pull from $c->response->body
    $c->stash->{'html'} = {
        data => '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"><html><head>
<title></title></head><body>'.Dumper( $data ).'</body></html>'
    };
    
		# For plain text in this example we just dump the example array.
		# Catalyst::View::Download::Plain can use either the 'plain'
    # stash key or just pull from $c->response->body.
    $c->stash->{'plain'} = {
      data => Dumper( $data )
    };

		# Finally forward processing to the Download View
		$c->forward('MyApp::View::Download');
	}

=head1 DESCRIPTION

A view module to help in the convenience of downloading data into many supportable formats.
	
=head1 SUBROUTINES

=head2 process

This method will be called by Catalyst if it is asked to forward to a component without a specified action.

=head2 render

Allows others to use this view for much more fine-grained content generation.

=head1 CONFIG

=over 4

=item stash_key

Determines the key in the stash this view will look for when attempting to retrieve the type of format to process. If this key isn't found it will search for a Content-Type header for the format. Further if neither are found a default format will be applied.

	$c->view('MyApp::View::Download')->config->{'stash_key'} = 'content_type';

=item default

Determines which Content-Type to use by default. Default: 'text/plain'

	$c->view('MyApp::View::Download')->config('default' => 'text/plain');

=item content_type

A hash ref of hash refs. Each key in content_type is Content-Type that is handled by this view. 

	$c->view('MyApp::View::Download')->config->{'content_type'}{'text/csv'} = {
		'outfile' => 'somefile.csv',
		'module' => 'My::Module'
	};

The Content-Type key refers to it's own hash of parameters to determine the actions thie view should take for that Content-Type.

'outfile' - The name and extenstion of the file that will display by default in the download dialog box.

'module' - The name of the module that will handle data output. If there is a plus symbol '+' at the beginning of the module name, this will indicate that the module is a Catalyst::View module will will add 'Catalyst::View::' to the beginning of the module name.

  # Module Loaded: Catalyst::View::Download::CSV
	$c->view('MyApp::View::Download')
    ->config
    ->{'content_type'}{'text/csv'}{'module'} = '+Download::CSV'; 

  # Module Loaded: My::Module::CSV
	$c->view('MyApp::View::Download')
    ->config
    ->{'content_type'}{'text/csv'}{'module'} = 'My::Module::CSV'; 

=back

=head1 Content-Type Module Requirements

Any module set as 'the' module for a certain Content-Type needs to have a subroutine named 'render' that returns the content to output with the following parameters handled.

=over 4

=item $c

The catalyst $c variable

=item $template

In case a template file is needed for the module. This view will pass $c->stash->{template} as this value.

=item $args

A list of arguments the module will use to process the data into content. This view will pass $c->stash as this value.

=back

=head1 CURRENT CONTENT-TYPES SUPPORTED

=head2 text/csv

Catalyst::View::Download has the following default configuration for this Content-Type

	$c->view('MyApp::View::Download')->config->{'content_type'}{'text/csv'} = {
		'outfile' => 'data.csv',
		'module' => '+Download::CSV'
	};

See L<Catalyst::View::Download::CSV> for more details.

=head2 text/html

Catalyst::View::Download has the following default configuration for this Content-Type

  $c->view('MyApp::View::Download')->config->{'content_type'}{'text/html'} = {
    'outfile' => 'data.html',
    'module' => '+Download::HTML'
  };
  
See L<Catalyst::View::Download::HTML> for more details.

=head2 text/plain

Catalyst::View::Download has the following default configuration for this Content-Type

	$c->view('MyApp::View::Download')->config->{'default'} = 'text/plain';

	$c->view('MyApp::View::Download')->config->{'content_type'}{'text/plain'} = {
		'outfile' => 'data.txt',
		'module' => '+Download::Plain'
	};
	
See L<Catalyst::View::Download::Plain> for more details.

=head2 text/xml

Catalyst::View::Download has the following default configuration for this Content-Type

  $c->view('MyApp::View::Download')->config->{'content_type'}{'text/xml'} = {
    'outfile' => 'data.xml',
    'module' => '+Download::XML'
  };
  
See L<Catalyst::View::Download::XML> for more details.

=head1 BUGS

=head1 SEE ALSO

L<Catalyst> L<Catalyst::View>

=head1 AUTHOR

Travis Chase, C<< <gaudeon at cpan.org> >>

=head1 ACKNOWLEDGEMENTS

Thanks to following people for their constructive comments and help:

=over 4

=item J. Shirley

=item Jonathan Rockway

=item Jon Schutz

=item Kevin Frost

=item Michele Beltrame

=item Dave Lambley

=back

Thanks also to my company Ti4 Technologies for their financial support. L<http://www.ti4tech.com/>

=head1 COPYRIGHT & LICENSE

Copyright 2011 Travis Chase.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
