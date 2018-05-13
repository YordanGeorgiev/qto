package IssueTracker::Controller::Select;
use strict ; use warnings ; 
use Mojo::Base 'Mojolicious::Controller';

use Data::Printer ; 
use Data::Dumper; 
use Scalar::Util qw /looks_like_number/;

use IssueTracker::App::Db::In::RdrDbsFactory;
use IssueTracker::App::Utils::Logger;
use IssueTracker::App::Cnvr::CnrHsr2ToArray ; 

our $module_trace   = 0 ;
our $appConfig      = {};
our $objLogger      = {} ;
our $rdbms_type     = 'postgre';
our $objModel       = {} ; 


#
# --------------------------------------------------------
# Select all the rows from db by passed db and table name
# --------------------------------------------------------
sub doSelectItems {

   my $self        = shift;
   my $item        = $self->stash('item');
   my $db          = $self->stash('db');
   my $rdbms_type  = 'postgres';

   $appConfig		= $self->app->get('AppConfig');
   $objModel       = ${$self->app->get('ObjModel')} ; 
   $objModel->set('postgres_db_name' , $db ) ; 
 
   my $ret = 0;
   my $msg = 'unknown error during Select item';

   $objModel->set('select.web-action.fltr-by' , $self->every_param('fltr-by') ) ; 
   $objModel->set('select.web-action.fltr-val' , $self->every_param('fltr-val') ) ; 
   $objModel->set('select.web-action.like-by' , $self->every_param('like-by') ) ; 
   $objModel->set('select.web-action.like-val' , $self->every_param('like-val') ) ; 
   $objModel->set('select.web-action.pick' , $self->req->query_params->param('pick') );
   $objModel->set('select.web-action.hide' , $self->req->query_params->param('hide') );
   $objModel->set('select.web-action.o' , $self->req->query_params->param('o') );
   
   my $hsr2 = {};
   my $objRdrDbsFactory
      = 'IssueTracker::App::Db::In::RdrDbsFactory'->new(\$appConfig, \$objModel );
   my $objRdrDb = $objRdrDbsFactory->doInstantiate("$rdbms_type");
   ($ret, $msg) = $objRdrDb->doSelectTableIntoHashRef(\$objModel, $item);

   $self->res->headers->accept_charset('UTF-8');
   $self->res->headers->accept_language('fi, en');
   $self->res->headers->content_type('application/json; charset=utf-8');


   if ( $ret == 0 ) {
      my $list = () ; # an array ref holding the converted hash ref of hash refs 
      my $http_code = 200 ; 
      $msg = "SELECT OK for table: $item" ; 
      my $objCnrHsr2ToArray = 
         'IssueTracker::App::Cnvr::CnrHsr2ToArray'->new ( \$appConfig , \$objModel ) ; 
      ( $ret , $msg , $list ) = $objCnrHsr2ToArray->doConvert();

      unless ( $ret == 0 ) {
         $http_code = 400 ; 
         $list = '' ;
      }
      
      $self->res->code($http_code);
      $self->render( 'json' =>  { 
           'msg'   => $msg
         , 'dat'   => $list
         , 'ret'   => $http_code
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
# provide the following json response of the tables Select in the db
# {
#  "1": {
#    "row_id": "1",
#    "table_catalog": "dev_issue_tracker",
#    "table_name": "confs",
#    "table_schema": "public"
#  }, ...
# }
# --------------------------------------------------------
sub doSelectTables {

	my $self        = shift;
	my $db          = $self->stash('db');
	my $rdbms_type  = 'postgres';
   my $msg = 'unknown error during select-tables';

	$appConfig		= $self->app->get('AppConfig');
	$objModel       = ${$self->app->get('ObjModel')} ; 
	$objModel->set('postgres_db_name' , $db ) ; 

	my $ret = 0;
	my $hsr2 = {};

	my $objRdrDbsFactory
			= 'IssueTracker::App::Db::In::RdrDbsFactory'->new(\$appConfig, \$objModel );

	my $objRdrDb = $objRdrDbsFactory->doInstantiate("$rdbms_type");
	($ret, $msg) = $objRdrDb->doSelectTablesList(\$objModel);

	$self->res->headers->accept_charset('UTF-8');
	$self->res->headers->accept_language('fi, en');
	$self->res->headers->content_type('application/json; charset=utf-8');

   if ( $ret == 0 ) {

      my $list = () ; # an array ref holding the converted hash ref of hash refs 
      my $objCnrHsr2ToArray = 
         'IssueTracker::App::Cnvr::CnrHsr2ToArray'->new ( \$appConfig , \$objModel ) ; 
      ( $ret , $msg , $list ) = $objCnrHsr2ToArray->doConvert();

      $self->res->headers->content_type('application/json; charset=utf-8');
      $self->res->code(200);
      $self->render( 'json' =>  { 
           'msg'   => $msg
         , 'dat'   => $list
         , 'ret'   => 200
         , 'req'   => "GET " . $self->req->url->to_abs
      });

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

# feature-guid: ecd424d7-e5bd-45f1-90c8-10fae1316bf9
