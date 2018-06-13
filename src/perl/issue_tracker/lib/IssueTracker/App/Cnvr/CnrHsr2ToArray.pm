use strict ; use warnings ; 
package IssueTracker::App::Cnvr::CnrHsr2ToArray ; 

our $appConfig = {} ; 
use Data::Printer ; 
use Carp ; 

our $objModel = {} ; 

   #
	# -----------------------------------------------------------------------------
	# convert from hash ref of hash refs to an array and return the array ref
	# -----------------------------------------------------------------------------
   sub doConvert {
      my $self          = shift ; 
      my $hsr2          = shift ; 
      my $to_order_by   = $objModel->get('select.web-action.o') || 'attnum' ; 
      my $to_hide       = $objModel->get('select.web-action.hide');

      my $msg        = 'unknown error has occurred !!!' ; 
      my $ret        = 1 ;      # assume error from the start  
      my @list       = () ; 

      my $rows_count = 0 ; 
      my $evl_str_sort_data = 'sort { $hsr2->{$a}->{ $to_order_by } cmp $hsr2->{$b}->{ $to_order_by } } keys (%$hsr2) ' ; 
      my $evl_str_sort_meta = 'keys %$hsr2' ; # as it is just a hash ref of hash refs 
      my $evl_str_sort_by = $evl_str_sort_data ; 
      $evl_str_sort_by = $evl_str_sort_meta if $to_order_by eq 'attnum' ; 

      if ( defined ( $to_order_by) ) {
         foreach my $key (  eval "$evl_str_sort_by" ) {
            my $row = $hsr2->{$key} ; 
            $rows_count = $row->{'rows_count'} ; delete $row->{'rows_count'} ; 
            ( $ret , $msg , $row ) = $self->doHideHidables ( $row , $to_hide , $msg ) ; 
            return ( $ret , $msg ) unless $ret == 0 ; 
            push ( @list , $row ) ; 
         }
      }
      else {
         foreach my $key ( keys %$hsr2 ) {
            my $row = $hsr2->{$key} ; 
            $rows_count = $row->{'rows_count'} ; delete $row->{'rows_count'} ; 
            ( $ret , $msg , $row ) = $self->doHideHidables ( $row , $to_hide , $msg ) ; 
            return ( $ret , $msg ) unless $ret == 0 ; 
            push ( @list , $row ) ; 
         }
      }
      $ret = 0 ; 
      $msg = "" ; 
      return ( $ret , $msg , \@list , $rows_count ) ; 
   } 


   #
	# -----------------------------------------------------------------------------
	# hide the attribute's values to hide per row in the hash ref of hash refs 
	# -----------------------------------------------------------------------------
   sub doHideHidables {

      my $self       = shift ; 
      my $row        = shift ; 
      my $to_hide    = shift ; 
      my $msg        = shift ; 

      my $ret        = 1 ; 

      if ( defined ( $to_hide ) ) {
         my @hides = split ( ',' , $to_hide ) ; 
         foreach my $hidable ( @hides ) {
           unless ( exists $row->{$hidable} ) {
               $msg = "the $hidable column does not exist" ; 
            return ( $ret , $msg ) ; 
           }
           delete $row->{$hidable} ;  
         }
      }
      $ret = 0 ; 
      return ( $ret , $msg , $row )  ; 
   }

   #
	# -----------------------------------------------------------------------------
	# the constructor 
	# -----------------------------------------------------------------------------
	sub new {

		my $class      = shift;    # Class name is in the first parameter
		$appConfig     = ${ shift @_ } || { 'foo' => 'bar' ,} ; 
		$objModel      = ${ shift @_ } || croak 'objModel not passed !!!' ; 

		my $self = {};        # Anonymous hash reference holds instance attributes
		bless( $self, $class );    # Say: $self is a $class
		return $self;
	}  
	#eof const
  

1;

__END__

=head1 NAME

CnrHsr2ToArray

=head1 SYNOPSIS

use UrlSniper  ; 


=head1 DESCRIPTION
the converter between xls read produced hsr2 and a hierarchichal model
containing hsr2
=head2 EXPORT


=head1 SEE ALSO

No mailing list for this module


=head1 AUTHOR

yordan.georgiev@gmail.com

=head1 



=cut 

