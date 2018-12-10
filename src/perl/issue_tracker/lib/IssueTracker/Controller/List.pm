package IssueTracker::Controller::List ; 
use strict ; use warnings ; 

require Exporter;
our @ISA = qw(Exporter Mojo::Base IssueTracker::Controller::BaseController);
our $AUTOLOAD =();
our $ModuleDebug = 0 ; 
use AutoLoader;

use parent qw(IssueTracker::Controller::BaseController);

use Data::Printer ; 
use Data::Dumper; 
use Scalar::Util qw /looks_like_number/;

use IssueTracker::App::Utils::Logger;
use IssueTracker::Controller::PageFactory ; 
use IssueTracker::App::IO::In::CnrUrlParams ; 
use IssueTracker::App::Db::In::RdrDbsFactory;
use IssueTracker::App::Cnvr::CnrHsr2ToArray ; 
use IssueTracker::App::UI::WtrUIFactory ; 
use IssueTracker::Controller::ListCloud ; 
use IssueTracker::Controller::ListLabels ;
use IssueTracker::App::Utils::Timer ; 

our $module_trace   = 0 ; 
our $appConfig      = {};
our $objLogger      = {} ;


#
# --------------------------------------------------------
# list all the items according to the "as" url param output type
# --------------------------------------------------------
sub doListItems {

   my $self             = shift;
   my $db               = $self->stash('db');
   my $item             = $self->stash('item');
   my $msr2             = {} ; 
   my $ret              = 1 ; 
   my $msg              = '' ; 

   return unless ( $self->SUPER::isAuthorized($db) == 1 );

   $appConfig		 		= $self->app->get('AppConfig');
   unless ( exists ( $appConfig->{ $db . '.meta' } )  ) {
      
      ( $ret , $msg , $msr2 ) = $self->SUPER::doReloadProjectDbMetaData( $db ) ; 
      unless ( $ret == 0 ) { 
         $self->res->code(400) ; 
         $self->render('text' => $msg ) ; 
         return ; 
      }
      else { 
         $appConfig->{ $db . '.meta' } = $msr2 ; 
      }
   } 
 
   my $as               = 'grid' ; # the default form of the list control 
   my $list_control     = '' ; 
   my $refObjModel      = {} ; 

	# debug print "List.pm ::: url: " . $self->req->url->to_abs . "\n\n" if $module_trace == 1 ; 
   $as = $self->req->query_params->param('as') || $as ; # decide which type of list page to build
   
   ( $ret , $msg , $refObjModel)  = $self->doSetRequestModelData( $item , $db ) ; 

   if ( $ret == 0 ) {
      ( $ret , $msg , $list_control ) = $self->doBuildListControl ( $msg , $refObjModel , $db , $item , $as  ) ; 
   } else {
      $list_control = '' ; 
   }

   # $self->doSetHtmlHeaders() ; # uncomment and implement if per list web action headers needed !!!
   $msg = $self->doSetPageMsg ( $ret , $msg ) ; 
   $self->doRenderPageTemplate( $as , $msg , $db , $item , $list_control ) ; 
}


sub doSetPageMsg {

   my $self       = shift ; 
   my $ret        = shift ; 
   my $msg        = shift ; 

   unless ( $ret == 0 ) {
      $msg = (split '::' , $msg)[0] ; 
      $msg = '<span id="spn_err_msg">' . $msg . '</span>' ; 
   } else {
      $msg = '<span id="spn_msg">' . $msg . '</span>' ; 
   }

   $self->res->code(400) unless $ret == 0 ; 

   return $msg ; 
}


sub doSetRequestModelData {

   my $self             = shift ; 
   my $item             = shift ; 
   my $db               = shift ; 
   
   my $ret              = 1 ;  
   my $msg              = '' ; 
   my $objCnrUrlParams  = {} ; 
   my $objModel         = {} ; 

   $appConfig		 		= $self->app->get('AppConfig');
   $objModel            = 'IssueTracker::App::Mdl::Model'->new ( \$appConfig ) ;

   $objModel->set('postgres_db_name' , $db ) ; 
   $objModel->set('table_name' , $item ) ; 

   $objCnrUrlParams   = 'IssueTracker::App::IO::In::CnrUrlParams'->new();
   ( $ret , $msg ) = $objCnrUrlParams->doSetListUrlParams(\$objModel, $self->req->query_params );
   return ( $ret , $msg ) unless $ret == 0 ; 

   ( $ret , $msg ) = $objCnrUrlParams->doSetSelectUrlParams(\$objModel, $self->req->query_params );
   return ( $ret , $msg ) unless $ret == 0 ; 

   ( $ret , $msg ) = $objCnrUrlParams->doSetWithUrlParams(\$objModel, $self->req->query_params );
   return ( $ret , $msg , \$objModel) ; 
}


sub doBuildListControl {

   my $self             = shift ; 
   my $msg              = shift ; 
   my $objModel         = ${ shift @_ } ; 
   my $db               = shift ; 
   my $table            = shift ; 
   my $as               = shift ; 

   my $ui_type          = 'page/list-grid' ; 
   my $ret              = 1 ; 
   my $list_control     = '' ; 
   my $objPageBuilder   = {} ; 
   my $objPageFactory   = {} ; 

   my $lables_pages = { 
         'lbls'   => 'list-labels'
      ,  'cloud'  => 'list-cloud' 
      ,  'grid'   => 'list-grid'
      ,  'print-table'  => 'list-print-table'
   };

   $ui_type = 'page/' . $lables_pages->{ $as } ; 

   $objPageFactory                  = 'IssueTracker::Controller::PageFactory'->new(\$appConfig, \$objModel );
   $objPageBuilder                  = $objPageFactory->doInstantiate( $ui_type );
   ( $ret , $msg , $list_control )  = $objPageBuilder->doBuildListControl( $msg , \$objModel , $db , $table , $as ) ;

   return ( $ret , $msg , $list_control ) ; 

}




sub doRenderPageTemplate {
   
   my $self             = shift ; 
   my $as               = shift || 'grid' ; 
   my $msg              = shift ; 
   my $db               = shift ; 
   my $item             = shift ; 
   my $list_control     = shift ; 
   my $notice           = '' ;

   
   my $as_templates = { 
         'lbls'         => 'list-labels'
      ,  'cloud'        => 'list-cloud' 
      ,  'grid'         => 'list-grid' 
      ,  'print-table'  => 'list-print-table' 
   };
  
   my $template_name    = $as_templates->{ $as } || 'list-grid' ; 
   my $template         = 'controls/' . $template_name . '/' . $template_name ; 

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
    , 'ShortCommitHash' => $appConfig->{'ShortCommitHash'}
    , 'page_load_time'  => $page_load_time
    , 'list_control'    => $list_control
    , 'notice'          => $notice
	) ; 

   return ; 
}


1;

__END__

