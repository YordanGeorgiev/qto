use strict ; use warnings ; 
package IssueTracker::App::Cnvr::CnrXlsHsr3ToDbHsr3 ; 

our $appConfig = {} ; 
use Data::Printer ; 

sub doConvert {
   my $self       = shift ; 
   my $hsr2_in    = shift ; 
   my $hsr2_out   = {} ; 
   
   my $lft        = 1 ; 
   my $rgt        = 2 ; 
   my $rid        = 0 ; 

   foreach my $key ( sort keys %$hsr2_in ) {

      my $row = $hsr2_in->{ $key } ; 

      my $level = $row->{ 'level' } ; 
      # next if $level == 0 ; # by convention the element with the 0 is the root
      $row->{ 'lft' } = $lft ;  
      $row->{ 'rgt' } = $rgt ; 
      $hsr2_out->{ $rid } = $row ; 
      $self->doPrintRow  ( $row ) ; 
      $rid++ ;
   }
   return $hsr2_out
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

