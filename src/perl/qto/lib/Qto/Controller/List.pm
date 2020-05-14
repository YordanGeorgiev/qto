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
use Gravatar::URL qw(gravatar_url);

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
our $config      	  = {};
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
my $list_control     = 'null' ; 
$config		         = $self->app->config ; 
$db                  = toEnvName ( $db , $config) ;

my $objModel         = 'Qto::App::Mdl::Model'->new ( \$config , $db , $item ) ; 
$self->SUPER::doReloadProjDbMeta( \$objModel , $db , $item) ;

my $objCnrUrlPrms    = 'Qto::App::IO::In::CnrUrlPrms'->new(\$config , \$objModel , $self->req->query_params);
$objCnrUrlPrms->doValidateAndSetSelect();

$as = $self->req->query_params->param('as') || $as ; # decide which type of list page to build
my @allowed_as = ('grid','lbls','print-table');
$as = 'grid' unless ( grep ( /^$as$/, @allowed_as)) ;
( $ret , $msg , $list_control ) = $self->doBuildListPageType ( $msg , \$objModel , $db , $item , $as  ) ; 

$msg = $self->doSetPageMsg ( $ret , $msg ) ; 
$self->doRenderPageTemplate( $ret , $msg , \$objModel, $as, $db , $item , $list_control) ; 
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
my $as               = shift ;  # grid, # print-table , lbls

my $ui_type          = 'page/list-grid' ; 
my $ret              = 1 ; 
my $list_control     = 'null' ; 
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
my $objModel         = ${ shift @_ } ; 
   my $as               = shift || 'grid' ; 
   my $db               = shift ; 
   my $item             = shift ; 
   my $list_control     = shift ; 
   my $notice           = '' ;
   my $config		      = $self->app->config ; 
   my $pdb              = toPlainName($db);
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

   my $objTimer         = 'Qto::App::Utils::Timer'->new( $config->{'env'}->{'log'}->{ 'TimeFormat' } );
   my $page_load_time   = $objTimer->GetHumanReadableTime();

   my $tables_list      = $objModel->get("$db" . '.tables-list');
   my @items_arr        = @$tables_list;
   my $items_lst        = '';
   foreach my $table ( @items_arr ){
      $items_lst .= "'" . "$table" . "'," ;
   }
   $items_lst = substr($items_lst, 0, -1);

   my $logged_in_usr_email = $self->session( 'app.' . $db . '.user') || '' ; 
   my $gravatar_url = gravatar_url('email' => $logged_in_usr_email , ('https',1)) || '';

   my $web_host = $config->{'env'}->{'app'}->{'web_host'};
   my $https_port = $config->{'env'}->{'app'}->{'https_port'};
   my $url_path = $self->url_for->path;
   my $url_to_share = 'https://' .  $web_host . ':' . $https_port . $url_path ;

   $self->render(
      'template'        => $template 
    , 'as'              => $as
    , 'msg'             => $msg
    , 'item'            => $item
    , 'db' 		         => $db
    , 'pdb' 		      => $pdb
    , 'EnvType' 		   => $config->{'env'}->{'run'}->{'ENV_TYPE'}
    , 'ProductVersion' 	=> $config->{'env'}->{'run'}->{'VERSION'}
    , 'GitShortHash' 	=> $config->{'env'}->{'run'}->{'GitShortHash'}
    , 'page_load_time'  => $page_load_time
    , 'list_control'    => $list_control
    , 'notice'          => $notice
    , 'items_lst'       => $items_lst
    , 'gravatar_url'    => $gravatar_url
    , 'url_to_share'    => $url_to_share
	) ; 

   return ; 
}


1;

__END__

