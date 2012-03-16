package Business::PayPal::API::RefundTransaction;

use 5.008001;
use strict;
use warnings;

use SOAP::Lite 0.67;
use Business::PayPal::API ();

our @ISA = qw(Business::PayPal::API);
our $VERSION = '0.11';
our $CVS_VERSION = '$Id: RefundTransaction.pm,v 1.4 2006/03/24 17:11:50 scott Exp $';
our @EXPORT_OK = qw(RefundTransaction);

sub RefundTransaction {
    my $self = shift;
    my %args = @_;

    my %types = ( TransactionID => 'xs:string',
		  RefundType    => '',                    ## Other | Full | Partial
		  Amount        => 'ebl:BasicAmountType',
		  Memo          => 'xs:string', );

    $args{currencyID} ||= 'USD';
    $args{RefundType} ||= 'Full';

    my @ref_trans = 
      (
       $self->version_req,
       SOAP::Data->name( TransactionID => $args{TransactionID} )->type($types{TransactionID}),
       SOAP::Data->name( RefundType => $args{RefundType} )->type($types{RefundType}),
      );

    if( $args{RefundType} ne 'Full' && $args{Amount} ) {
	push @ref_trans,
	  SOAP::Data->name( Amount => $args{Amount} )
	      ->type( $types{Amount} )
		->attr( { currencyID => $args{currencyID} } )
    }

    push @ref_trans,
      SOAP::Data->name( Memo => $args{Memo} )->type( $types{Memo} )
	  if $args{Memo};

    my $request = SOAP::Data->name
      ( RefundTransactionRequest => \SOAP::Data->value( @ref_trans ) )
	->type("ns:RefundTransactionRequestType");

    my $som = $self->doCall( RefundTransactionReq => $request )
      or return;

    my $path = '/Envelope/Body/RefundTransactionResponse';

    my %response = ();
    unless( $self->getBasic($som, $path, \%response) ) {
        $self->getErrors($som, $path, \%response);
        return %response;
    }

    $self->getFields($som, $path, \%response,
                     { RefundTransactionID => 'RefundTransactionID',
                       FeeRefundAmount     => 'FeeRefundAmount',
                       NetRefundAmount     => 'NetRefundAmount',
                       GrossRefundAmount   => 'GrossRefundAmount', }
                    );

    return %response;
}

1;
__END__

=head1 NAME

Business::PayPal::API::RefundTransaction - PayPal RefundTransaction API

=head1 SYNOPSIS

  use Business::PayPal::API::RefundTransaction;

  ## see Business::PayPal::API documentation for parameters
  my $pp = new Business::PayPal::API::RefundTransaction ( ... );

  my %response = $pp->RefundTransaction( TransactionID => $transid,
                                         RefundType    => 'Full',
                                         Memo          => "Please come again!" );

=head1 DESCRIPTION

B<Business::PayPal::API::RefundTransaction> implements PayPal's
B<RefundTransaction> API using SOAP::Lite to make direct API calls to
PayPal's SOAP API server. It also implements support for testing via
PayPal's I<sandbox>. Please see L<Business::PayPal::API> for details
on using the PayPal sandbox.

=head2 RefundTransaction

Implements PayPal's B<RefundTransaction> API call. Supported
parameters include:

  TransactionID
  RefundType (defaults to 'Full' if not supplied)
  Amount
  Memo
  currencyID (defaults to 'USD' if not supplied)

as described in the PayPal "Web Services API Reference" document. The
default B<currencyID> setting is 'USD' if not otherwise specified. The
default B<RefundType> setting is 'Full' if not otherwise specified.

If B<RefundType> is set to 'Full', B<Amount> is ignored (even if
set). If B<RefundType> is set to 'Partial', B<Amount> is required.

Returns a hash containing the results of the transaction. The B<Ack>
element is likely the only useful return value at the time of this
revision (the Nov. 2005 errata to the Web Services API indicates that
the documented fields 'TransactionID', 'GrossAmount', etc. are I<not>
returned with this API call).

Example:

  my %resp = $pp->RefundTransaction( TransactionID => $trans_id,
                                     RefundType    => 'Partial',
                                     Amount        => '15.00', );

  unless( $resp{Ack} !~ /Success/ ) {
      for my $error ( @{$response{Errors}} ) {
          warn "Error: " . $error->{LongMessage} . "\n";
      }
  }

=head2 ERROR HANDLING

See the B<ERROR HANDLING> section of B<Business::PayPal::API> for
information on handling errors.

=head2 EXPORT

None by default.

=head1 SEE ALSO

L<https://developer.paypal.com/en_US/pdf/PP_APIReference.pdf>

=head1 AUTHOR

Scot Wiersdorf E<lt>scott@perlcode.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2006 by Scott Wiersdorf

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.5 or,
at your option, any later version of Perl 5 you may have available.


=cut
