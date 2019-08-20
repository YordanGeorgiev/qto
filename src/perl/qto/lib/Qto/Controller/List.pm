package Qto::Controller::List ; 
use strict ; use warnings ; 

require Exporter;
our @ISA = qw(Exporter Mojo::Base Qto::Controller::BaseController);
our $AUTOLOAD =();
our $ModuleDebug = 0 ; 
use AutoLoader;

use parent qw(Qto::Controller::BaseController);

use Data::Printer ; 
use Data::Dumper; 
use Scalar::Util qw /looks_like_number/;

use Qto::App::Utils::Logger;
use Qto::Controller::PageFactory ; 
use Qto::App::IO::In::CnrUrlPrms ; 
use Qto::App::Db::In::RdrDbsFcry;
use Qto::App::Cnvr::CnrHsr2ToArray ; 
use Qto::App::UI::WtrUIFactory ; 
use Qto::Controller::ListLabels ;
use Qto::App::Utils::Timer ; 
use Qto::App::Cnvr::CnrDbName qw(toPlainName toEnvName);


our $module_trace   = 0 ; 
our $config      = {};
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
   my $as               = 'grid' ; # the default form of the list control 

  
   $config		 		= $self->app->get('AppConfig');
   $db                  = toEnvName ( $db , $config) ;
   return unless ( $self->SUPER::isAuthenticated($db) == 1 );
   $self->SUPER::doReloadProjDbMeta( $db,$item ) ;
 
   my $list_control     = '' ; 
   my $objModel         = 'Qto::App::Mdl::Model'->new ( \$config , $db , $item) ;
   my $objCnrUrlPrms       = 'Qto::App::IO::In::CnrUrlPrms'->new(\$config , \$objModel , $self->req->query_params);
   $objCnrUrlPrms->doValidateAndSetSelect();

   $as = $self->req->query_params->param('as') || $as ; # decide which type of list page to build
   ( $ret , $msg , $list_control ) = $self->doBuildListPageType ( $msg , \$objModel , $db , $item , $as  ) ; 



   $msg = $self->doSetPageMsg ( $ret , $msg ) ; 
   $self->doRenderPageTemplate( $ret , $msg , $as, $db , $item , $list_control ) ; 
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

   return $msg ; 
}



sub doBuildListPageType {

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
         'lbls'         => 'list-labels'
      ,  'grid'         => 'list-grid'
      ,  'print-table'  => 'list-print-table'
   };

   $ui_type = 'page/' . $lables_pages->{ $as } ; 

   $objPageFactory                  = 'Qto::Controller::PageFactory'->new(\$config, \$objModel );
   $objPageBuilder                  = $objPageFactory->doSpawn( $ui_type );
   ( $ret , $msg , $list_control )  = $objPageBuilder->doBuildListControl( $msg , \$objModel , $db , $table , $as ) ;

   return ( $ret , $msg , $list_control ) ; 

}




sub doRenderPageTemplate {
   
   my $self             = shift ; 
   my $ret              = shift ; 
   my $msg              = shift ; 
   my $as               = shift || 'grid' ; 
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
         'lbls'         => 'list-labels'
      ,  'grid'         => 'list-grid' 
      ,  'print-table'  => 'list-print-table' 
   };
  
   my $template_name    = $as_templates->{ $as } || 'list-grid' ; 
   my $template         = 'controls/' . $template_name . '/' . $template_name ; 

   my $objTimer         = 'Qto::App::Utils::Timer'->new( $config->{ 'TimeFormat' } );
   my $page_load_time   = $objTimer->GetHumanReadableTime();

   $self->render(
      'template'        => $template 
    , 'as'              => $as
    , 'msg'             => $msg
    , 'item'            => $item
    , 'db' 		         => $db
    , 'EnvType' 		=> $config->{'EnvType'}
    , 'ProductVersion' 	=> $config->{'ProductVersion'}
    , 'GitShortHash' => $config->{'GitShortHash'}
    , 'page_load_time'  => $page_load_time
    , 'list_control'    => $list_control
    , 'notice'          => $notice
	) ; 

   return ; 
}


1;

__END__

