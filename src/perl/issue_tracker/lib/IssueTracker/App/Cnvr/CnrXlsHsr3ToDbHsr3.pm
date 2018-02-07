use strict ; use warnings ; 
package IssueTracker::App::Cnvr::CnrXlsHsr3ToDbHsr3 ; 

our $appConfig = {} ; 
use Data::Printer ; 
use Carp ; 

#
# convert a regular hs2 into a hierarchical one 
# 
sub doConvert {
   my $self       = shift ; 
   my $hsr2_in    = shift ; 
   my $hsr2       = {} ; 
   my $cp         = {} ;  # child -> parent 
  
   my $msg        = 'unkown error has occurred !!!' ; 
   my $ret        = 1 ;      # assume error from the start  
   my $lft        = 'lft' ;  # use header col name for defaults
   my $rgt        = 'rgt' ;  # use header col name for defaults
   my $rid        = 0 ;      # the row id as set by the reader
   my $state      = {} ; 

   foreach my $key ( sort keys %$hsr2_in ) {

      #print "rid : $rid \n" ; 
      #print "key : $key \n" ; 

      my $row = $hsr2_in->{ "$key" } ; 
      my $level = $row->{ 'level' } ; 

      
      if ( !defined ( $level ) ) {
         $msg = " the level for row id $rid was not defined !!!" ; 
         carp $msg ; 
         return ( $ret , $msg ) ; 
      } 

      if ( $rid == 0 ) {
         if ( $level ne 'level' ) {
            $msg = "the header for the level should always be : level" ; 
            carp $msg ; 
            return ( $ret , $msg ) ; 
         } 
      }
      elsif ( $rid == 1 ) {
         if ( $level != 0 ) {
            $msg = "the root element should have always level = 0" ; 
            carp $msg ; 
            return ( $ret , $msg ) ; 
         } 
         $lft = 1 ; $rgt = 2 ; 
      }
      else {         # ( $rid > 1 ) descending without siblings
         if ( $level == $hsr2->{ $rid-1 }->{'level'}+1 ) {
           ( $hsr2 ,$lft , $rgt ) = $self->doAddItemWithNoSiblings ( $hsr2 , $hsr2_in , $level , $lft , $rgt , $rid ) ; 
         } # descending with sibling
         elsif ( $level == $hsr2->{ $rid-1 }->{'level'} ) {
           ( $hsr2 ,$lft , $rgt ) = $self->doAddItemWithSiblings ( $hsr2 , $hsr2_in , $level , $lft , $rgt , $rid ) ; 
         }
         elsif ( $level == $hsr2->{ $rid-1 }->{'level'}-1 ) {
           ( $hsr2 ,$lft , $rgt ) = $self->doAddItemWithSiblings ( $hsr2 , $hsr2_in , $level , $lft , $rgt , $rid ) ; 
         }
         elsif( $level < $hsr2->{ $rid-1 }->{'level'}+2 ) {
            $msg = 'level decreased with more than 1 at row id:' . $rid ; 
            carp $msg ; 
            return ( $ret , $msg ) ; 
         }
         else  {     #( $level >= $hsr2->{ $rid-1 }->{'level'}+2 ) {
            $msg = 'level increased with more than 1 at row id:' . $rid ; 
            carp $msg ; 
            return ( $ret , $msg ) ; 
         }
      } #eof elsif rid > 1

      $row->{ 'lft' } = $lft ;  
      $row->{ 'rgt' } = $rgt ; 
      $hsr2->{ $rid } = $row ; 
      # $self->doPrintRow  ( $row ) ; 
      $rid++ ;

   } #eof foreach key

   # p $hsr2 ;

   $ret = 0 ; 
   $msg = 'ok for conversion of hsr2 to a hierarchy hs2' ; 
   return ( $ret , $msg , $hsr2 ) ; 
}


sub doAddItemWithSiblings {
   my $self  = shift ;
   my $hsr2  = shift ;
   my $hsr2_in  = shift ;
   my $level = shift ; 
   my $lft   = shift ; 
   my $rgt   = shift ; 
   my $rid   = shift ; 

   foreach my $irid ( sort keys %$hsr2_in ) {
      next if $irid == 0 ; 
      my $ilvl = $hsr2->{$irid}->{'level'} ; 

      if ( $irid < $rid ) {
         
         my $prgt = 0 ; 
         if ( $level == $hsr2->{ $rid-1 }->{ 'level' } ) {
            $prgt = $hsr2->{ $rid-1 }->{ 'rgt' } ; 
            $lft = $hsr2->{ $rid-1 }->{ 'rgt' } + 1 ; 
         }
         if ( $level < $hsr2->{ $rid-1 }->{ 'level' } ) {
            for (my $i = $rid -1; $i >= 1; $i--) {
               if ( $level == $hsr2->{ $i }->{ 'level' } ) {
                  $prgt = $hsr2->{ $i }->{ 'rgt' } ;
                  $lft = $prgt +1 ; 
                  last ;
               }
            }
         }

         if ( $hsr2->{ $irid }->{ 'lft' } > $prgt ){
            $hsr2->{ $irid }->{ 'lft' } = $hsr2->{ $irid }->{ 'lft' } + 2 ; 
         }
         if ( $hsr2->{ $irid }->{ 'rgt' } > $prgt ){
            $hsr2->{ $irid }->{ 'rgt' } = $hsr2->{ $irid }->{ 'rgt' } + 2 ; 
         }
      }
   }
   $rgt = $lft + 1 ; 
   return ( $hsr2 , $lft , $rgt ) ; 
}

sub doAddItemWithNoSiblings {

   my $self  = shift ;
   my $hsr2  = shift ;
   my $hsr2_in  = shift ;
   my $level = shift ; 
   my $lft   = shift ; 
   my $rgt   = shift ; 
   my $rid   = shift ; 

   # print "$hsr2->{ $rid-1 }->{ 'lft' } !!! \n\n" ;  
   $hsr2->{ $rid }->{ 'pid' } = $rid-1 ; 
   my $plft = $hsr2->{ $rid-1 }->{ 'lft' } ; 
   foreach my $irid ( sort keys %$hsr2_in ) {
      next if $irid == 0 ; 
      my $ilvl = $hsr2_in->{ $irid }->{'level'} ; 

       if ( $irid < $rid ) {
         if ( $hsr2->{ $irid }->{ 'lft' } > $plft ) {
            $hsr2->{ $irid }->{ 'lft' } = $hsr2->{ $irid }->{ 'lft' } +2 ; 
         }
         if ( $hsr2->{ $irid }->{ 'rgt' } > $plft ) {
            $hsr2->{ $irid }->{ 'rgt' } = $hsr2->{ $irid }->{ 'rgt' } +2 ; 
         }
       }
   $lft = $plft + 1 ; 
   $rgt = $plft + 2 ; 
   }
   return ( $hsr2 , $lft , $rgt ) ; 
}



sub doPrintRow {
   my $self = shift ; 
   my $row  = shift ; 

   print "start row: \n" ; 
   p $row ; 
   print "stop  row: \n" ; 

}
	# -----------------------------------------------------------------------------
	# the constructor 
	# -----------------------------------------------------------------------------
	sub new {

		my $class      = shift;    # Class name is in the first parameter
		$appConfig     = ${ shift @_ } || { 'foo' => 'bar' ,} ; 
		my $self = {};        # Anonymous hash reference holds instance attributes
		bless( $self, $class );    # Say: $self is a $class
      # $self = $self->doInitialize() ; 
		return $self;
	}  
	#eof const
   #
1;

__END__

=head1 NAME

CnrXlsHsr3ToDbHsr3

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

