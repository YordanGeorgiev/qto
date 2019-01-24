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
use IssueTracker::App::IO::In::CnrUrlPrms ; 
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
   my $http_method      = 'GET' ; 
   my $met              = '' ; 
   my $cnt              = '' ; 
   my $dat              = '' ; 

   return unless ( $self->SUPER::isAuthorized($db) == 1 );
   $self->SUPER::doReloadProjDbMeta( $db ) ;
   $appConfig		 		= $self->app->get('AppConfig');
 
   my $as               = 'xls' ; # the default form of the Export control 
   $as = $self->req->query_params->param('as') || $as ; # decide which type of list page to build

   my $objModel         = 'IssueTracker::App::Mdl::Model'->new ( \$appConfig , $db , $table ) ;
   my $objCnrUrlPrms    = 'IssueTracker::App::IO::In::CnrUrlPrms'->new(\$appConfig , \$objModel , $self->req->query_params);
   
   return $self->SUPER::doRenderJSON($objCnrUrlPrms->get('http_code'),$objCnrUrlPrms->get('msg'),$http_method,$met,$cnt,$dat) 
      unless $objCnrUrlPrms->doValidateAndSetSelect();

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



1;

__END__

