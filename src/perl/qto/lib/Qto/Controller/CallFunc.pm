package Qto::Controller::CallFunc ; 
use strict ; use warnings ; 
	
require Exporter;
our @ISA = qw(Exporter Mojo::Base Qto::Controller::BaseController);
our $AUTOLOAD =();
our $ModuleDebug = 0 ; 
use AutoLoader;

use Data::Printer ; 

use parent qw(Qto::Controller::BaseController);

use Qto::App::Db::In::RdrDbsFcry;
use Qto::App::Utils::Logger;
use Qto::App::Cnvr::CnrHsr2ToArray ; 
use Qto::App::Cnvr::CnrDbName qw(toPlainName toEnvName);
use Qto::App::IO::In::CnrUrlPrms ; 

my $module_trace    = 0 ;
our $config         = {};
our $objLogger      = {} ;
our $rdbms_type     = 'postgres';

#
# --------------------------------------------------------
# Select all the rows from db by passed db and table name
# --------------------------------------------------------
sub doCallFunc {

   my $self             = shift;
   
   my $db               = $self->stash('db');
   my $func 				= 'func_' . $self->stash('func');
   my $ret              = 1 ; 
   my $met              = {} ; 
   my $msg              = 'unknown error during global text search ';
   my $item             = 'search' ; 

   $config		         = $self->app->config ; 
   $db                  = toEnvName ( $db , $config) ;
   return unless ( $self->SUPER::isAuthenticated($db) == 1 );
   my $objModel         = 'Qto::App::Mdl::Model'->new ( \$config , $db , $item ) ; 
   $self->SUPER::doReloadProjDbMeta( \$objModel , $db , $item) ;
   my $msr2             = $self->doGetRsMeta($db,$func) ; 
   my $tables_meta      = $objModel->get("$db" . '.meta-tables');
   my $objCnrUrlPrms    = {} ; 
   my $objRdrDbsFcry    = {} ; 
   my $objRdrDb         = {} ; 
   my $hsr2             = {};
   my $http_code        = 400 ;
   my $rows_count       = 0 ; 
   
   my $query_params = $self->req->query_params ; 
   $objCnrUrlPrms = 
      'Qto::App::IO::In::CnrUrlPrms'->new(\$config , \$objModel , $self->req->query_params);
   ( $ret , $msg ) = $objCnrUrlPrms->doSetCallFuncUrlParams('CallFunc' );

   if ( $ret == 0 ) {

      $objRdrDbsFcry = 'Qto::App::Db::In::RdrDbsFcry'->new(\$config, \$objModel );
      $objRdrDb = $objRdrDbsFcry->doSpawn("$rdbms_type",$db);

      ($ret, $msg , $hsr2 ) = $objRdrDb->doCallFuncGetHashRef($func,'id'); # by convention ?!

      if ( $ret == 0 ) {
         my $list = ();
         my $page_size = $self->param('pg-size') || 7 ; 
         my $page_num = $self->param('pg-num') || 1 ;

         my $objCnrHsr2ToArray = 
            'Qto::App::Cnvr::CnrHsr2ToArray'->new ( \$config , \$objModel ) ; 
         ( $ret , $msg , $msr2, $list , $rows_count ) = 
               $objCnrHsr2ToArray->doConvertSetMaxWidth ($msr2, $hsr2 , '<=>', 'id',$page_size,$page_num) ;
         $met = {
              'meta_cols'     => $msr2
            , 'meta_tables'   => $tables_meta
         };
         $self->SUPER::doRenderJSON(200,$msg,'GET',$met,$rows_count,$list);
      } elsif ( $ret == 204 ) { # the CallFunc did not return any data ..., but did not fail neither ...
         $msg = ' no data ' ;
         $self->SUPER::doRenderJSON(200,$msg,'GET',$met,'0','');
      } elsif ( $ret == 100 ) {
         $self->SUPER::doRenderJSON(200,$msg,'GET',$met,'0',());
      } else {
         $self->SUPER::doRenderJSON(400,$msg,'GET',$met,'0','');
      }

   } elsif ( $ret == 204 ) {
      $self->SUPER::doRenderJSON(204,$msg,'GET',$met,'0','');
   } elsif ( $ret == 100 ) {
      $self->SUPER::doRenderJSON(200,$msg,'GET',$met,'0',());
   } else {
      $self->SUPER::doRenderJSON(400,$msg,'GET',$met,'0','');
   }
}


sub doGetRsMeta {
   my $self 			= shift ; 
	my $db 				= shift ; 
   my $func_name     = shift ; 
   
   $config		      = $self->app->config ; 
   $db               = toEnvName ( $db , $config) ;
   my $objModel      = 'Qto::App::Mdl::Model'->new ( \$config , $db , 'report') ; 
   my $objRdrDbsFcry = {} ; 
   my $objRdrDb      = {} ; 
   
	$objRdrDbsFcry = 'Qto::App::Db::In::RdrDbsFcry'->new(\$config, \$objModel );
   $objRdrDb = $objRdrDbsFcry->doSpawn("$rdbms_type",$db);

   my ($ret, $msg , $msr2 ) = $objRdrDb->doCallFuncGetHashRef('func_get_function_args','pos',$func_name,'public');
   return $msr2 ; 
}

1;

__END__
