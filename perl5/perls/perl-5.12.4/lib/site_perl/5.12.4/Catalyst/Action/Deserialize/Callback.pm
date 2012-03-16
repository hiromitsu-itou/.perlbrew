package Catalyst::Action::Deserialize::Callback;

use Moose;
use namespace::autoclean;
use Scalar::Util qw(openhandle);

extends 'Catalyst::Action';

our $VERSION = '0.96';
$VERSION = eval $VERSION;

sub execute {
    my $self = shift;
    my ( $controller, $c, $callbacks ) = @_;

    my $rbody;

    # could be a string or a FH
    if ( my $body = $c->request->body ) {
        if(openhandle $body) {
            seek($body, 0, 0); # in case something has already read from it
            while ( defined( my $line = <$body> ) ) {
                $rbody .= $line;
            }
        } else {
            $rbody = $body;
        }
    }

    if ( $rbody ) {
        my $rdata = eval { $callbacks->{deserialize}->( $rbody, $controller, $c ) };
        if ($@) {
            return $@;
        }
        $c->request->data($rdata);
    } else {
        $c->log->debug(
            'I would have deserialized, but there was nothing in the body!')
            if $c->debug;
    }
    return 1;
}

__PACKAGE__->meta->make_immutable;

1;

