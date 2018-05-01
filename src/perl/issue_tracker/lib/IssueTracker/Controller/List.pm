package IssueTracker::Controller::List;
use strict ; use warnings ; 
use Mojo::Base 'Mojolicious::Controller';

use IssueTracker::App::Db::In::RdrDbsFactory;
use IssueTracker::App::Utils::Logger;

our $module_trace   = 0 ;
our $appConfig      = {};
our $objLogger      = {} ;
our $rdbms_type     = 'postgre';
our $objModel       = {} ; 


#
# --------------------------------------------------------
# List all the rows from db by passed db and table name
# --------------------------------------------------------
sub doListItems {

  my $self        = shift;
  my $item        = $self->stash('item');
  my $db          = $self->stash('db');
  my $guid        = $self->stash('guid');
  my $rdbms_type  = 'postgres';

  $appConfig		= $self->app->get('AppConfig');
  $objModel       = ${$self->app->get('ObjModel')} ; 
  $objModel->set('postgres_db_name' , $db ) ; 
 
  # $objLogger  = $self->app->List('ObjLogger');

	my $ret = 0;
	my $msg = 'unknown error during List item';
	my $hsr2 = {};

	my $objRdrDbsFactory
		= 'IssueTracker::App::Db::In::RdrDbsFactory'->new(\$appConfig, \$objModel );

	my $objRdrDb = $objRdrDbsFactory->doInstantiate("$rdbms_type");
	($ret, $msg) = $objRdrDb->doSelectTableIntoHashRef(\$objModel, $item);
	$hsr2 = $objModel->get('hsr2');

	$self->res->headers->accept_charset('UTF-8');
	$self->res->headers->accept_language('fi, en');

	$self->res->headers->content_type('application/json; charset=utf-8');
	$self->render(json => $hsr2);

}


#
# --------------------------------------------------------
# provide the following json response of the tables list in the db
# {
#  "1": {
#    "row_id": "1",
#    "table_catalog": "dev_issue_tracker",
#    "table_name": "confs",
#    "table_schema": "public"
#  }, ...
# }
# --------------------------------------------------------
sub doListTables {

	my $self        = shift;
	my $db          = $self->stash('db');
	my $rdbms_type  = 'postgres';

	$appConfig		= $self->app->get('AppConfig');
	$objModel       = ${$self->app->get('ObjModel')} ; 
	$objModel->set('postgres_db_name' , $db ) ; 

	my $ret = 0;
	my $msg = 'unknown error during List item';
	my $hsr2 = {};

	my $objRdrDbsFactory
			= 'IssueTracker::App::Db::In::RdrDbsFactory'->new(\$appConfig, \$objModel );

	my $objRdrDb = $objRdrDbsFactory->doInstantiate("$rdbms_type");
	($ret, $msg) = $objRdrDb->doSelectTablesList(\$objModel);
	$hsr2 = $objModel->get('hsr2');

	$self->res->headers->accept_charset('UTF-8');
	$self->res->headers->accept_language('fi, en');

	$self->res->headers->content_type('application/json; charset=utf-8');
	$self->render(json => $hsr2);

}


1;

__END__
