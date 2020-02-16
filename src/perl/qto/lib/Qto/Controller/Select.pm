package Qto::Controller::Select;
use strict ; use warnings ; 

require Exporter; our @ISA = qw(Exporter Mojo::Base Qto::Controller::BaseController);
our $AUTOLOAD =();
use AutoLoader;
use parent qw(Qto::Controller::BaseController);

use Data::Printer ; 
use Data::Dumper; 

use Qto::App::Utils::Logger;
use Qto::App::Db::In::RdrDbsFcry;
use Qto::App::Cnvr::CnrHsr2ToArray ; 
use Qto::App::IO::In::CnrUrlPrms ; 
use Qto::App::Cnvr::CnrDbName qw(toPlainName toEnvName);

my $module_trace     = 0 ;
our $config          = {};
our $objLogger       = {} ;
our $rdbms_type      = 'postgre';




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
   my $meta_cols        = {}; # the meta-data of the this item
   my $mc               = {}; # the meta-counter of the meta-data
   my $cnt              = 0 ; 
   my $objCnrUrlPrms    = {} ; 
   my $objRdrDbsFcry    = {} ; 
   my $objRdrDb         = {} ; 
   $config		         = $self->app->config ; 
   $db                  = toEnvName ( $db , $config) ;
   return unless ( $self->SUPER::isAuthenticated($db) == 1 );
   my $objModel         = 'Qto::App::Mdl::Model'->new ( \$config , $db , $item ) ; 
   $self->SUPER::doReloadProjDbMeta( \$objModel , $db , $item) ;
   $objCnrUrlPrms       = 'Qto::App::IO::In::CnrUrlPrms'->new(\$config , \$objModel , $self->req->query_params);
   
   return $self->SUPER::doRenderJSON(
      $objCnrUrlPrms->get('http_code'),$objCnrUrlPrms->get('msg'),$http_method,$met,$cnt,$dat) 
         unless $objCnrUrlPrms->doValidateAndSetSelect();

   $objRdrDbsFcry       = 'Qto::App::Db::In::RdrDbsFcry'->new(\$config, \$objModel );
   $objRdrDb            = $objRdrDbsFcry->doSpawn ( $rdbms_type );
   my $who              = $self->session( 'app.' . $db . '.user' );

   ($ret, $msg, $hsr2)  = $objRdrDb->doSelectRows($db, $item,$who);
   my $meta_tables = $objModel->get("$db" . '.meta-tables');
   $meta_cols = $objModel->get("$db" . '.meta-columns');
   $met = {
        'meta_cols' => $meta_cols
      , 'meta_tables' => $meta_tables
   };
   $http_code = 200;
   $cnt = 0 ; 
   my $objCnrHsr2ToArray = 'Qto::App::Cnvr::CnrHsr2ToArray'->new ( \$config , \$objModel ) ; 
   my $msg1 = '' ; my $ret1 = 0;
   ( $ret1 , $msg1 , $dat , $cnt )       = $objCnrHsr2ToArray->doConvert ($hsr2);

   $self->SUPER::doRenderJSON($http_code,$msg . $msg1,$http_method,$met,$cnt,$dat,$ret);
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
   my $msg = 'unknown error during select-tables';
   my $item       = 'select_tables' ; 
   $config		      = $self->app->config ; 

   return unless ( $self->SUPER::isAuthenticated($db) == 1 );
   my $objModel         = 'Qto::App::Mdl::Model'->new ( \$config , $db , $item ) ; 
   $self->SUPER::doReloadProjDbMeta( \$objModel , $db , $item) ;

	my $ret        = 0;
	my $hsr2       = {};

	my $objRdrDbsFcry = 'Qto::App::Db::In::RdrDbsFcry'->new(\$config, \$objModel );

	my $objRdrDb = $objRdrDbsFcry->doSpawn("$rdbms_type");
	($ret, $msg,$hsr2) = $objRdrDb->doSelectTablesList($db);

   my $dat = [] ; # an array ref holding the converted hash ref of hash refs 
   if ( $ret == 0 ) {
      $objModel->set('select.web-action.o', 'row_id' );
      my $objCnrHsr2ToArray = 
         'Qto::App::Cnvr::CnrHsr2ToArray'->new ( \$config , \$objModel ) ; 
      ( $ret , $msg , $dat ) = $objCnrHsr2ToArray->doConvert($hsr2 , '>' );
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
   my $item          = 'select_databases' ; 
	$config	   = $self->app->config;

   return unless ( $self->SUPER::isAuthenticated($db) == 1 );
   my $objModel         = 'Qto::App::Mdl::Model'->new ( \$config , $db , $item ) ; 
   $self->SUPER::doReloadProjDbMeta( \$objModel , $db , $item) ;

	my $ret = 0;
	my $hsr2 = {};

	my $objRdrDbsFcry
			= 'Qto::App::Db::In::RdrDbsFcry'->new(\$config, \$objModel );

	my $objRdrDb = $objRdrDbsFcry->doSpawn("$rdbms_type");
	($ret, $msg) = $objRdrDb->doSelectDatabasesList(\$objModel);

   if ( $ret == 0 ) {

      my $dat = () ; # an array ref holding the converted hash ref of hash refs 
      $objModel->set('select.web-action.o', 'row_id' );
      my $objCnrHsr2ToArray = 
         'Qto::App::Cnvr::CnrHsr2ToArray'->new ( \$config , \$objModel ) ; 
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
# select the meta data 
# --------------------------------------------------------
sub doSelectMeta {

   my $self        = shift;
   my $db          = $self->stash('db');
   my $table       = $self->stash('item') || undef ; 
   my $ret         = 0;
   my $msg         = 'unknown error during Select item';
   my $met         = {} ;
   my $cols_meta   = '' ; 
   my $rdbms_type  = 'postgres';
   my $http_method = 'GET';
   my $http_code   = '400';
   my $dat         = '' ; 
   my $cnt         = 0;
   my $item        = 'select_meta' ; 
   $config		    = $self->app->config ; 
   $db             = toEnvName ( $db , $config) ;

   return unless ( $self->SUPER::isAuthenticated($db) == 1 );
   my $objModel    = 'Qto::App::Mdl::Model'->new ( \$config , $db , $item ) ; 
   $self->SUPER::doReloadProjDbMeta( \$objModel , $db , $item) ;

   if ( $ret == 0 ) {
      my $arr_meta_cols = () ; # an array ref holding the converted hash ref of hash refs 
      my $meta_cols = () ; # an array ref holding the converted hash ref of hash refs 
      my $http_code = 200 ; 
      $msg = "SELECT meta OK for table: $table " ; 
      my $objCnrHsr2ToArray = 'Qto::App::Cnvr::CnrHsr2ToArray'->new ( \$config , \$objModel ) ; 
      $meta_cols = $objModel->get("$db" . '.meta-columns');
      ( $ret , $msg , $arr_meta_cols, $cnt ) = $objCnrHsr2ToArray->doConvert($meta_cols);
      unless ( $ret == 0 ) {
         $http_code = 400 ; $dat = '' ; $cnt = 0 ; 
      }
      my $meta_tables = $objModel->get("$db" . '.meta-tables');
      ( $ret , $msg , $meta_cols , $cnt ) = $objModel->doGetColumnsMeta( $config , $db , $table );
      $met = {
         'meta_cols' => $meta_cols
       , 'meta_tables' => $meta_tables
      };
      $self->SUPER::doRenderJSON($http_code,$msg,$http_method,$met,$cnt,$arr_meta_cols);
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
