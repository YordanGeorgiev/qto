package IssueTracker::Controller::Get;
use Mojo::Base 'Mojolicious::Controller';

use IssueTracker::App::Db::In::RdrDbsFactory;
use IssueTracker::App::Utils::Logger;

our $module_trace   = 0 ;
our $appConfig      = {} ;
our $objLogger      = {} ;
our $rdbms_type     = 'postgre';
our $objModel       = {} ; 

#
# --------------------------------------------------------
# get a single row from db by passed guid and render it
# as json 
# --------------------------------------------------------
sub doGetItem {

  my $self        = shift;
  my $item        = $self->stash('item');
  my $db          = $self->stash('db');
  my $guid        = $self->stash('guid');
  my $rdbms_type  = 'postgre';
  my $app_config  = {};
  $app_config     = $self->app->get('AppConfig');
  $objModel       = $self->app->get('ObjModel');
 
  # $objLogger  = $self->app->get('ObjLogger');

  my $ret = 0;
  my $msg = 'unknown error during get item';
  my $hrs = {};


   my $objRdrDbsFactory
    = 'IssueTracker::App::Db::In::RdrDbsFactory'->new(\$appConfig, \$objModel );

   my $objRdrDb = $objRdrDbsFactory->doInstantiate("$rdbms_type");
#  ($ret, $msg) = $objRdrDb->doSelectItemByGuid($db, $item, $guid);

#  $self->res->headers->accept_charset('UTF-8');
#  $self->res->headers->accept_language('fi, en');
#  $self->res->headers->content_type('application/json; charset=utf-8');
 # $self->render(json => $hrs);
 $self->render(json => '{}');

}


1;
