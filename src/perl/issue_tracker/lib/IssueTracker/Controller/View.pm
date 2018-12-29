package IssueTracker::Controller::View ; 
use strict ; use warnings ; 

require Exporter;
our @ISA = qw(Exporter Mojo::Base IssueTracker::Controller::BaseController);
our $AUTOLOAD =();
our $ModuleDebug = 0 ; 
use AutoLoader;

use parent qw(IssueTracker::Controller::BaseController);

use Data::Printer ; 
use Scalar::Util qw /looks_like_number/;

use IssueTracker::Controller::PageFactory ; 
use IssueTracker::App::Utils::Logger;
use IssueTracker::App::Utils::Timer ; 

our $module_trace   = 0 ; 
our $appConfig      = {};
our $objLogger      = {} ;


sub doViewItems {

   my $self             = shift;
   my $db               = $self->stash('db');
   my $item             = $self->stash('item');

   my $ret              = 1 ; 
   my $msg              = '' ; 
   my $objModel         = {} ; 
   my $view_control     = '' ; 
   my $as               = 'doc' ; 

   return unless ( $self->SUPER::isAuthorized($db) == 1 );
   $self->SUPER::doReloadProjDbMeta( $db ) ;

   $appConfig		 		= $self->app->get('AppConfig');
   $objModel            = 'IssueTracker::App::Mdl::Model'->new ( \$appConfig ) ;
   ( $ret , $msg )  = $self->doSetRequestModelData( \$objModel, $db , $item );

   ( $ret , $msg , $view_control ) = $self->doBuildViewPageType ( $msg , \$objModel , $db , $item , $as  ) ; 
   $self->render('text' => 'view page is presented') unless $ret == 0 ; 
   $self->doRenderPageTemplate( $ret , $msg , $as, $db , $item , $view_control ) if $ret == 0 ;
   return
}

sub doBuildViewPageType {

   my $self             = shift ; 
   my $msg              = shift ; 
   my $objModel         = ${ shift @_ } ; 
   my $db               = shift ; 
   my $item             = shift ; 
   my $as               = shift ; 

   my $ui_type          = 'page/view-grid' ; 
   my $ret              = 1 ; 
   my $view_control     = '' ; 
   my $objPageBuilder   = {} ; 
   my $objPageFactory   = {} ; 

   my $lables_pages = { 
         'doc'        => 'view-doc'
      ,  'print-doc'  => 'view-print-doc'
   };

   my $page_type = $lables_pages->{ $as } || 'view-doc' ; 
   $ui_type = "page/$page_type" ;

   $objPageFactory                  = 'IssueTracker::Controller::PageFactory'->new(\$appConfig, \$objModel );
   $objPageBuilder                  = $objPageFactory->doSpawn( $ui_type );
   ( $ret , $msg , $view_control )  = $objPageBuilder->doBuildViewControl( $msg , \$objModel , $db , $item , $as ) ;

   return ( $ret , $msg , $view_control ) ; 

}

sub doSetRequestModelData {

   my $self             = shift ; 
   my $objModel         = ${shift @_ } ; 
   my $db               = shift ; 
   my $item             = shift ; 
   
   my $ret              = 1 ;  
   my $msg              = '' ; 
   my $objCnrUrlParams  = {} ; 

   $appConfig		 		= $self->app->get('AppConfig');

   $objModel->set('postgres_db_name' , $db ) ; 
   $objModel->set('table_name' , $item ) ; 

   $objCnrUrlParams   = 'IssueTracker::App::IO::In::CnrUrlParams'->new();
   
   ( $ret , $msg ) = $objCnrUrlParams->doSetView(\$objModel, $self->req->query_params );
   return ( $ret , $msg ) unless $ret == 0 ; 
  
  ( $ret , $msg ) = $objCnrUrlParams->doSetList(\$objModel, $self->req->query_params );
   return ( $ret , $msg ) unless $ret == 0 ; 

   ( $ret , $msg ) = $objCnrUrlParams->doSetSelect(\$objModel, $self->req->query_params );
   return ( $ret , $msg ) unless $ret == 0 ; 

   ( $ret , $msg ) = $objCnrUrlParams->doSetWith(\$objModel, $self->req->query_params );
   return ( $ret , $msg , \$objModel) ; 
}


sub doRenderPageTemplate {
   
   my $self             = shift ; 
   my $ret              = shift ; 
   my $msg              = shift ; 
   my $as               = shift || 'doc' ; 
   my $db               = shift ; 
   my $item             = shift ; 
   my $list_control     = shift ; 
   my $notice           = '' ;

   unless ( $ret == 0 ) {
      $self->res->code($ret) unless $ret == 0 ; 
   } else {
      $self->res->code(200) ; 
   }

   my $as_templates = { 
         'doc'          => 'view-doc'
      ,  'print-doc'    => 'list-print-doc' 
   };
  
   my $template_name    = $as_templates->{ $as } || 'view-doc' ; 
   my $template         = 'pages/' . $template_name . '/' . $template_name ; 

   my $objTimer         = 'IssueTracker::App::Utils::Timer'->new( $appConfig->{ 'TimeFormat' } );
   my $page_load_time   = $objTimer->GetHumanReadableTime();

   $self->render(
      'template'        => $template 
    , 'as'              => $as
    , 'msg'             => $msg
    , 'item'            => $item
    , 'db' 		         => $db
    , 'ProductType' 		=> $appConfig->{'ProductType'}
    , 'ProductVersion' 	=> $appConfig->{'ProductVersion'}
    , 'GitShortHash'    => $appConfig->{'GitShortHash'}
    , 'page_load_time'  => $page_load_time
    , 'list_control'    => $list_control
    , 'notice'          => $notice
	) ; 

   return ; 
}

1;

__END__

