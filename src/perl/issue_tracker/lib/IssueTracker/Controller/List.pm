package IssueTracker::Controller::List ; 
use strict ; use warnings ; 
use Mojo::Base 'Mojolicious::Controller';

use Data::Printer ; 
use Data::Dumper; 
use Scalar::Util qw /looks_like_number/;

use IssueTracker::App::Utils::Logger;
use IssueTracker::Controller::PageFactory ; 
use IssueTracker::App::IO::In::RdrUrlParams ; 
use IssueTracker::App::Db::In::RdrDbsFactory;
use IssueTracker::App::Cnvr::CnrHsr2ToArray ; 
use IssueTracker::App::UI::WtrUIFactory ; 
use IssueTracker::Controller::ListCloud ; 
use IssueTracker::Controller::ListLabels ;

our $module_trace   = 0 ; 
our $appConfig      = {};
our $objLogger      = {} ;
our $rdbms_type     = 'postgre';


#
# --------------------------------------------------------
# Select all the rows from db by passed db and table name
# --------------------------------------------------------
sub doListItems {

   my $self             = shift;
   my $item             = $self->stash('item');
   my $db               = $self->stash('db');
   my $rdbms_type       = 'postgres';
   my $ret              = 1 ; 
   my $msg              = '' ; 
   my $vct_list  			= '' ; 
   my $as               = 'lbls' ; 
   my $ui_type          = 'page/list-lbls' ; 
   my $objPageBuilder   = {} ; 
   my $objPageFactory   = {} ; 
   my $objRdrUrlParams  = {} ; 

	print "List.pm ::: url: " . $self->req->url->to_abs . "\n\n" if $module_trace == 1 ; 
   $appConfig		 		= $self->app->get('AppConfig');
   my $objModel         = 'IssueTracker::App::Mdl::Model'->new ( \$appConfig ) ;

   $objModel->set('postgres_db_name' , $db ) ; 
   $objModel->set('table_name' , $item ) ; 
  
   $objModel->set('list.web-action.fltr-by' , $self->req->query_params->every_param('fltr-by') ) ; 
   $objModel->set('list.web-action.fltr-val' , $self->req->query_params->every_param('fltr-val') ) ; 
   $objModel->set('list.web-action.like-by' , $self->req->query_params->every_param('like-by') ) ; 
   $objModel->set('list.web-action.like-val' , $self->req->query_params->every_param('like-val') ) ; 
   $objModel->set('list.web-action.pick' , $self->req->query_params->param('pick') );
   $objModel->set('list.web-action.hide' , $self->req->query_params->param('hide') );
   $objModel->set('list.web-action.o' , $self->req->query_params->param('o') );

   my $lables_pages = { 
         'lbls'   => 'list-labels'
      ,  'cloud'  => 'list-cloud' 
   };
   $as = $self->req->query_params->param('as') || $as ; 
   $ui_type = 'page/' . $lables_pages->{ $as } ; 
   
   $objRdrUrlParams= 'IssueTracker::App::IO::In::RdrUrlParams'->new();
   $objRdrUrlParams->doSetUrlParams(\$objModel, $self->req->query_params );
   $objRdrUrlParams->doSetWithUrlParams(\$objModel, $self->req->query_params );

   $objPageFactory               = 'IssueTracker::Controller::PageFactory'->new(\$appConfig, \$objModel );
   $objPageBuilder               = $objPageFactory->doInstantiate( $ui_type );
   ( $ret , $msg , $vct_list )   = $objPageBuilder->doBuildListControl( $msg , \$objModel  ) ;

   $msg = '<span id="spn_err_msg">' . $msg . '</span>' unless $ret == 0 ; 
   $msg = '<span id="spn_msg">' . $msg . '</span>' if $ret == 0 ; 
   $self->res->code(400) unless $ret == 0 ; 

   $self->res->headers->accept_charset('UTF-8');
   $self->res->headers->accept_language('fi, en');

   my $as_templates = { 
         'lbls'   => 'list-labels'
      ,  'cloud'  => 'list-cloud' 
   };

   my $template = 'controls/' . $as_templates->{ $as } ; 
   $self->render(
      'template'  => $template 
    , 'msg'       => $msg
    , 'item'      => $item
    , 'db' 		   => $db
    , 'vct_list'  => $vct_list
   ); 

}


1;

__END__

