package Qto::Controller::SearchGrid ; 
use strict ; use warnings ; 

use Data::Printer ; 
use Data::Dumper; 
use Carp ; 
use Mojo::Base 'Mojolicious::Controller';

use Qto::App::IO::In::CnrUrlPrms ; 
use Qto::App::Db::In::RdrDbsFcry;
use Qto::App::Cnvr::CnrHsr2ToArray ; 
use Qto::App::UI::WtrUIFactory ; 

our $module_trace   = 0 ; 
our $appConfig      = {};
our $objModel       = {} ; 


sub doBuildSearchControl {

   my $self          	= shift ; 
   my $msg           	= shift ; 
   my $db               = shift ; 
   my $ret           	= 0 ; 
   my $control       	= '' ; 

   $control = "['id' , 'item' , 'relevancy' , 'name' , 'description']" ; # it is just the js array definining the cols
   return ( $ret , $msg , $control ) ; 
}


sub new {
   my $invocant 			= shift ;    
   $appConfig           = ${ shift @_ } || croak 'missing appConfig !!!' ; 
   $objModel            = ${ shift @_ } || croak 'missing objModel !!!' ; 
   my $class            = ref ( $invocant ) || $invocant ; 
   my $self             = {}; bless( $self, $class );    
   return $self;
}  

1;

__END__

