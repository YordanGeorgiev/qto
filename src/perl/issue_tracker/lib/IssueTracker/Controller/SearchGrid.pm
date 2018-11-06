package IssueTracker::Controller::SearchGrid ; 
use strict ; use warnings ; 

use Data::Printer ; 
use Data::Dumper; 
use Carp ; 
use Mojo::Base 'Mojolicious::Controller';

use IssueTracker::App::IO::In::RdrUrlParams ; 
use IssueTracker::App::Db::In::RdrDbsFactory;
use IssueTracker::App::Cnvr::CnrHsr2ToArray ; 
use IssueTracker::App::UI::WtrUIFactory ; 

our $module_trace   = 0 ; 
our $appConfig      = {};
our $objModel       = {} ; 
our $rdbms_type     = 'postgres' ; 


sub doBuildSearchControl {

   my $self          	= shift ; 
   my $msg           	= shift ; 
   my $db               = shift ; 
   my $ret           	= 0 ; 
   my $control       	= '' ; 

   $control = "['id' , 'item' , 'name' , 'description']" ; # it is just the js array definining the cols
   return ( $ret , $msg , $control ) ; 
}


sub new {
   my $invocant 			= shift ;    
   $appConfig           = ${ shift @_ } || { 'foo' => 'bar' ,} ; 
   $objModel            = ${ shift @_ } || croak 'missing objModel !!!' ; 
   my $class            = ref ( $invocant ) || $invocant ; 
   my $self             = {}; bless( $self, $class );    
   return $self;
}  

1;

__END__

