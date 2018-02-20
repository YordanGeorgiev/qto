use strict ; use warnings ; 
package IssueTracker::App::Cnvr::CnrXlsHsr3ToDbHsr3 ; 

our $appConfig = {} ; 
use Data::Printer ; 
use Carp ; 

our $lfth         = 'lft' ; # the string used for the left header - lft or LeftRank
our $rgth         = 'rgt' ;  # the string used for the rgt header - rgt or RightRank
our $levelh       = 'level' ;  # the string used for the level header - level or Level
our $rdbms_type   = 'postgres' ; 
#
# convert a regular hs2 into a hierarchical one 
# 
sub doConvert {
   my $self       = shift ; 
   my $hsr2_in    = shift ; 
   my $hsr2       = {} ; 
   my $cp         = {} ;  # child -> parent 
  
   my $msg        = 'unknown error has occurred !!!' ; 
   my $ret        = 1 ;      # assume error from the start  
   my $lft        = $lfth ;  # use header col name for defaults
   my $rgt        = $rgth ;  # use header col name for defaults
   my $rid        = 0 ;      # the row id as set by the reader
   my $state      = {} ; 


   foreach my $key ( sort  {$a<=>$b} keys %$hsr2_in  ) {

      # print "rid : $rid \n" ; 
      # print "key : $key \n" ; 

      my $row = $hsr2_in->{ "$key" } ; 
      my $level = $row->{ $levelh } ; 
      #print "level : $level \n" ; 
      # $self->doPrintRow  ( $rid , $row ) ; 

      
      if ( !defined ( $level ) ) {
         $msg = " the level for row id $rid was not defined !!!" ; 
         carp $msg ; 
         return ( $ret , $msg ) ; 
      } 

      if ( $rid == 0 ) {
         if ( $level ne $levelh ) {
            $msg = "the header for the level should always be : 
               level for postgres 
               and Level for mysql" ; 
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
         if ( $level == $hsr2->{ $rid-1 }->{$levelh}+1 ) {
           ( $hsr2 ,$lft , $rgt ) = $self->doAddItemWithNoSiblings ( $hsr2 , $hsr2_in , $level , $lft , $rgt , $rid ) ; 
         } # descending with sibling
         elsif ( $level == $hsr2->{ $rid-1 }->{$levelh} ) {
           ( $hsr2 ,$lft , $rgt ) = $self->doAddItemWithSiblings ( $hsr2 , $hsr2_in , $level , $lft , $rgt , $rid ) ; 
         }
         elsif ( $level <= $hsr2->{ $rid-1 }->{$levelh} - 1 ) {
           ( $hsr2 ,$lft , $rgt ) = $self->doAddItemWithSiblings ( $hsr2 , $hsr2_in , $level , $lft , $rgt , $rid ) ; 
         }
         elsif ( $level >= $hsr2->{ $rid-1 }->{$levelh} + 2 ) {
            # print 'rid is : ' . $rid . "\n" ; 
            # print 'level is : ' . $level . "\n" ; 
            # print 'prev is : ' . $hsr2->{ $rid-1 }->{$levelh} . "\n" ; 
            $msg = 'the ' . $levelh . ' increased with more than 1 at row id:' . $rid ; 
            carp $msg ; 
            return ( $ret , $msg ) ; 
         }
         else {
            print 'rid is : ' . $rid . "\n" ; 
            print 'level is : ' . $level . "\n" ; 
            print 'prev is : ' . $hsr2->{ $rid-1 }->{$levelh} . "\n" ; 
            $msg = 'the ' . $levelh . ' untrapped case for rid ' . "$rid" . "\n" ; 
            carp $msg ; 
            return ( $ret , $msg ) ; 
         }
         #elsif( $level < $hsr2->{ $rid-1 }->{$levelh} + 2 ) {
         #   $msg = 'the ' . $levelh .  ' decreased with more than 1 at row id:' . $rid ; 
         #   carp $msg ; 
         #   return ( $ret , $msg ) ; 
         #}

      } #eof elsif rid > 1

      $row->{ $lfth } = $lft ;  
      $row->{ $rgth } = $rgt ; 
      $hsr2->{ $rid } = $row ; 
      # $self->doPrintRow  ( $rid , $row ) ; 
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
      my $ilvl = $hsr2->{$irid}->{$levelh} ; 

      if ( $irid < $rid ) {
         
         my $prgt = 0 ; 
         if ( $level == $hsr2->{ $rid-1 }->{ $levelh } ) {
            $prgt = $hsr2->{ $rid-1 }->{ $rgth } ; 
            $lft = $hsr2->{ $rid-1 }->{ $rgth } + 1 ; 
         }
         if ( $level < $hsr2->{ $rid-1 }->{ $levelh } ) {
            for (my $i = $rid -1; $i >= 1; $i--) {
               if ( $level == $hsr2->{ $i }->{ $levelh } ) {
                  $prgt = $hsr2->{ $i }->{ $rgth } ;
                  $lft = $prgt +1 ; 
                  last ;
               }
            }
         }

         if ( $hsr2->{ $irid }->{ $lfth } > $prgt ){
            $hsr2->{ $irid }->{ $lfth } = $hsr2->{ $irid }->{ $lfth } + 2 ; 
         }
         if ( $hsr2->{ $irid }->{ $rgth } > $prgt ){
            $hsr2->{ $irid }->{ $rgth } = $hsr2->{ $irid }->{ $rgth } + 2 ; 
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

   # print "$hsr2->{ $rid-1 }->{ $lfth } !!! \n\n" ;  
   $hsr2->{ $rid }->{ 'pid' } = $rid-1 ; 
   my $plft = $hsr2->{ $rid-1 }->{ $lfth } ; 
   foreach my $irid ( sort keys %$hsr2_in ) {
      next if $irid == 0 ; 
      my $ilvl = $hsr2_in->{ $irid }->{$levelh} ; 

       if ( $irid < $rid ) {
         if ( $hsr2->{ $irid }->{ $lfth } > $plft ) {
            $hsr2->{ $irid }->{ $lfth } = $hsr2->{ $irid }->{ $lfth } +2 ; 
         }
         if ( $hsr2->{ $irid }->{ $rgth } > $plft ) {
            $hsr2->{ $irid }->{ $rgth } = $hsr2->{ $irid }->{ $rgth } +2 ; 
         }
       }
   $lft = $plft + 1 ; 
   $rgt = $plft + 2 ; 
   }
   return ( $hsr2 , $lft , $rgt ) ; 
}



sub doPrintRow {
   my $self = shift ; 
   my $rid  = shift ; 
   my $row  = shift ; 

   # debug p $rid ; 
   # debug print " stop  rid \n" ; 
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
      $rdbms_type    = shift @_ || 'postgres' ; 
      if ( $rdbms_type eq 'mysql' || $rdbms_type eq 'mariadb' ) {
         $lfth          = 'LeftRank' ; 
         $rgth          = 'RightRank' ; 
         $levelh        = 'Level' ; 
      }
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

