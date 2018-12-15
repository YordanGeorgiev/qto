package IssueTracker::Controller::ViewDoc ; 
use strict ; use warnings ; 

use Carp ; 
use Data::Printer ; 
use Data::Dumper; 
use Scalar::Util qw /looks_like_number/;

use IssueTracker::App::Utils::Logger;
use IssueTracker::App::IO::In::CnrUrlParams ; 
use IssueTracker::App::Db::In::RdrDbsFactory;
use IssueTracker::App::Cnvr::CnrHsr2ToArray ; 
use IssueTracker::App::UI::WtrUIFactory ; 

our $module_trace   = 0 ; 
our $appConfig      = {};
our $objLogger      = {} ;
our $objModel       = {} ; 
our $rdbms_type     = 'postgres' ; 

sub new {

   my $invocant 			= shift ;    
   $appConfig           = ${ shift @_ } || { 'foo' => 'bar' ,} ; 
   $objModel            = ${ shift @_ } || croak 'missing objModel !!!' ; 
   my $class            = ref ( $invocant ) || $invocant ; 
   my $self             = {};       
   bless( $self, $class );    
   return $self;
}  


sub doBuildViewControl {

	my $self          	= shift ; 
	my $msg           	= shift ; 
   my $objModel      	= ${ shift @_ } ; 
	my $db               = shift ; 
	my $item             = shift ; 

   my $ret           	= 1 ; 
   my $control       	= '' ; 
   my $mhsr2 				= {};
   my $objRdrDbsFactory = {} ; 
   my $objRdrDb 			= {} ; 
   my $objWtrUIFactory 	= {} ; 
   my $objUIBuilder 		= {} ; 
   my $cols             = () ; 

   $objRdrDbsFactory    = 'IssueTracker::App::Db::In::RdrDbsFactory'->new(\$appConfig, \$objModel ) ;
   $objRdrDb            = $objRdrDbsFactory->doInit("$rdbms_type");

   ( $ret , $msg , $cols) = $objModel->doGetTableColumnView( $appConfig , $db , $item ) ;
   return ( $ret , $msg , '' ) unless $ret == 0 ; 
		
   my $to_picks   = $objModel->get('view.web-action.pick') ; 
   my @picks      = split ( ',' , $to_picks ) if defined ( $to_picks ) ; 
   my $to_hides   = $objModel->get('view.web-action.hide') ; 
   my @hides      = split ( ',' , $to_hides ) if defined ( $to_hides ) ; 
	
   unless ( defined ( $to_picks )) {
		foreach my $col ( @$cols ) {
		  $control = $control . ",'" . $col . "'" unless (grep /$col/, @hides) ; 
		}
   	$control = "['id'," . substr($control, 1) . ']' ; 
	} 
	else {
   	$control = "['id'," ; # it is just the js array definining the cols
		foreach my $to_pick ( @picks ) {
			$control .= "'" . $to_pick . "' , " unless ( $to_pick eq 'id' ) ; 
		}
		for (1..3) { chop ( $control ) } ;
   	$control .= ']' ;
	}

   return ( $ret , $msg , $control ) ; 
}

1;

__END__

