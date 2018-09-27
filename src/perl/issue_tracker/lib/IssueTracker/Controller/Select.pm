package IssueTracker::Controller::Select;
use strict ; use warnings ; 
use Mojo::Base 'Mojolicious::Controller';

use Data::Printer ; 
use Data::Dumper; 
use Scalar::Util qw /looks_like_number/;

use IssueTracker::App::Db::In::RdrDbsFactory;
use IssueTracker::App::Utils::Logger;
use IssueTracker::App::Cnvr::CnrHsr2ToArray ; 
use IssueTracker::App::IO::In::RdrUrlParams ; 

my $module_trace    = 0 ;
our $appConfig      = {};
our $objLogger      = {} ;
our $rdbms_type     = 'postgre';

#
# --------------------------------------------------------
# Select all the rows from db by passed db and table name
# --------------------------------------------------------
sub doSelectItems {
   my $self             = shift;
   my $item             = $self->stash('item');
   my $db               = $self->stash('db');
   my $rdbms_type       = 'postgres';
   my $objRdrUrlParams  = {} ; 
   my $objRdrDbsFactory = {} ; 
   my $objRdrDb         = {} ; 
   my $ret              = 0;
   my $msg              = 'unknown error during Select item';
   my $hsr2             = {};
   my $http_code        = 200 ; 
   my $rows_count       = 0 ; 

	print "Select.pm ::: url: " . $self->req->url->to_abs . "\n\n" if $module_trace == 1 ; 

   $appConfig		= $self->app->get('AppConfig');
   my $objModel         = 'IssueTracker::App::Mdl::Model'->new ( \$appConfig ) ;
   $objModel->set('postgres_db_name' , $db ) ; 

   my $query_params = $self->req->query_params ; 
   $objRdrUrlParams = 'IssueTracker::App::IO::In::RdrUrlParams'->new();
   ( $ret , $msg ) = $objRdrUrlParams->doSetSelectUrlParams(\$objModel, $query_params );
   if ( $ret != 0 ) {
      $self->res->code(400);
      $self->render( 'json' =>  { 
         'msg'   => $msg,
         'ret'   => 400, 
         'met'   => 0,
         'req'   => "GET " . $self->req->url->to_abs
      });
      return ; 
   } 

   ( $ret , $msg ) = $objRdrUrlParams->doSetWithUrlParams(\$objModel, $query_params );
   if ( $ret != 0 ) {
      $self->res->code(400);
      $self->render( 'json' =>  { 
         'msg'   => $msg,
         'ret'   => 400, 
         'met'   => 0,
         'req'   => "GET " . $self->req->url->to_abs
      });
      return ; 
   } 

   $objRdrDbsFactory
      = 'IssueTracker::App::Db::In::RdrDbsFactory'->new(\$appConfig, \$objModel );
   $objRdrDb = $objRdrDbsFactory->doInstantiate("$rdbms_type");
   ($ret, $msg) = $objRdrDb->doSelectTableIntoHashRef(\$objModel, $item);

   $self->res->headers->accept_charset('UTF-8');
   $self->res->headers->accept_language('fi, en');
   $self->res->headers->content_type('application/json; charset=utf-8');

   unless ( $ret == 0 ) {
      $http_code = $ret ; 
   }

   if ( $ret == 0 ) {
      my $list = () ; # an array ref holding the converted hash ref of hash refs 
      $rows_count = 0 ; 
      $http_code = 200 ; 
      $msg = "SELECT OK for table: $item" ; 
      my $objCnrHsr2ToArray = 
         'IssueTracker::App::Cnvr::CnrHsr2ToArray'->new ( \$appConfig , \$objModel ) ; 
      ( $ret , $msg , $list , $rows_count ) = $objCnrHsr2ToArray->doConvert ($objModel->get('hsr2'));

      unless ( $ret == 0 ) {
         $list = '' ;
         $http_code = $ret ; 
      }
       
      $self->res->code($http_code);
      $self->render( 'json' =>  { 
           'msg'   => $msg
         , 'dat'   => $list
         , 'ret'   => $http_code
         , 'met'   => $rows_count 
         , 'req'   => "GET " . $self->req->url->to_abs
      });
   } else {
      $rows_count = 0 ; 
      $self->res->code($http_code);
      $self->render( 'json' =>  { 
           'msg'   => $msg
         , 'ret'   => 400
         , 'met'   => $rows_count
         , 'req'   => "GET " . $self->req->url->to_abs
      });
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

	my $self       = shift;
	my $db         = $self->stash('db');
	my $rdbms_type = 'postgres';
   my $msg = 'unknown error during select-tables';

	$appConfig	   = $self->app->get('AppConfig');
   my $objModel   = 'IssueTracker::App::Mdl::Model'->new ( \$appConfig ) ;

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

   my $list = () ; # an array ref holding the converted hash ref of hash refs 

   if ( $ret == 0 ) {

      $objModel->set('select.web-action.o', 'row_id' );
      my $objCnrHsr2ToArray = 
         'IssueTracker::App::Cnvr::CnrHsr2ToArray'->new ( \$appConfig , \$objModel ) ; 
      ( $ret , $msg , $list ) = $objCnrHsr2ToArray->doConvert($objModel->get('hsr2') , '>' );
   }

      $self->res->headers->content_type('application/json; charset=utf-8');
   if ( $ret == 0 ) {
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

sub doSelectDatabases {

	my $self       = shift;
	my $db         = $self->stash('db');
	my $rdbms_type = 'postgres';
   my $msg = 'unknown error during select-databases';
   my $http_code  = 200 ; 

	$appConfig	   = $self->app->get('AppConfig');
   my $objModel   = 'IssueTracker::App::Mdl::Model'->new ( \$appConfig ) ;

	$objModel->set('postgres_db_name' , 'postgres' ) ; 

	my $ret = 0;
	my $hsr2 = {};

	my $objRdrDbsFactory
			= 'IssueTracker::App::Db::In::RdrDbsFactory'->new(\$appConfig, \$objModel );

	my $objRdrDb = $objRdrDbsFactory->doInstantiate("$rdbms_type");
	($ret, $msg) = $objRdrDb->doSelectDatabasesList(\$objModel);

	$self->res->headers->accept_charset('UTF-8');
	$self->res->headers->accept_language('fi, en');
	$self->res->headers->content_type('application/json; charset=utf-8');

   if ( $ret == 0 ) {

      my $list = () ; # an array ref holding the converted hash ref of hash refs 
      $objModel->set('select.web-action.o', 'row_id' );
      my $objCnrHsr2ToArray = 
         'IssueTracker::App::Cnvr::CnrHsr2ToArray'->new ( \$appConfig , \$objModel ) ; 
      ( $ret , $msg , $list ) = $objCnrHsr2ToArray->doConvert($objModel->get('hsr2'),'>');

      $self->res->headers->content_type('application/json; charset=utf-8');
      $self->res->code(200);
      $self->render( 'json' =>  { 
           'msg'   => $msg
         , 'dat'   => $list
         , 'ret'   => 200
         , 'req'   => "GET " . $self->req->url->to_abs
      });

   } elsif ( $ret == 400 or $ret == 404) {
      $http_code = $ret ; 
      $self->res->code($http_code);
      $self->render( 'json' =>  { 
         'msg'   => $msg,
         'ret'   => $http_code , 
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

#
# --------------------------------------------------------
# Select all the rows from db by passed db and table name
# --------------------------------------------------------
sub doSelectMeta {

   my $self        = shift;
   my $item        = $self->stash('item');
   my $db          = $self->stash('db');
   my $rdbms_type  = 'postgres';

	print "Select.pm ::: url: " . $self->req->url->to_abs . "\n\n" if $module_trace == 1 ; 

   $appConfig		= $self->app->get('AppConfig');
   my $objModel         = 'IssueTracker::App::Mdl::Model'->new ( \$appConfig ) ;
   $objModel->set('postgres_db_name' , $db ) ; 
 
   my $ret = 0;
   my $msg = 'unknown error during Select item';
   my $rows_count = 0;

   my $objRdrDbsFactory
      = 'IssueTracker::App::Db::In::RdrDbsFactory'->new(\$appConfig, \$objModel );
   my $objRdrDb = $objRdrDbsFactory->doInstantiate("$rdbms_type");
   ($ret, $msg) = $objRdrDb->doSelectTablesColumnList($item);
   
   # todo:ysg 
   print "ret: $ret , msg: $msg \n" ; 
   print "Select.pm" ; 


   $self->res->headers->accept_charset('UTF-8');
   $self->res->headers->accept_language('fi, en');
   $self->res->headers->content_type('application/json; charset=utf-8');


   if ( $ret == 0 ) {
      my $list = () ; # an array ref holding the converted hash ref of hash refs 
      my $http_code = 200 ; 
      $msg = "SELECT meta OK for table: $item" ; 
      my $objCnrHsr2ToArray = 
         'IssueTracker::App::Cnvr::CnrHsr2ToArray'->new ( \$appConfig , \$objModel ) ; 
      ( $ret , $msg , $list , $rows_count ) = $objCnrHsr2ToArray->doConvert($objModel->get('hs_headers'));

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
         , 'met'   => $rows_count
      });
   } elsif ( $ret == 400 or $ret == 404 ) {

      $self->res->code($ret);
      $self->render( 'json' =>  { 
         'msg'   => $msg,
         'ret'   => $ret , 
         'req'   => "GET " . $self->req->url->to_abs
      });
   } elsif ( $ret == 2 ) {

      $self->res->code(400);
      $self->render( 'json' =>  { 
         'msg'   => $msg,
         'ret'   => 400, 
         'req'   => "GET " . $self->req->url->to_abs
      });
   } elsif ( $ret == 1 ) {
      $msg = " the table $item does not exist " ; 
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
1;

__END__

# feature-guid: ecd424d7-e5bd-45f1-90c8-10fae1316bf9
