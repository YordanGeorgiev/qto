package Qto::Controller::SelectMy;
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
our $rdbms_type      = 'postgres';




#
# --------------------------------------------------------
# Select all the rows from db by passed db and table name
# src: https://en.wikipedia.org/wiki/List_of_HTTP_status_codes
# --------------------------------------------------------
sub doSelectMyItems {
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
   my $objModel         = 'Qto::App::Mdl::Model'->new ( \$config , $db , $item ) ; 
   $self->SUPER::doReloadProjDbMeta( \$objModel , $db , $item) ;
   $objCnrUrlPrms       = 'Qto::App::IO::In::CnrUrlPrms'->new(\$config , \$objModel , $self->req->query_params);
   
   return $self->SUPER::doRenderJSON(
      $objCnrUrlPrms->get('http_code'),$objCnrUrlPrms->get('msg'),$http_method,$met,$cnt,$dat) 
         unless $objCnrUrlPrms->doValidateAndSetSelect();

   $objRdrDbsFcry       = 'Qto::App::Db::In::RdrDbsFcry'->new(\$config, \$objModel );
   $objRdrDb            = $objRdrDbsFcry->doSpawn ( $rdbms_type , $db);
   my $who              = $self->session( 'app.' . $db . '.user' );

   ($ret, $msg, $hsr2)  = $objRdrDb->doSelectMyRows($db, $item,$who);
   my $app_items        = $objModel->get("$db" . '.meta-tables');
   $meta_cols           = $objModel->get("$db" . '.meta-columns');

   $met = {
        'meta_cols' => $meta_cols
      , 'app_items' => $app_items
   };
   $http_code = 200;
   $cnt = 0 ; 
   my $objCnrHsr2ToArray = 'Qto::App::Cnvr::CnrHsr2ToArray'->new ( \$config , \$objModel ) ; 
   my $msg1 = '' ; my $ret1 = 0;
   ( $ret1 , $msg1 , $dat , $cnt )       = $objCnrHsr2ToArray->doConvert ($hsr2);

   $msg = $msg . $msg1 ; 
   $self->SUPER::doRenderJSON($http_code,$msg, $http_method,$met,$cnt,$dat,$ret);
}


1;

__END__

# feature-guid: ecd424d7-e5bd-45f1-90c8-10fae1316bf9
