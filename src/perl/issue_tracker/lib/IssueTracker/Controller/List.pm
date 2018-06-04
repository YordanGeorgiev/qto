package IssueTracker::Controller::List ; 
use strict ; use warnings ; 
use Mojo::Base 'Mojolicious::Controller';

use Data::Printer ; 
use Data::Dumper; 
use Scalar::Util qw /looks_like_number/;

use IssueTracker::App::Db::In::RdrDbsFactory;
use IssueTracker::App::Utils::Logger;
use IssueTracker::App::Cnvr::CnrHsr2ToArray ; 
use IssueTracker::App::UI::WtrUIFactory ; 
use IssueTracker::App::IO::In::RdrUrlParams ; 

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

   $as = $self->req->query_params->param('as') || $as ; 
   if ( $as eq 'lbls' ) {
      ( $ret , $msg , $vct_list )  = $self->doBuildVueControlListLabels( $msg , \$objModel  ) ; 
   } elsif ( $as eq 'cloud' ) {
      ( $ret , $msg , $vct_list )  = $self->doBuildVueControlListCloud( $msg , \$objModel  ) ; 
   } else {
      ( $ret , $msg , $vct_list )  = $self->doBuildVueControlListLabels( $msg , \$objModel  ) ; 
   }

   $msg = '<span id="spn_err_msg">' . $msg . '</span>' unless $ret == 0 ; 
   $msg = '<span id="spn_msg">' . $msg . '</span>' if $ret == 0 ; 
   $self->res->code(400) unless $ret == 0 ; 

   $self->res->headers->accept_charset('UTF-8');
   $self->res->headers->accept_language('fi, en');

   if ( $as eq 'lbls' ) {
      $self->render(
         template          => 'controls/list'
       , msg               => $msg
       , item              => $item
       , db 					=> $db
       , vct_list   			=> $vct_list
      ); 
   } elsif ( $as eq 'cloud' ) {
      $self->render(
         template          => 'controls/cloud'
       , msg               => $msg
       , item              => $item
       , db 					=> $db
       , vct_list   			=> $vct_list
      ); 
   } else {
      $self->render(
         template          => 'controls/list'
       , msg               => $msg
       , item              => $item
       , db 					=> $db
       , vct_list   			=> $vct_list
      ); 
   } 

}

sub doBuildVueControlListCloud {

	my $self          		= shift ; 
	my $msg           		= shift ; 
   my $objModel      		= ${ shift @_ } ; 

   my $ret           		= 1 ; 
   my $control       		= '' ; 
   my $mhsr2 					= {} ;
   my $hsr2 					= {} ;
   my $objRdrDb 				= {} ; 
   my $objRdrDbsFactory 	= {} ; 
   my $table 					= {} ; 
	my $objCnrHsr2ToArray	= {} ; 
   my $objWtrUIFactory		= {} ; 
   my $objUIBuilder 			= {} ; 
  
	$objRdrDbsFactory = 'IssueTracker::App::Db::In::RdrDbsFactory'->new(\$appConfig, \$objModel ) ;
   $objRdrDb = $objRdrDbsFactory->doInstantiate("$rdbms_type");
   $table = $objModel->get('table_name'); 

   my $objRdrUrlParams= 'IssueTracker::App::IO::In::RdrUrlParams'->new();
   $objRdrUrlParams->doSetUrlParams(\$objModel, $self->req->query_params );
   $objRdrUrlParams->doSetWithUrlParams(\$objModel, $self->req->query_params );

   $objRdrDbsFactory = 'IssueTracker::App::Db::In::RdrDbsFactory'->new(\$appConfig, \$objModel );
   $objRdrDb = $objRdrDbsFactory->doInstantiate("$rdbms_type");
   ($ret, $msg) = $objRdrDb->doSelectTableIntoHashRef(\$objModel, $table);

	$objCnrHsr2ToArray = 'IssueTracker::App::Cnvr::CnrHsr2ToArray'->new ( \$appConfig , \$objModel ) ;
	( $ret , $msg , $hsr2) = $objCnrHsr2ToArray->doConvert ($objModel->get('hsr2'));

   $objWtrUIFactory = 'IssueTracker::App::UI::WtrUIFactory'->new(\$appConfig, \$objModel );
   $objUIBuilder = $objWtrUIFactory->doInstantiate('control/list-cloud');

   ( $ret , $msg , $control ) = $objUIBuilder->doBuild() ; 
   return ( $ret , $msg , $control ) ; 
}

sub doBuildVueControlListLabels {

	my $self          	= shift ; 
	my $msg           	= shift ; 
   my $objModel      	= ${ shift @_ } ; 
   my $ret           	= 1 ; 
   my $control       	= '' ; 
   my $mhsr2 				= {};
   my $objRdrDbsFactory = {} ; 
   my $objRdrDb 			= {} ; 
   my $table 				= {} ; 
   my $objWtrUIFactory 	= {} ; 
   my $objUIBuilder 		= {} ; 

   $objRdrDbsFactory = 'IssueTracker::App::Db::In::RdrDbsFactory'->new(\$appConfig, \$objModel ) ;
   $objRdrDb = $objRdrDbsFactory->doInstantiate("$rdbms_type");
   $table = $objModel->get('table_name'); 

   ( $ret , $msg , $mhsr2 ) = $objRdrDb->doSelectTablesColumnList ( $table ) ;
   return ( $ret , $msg , '' ) unless $ret == 0 ; 
	
   $objWtrUIFactory = 'IssueTracker::App::UI::WtrUIFactory'->new(\$appConfig, \$objModel );
   $objUIBuilder = $objWtrUIFactory->doInstantiate('control/list-labels');

   ( $ret , $msg , $control ) = $objUIBuilder->doBuild() ; 
   
   return ( $ret , $msg , $control ) ; 
}


1;

__END__

