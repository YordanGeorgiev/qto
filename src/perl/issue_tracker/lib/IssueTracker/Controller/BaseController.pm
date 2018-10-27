package IssueTracker::Controller::BaseController ; 
use strict ; use warnings ; 

use Mojo::Base 'Mojolicious::Controller';
use Data::Printer ; 


our $module_trace    = 0 ; 
our $appConfig       = {};
our $objLogger       = {} ;
our $rdbms_type      = 'postgres' ; 

use IssueTracker::App::Mdl::Model ; 
use IssueTracker::App::Db::In::RdrDbsFactory ; 
use IssueTracker::App::Cnvr::CnrHsr2ToHsr2 ; 


sub doReloadProjectDbMetaData {

   my $self                = shift ;
   my $db                  = shift ;
   print "doReloadProjectDbMetaData called !!! \n" ; 

   $appConfig		 		   = $self->app->get('AppConfig');
   my $objRdrDbsFactory    = {} ; 
   my $objRdrDb            = {} ; 
   my $msr2                = {} ; 
   my $ret                 = 1 ; 
   my $msg                 = "fatal error while reloading project database meta data " ; 
   my $objModel            = {} ; 

   $objModel               = 'IssueTracker::App::Mdl::Model'->new ( \$appConfig ) ;
   $objModel->set('postgres_db_name' , $db ) ; 
    
   $objRdrDbsFactory       = 'IssueTracker::App::Db::In::RdrDbsFactory'->new( \$appConfig, \$objModel );
   $objRdrDb               = $objRdrDbsFactory->doInstantiate( $rdbms_type );
   ($ret, $msg , $msr2 )   = $objRdrDb->doLoadProjDbMetaData( $db ) ; 
   # debug p $msr2 ; 

   return ( $ret , $msg , $msr2 ) ; 
}


sub isAuthorized {

   my $self                = shift ;
   my $db                  = shift ;
   $appConfig		 		   = $self->app->get('AppConfig');

   my $htpasswd_file = $appConfig->{ 'ProductInstanceDir'} . '/cnf/sec/passwd/' . $db . '.htpasswd' ;

   return 1 unless -f $htpasswd_file ;  # open by default !!! ( temporary till v0.5.1 )
   return 1 if $self->basic_auth(
      $db => {
         'path' => $htpasswd_file
      }
   );

   return 0  ;

}


1;

__END__

