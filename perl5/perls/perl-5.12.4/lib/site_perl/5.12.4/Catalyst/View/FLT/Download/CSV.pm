package Catalyst::View::FLT::Download::CSV;

use strict;
use warnings;
use base qw( Catalyst::View );

use Catalyst::Exception;
use Text::CSV::Encoded;

our $VERSION='0.01';

=head1 NAME

Catalyst::View::FLT::Download::CSV

=cut

__PACKAGE__->config(
    'stash_key' => 'csv',
    'quote_char' => '"',
    'escape_char' => '"',
    'sep_char' => ',',
    'eol' => "\n",
    'encoding_out' => 'shiftjis',
);

sub process {
    my $self = shift;
    my ($c) = @_;

    my $template = $c->stash->{template};
    my $content = $self->render($c, $template, $c->stash);

    $c->res->content_type('application/octet-stream');
    $c->res->body( $content );
}

sub render {
    my $self = shift;
    my ($c,  $template, $args) = @_;

    my $content = "";

    my @data;

    my $stash_key = $self->config->{'stash_key'};

    if(defined($args->{$stash_key}) && ref($args->{$stash_key}) =~ /HASH/ &&
       defined($args->{$stash_key}{data}) &&
       defined($args->{$stash_key}{columns}) &&
       defined($args->{$stash_key}{filename}) &&
       $args->{$stash_key}{data} =~ /ARRAY/ &&
       $args->{$stash_key}{columns} =~ /ARRAY/) {
        push(@data, @{$args->{$stash_key}{data}});
    }
    else {
        return $content;
    }

    $c->res->header( 'Content-Disposition' => 'attachment; filename="'
                        . $args->{$stash_key}{filename} . '"' );

    my $csv = Text::CSV::Encoded->new ({
        quote_char          => $self->config->{'quote_char'},
        escape_char         => $self->config->{'escape_char'},
        sep_char            => $self->config->{'sep_char'},
        eol                 => $self->config->{'eol'},
        binary              => 1,
        allow_loose_quotes  => 1,
        allow_loose_escapes => 1,
        allow_whitespace    => 1,
        encoding_out        => $self->config->{'encoding_out'},
    });

    # header追加
    if (defined($args->{$stash_key}{header} =~ /ARRAY/)){
        my $status = $csv->combine(@{$args->{$stash_key}{header}});
        Catalyst::Exception->throw("Text::CSV->combine Error: ".$csv->error_diag()) if(!$status);
        $content .= $csv->string;
    }

    foreach my $row(@data) {
        my $status = $csv->combine(map ($row->{$_}, @{$args->{$stash_key}{columns}}) );
        Catalyst::Exception->throw("Text::CSV->combine Error: ".$csv->error_diag()) if(!$status);
        $content .= $csv->string();
    }
    return $content;
}

1;
