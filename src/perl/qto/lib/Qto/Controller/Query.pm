package Qto::Controller::Query ; 
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
use Qto::App::Db::In::RdrRedis ; 

my $module_trace    = 0 ;
our $config         = {};
our $objLogger      = {} ;
our $rdbms_type     = 'postgres';



#
# --------------------------------------------------------
# Select all the rows from db by passed db and table name
# --------------------------------------------------------
sub doQueryItems {

   my $self             = shift;
   
   my $db               = $self->stash('db');
   my $ret              = 1 ; 
   my $met              = {} ; 
   my $msg              = 'unknown error during global text search ';
   my $msr2             = $self->doGetRsMeta() ; 

   return unless ( $self->SUPER::isAuthenticated($db) == 1 );
   $self->SUPER::doReloadProjDbMeta( $db,'search' ) ;
   $config		         = $self->app->config ; 
   $db                  = toEnvName ( $db , $config) ;
   #my $tables_meta      = $self->app->config($db . '.meta-tables');
   my $objRdrRedis   = 'Qto::App::Db::In::RdrRedis'->new(\$config);
   my $tables_meta   = $objRdrRedis->getData(\$config,"$db" . '.meta-tables');
   $met = {
        'meta_cols'     => $msr2
      , 'meta_tables'   => $tables_meta
   };
   my $objCnrUrlPrms  = {} ; 
   my $objRdrDbsFcry = {} ; 
   my $objRdrDb         = {} ; 
   my $hsr2             = {};
   my $http_code        = 400 ;
   my $rows_count       = 0 ; 

	#print STDOUT "Query.pm ::: url: " . $self->req->url->to_abs . "\n\n" if $module_trace == 1 ; 

   my $objModel         = 'Qto::App::Mdl::Model'->new ( \$config , $db) ;
   $objModel->set('postgres_db_name' , $db ) ; 

   my $query_params = $self->req->query_params ; 
   $objCnrUrlPrms = 
      'Qto::App::IO::In::CnrUrlPrms'->new(\$config , \$objModel , $self->req->query_params);
   ( $ret , $msg ) = $objCnrUrlPrms->doSetQueryUrlParams('Query' );

   if ( $ret == 0 ) {

      $objRdrDbsFcry = 'Qto::App::Db::In::RdrDbsFcry'->new(\$config, \$objModel );
      $objRdrDb = $objRdrDbsFcry->doSpawn("$rdbms_type");
      ($ret, $msg , $hsr2 ) = $objRdrDb->doGlobalSrchIntoHashRef(\$objModel );

      if ( $ret == 0 ) {
         my $list = ();
         my $objCnrHsr2ToArray = 
            'Qto::App::Cnvr::CnrHsr2ToArray'->new ( \$config , \$objModel ) ; 
         ( $ret , $msg , $list , $rows_count ) = $objCnrHsr2ToArray->doConvert ($hsr2 , '>', 'relevancy') ;
         $self->SUPER::doRenderJSON(200,$msg,'GET',$met,$rows_count,$list);
      } elsif ( $ret == 204 ) { # the query did not return any data ..., but did not fail neither ...
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
   my $self = shift ; 

   my $msr2             = {
		'0' => {
			'attribute_name' => 'id',
			'attribute_number' => 1,
			'char_max_length' => 104,
			'data_type' => 'character varying(100)',
			'width' => '20'
		}
		, '1' => {
			'attribute_name' => 'item',
			'attribute_number' => 2,
			'char_max_length' => 104,
			'data_type' => 'character varying(100)',
			'width' => '40'
		}
		, '2' => {
			'attribute_name' => 'relevancy',
			'attribute_number' => 3,
			'char_max_length' => 60,
			'data_type' => 'character varying(100)',
			'width' => '20'
		}
		, '3' => {
			'attribute_name' => 'name',
			'attribute_number' => 4,
			'char_max_length' => 104,
			'data_type' => 'character varying(100)',
			'width' => '100'
		}
		, '4' => {
			'attribute_name' => 'description',
			'attribute_number' => 5,
			'char_max_length' => 4004,
			'data_type' => 'character varying(4000)',
			'width' => '600'
		}
}; 
      return $msr2 ; 
}


1;

__END__
