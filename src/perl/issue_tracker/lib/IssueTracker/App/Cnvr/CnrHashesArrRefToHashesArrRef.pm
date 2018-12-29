use strict ; use warnings ; 
package IssueTracker::App::Cnvr::CnrHashesArrRefToHashesArrRef ; 

use Data::Printer ; 
use Carp ; 

our $appConfig       = {} ; 
	
#
# -----------------------------------------------------------------------------
# clear the logical numbers from the node id passed and set to 0
# -----------------------------------------------------------------------------
sub doResetAllSubordinateLevels {

   my $self 						= shift ; 
   my $hs_level_counts		 	= shift ; 
   my $current_level				= shift ; 

   
   for ( my $level = 0 ;$level < 20; $level++ ) {
      next if $level <= $current_level  ; 
      $hs_level_counts->{ $level } = 0 ; 
   }

}


#
# -----------------------------------------------------------------------------
# the numbering of the view page comes from here ...
# obs code from year 2014 !!!
# -----------------------------------------------------------------------------
sub doConvert {
		
   my $self 						= shift  ;
   my $rs 							= shift ; 
   my $start_upper_level		= shift || 0 ; 

   my @arr_out                = () ; 
   my $item_id_name				= 'id' ; 
   my $hs_seq_logical_order	= {} ; 
   my $logical_order				= '1' ; 
   my $level_count				= '0' ; 	
   my $hs_level_counts			= {} ; 
   my $prev_level_num			= 0 ; 
   my $prev_row_id			   = 0 ; 
   my $prev_row 				   = {} ; 

   @$rs = sort { $a->{ 'seq' } <=> $b->{ 'seq' } } @$rs;
   my $rowc	= 0 ; 

   # fill first the level counts
   foreach my $row ( @$rs )  {

      # set the id as the key to the logical hash
      my $id  = $row->{ $item_id_name } || $start_upper_level ; 
      $prev_level_num = $prev_row->{'level'} || 0 ; 

      $hs_seq_logical_order->{ $id } = {} ; 
      $hs_seq_logical_order->{ $id }->{'id'} = $id ; 
      

      my $level_num 	= $row->{ 'level' } ; 

      my $start_num = 0 ; 
      # only the first visible level starts at 1
      $start_num 	= 0 if $row->{ 'level' } == 2 ; 
      
      $hs_level_counts->{ $level_num } = $start_num 
         unless ( $hs_level_counts->{ $level_num } ) ; 
      
      #old if ( $row->{'level'} == 1 ) {
      if ( $rowc == 0 ) {
         my $current_level = $row->{'level'} ; 
         my $current_nxt_level = $row->{'level'} ; 
         $hs_level_counts->{ $current_level } = 0 ; 
         $hs_level_counts->{ $current_nxt_level } = 0 ; 
         $rowc++ ;
         next  ;
      }


      if ( $level_num == $prev_level_num ) {

         my $prev_level_count = $hs_level_counts->{ $level_num } ; 
         # rint rint "\$prev_level_count ::: $prev_level_count \n" ; 
         my $curr_level_count = $prev_level_count + 1 ;
         $hs_level_counts->{ $level_num } = $curr_level_count ; 

      }
      if ( $level_num < $prev_level_num ) {
         #$hs_level_counts->{ $level_num } = $start_num  ; 
         $self->doResetAllSubordinateLevels ( $hs_level_counts , $level_num ) ;
         my $prev_level_count = $hs_level_counts->{ $level_num } ; 
         # debug rint "\$prev_level_count ::: $prev_level_count \n" ; 
         my $curr_level_count = $prev_level_count + 1 ;
         $hs_level_counts->{ $level_num } = $curr_level_count ; 
      }
      if ( $level_num > $prev_level_num ) {

         my $prev_level_count = $hs_level_counts->{ $level_num } ; 
         # print "\$prev_level_count ::: $prev_level_count \n" ; 
         my $curr_level_count = $prev_level_count + 1 ;
         $hs_level_counts->{ $level_num } = $curr_level_count ; 
         $hs_level_counts->{ $level_num + 1 } = $start_num ; 
      }

      my %copy_of_hs_level_counts = %$hs_level_counts ; 
      $hs_seq_logical_order->{ $id }->{ 'HashReferenceLevelCounts' } = \%copy_of_hs_level_counts ; 


      #debug ok rint "level_num ::: " . $level_num . "\n" ; 
      $prev_row_id = $id ; 
      $prev_row	 = $row ; 
      $rowc++ ; 
   }
   #eof foreach my $i

   # build than the logical orders based on filled already level counts 
   # the $row is just a hash reference
   foreach my $row ( @$rs )  {
      # get the id as the key to the logical hash
      my $id  = $row->{ $item_id_name } || 0 ; 
      my $hs_i = $hs_seq_logical_order->{ $id }->{'HashReferenceLevelCounts'} ;
      #debug p ($hs_i);

      foreach my $key ( sort ( keys ( %$hs_i ) )) {
         #debug rint "hs_i key is " . $key . "\n" ; 

         my $post_dot_maybe			= '.' ; 
         $post_dot_maybe 				= '' if $key == 0 ; 

         my $curr_level_count = '' ; 
         $curr_level_count		= $hs_i->{ $key } if ( $hs_i->{ $key } and $key != 0  ) ; 
         $post_dot_maybe 				= '' unless $curr_level_count ; 

         #$curr_level_count		= '' 
         #	if ( $curr_level_count == 0 and $key == 1 ) ; 
         if ( $key > 1 ) {				
            my $logical_order = $hs_seq_logical_order->{ $id }->{ 'logic_order' } ; 
            $logical_order  =~ s/(.*)\.\.\./$1/g ; 
            $logical_order  .= 
               $curr_level_count . $post_dot_maybe ; 
            $hs_seq_logical_order->{ $id }->{ 'logic_order' } = $logical_order ; 
         }
         else {
            $hs_seq_logical_order->{ $id }->{ 'logic_order' } =
               $curr_level_count . $post_dot_maybe ; 
         }
         #debug print "logical order is " . $hs_seq_logical_order->{ $id }->{ 'logic_order' } . "\n" ;  
      }
      #eof foreach $key
      my $logical_order = $hs_seq_logical_order->{ $id }->{ 'logic_order' } ; 
      $row->{ 'logical_order' } = $logical_order ; 
      push @arr_out , $row ; 
   }
   #eof foreach row

   return \@arr_out ; 
}




sub new {
   my $class      = shift;    
   $appConfig     = ${ shift @_ } || croak "appConfig not provided !!!" ; 
   my $self = {}; bless( $self, $class );    
   return $self;
}  

1;

__END__

=head1 NAME

CnrHashesArrRefToHashesArrRef

=head1 SYNOPSIS

use CnrHashesArrRefToHashesArrRef;


=head1 DESCRIPTION
Convert an array reference of hashes to array reference of hashes having lft and rgt keys 
and the logical_order to model a nested-set hierarchichal structure ...
=head2 EXPORT


=head1 SEE ALSO

No mailing list for this module


=head1 AUTHOR

yordan.georgiev@gmail.com

=head1 



=cut 

