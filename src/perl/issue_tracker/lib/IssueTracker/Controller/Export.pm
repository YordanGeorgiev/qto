package IssueTracker::Controller::Export ;
use strict ; use warnings ; 

require Exporter;
our @ISA = qw(Exporter Mojo::Base IssueTracker::Controller::BaseController);
our $AUTOLOAD =();
our $ModuleDebug = 0 ; 
use AutoLoader;

use parent qw(IssueTracker::Controller::BaseController);

use Data::Printer ; 
use Carp qw /cluck confess shortmess croak carp/ ;

use IssueTracker::App::Utils::Logger;
use IssueTracker::App::IO::In::CnrUrlParams ; 
use IssueTracker::App::IO::WtrExportFactory ; 
use IssueTracker::App::Utils::Timer ; 

our $appConfig      = {};
our $objLogger      = {} ;


#
# --------------------------------------------------------
# Export all the items according to the "as" url param output type
# --------------------------------------------------------
sub doExportItems {

   my $self             = shift;
   my $db               = $self->stash('db');
   my $item             = $self->stash('item');
   my $table            = $item ; 
   my $ret              = 1 ; 
   my $msg              = 0 ; 
   my $msr2             = {}  ; 
   my $file_to_export   = '/tmp/non-existent-file-to-export.tmp' ; 

   return unless ( $self->SUPER::isAuthorized($db) == 1 );
   $self->SUPER::doReloadProjDbMeta( $db ) ;
   $appConfig		 		= $self->app->get('AppConfig');
 
   my $as               = 'xls' ; # the default form of the Export control 
   $as = $self->req->query_params->param('as') || $as ; # decide which type of list page to build

   my $objModel         = 'IssueTracker::App::Mdl::Model'->new ( \$appConfig ) ;
   ( $ret , $msg )      = $self->doSetRequestModelData( \$objModel , $db , $item );

   my $objExportFactory = 'IssueTracker::App::IO::WtrExportFactory'->new(\$appConfig, \$objModel , $as );
   my $objExporter      = $objExportFactory->doSpawn( $as );
   $objExporter->doExport( $db , $table ) ; 
   ($ret , $msg , $file_to_export ) = $objExporter->doExport( $db , $table ) ;

   unless ( $ret == 0 ) {
      $self->render('text' => "$msg" );
   } else {
      $self->render_file('filepath' => "$file_to_export" ); 
   }
}

sub doSetRequestModelData {

   my $self             = shift ; 
   my $objModel         = ${ shift @_ } ; 
   my $db               = shift ; 
   my $item             = shift ; 
   
   my $ret              = 1 ;  
   my $msg              = '' ; 
   my $objCnrUrlParams  = {} ; 

   $appConfig		 		= $self->app->get('AppConfig');
   $objModel->set('postgres_db_name' , $db ) ; 
   $objModel->set('table_name' , $item ) ; 

   $objCnrUrlParams   = 'IssueTracker::App::IO::In::CnrUrlParams'->new();
   ( $ret , $msg ) = $objCnrUrlParams->doSetList(\$objModel, $self->req->query_params );
   return ( $ret , $msg ) unless $ret == 0 ; 
   
   ( $ret , $msg ) = $objCnrUrlParams->doSetView(\$objModel, $self->req->query_params );
   return ( $ret , $msg ) unless $ret == 0 ; 

   ( $ret , $msg ) = $objCnrUrlParams->doSetSelect(\$objModel, $self->req->query_params );
   return ( $ret , $msg ) unless $ret == 0 ; 

   ( $ret , $msg ) = $objCnrUrlParams->doSetWith(\$objModel, $self->req->query_params );
   return ( $ret , $msg ) ;

}




1;

__END__

