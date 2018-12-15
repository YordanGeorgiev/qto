package IssueTracker::Controller::Export ;
use strict ; use warnings ; 

require Exporter;
our @ISA = qw(Exporter Mojo::Base IssueTracker::Controller::BaseController);
our $AUTOLOAD =();
our $ModuleDebug = 0 ; 
use AutoLoader;

use parent qw(IssueTracker::Controller::BaseController);

use Data::Printer ; 
use Data::Dumper; 
use Mojolicious::Plugin::RenderFile ;
use Carp qw /cluck confess shortmess croak carp/ ;

use IssueTracker::App::Utils::Logger;
use IssueTracker::App::IO::In::CnrUrlParams ; 
use IssueTracker::App::Db::In::RdrDbsFactory;
use IssueTracker::App::Utils::Timer ; 
use IssueTracker::App::IO::Out::WtrXls ; 

our $module_trace   = 0 ; 
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
   my $msr2             = {} ; 
   my $hsr2             = {} ; 
   my $ret              = 1 ; 
   my $msg              = '' ; 
   my $objRdrDb         = {}  ; 
   my $objRdrDbsFactory = {} ; 
   my $rdbms_type       = 'postgres' ; 
   my $xls_file         = '' ; 

   return unless ( $self->SUPER::isAuthorized($db) == 1 ); 

   $appConfig		 		= $self->app->get('AppConfig');
   unless ( exists ( $appConfig->{ $db . '.meta' } )  ) {
      ( $ret , $msg , $msr2 ) = $self->SUPER::doReloadProjectDbMetaData( $db ) ; 
      unless ( $ret == 0 ) { 
         $self->res->code(400) ; 
         $self->render('text' => $msg ) ; 
         return ; 
      }
   } 
 
   my $as               = 'xls' ; # the default form of the Export control 
   my $refObjModel      = {} ; 
   ( $ret , $msg , $refObjModel)  = $self->doSetRequestModelData( $db , $item ) ; 
   my $objModel = $$refObjModel ; 
#
#	# debug rint "Export.pm ::: url: " . $self->req->url->to_abs . "\n\n" if $module_trace == 1 ; 
#   $as = $self->req->query_params->param('as') || $as ; # decide which type of Export page to build
#   
   $objRdrDbsFactory = 'IssueTracker::App::Db::In::RdrDbsFactory'->new(\$appConfig, \$objModel ) ;
   $objRdrDb = $objRdrDbsFactory->doInit("$rdbms_type");
   
   ( $ret , $msg , $msr2 ) = $objModel->doGetTableMeta ( $appConfig , $db , $table ) ;
   return ( $ret , $msg ) unless $ret == 0 ; 
   ( $ret , $msg , $hsr2)  = $objRdrDb->doSelect( \$objModel , $table ) ; 
   return ( $ret , $msg ) unless $ret == 0 ; 
   $objModel->set('controller' , 'export');

   my $objWtrXls    = 'IssueTracker::App::IO::Out::WtrXls'->new( \$appConfig ) ;
   p $hsr2 ; 
   ($ret , $msg , $xls_file ) = $objWtrXls->doBuildXlsFromHashRef ( \$objModel , $table , $hsr2 , $msr2) ;

   unless ( $ret == 0 ) {
      $self->render('text' => "$msg" );
   } else {
      $self->render_file('filepath' => "$xls_file" ); 
   }

}

sub doSetRequestModelData {

   my $self             = shift ; 
   my $db               = shift ; 
   my $item             = shift ; 
  
   my $table            = $item or croak " item not specified !!!" ; 
   my $ret              = 1 ;  
   my $msg              = '' ; 
   my $objCnrUrlParams  = {} ; 
   my $objModel         = {} ; 

   $appConfig		 		= $self->app->get('AppConfig');
   $objModel            = 'IssueTracker::App::Mdl::Model'->new ( \$appConfig ) ;

   $objModel->set('postgres_db_name' , $db ) ; 
   $objModel->set('table_name' , $item ) ; 

   $objCnrUrlParams   = 'IssueTracker::App::IO::In::CnrUrlParams'->new();
   ( $ret , $msg ) = $objCnrUrlParams->doSetSelectUrlParams(\$objModel, $self->req->query_params );
   return ( $ret , $msg ) unless $ret == 0 ; 

   ( $ret , $msg ) = $objCnrUrlParams->doSetWithUrlParams(\$objModel, $self->req->query_params );
   return ( $ret , $msg , \$objModel) ;

}




1;

__END__

