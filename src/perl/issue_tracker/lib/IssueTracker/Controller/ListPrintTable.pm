package IssueTracker::Controller::ListPrintTable ; 
use strict ; use warnings ; 

use Data::Printer ; 
use Data::Dumper; 
use Scalar::Util qw /looks_like_number/;
use Carp ; 
use Mojo::Base 'Mojolicious::Controller';
use List::Util 1.33 'any';

use IssueTracker::App::Db::In::RdrDbsFactory;
use IssueTracker::App::Utils::Logger;
use IssueTracker::App::Cnvr::CnrHsr2ToArray ; 
use IssueTracker::App::UI::WtrUIFactory ; 
use IssueTracker::App::IO::In::CnrUrlParams ; 

our $module_trace    = 0 ; 
our $appConfig       = {};
our $objLogger       = {} ;
our $objModel        = {} ; 
our $rdbms_type      = 'postgres' ; 

sub new {

   my $invocant 			= shift ;    
   $appConfig           = ${ shift @_ } || { 'foo' => 'bar' ,} ; 
   $objModel            = ${ shift @_ } || croak 'missing objModel !!!' ; 
   my $class            = ref ( $invocant ) || $invocant ; 
   my $self             = {};       
   bless( $self, $class );    
   return $self;
}  


sub doBuildListControl {

	my $self          	= shift ; 
	my $msg           	= shift ; 
   my $objModel      	= ${ shift @_ } ; 
	my $db               = shift ; 
	my $table            = shift ; 

   my $ret           	= 1 ; 
   my $control       	= '' ; 
   my $mhsr2 				= {};
   my $objRdrDbsFactory = {} ; 
   my $objRdrDb 			= {} ; 
   my $objWtrUIFactory 	= {} ; 
   my $objUIBuilder 		= {} ; 

   ( $ret , $msg , $mhsr2 ) = $objModel->doGetTableMeta ( $appConfig , $db , $table ) ;
   return ( $ret , $msg , '' ) unless $ret == 0 ; 
		
   my $to_picks   = $objModel->get('list.web-action.pick') ; 
   my @picks      = split ( ',' , $to_picks ) if defined ( $to_picks ) ; 
   my $to_hides   = $objModel->get('list.web-action.hide') ; 
   my @hides      = split ( ',' , $to_hides ) if defined ( $to_hides ) ; 
	
   #debug p $mhsr2 ;  

   unless ( defined ( $to_picks )) {
   	$control = ']' ; # it is just the js array definining the cols ... i.e. less is more !!!
		foreach my $id ( reverse sort keys %$mhsr2 ) {
			my $row = $mhsr2->{ $id } ; 
			my $col = $row->{ 'attribute_name' } ; 
				$control = "'" . $col . "' , " . $control unless (grep /$col/, @hides) ; 
		}
   	$control = '[' . $control ; 
	} 
	else {
   	$control = "['id'," ; # it is just the js array definining the cols
		foreach my $to_pick ( @picks ) {
			$control .= "'" . $to_pick . "' , " unless ( $to_pick eq 'id' ) ; 
		}
		for (1..3) { chop ( $control ) } ;
   	$control .= ']' ;
	}

	# debug rint "control is $control \n" ; 
   return ( $ret , $msg , $control ) ; 
}

1;

__END__

