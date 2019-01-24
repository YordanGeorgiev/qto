package IssueTracker::Controller::Query ; 
use strict ; use warnings ; 
	
require Exporter;
our @ISA = qw(Exporter Mojo::Base IssueTracker::Controller::BaseController);
our $AUTOLOAD =();
our $ModuleDebug = 0 ; 
use AutoLoader;

use Data::Printer ; 

use parent qw(IssueTracker::Controller::BaseController);

use IssueTracker::App::Db::In::RdrDbsFactory;
use IssueTracker::App::Utils::Logger;
use IssueTracker::App::Cnvr::CnrHsr2ToArray ; 
use IssueTracker::App::IO::In::CnrUrlPrms ; 

my $module_trace    = 0 ;
our $appConfig      = {};
our $objLogger      = {} ;
our $rdbms_type     = 'postgres';



#
# --------------------------------------------------------
# Select all the rows from db by passed db and table name
# --------------------------------------------------------
sub doQueryItems {

   my $self             = shift;
   
   my $db               = $self->stash('db');
   my $ret              = 1 ; 
   my $msg              = 'unknown error during global text search ';
   my $msr2             = {} ; 
   
   return unless ( $self->SUPER::isAuthorized($db) == 1 );
   $self->SUPER::doReloadProjDbMeta( $db ) ;
   
   $appConfig		 		= $self->app->get('AppConfig');
   unless ( exists ( $appConfig->{ $db . '.meta' } )  ) {
      
      ( $ret , $msg , $msr2 ) = $self->SUPER::doReloadProjDbMeta( $db ) ; 
      unless ( $ret == 0 ) { 
         $self->render('text' => $msg ) unless $ret == 0 ; 
         return ; 
      }
      else { 
         $appConfig->{ $db . '.meta' } = $msr2 ; 
      }
   } 

   my $objCnrUrlPrms  = {} ; 
   my $objRdrDbsFactory = {} ; 
   my $objRdrDb         = {} ; 
   my $hsr2             = {};
   my $http_code        = 400 ;
   my $rows_count       = 0 ; 

	#print STDOUT "Query.pm ::: url: " . $self->req->url->to_abs . "\n\n" if $module_trace == 1 ; 

   my $objModel         = 'IssueTracker::App::Mdl::Model'->new ( \$appConfig , $db) ;
   $objModel->set('postgres_db_name' , $db ) ; 

   my $query_params = $self->req->query_params ; 
   $objCnrUrlPrms = 
      'IssueTracker::App::IO::In::CnrUrlPrms'->new(\$appConfig , \$objModel , $self->req->query_params);
   ( $ret , $msg ) = $objCnrUrlPrms->doSetQueryUrlParams('Query' );
   if ( $ret != 0 ) {
      $self->SUPER::doRenderJSON(400,$msg,'GET','','0','');
      return ; 
   } 

   $objRdrDbsFactory = 'IssueTracker::App::Db::In::RdrDbsFactory'->new(\$appConfig, \$objModel );
	$objRdrDb = $objRdrDbsFactory->doSpawn("$rdbms_type");
   ($ret, $msg , $hsr2 ) = $objRdrDb->doGlobalSrchIntoHashRef(\$objModel);

   if ( $ret == 0 ) {
      my $list = ();
      my $objCnrHsr2ToArray = 
         'IssueTracker::App::Cnvr::CnrHsr2ToArray'->new ( \$appConfig , \$objModel ) ; 
      ( $ret , $msg , $list , $rows_count ) = $objCnrHsr2ToArray->doConvert ($hsr2 ) ;

      $self->SUPER::doRenderJSON(200,$msg,'GET',$msr2,$rows_count,$list);
   } elsif ( $ret == 204 ) {
      $self->SUPER::doRenderJSON(204,$msg,'GET','','0','');
   } else {
      $self->SUPER::doRenderJSON(400,$msg,'GET','','0','');
   }
}


1;

__END__

# feature-guid: ecd424d7-e5bd-45f1-90c8-10fae1316bf9
