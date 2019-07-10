package Qto::Controller::Select;
use strict ; use warnings ; 

require Exporter; our @ISA = qw(Exporter Mojo::Base Qto::Controller::BaseController);
our $AUTOLOAD =();
use AutoLoader;
use parent qw(Qto::Controller::BaseController);

use Data::Printer ; 
use Data::Dumper; 

use Qto::App::Utils::Logger;
use Qto::App::Db::In::RdrDbsFactory;
use Qto::App::Cnvr::CnrHsr2ToArray ; 
use Qto::App::IO::In::CnrUrlPrms ; 
use Qto::App::Cnvr::CnrDbName qw(toPlainName toEnvName);

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
   my $http_code        = 200 ; 
   my $ret              = 0;
   my $dat              = undef ; 
   my $msg              = 'unknown error during Select item';
   my $hsr2             = {};
   my $met              = {}; # the meta-data of the this item
   my $mc               = {}; # the meta-counter of the meta-data
   my $cnt              = 0 ; 
   my $objCnrUrlPrms    = {} ; 
   my $objRdrDbsFactory = {} ; 
   my $objRdrDb         = {} ; 

   $appConfig		      = $self->app->get('AppConfig');
   $db                  = toEnvName ( $db , $appConfig) ;
   return unless ( $self->SUPER::isAuthorized($db) == 1 );
   $self->SUPER::doReloadProjDbMeta( $db , $item) ;

	# debug rint "Select.pm ::: url: " . $self->req->url->to_abs . "\n\n" if $module_trace == 1 ; 
   my $objModel         = 'Qto::App::Mdl::Model'->new ( \$appConfig , $db , $item ) ; 
   $objCnrUrlPrms       = 'Qto::App::IO::In::CnrUrlPrms'->new(\$appConfig , \$objModel , $self->req->query_params);
   
   return $self->SUPER::doRenderJSON(
      $objCnrUrlPrms->get('http_code'),$objCnrUrlPrms->get('msg'),$http_method,$met,$cnt,$dat) 
         unless $objCnrUrlPrms->doValidateAndSetSelect();

   $objRdrDbsFactory = 'Qto::App::Db::In::RdrDbsFactory'->new(\$appConfig, \$objModel );
   $objRdrDb            = $objRdrDbsFactory->doSpawn ( $rdbms_type );
   ($ret, $msg, $hsr2)   = $objRdrDb->doSelect($db, $item); # doSelect

   if ( $ret != 0 ) {
      $http_code = $ret ; 
   } elsif ( $ret == 404 or $ret == 204 ) {
      $http_code = $ret ; 
      $dat = {} ;
      $cnt = 0 ; 
   } elsif ( $ret == 0 )  {
      $cnt = 0 ; 
      $http_code = 200 ; 
      $msg = "SELECT OK for table: $item" ; 
      my $objCnrHsr2ToArray = 
         'Qto::App::Cnvr::CnrHsr2ToArray'->new ( \$appConfig , \$objModel ) ; 
      ( $ret , $msg , $dat , $cnt ) = $objCnrHsr2ToArray->doConvert ($hsr2);
      
      unless ( $ret == 0 ) {
        $http_code = 404 ; 
      } else {
         $http_code = 200 ; 
      }
      ( $ret , $msg , $met , $mc) = $objModel->doGetTableMeta($appConfig,$db,$item);
   } else {
      $http_code = 400 ; 
   } 

   $self->SUPER::doRenderJSON($http_code,$msg,$http_method,$met,$cnt,$dat);
}


#
# --------------------------------------------------------
# provide the following json response of the tables Select in the db
# {
#  "1": {
#    "row_id": "1",
#    "table_catalog": "dev_qto",
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
   my $objModel   = 'Qto::App::Mdl::Model'->new ( \$appConfig , $db) ;

   $db                  = toEnvName ( $db , $appConfig) ;
   return unless ( $self->SUPER::isAuthorized($db) == 1 );
   $self->SUPER::doReloadProjDbMeta( $db , 'meta_columns' ) ;

	my $ret        = 0;
	my $hsr2       = {};

	my $objRdrDbsFactory
			= 'Qto::App::Db::In::RdrDbsFactory'->new(\$appConfig, \$objModel );

	my $objRdrDb = $objRdrDbsFactory->doSpawn("$rdbms_type");
	($ret, $msg) = $objRdrDb->doSelectTablesList(\$objModel);


	$self->res->headers->accept_charset('UTF-8');
	$self->res->headers->accept_language('fi, en');
	$self->res->headers->content_type('application/json; charset=utf-8');

   my $dat = [] ; # an array ref holding the converted hash ref of hash refs 
   if ( $ret == 0 ) {
      $objModel->set('select.web-action.o', 'row_id' );
      my $objCnrHsr2ToArray = 
         'Qto::App::Cnvr::CnrHsr2ToArray'->new ( \$appConfig , \$objModel ) ; 
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
   my $objModel   = 'Qto::App::Mdl::Model'->new ( \$appConfig ) ;

   $db                  = toEnvName ( $db , $appConfig) ;
	$objModel->set('postgres_db_name' , 'postgres' ) ; 

   return unless ( $self->SUPER::isAuthorized($db) == 1 );
   $self->SUPER::doReloadProjDbMeta( $db , 'meta_columns') ;

	my $ret = 0;
	my $hsr2 = {};

	my $objRdrDbsFactory
			= 'Qto::App::Db::In::RdrDbsFactory'->new(\$appConfig, \$objModel );

	my $objRdrDb = $objRdrDbsFactory->doSpawn("$rdbms_type");
	($ret, $msg) = $objRdrDb->doSelectDatabasesList(\$objModel);

   if ( $ret == 0 ) {

      my $dat = () ; # an array ref holding the converted hash ref of hash refs 
      $objModel->set('select.web-action.o', 'row_id' );
      my $objCnrHsr2ToArray = 
         'Qto::App::Cnvr::CnrHsr2ToArray'->new ( \$appConfig , \$objModel ) ; 
      ( $ret , $msg , $dat ) = $objCnrHsr2ToArray->doConvert($objModel->get('hsr2'),'>');
      $self->SUPER::doRenderJSON($http_code,$msg,$http_method,$met,$cnt,$dat);
   } elsif ( $ret == 400 or $ret == 404) {
      $http_code = $ret ; 
      $self->SUPER::doRenderJSON($http_code,$msg,$http_method,$met,$cnt,$dat);
   } elsif ( $ret == 2 ) {
      $http_code = 400 ; 
      $self->SUPER::doRenderJSON($http_code,$msg,$http_method,$met,$cnt,$dat);
   } else {
      $http_code = 404 ; 
      $self->SUPER::doRenderJSON($http_code,$msg,$http_method,$met,$cnt,$dat);
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

   $appConfig		= $self->app->get('AppConfig');
   my $objModel         = 'Qto::App::Mdl::Model'->new ( \$appConfig ) ;
   
   $db                  = toEnvName ( $db , $appConfig) ;
   return unless ( $self->SUPER::isAuthorized($db) == 1 );
   $self->SUPER::doReloadProjDbMeta( $db ) ;
   
   $appConfig		 		= $self->app->get('AppConfig');
      
   if ( defined $table ) {
      ( $ret , $msg , $met , $cnt ) = $objModel->doGetTableMeta ( $appConfig , $db , $table ) 
   }

   if ( $ret == 0 ) {
      my $dat = () ; # an array ref holding the converted hash ref of hash refs 
      my $http_code = 200 ; 
      $msg = "SELECT meta OK for table: $table " ; 
      my $objCnrHsr2ToArray = 
         'Qto::App::Cnvr::CnrHsr2ToArray'->new ( \$appConfig , \$objModel ) ; 
      ( $ret , $msg , $dat , $cnt ) = $objCnrHsr2ToArray->doConvert($met);

      unless ( $ret == 0 ) {
         $http_code = 400 ; $dat = '' ; $cnt = 0 ; 
      }
      my $met = $met ; 
      $self->SUPER::doRenderJSON($http_code,$msg,$http_method,$met,$cnt,$dat);
   } elsif ( $ret == 400 or $ret == 404 ) {
      $http_code = 400 ; 
      $self->SUPER::doRenderJSON($http_code,$msg,$http_method,$met,$cnt,$dat);
   } elsif ( $ret == 2 ) {
      $http_code = 400 ; 
      $self->SUPER::doRenderJSON($http_code,$msg,$http_method,$met,$cnt,$dat);
   } elsif ( $ret == 1 ) {
      $http_code = 400 ; 
      $msg = " the table $table does not exist " ; 
      $self->SUPER::doRenderJSON($http_code,$msg,$http_method,$met,$cnt,$dat);
   } else {
      $http_code = 400 ; 
      $msg = 'unknown error has occurred' ; 
      $self->SUPER::doRenderJSON($http_code,$msg,$http_method,$met,$cnt,$dat);
   }
}


1;

__END__

# feature-guid: ecd424d7-e5bd-45f1-90c8-10fae1316bf9
