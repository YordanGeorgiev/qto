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
 
   my $ret = 0;
   my $msg = 'unknown error during List item';
  

   my $hsr2 = {};

   my $objRdrDbsFactory
      = 'IssueTracker::App::Db::In::RdrDbsFactory'->new(\$appConfig, \$objModel );

   my $objRdrDb = $objRdrDbsFactory->doInstantiate("$rdbms_type");
   ($ret, $msg) = $objRdrDb->doSelectTableIntoHashRef(\$objModel, $item);

   $self->res->headers->accept_charset('UTF-8');
   $self->res->headers->accept_language('fi, en');

   if ( $ret == 0 ) {
      $hsr2 = $objModel->get('hsr2');
      $self->res->headers->content_type('application/json; charset=utf-8');
      $self->res->code(200);
      $self->render( 'json' =>  { 
           'msg'   => $msg
         , 'dat'   => $hsr2
         , 'ret'   => 200
         , 'req'   => "GET " . $self->req->url->to_abs
      });
   } elsif ( $ret == 400 ) {

      $self->res->code(400);
      $self->render( 'json' =>  { 
         'msg'   => $msg,
         'ret'   => 400, 
         'req'   => "GET " . $self->req->url->to_abs
      });
   } elsif ( $ret == 2 ) {

      $self->res->code(400);
      $self->render( 'json' =>  { 
         'msg'   => $msg,
         'ret'   => 400, 
         'req'   => "GET " . $self->req->url->to_abs
      });
   } else {

      $msg = 'unknown error has occurred' ; 
      $self->res->code(400);
      $self->render( 'json' => { 
         'msg'   => $msg,
         'ret' => 404, 
         'req'   => "GET " . $self->req->url->to_abs
      })
      ;
   }
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
   my $msg = 'unknown error during list-tables';

	$appConfig		= $self->app->get('AppConfig');
	$objModel       = ${$self->app->get('ObjModel')} ; 
	$objModel->set('postgres_db_name' , $db ) ; 

	my $ret = 0;
	my $hsr2 = {};

	my $objRdrDbsFactory
			= 'IssueTracker::App::Db::In::RdrDbsFactory'->new(\$appConfig, \$objModel );

	my $objRdrDb = $objRdrDbsFactory->doInstantiate("$rdbms_type");
	($ret, $msg) = $objRdrDb->doSelectTablesList(\$objModel);
	$hsr2 = $objModel->get('hsr2');

	$self->res->headers->accept_charset('UTF-8');
	$self->res->headers->accept_language('fi, en');

	$self->res->headers->content_type('application/json; charset=utf-8');

   if ( $ret == 0 ) {
      $hsr2 = $objModel->get('hsr2');
      $self->res->headers->content_type('application/json; charset=utf-8');
      $self->res->code(200);
      $self->render( 'json' =>  { 
         'msg'   => $msg,
         'dat'   => $hsr2 ,
         'ret'   => 200 , 
         'req'   => "GET " . $self->req->url->to_abs
      })
      ;
   } elsif ( $ret == 400 ) {

      $self->res->code(404);
      $self->render( 'json' =>  { 
         'msg'   => $msg,
         'ret'   => 404, 
         'req'   => "GET " . $self->req->url->to_abs
      })
      ;
   } elsif ( $ret == 2 ) {

      $self->res->code(400);
      $self->render( 'json' =>  { 
         'msg'   => $msg,
         'ret'   => 400, 
         'req'   => "GET " . $self->req->url->to_abs
      });
   } else {

      $self->res->code(404);
      $msg = 'unknown error has occurred' ; 
      $self->render( 'json' => { 
         'msg'   => $msg,
         'ret'   => 404, 
      })
      ;
   }

}


1;

__END__
