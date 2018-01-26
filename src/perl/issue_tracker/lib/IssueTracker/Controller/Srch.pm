use strict ; use warnings ; 
package IssueTracker::Controller::Srch;
use Mojo::Base 'Mojolicious::Controller';

use Data::Printer;

use IssueTracker::App::Db::In::RdrDbsFactory;
use IssueTracker::App::Utils::Logger;

our $module_trace   = 0;
our $appConfig      = {};
our $objLogger      = {};
our $objFileHandler = {};
our $rdbms_type     = 'postgre';


#
# --------------------------------------------------------
# Srch a single row from db by passed guid and render it
# as json 
# --------------------------------------------------------
sub doSrchItem {

  my $self       = shift;
  my $db         = $self->stash('db');
  my $item       = $self->stash('item');
  my $query_str  = $self->stash('srch') || '%' ; 
  my $rdbms_type = 'postgre';
  my $appConfig = {};

  my $ret = 0;
  my $msg = 'unknown error during Srch item';
  my $hrs = {};

  $appConfig = $self->app->get('AppConfig');
  $objLogger  = $self->app->get('ObjLogger');
  # p($appConfig);
  my $objRdrDbsFactory
    = 'IssueTracker::App::Db::In::RdrDbsFactory'->new(\$appConfig, $self);
  my $objRdrDb = $objRdrDbsFactory->doInstantiate("$rdbms_type");
  ($ret, $msg, $hrs) = $objRdrDb->doSearchConfigurationEntries($db, $item , $query_str);

  $self->res->headers->from_hash({
       'Access-Control-Allow-Origin' => '*'
     , 'Access-Control-Allow-Credentials' => 'true'
     , 'Access-Control-Allow-Methods' => 'GET,HEAD,OPTIONS,POST,PUT'
     , 'Access-Control-Allow-Headers' => 'Access-Control-Allow-Headers,Origin,Accept,X-Requested-With,Content-Type,Access-Control-Request-Method,Access-Control-Request-Headers,Access-Control-Allow-Origin'
   });

  $self->res->headers->accept_charset('UTF-8');
  $self->res->headers->allow('GET' , 'POST', 'OPTIONS' );
  $self->res->headers->access_control_allow_origin('*');
  $self->res->headers->accept_language('fi, en');
 # $self->res->headers->content_type('application/json; charset=utf-8');

  $self->render(json => $hrs);

}


1;
