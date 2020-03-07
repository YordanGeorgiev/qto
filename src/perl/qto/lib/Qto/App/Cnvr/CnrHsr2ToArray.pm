use strict ; use warnings ; 
package Qto::App::Cnvr::CnrHsr2ToArray ; 

our $config = {} ; 
use Data::Printer ; 
use Carp ; 

our $objModel = {} ; 
   
   sub doConvertSetMaxWidth {

      my $self          = shift ; 
      my $msr2          = shift ;
      my $hsr2          = shift ; 
      my $order_op      = shift || '<=>' ; 
      my $to_order_by   = shift || 'id';
      my $page_size     = shift || 7 ;
      my $page_num      = shift || 1 ;
      my $msg           = 'unknown error has occurred !!!' ; 
      my $ret           = 1 ;      # assume error from the start  
      my @list          = () ; 

      my $rows_count = 0 ; 
      $to_order_by   = 'id' unless ( defined $to_order_by ) ; 
      my $evl_str_sort_data = 'sort { $hsr2->{$b}->{ $to_order_by } ' . "$order_op" . ' $hsr2->{$a}->{ $to_order_by } } keys (%$hsr2) ' ; 
      my $evl_str_sort_meta = 'keys %$hsr2' ; # as it is just a hash ref of hash refs 
      my $evl_str_sort_by = $evl_str_sort_data ; 
      $evl_str_sort_by = $evl_str_sort_meta if $to_order_by eq 'attnum' ; 
      $evl_str_sort_by = $evl_str_sort_meta if $to_order_by eq 'attribute_number' ; 
      $evl_str_sort_by = $evl_str_sort_meta if $to_order_by eq 'relevancy' ; 

      foreach my $key (  eval "$evl_str_sort_by" ) {
         my $row = $hsr2->{$key} ; 
			foreach my $k ( keys %$row ){
   			$self->setCellMaxWidth($msr2,$k,$row->{"$k"});
			}
         unshift( @list , $row ) ; 
      }

      $rows_count          = scalar(@list);      
      my $slice_start      = $page_size*($page_num-1);
      my $slice_stop       = $slice_start + ($page_size-1);
      $slice_stop          = scalar(@list) -1 if ( $slice_stop >= scalar(@list));
      my @paged_list       = @list[$slice_start..$slice_stop];

      $ret                 = 0 ; 
      $msg                 = "" ; 
      return ( $ret , $msg , $msr2, \@paged_list , $rows_count ) ; 
   } 

   sub setCellMaxWidth {
      my $self = shift ; 
      my $msr2 = shift ; 
      my $attribute_name = shift ; 
      my $cell_cnt = shift ; 

      foreach my $pos (keys %$msr2 ){
         if ( $msr2->{"$pos"}->{'argname'} eq "$attribute_name" ){
            $msr2->{"$pos"}->{'attribute_name'} = $msr2->{"$pos"}->{'argname'};
				$msr2->{"$pos"}->{'attribute_number'} = $msr2->{$pos}->{'pos'} ; 
				$msr2->{"$pos"}->{'char_max_length'} = length($cell_cnt);
				$msr2->{"$pos"}->{'width'} = length($cell_cnt)*4;
         }
      }
   }


   #
	# -----------------------------------------------------------------------------
	# convert from hash ref of hash refs to an array and return the array ref
	# -----------------------------------------------------------------------------
   sub doConvert {

      my $self          = shift ; 
      my $hsr2          = shift ; 
      my $order_op      = shift || 'cmp' ; 
      my $to_order_by   = shift || $objModel->get('select.web-action.o') ; 

      $to_order_by   = 'id' unless ( defined $to_order_by ) ; 
      my $msg        = 'unknown error has occurred !!!' ; 
      my $ret        = 1 ;      # assume error from the start  
      my @list       = () ; 

      my $rows_count = 0 ; 
      my $evl_str_sort_data = 'sort { $hsr2->{$a}->{ $to_order_by } ' . "$order_op" . ' $hsr2->{$b}->{ $to_order_by } } keys (%$hsr2) ' ; 
      my $evl_str_sort_meta = 'keys %$hsr2' ; # as it is just a hash ref of hash refs 
      my $evl_str_sort_by = $evl_str_sort_data ; 
      $evl_str_sort_by = $evl_str_sort_meta if $to_order_by eq 'attnum' ; 
      $evl_str_sort_by = $evl_str_sort_meta if $to_order_by eq 'attribute_number' ; 
      $evl_str_sort_by = $evl_str_sort_meta if $to_order_by eq 'relevancy' ; 

      foreach my $key (  eval "$evl_str_sort_by" ) {
         my $row = $hsr2->{$key} ; 
         $rows_count = $row->{'rows_count'} if ( exists $row->{'rows_count'} ); delete $row->{'rows_count'} ; 
         push( @list , $row ) ; 
      }
      $ret = 0 ; 
      $msg = "" ; 
      return ( $ret , $msg , \@list , $rows_count ) ; 
   } 


	sub new {
		my $class      = shift;    # Class name is in the first parameter
		$config     = ${ shift @_ } || { 'foo' => 'bar' ,} ; 
		$objModel      = ${ shift @_ } || croak 'objModel not passed !!!' ; 
		my $self = {} ; bless( $self, $class );    # Say: $self is a $class
		return $self;
	}  
  

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

