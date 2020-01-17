package Qto::Controller::View ; 
use strict ; use warnings ; 

require Exporter;
our @ISA = qw(Exporter Mojo::Base Qto::Controller::BaseController);
our $AUTOLOAD =();
our $ModuleDebug = 0 ; 
use AutoLoader;

use parent qw(Qto::Controller::BaseController);

use Data::Printer ; 
use Scalar::Util qw /looks_like_number/;

use Qto::Controller::PageFactory ; 
use Qto::App::Utils::Logger;
use Qto::App::Utils::Timer ; 
use Qto::App::Cnvr::CnrDbName qw(toPlainName toEnvName);

our $module_trace    = 0 ; 
our $config          = {};
our $objLogger       = {} ;


sub doViewItems {

   my $self             = shift;
   my $db               = $self->stash('db');
   my $item             = $self->stash('item');

   my $ret              = 1 ; 
   my $msg              = '' ; 
   my $objModel         = {} ; 
   my $view_control     = '' ; 
   my $left_menu        = '' ; 
   my $as               = 'doc' ; 

   $config		         = $self->app->config ; 
   $db                  = toEnvName ( $db , $config) ;
   return unless ( $self->SUPER::isAuthenticated($db) == 1 );
   $self->SUPER::doReloadProjDbMeta( $db,$item ) ;
   $objModel            = 'Qto::App::Mdl::Model'->new ( \$config , $db ) ;
   ($ret,$msg,$left_menu) = $self->SUPER::doBuildLeftMenu(\$objModel, $db );


   my $url_params = $self->req->params->to_hash ; # hash reference
   $self->stash('url_params' => $url_params) ;

   ( $ret , $msg , $view_control ) = $self->doBuildViewPageType ( $msg , \$objModel , $db , $item , $as  ) ; 
   $self->render('text' => 'view page is presented') unless $ret == 0 ; 
   $self->doRenderPageTemplate( $ret , $msg , $as, $db , $item , $view_control , $left_menu) if $ret == 0 ;
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

   $objPageFactory                  = 'Qto::Controller::PageFactory'->new(\$config, \$objModel );
   $objPageBuilder                  = $objPageFactory->doSpawn( $ui_type );
   ( $ret , $msg , $view_control )  = $objPageBuilder->doBuildViewControl( $msg , \$objModel , $db , $item , $as ) ;

   return ( $ret , $msg , $view_control ) ; 

}



sub doRenderPageTemplate {
   
   my $self             = shift ; 
   my $ret              = shift ; 
   my $msg              = shift ; 
   my $as               = shift || 'doc' ; 
   my $db               = shift ; 
   my $item             = shift ; 
   my $list_control     = shift ; 
   my $left_menu        = shift ;
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
  
   my $template_name       = $as_templates->{ $as } || 'view-doc' ; 
   my $template            = 'pages/' . $template_name . '/' . $template_name ; 

   my $objTimer            = 'Qto::App::Utils::Timer'->new( $config->{'env'}->{'log'}->{ 'TimeFormat' } );
   my $page_load_time      = $objTimer->GetHumanReadableTime();
   my @items_arr           = @{$config->{$db . '.tables-list'}};
   my $items_lst           = '';
   foreach my $table ( @items_arr ){
      $items_lst .= "'" . "$table" . "'," ;
   }
   $items_lst = substr($items_lst, 0, -1);

   $self->render(
      'template'        => $template 
    , 'as'              => $as
    , 'msg'             => $msg
    , 'item'            => $item
    , 'db' 		         => $db
    , 'EnvType' 		   => $config->{'env'}->{'run'}->{'ENV_TYPE'}
    , 'ProductVersion' 	=> $config->{'env'}->{'run'}->{'VERSION'}
    , 'GitShortHash' 	=> $config->{'env'}->{'run'}->{'GitShortHash'}
    , 'page_load_time'  => $page_load_time
    , 'list_control'    => $list_control
    , 'notice'          => $notice
    , 'left_menu'       => $left_menu
    , 'items_lst'       => $items_lst
	) ; 

   return ; 
}

1;

__END__

