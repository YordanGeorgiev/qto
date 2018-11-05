package IssueTracker::Controller::ListLabels ; 
use strict ; use warnings ; 

use Data::Printer ; 
use Data::Dumper; 
use Scalar::Util qw /looks_like_number/;
use Carp ; 
use Mojo::Base 'Mojolicious::Controller';

use IssueTracker::App::Db::In::RdrDbsFactory;
use IssueTracker::App::Utils::Logger;
use IssueTracker::App::Cnvr::CnrHsr2ToArray ; 
use IssueTracker::App::UI::WtrUIFactory ; 
use IssueTracker::App::IO::In::RdrUrlParams ; 

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

   ( $ret , $msg , $mhsr2 ) = $objModel->doGetTablesColumnList ( $appConfig , $db , $table ) ;
   return ( $ret , $msg , '' ) unless $ret == 0 ; 
	
   $objWtrUIFactory = 'IssueTracker::App::UI::WtrUIFactory'->new(\$appConfig, \$objModel );
   $objUIBuilder = $objWtrUIFactory->doInstantiate('control/list-labels');

   ( $ret , $msg , $control ) = $objUIBuilder->doBuild() ; 
   
   return ( $ret , $msg , $control ) ; 
}


1;

__END__

