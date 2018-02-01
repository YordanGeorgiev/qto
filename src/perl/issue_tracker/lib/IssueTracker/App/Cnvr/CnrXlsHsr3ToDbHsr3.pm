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
   my $hsr2_out   = {} ; 
  
   my $msg        = 'unkown error has occurred !!!' ; 
   my $ret        = 1 ; 
   my $lft        = 1 ; 
   my $rgt        = 2 ; 
   my $rid        = 0 ; 

   foreach my $key ( sort keys %$hsr2_in ) {

      # print "rid : $rid \n" ; 
      # print "key : $key \n" ; 

      my $row = $hsr2_in->{ "$key" } ; 
      #p ( "row is $row ) ; 
      my $level = $row->{ 'level' } ; 
      if ( $rid == 0 ) {
         if ( !defined ( $level ) || $level ne 'level' ) {
            $msg = "the root element should have always level = 0" ; 
            carp $msg ; 
            return ( $ret , $msg ) ; 
         } 
         $row->{ 'lft' } = 'lft' ;  
         $row->{ 'rgt' } = 'rgt' ; 
         $hsr2_out->{ $rid } = $row ; 
         $rid++ ;
         next  ; 
      }

      if ( $rid == 1 ) {
         if ( !defined ( $level ) || $level != 0 ) {
            $msg = "the root element should have always level = 0" ; 
            carp $msg ; 
            return ( $ret , $msg ) ; 
         } 
      }
      $row->{ 'lft' } = $lft ;  
      $row->{ 'rgt' } = $rgt ; 
      $hsr2_out->{ $rid } = $row ; 
      $self->doPrintRow  ( $row ) ; 
   } #eof foreach key

   # p $hsr2_out ;

   $ret = 0 ; 
   $msg = 'ok for conversion of hsr2 to a hierarchy hs2' ; 
   return ( $ret , $msg , $hsr2_out ) ; 
}


sub doPrintRow {
   my $self = shift ; 
   my $row  = shift ; 

   # print "start row: \n" ; 
   # p $row ; 
   # print "stop  row: \n" ; 

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

