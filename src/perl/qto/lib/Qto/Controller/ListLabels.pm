package Qto::Controller::ListLabels ; 
use strict ; use warnings ; 

use Data::Printer ; 
use Data::Dumper; 
use Scalar::Util qw /looks_like_number/;
use Carp ; 
use Mojo::Base 'Mojolicious::Controller';

use Qto::App::Db::In::RdrDbsFcry;
use Qto::App::Utils::Logger;
use Qto::App::Cnvr::CnrHsr2ToArray ; 
use Qto::App::UI::WtrUIFactory ; 
use Qto::App::IO::In::CnrUrlPrms ; 

our $module_trace   = 0 ; 
our $config      = {};
our $objLogger      = {} ;
our $objModel       = {} ; 
our $rdbms_type     = 'postgres' ; 

sub new {

   my $invocant 			= shift ;    
   $config           = ${ shift @_ } || { 'foo' => 'bar' ,} ; 
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
   my $objRdrDbsFcry = {} ; 
   my $objRdrDb 			= {} ; 
   my $objWtrUIFactory 	= {} ; 
   my $objUIBuilder 		= {} ; 

   ( $ret , $msg , $mhsr2 ) = $objModel->doGetTableMeta ( $config , $db , $table ) ;
   return ( $ret , $msg , '' ) unless $ret == 0 ; 
	
   $objWtrUIFactory = 'Qto::App::UI::WtrUIFactory'->new(\$config, \$objModel );
   $objUIBuilder = $objWtrUIFactory->doInit('control/list-labels');

   ( $ret , $msg , $control ) = $objUIBuilder->doBuild() ; 
   
   return ( $ret , $msg , $control ) ; 
}


1;

__END__

