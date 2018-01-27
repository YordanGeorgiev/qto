package IssueTracker::Controller::Get;
use Mojo::Base 'Mojolicious::Controller';

use IssueTracker::App::Db::In::DbReadersFactory;
use IssueTracker::App::Utils::Logger;

our $module_trace   = 0;
our $appConfig      = {};
our $objLogger      = {};
our $objFileHandler = {};
our $rdbms_type     = 'postgre';


#
# --------------------------------------------------------
# get a single row from db by passed guid and render it
# as json 
# --------------------------------------------------------
sub doGetItem {

  my $self       = shift;
  my $item       = $self->stash('item');
  my $db         = $self->stash('db');
  my $guid       = $self->stash('guid');
  my $rdbms_type = 'postgre';
  my $app_config = {};
  $app_config = $self->app->get('AppConfig');
  $objLogger  = $self->app->get('ObjLogger');

  my $ret = 0;
  my $msg = 'unknown error during get item';
  my $hrs = {};


  my $objDbReadersFactory
    = 'IssueTracker::App::Db::In::DbReadersFactory'->new(\$appConfig, $self);
  my $objDbReader = $objDbReadersFactory->doInstantiate("$rdbms_type");
  ($ret, $msg, $hrs) = $objDbReader->doSelectItemByGuid($db, $item, $guid);

  $self->res->headers->accept_charset('UTF-8');
  $self->res->headers->accept_language('fi, en');
  $self->res->headers->content_type('application/json; charset=utf-8');
  $self->render(json => $hrs);

}


1;
