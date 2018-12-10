package IssueTracker::Controller::Select;
use strict ; use warnings ; 

require Exporter; our @ISA = qw(Exporter Mojo::Base IssueTracker::Controller::BaseController);
our $AUTOLOAD =();
use AutoLoader;
use parent qw(IssueTracker::Controller::BaseController);

use Data::Printer ; 
use Data::Dumper; 

use IssueTracker::App::Db::In::RdrDbsFactory;
use IssueTracker::App::Utils::Logger;
use IssueTracker::App::Cnvr::CnrHsr2ToArray ; 
use IssueTracker::App::IO::In::CnrUrlParams ; 

my $module_trace    = 0 ;
our $appConfig      = {};
our $objLogger      = {} ;
our $rdbms_type     = 'postgre';

#
# --------------------------------------------------------
# Select all the rows from db by passed db and table name
# src: https://en.wikipedia.org/wiki/List_of_HTTP_status_codes
# --------------------------------------------------------
sub doSelectItems {
   my $self             = shift;
   my $db               = $self->stash('db');
   my $item             = $self->stash('item');
   my $http_method      = 'GET' ;  
   my $rdbms_type       = 'postgres';
   my $objCnrUrlParams  = {} ; 
   my $objRdrDbsFactory = {} ; 
   my $objRdrDb         = {} ; 
   my $ret              = 0;
   my $dat              = '' ; 
   my $msg              = 'unknown error during Select item';
   my $hsr2             = {};
   my $msr2             = {};
   my $met              = {}; # the meta-data of the this item
   my $mc               = {}; # the meta-counter of the meta-data
   my $http_code        = 200 ; 
   my $cnt       = 0 ; 

   unless ( $self->SUPER::isAuthorized($db) == 1 ) {
      $self->render('text' => 'Refresh your page to login ');
      return ; 
   } 
   
   $appConfig		 		= $self->app->get('AppConfig');
   unless ( exists ( $appConfig->{ $db . '.meta' } )  ) {
      
      ( $ret , $msg , $msr2 ) = $self->SUPER::doReloadProjectDbMetaData( $db ) ; 
      unless ( $ret == 0 ) { 
         $self->render('text' => $msg ) unless $ret == 0 ; 
         return ; 
      }
      else { 
         $appConfig->{ $db . '.meta' } = $msr2 ; 
      }
   } 

	# debug print "Select.pm ::: url: " . $self->req->url->to_abs . "\n\n" if $module_trace == 1 ; 
   my $objModel         = 'IssueTracker::App::Mdl::Model'->new ( \$appConfig ) ;
   $objModel->set('postgres_db_name' , $db ) ; 

   my $query_params = $self->req->query_params ; 
   $objCnrUrlParams = 'IssueTracker::App::IO::In::CnrUrlParams'->new();
   ( $ret , $msg ) = $objCnrUrlParams->doSetSelectUrlParams(\$objModel, $query_params );
   if ( $ret != 0 ) {
      $http_code = 400 ; 
      $self->SUPER::doRenderJson($http_code,$msg,$http_method,$met,$cnt,$dat);
      return ; 
   } 

   ( $ret , $msg ) = $objCnrUrlParams->doSetWithUrlParams(\$objModel, $query_params );
   if ( $ret != 0 ) {
      $http_code = 400 ; 
      $self->SUPER::doRenderJson($http_code,$msg,$http_method,$met,$cnt,$dat);
      return ; 
   } 

   $objRdrDbsFactory
      = 'IssueTracker::App::Db::In::RdrDbsFactory'->new(\$appConfig, \$objModel );
   $objRdrDb = $objRdrDbsFactory->doInstantiate("$rdbms_type");

   ($ret, $msg,$hsr2) = $objRdrDb->doSelectTableIntoHashRef(\$objModel, $item);

   
   # debug print "Select.pm \n" ; 
   # debug print "ret: $ret , msg: $msg \n" ; 
   # debug print "Select.pm \n" ; 

   unless ( $ret == 0 ) {
      $http_code = $ret ; 
   }

   if ( $ret == 0 ) {
      $cnt = 0 ; 
      $http_code = 200 ; 
      $msg = "SELECT OK for table: $item" ; 
      my $objCnrHsr2ToArray = 
         'IssueTracker::App::Cnvr::CnrHsr2ToArray'->new ( \$appConfig , \$objModel ) ; 
      ( $ret , $msg , $dat , $cnt ) = $objCnrHsr2ToArray->doConvert ($hsr2);

      unless ( $ret == 0 ) {
         $http_code = 404 ; 
         ( $ret , $msg , $met , $mc) = $objModel->doGetTableMeta($appConfig,$db,$item);
      }
      
      ( $ret , $msg , $met , $mc) = $objModel->doGetTableMeta($appConfig,$db,$item);
      $http_code = 200 ; 
      $self->SUPER::doRenderJson($http_code,$msg,$http_method,$met,$cnt,$dat);
   } elsif ( $ret == 404 ) {
      $http_code = 404 ; 
      $self->SUPER::doRenderJson($http_code,$msg,$http_method,$met,$cnt,$dat);
   } elsif ( $ret == 204 ) {
      $http_code = 204 ; 
      $self->SUPER::doRenderJson($http_code,$msg,$http_method,$met,$cnt,$dat);
   } else {
      $http_code = 400 ; 
      $self->SUPER::doRenderJson($http_code,$msg,$http_method,$met,$cnt,$dat);
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

   my $dat = () ; # an array ref holding the converted hash ref of hash refs 

   if ( $ret == 0 ) {

      $objModel->set('select.web-action.o', 'row_id' );
      my $objCnrHsr2ToArray = 
         'IssueTracker::App::Cnvr::CnrHsr2ToArray'->new ( \$appConfig , \$objModel ) ; 
      ( $ret , $msg , $dat ) = $objCnrHsr2ToArray->doConvert($objModel->get('hsr2') , '>' );
   }

      $self->res->headers->content_type('application/json; charset=utf-8');
   if ( $ret == 0 ) {
      $self->res->code(200);
      $self->render( 'json' =>  { 
           'msg'   => $msg
         , 'dat'   => $dat
         , 'ret'   => 200
         , 'req'   => "GET " . $self->req->url->to_abs
      });
   } elsif ( $ret == 404 ) {

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

	my $self          = shift;
	my $db            = $self->stash('db');
	my $rdbms_type    = 'postgres';
   my $msg           = 'unknown error during select-databases';
   my $http_code     = 200 ; 
   my $http_method   = 'GET' ; 
   my $met           = '' ; 
   my $dat           = '' ; 
   my $cnt           = 0 ; 

	$appConfig	   = $self->app->get('AppConfig');
   my $objModel   = 'IssueTracker::App::Mdl::Model'->new ( \$appConfig ) ;

	$objModel->set('postgres_db_name' , 'postgres' ) ; 

	my $ret = 0;
	my $hsr2 = {};

	my $objRdrDbsFactory
			= 'IssueTracker::App::Db::In::RdrDbsFactory'->new(\$appConfig, \$objModel );

	my $objRdrDb = $objRdrDbsFactory->doInstantiate("$rdbms_type");
	($ret, $msg) = $objRdrDb->doSelectDatabasesList(\$objModel);

   if ( $ret == 0 ) {

      my $dat = () ; # an array ref holding the converted hash ref of hash refs 
      $objModel->set('select.web-action.o', 'row_id' );
      my $objCnrHsr2ToArray = 
         'IssueTracker::App::Cnvr::CnrHsr2ToArray'->new ( \$appConfig , \$objModel ) ; 
      ( $ret , $msg , $dat ) = $objCnrHsr2ToArray->doConvert($objModel->get('hsr2'),'>');
      $self->SUPER::doRenderJson($http_code,$msg,$http_method,$met,$cnt,$dat);
   } elsif ( $ret == 400 or $ret == 404) {
      $http_code = $ret ; 
      $self->SUPER::doRenderJson($http_code,$msg,$http_method,$met,$cnt,$dat);
   } elsif ( $ret == 2 ) {
      $http_code = 400 ; 
      $self->SUPER::doRenderJson($http_code,$msg,$http_method,$met,$cnt,$dat);
   } else {
      $http_code = 404 ; 
      $self->SUPER::doRenderJson($http_code,$msg,$http_method,$met,$cnt,$dat);
   }

}

#
# --------------------------------------------------------
# Select all the rows from db by passed db and table name
# --------------------------------------------------------
sub doSelectMeta {

   my $self        = shift;
   my $db          = $self->stash('db');
   my $table       = $self->stash('item') || undef ; 
   my $ret         = 0;
   my $msg         = 'unknown error during Select item';
   my $met         = '' ; 
   my $rdbms_type  = 'postgres';
   my $http_method = 'GET';
   my $http_code   = '400';
   my $dat         = '' ; 
   my $cnt         = 0;

	# print "Select.pm ::: url: " . $self->req->url->to_abs . "\n\n" if $module_trace == 1 ; 

   $appConfig		= $self->app->get('AppConfig');
   my $objModel         = 'IssueTracker::App::Mdl::Model'->new ( \$appConfig ) ;
   
   unless ( $self->SUPER::isAuthorized($db) == 1 ) {
      $self->render('text' => 'Refresh your page to login ');
      return ; 
   } 
   
   # chk: it-181101180808
   $appConfig		 		= $self->app->get('AppConfig');
   unless ( exists ( $appConfig->{ $db . '.meta' } )  ) {
      
      ( $ret , $msg , $met ) = $self->SUPER::doReloadProjectDbMetaData( $db ) ; 
      unless ( $ret == 0 ) { 
         $self->render('text' => $msg ) unless $ret == 0 ; 
         return ; 
      }
      else { 
         $appConfig->{ $db . '.meta' } = $met ; 
      }
   } 
   
   # debug p $appConfig->{ $db . '.meta' } ; 
   if ( defined $table ) {
      ( $ret , $msg , $met , $cnt ) = $objModel->doGetTableMeta ( $appConfig , $db , $table ) 
   }

   if ( $ret == 0 ) {
      my $dat = () ; # an array ref holding the converted hash ref of hash refs 
      my $http_code = 200 ; 
      $msg = "SELECT meta OK for table: $table " ; 
      my $objCnrHsr2ToArray = 
         'IssueTracker::App::Cnvr::CnrHsr2ToArray'->new ( \$appConfig , \$objModel ) ; 
      ( $ret , $msg , $dat , $cnt ) = $objCnrHsr2ToArray->doConvert($met);

      unless ( $ret == 0 ) {
         $http_code = 400 ; $dat = '' ; $cnt = 0 ; 
      }
      my $met = $met ; 
      $self->SUPER::doRenderJson($http_code,$msg,$http_method,$met,$cnt,$dat);
   } elsif ( $ret == 400 or $ret == 404 ) {
      $http_code = 400 ; 
      $self->SUPER::doRenderJson($http_code,$msg,$http_method,$met,$cnt,$dat);
   } elsif ( $ret == 2 ) {
      $http_code = 400 ; 
      $self->SUPER::doRenderJson($http_code,$msg,$http_method,$met,$cnt,$dat);
   } elsif ( $ret == 1 ) {
      $http_code = 400 ; 
      $msg = " the table $table does not exist " ; 
      $self->SUPER::doRenderJson($http_code,$msg,$http_method,$met,$cnt,$dat);
   } else {
      $http_code = 400 ; 
      $msg = 'unknown error has occurred' ; 
      $self->SUPER::doRenderJson($http_code,$msg,$http_method,$met,$cnt,$dat);
   }
}


1;

__END__

# feature-guid: ecd424d7-e5bd-45f1-90c8-10fae1316bf9
