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

our $module_trace   = 0 ;
our $appConfig      = {};
our $objLogger      = {} ;
our $rdbms_type     = 'postgre';
our $objModel       = {} ; 


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
   my $msg              = 'unknown error while listing items !!!' ; 
   my $vct_list_labels  = '' ; 

   $appConfig		 = $self->app->get('AppConfig');
   $objModel       = ${$self->app->get('ObjModel')} ; 

   $objModel->set('postgres_db_name' , $db ) ; 
   $objModel->set('table_name' , $item ) ; 
  
	# build the list control 
   ( $ret , $msg , $vct_list_labels )  = $self->doBuildVueControlListLabels( $msg , \$objModel  ) ; 
   $vct_list_labels = '<div><p>' . $msg . '</p></div>' unless $ret == 0 ; 

   $self->res->headers->accept_charset('UTF-8');
   $self->res->headers->accept_language('fi, en');

   # and render the result
   $self->render(
      template             => 'pages/list'
    , item                 => $item
    , db 						=> $db
    , vct_list_labels      => $vct_list_labels
   ); 
}

sub doBuildVueControlListLabels {

	my $self          = shift ; 
	my $msg           = shift ; 
   my $objModel      = ${ shift @_ } ; 
   my $ret           = 1 ; 
   my $control       = '' ; 

	# get the list of the table columns 
   my $mhsr2 = {};
   my $objRdrDbsFactory
      = 'IssueTracker::App::Db::In::RdrDbsFactory'->new(\$appConfig, \$objModel ) ;
   my $objRdrDb = $objRdrDbsFactory->doInstantiate("$rdbms_type");
   my $table = $objModel->get('table_name'); 

   ( $ret , $msg , $mhsr2 ) = $objRdrDb->doSelectTablesColumnList ( $table ) ;
   return ( $ret , $msg , undef ) unless $ret == 0 ; 
	
   my $objWtrUIFactory
      = 'IssueTracker::App::UI::WtrUIFactory'->new(\$appConfig, \$objModel );
   my $objUIBuilder = $objWtrUIFactory->doInstantiate('control/list-labels');
   # build the list-labels control with it 
   ( $ret , $msg , $control ) = $objUIBuilder->doBuild() ; 
   
   return ( $ret , $msg , $control ) ; 
}




1;

__END__

