package WWW::MobileCarrierJP::Softbank::PictogramInfo;
use strict;
use warnings;
use WWW::MobileCarrierJP::Declare;
use LWP::UserAgent;

my @urls = map { sprintf 'http://creation.mb.softbank.jp/web/web_pic_%02d.html', $_ } 1..6;
sub url { [@urls] }

sub scrape {
    my $xpath = q{//div[@class='contents']/table[2]/tr[1]/td/table/tr/td/table/tr[count(preceding-sibling::tr)>0]};
    my $scraper = scraper {
        col 2, unicode => [ 'TEXT', sub { s/\s//g } ];
    };

    my @res = ();
    my $ua = LWP::UserAgent->new(agent => __PACKAGE__);
    for my $url ( @urls ) {
        my $res = $ua->get($url);
        $res->is_success or die "cannot get $url";
        my $html = $res->content;

        $html =~ s/&#27;/ESC/g; # workaround for XML::LIbXML parser
        $html =~ s/&#15;/SI/g;

        my $result = scraper {
            process $xpath, 'rows[]', $scraper;
        }->scrape( $html )->{rows};

        push @res, @$result;
    }
    return \@res;
}

1;
__END__

=encoding utf-8

=head1 NAME

WWW::MobileCarrierJP::Softbank::PictogramInfo - 絵文字(Softbank)

=head1 SYNOPSIS

    use WWW::MobileCarrierJP::Softbank::PictogramInfo;
    WWW::MobileCarrierJP::Softbank::PictogramInfo->scrape();

=head1 INCOMPATIBILITY

From 2010-02-26, Softbank removes sjis pictogram code from web page.

=head1 AUTHOR

Tokuhiro Matsuno < tokuhirom gmail com >

=head1 SEE ALSO

L<WWW::MobileCarrierJP>

