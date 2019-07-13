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
use Qto::App::IO::In::CnrUrlPrms ; 

my $module_trace    = 0 ;
our $appConfig      = {};
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
   my $msg              = 'unknown error during global text search ';
   my $msr2             = $self->doGetRsMeta() ; 

   return unless ( $self->SUPER::isAuthenticated($db) == 1 );
   $self->SUPER::doReloadProjDbMeta( $db,'search' ) ;
   
   $appConfig		 		= $self->app->get('AppConfig');
   unless ( exists ( $appConfig->{ $db . '.meta' } )  ) {
      
      ( $ret , $msg , $msr2 ) = $self->SUPER::doReloadProjDbMeta( $db ,'search') ; 
      unless ( $ret == 0 ) { 
         $self->render('text' => $msg ) unless $ret == 0 ; 
         return ; 
      }
      else { 
         $appConfig->{ $db . '.meta' } = $msr2 ; 
      }
   } 

   my $objCnrUrlPrms  = {} ; 
   my $objRdrDbsFcry = {} ; 
   my $objRdrDb         = {} ; 
   my $hsr2             = {};
   my $http_code        = 400 ;
   my $rows_count       = 0 ; 

	#print STDOUT "Query.pm ::: url: " . $self->req->url->to_abs . "\n\n" if $module_trace == 1 ; 

   my $objModel         = 'Qto::App::Mdl::Model'->new ( \$appConfig , $db) ;
   $objModel->set('postgres_db_name' , $db ) ; 

   my $query_params = $self->req->query_params ; 
   $objCnrUrlPrms = 
      'Qto::App::IO::In::CnrUrlPrms'->new(\$appConfig , \$objModel , $self->req->query_params);
   ( $ret , $msg ) = $objCnrUrlPrms->doSetQueryUrlParams('Query' );
   if ( $ret != 0 ) {
      $self->SUPER::doRenderJSON(400,$msg,'GET','','0','');
      return ; 
   } 

   $objRdrDbsFcry = 'Qto::App::Db::In::RdrDbsFcry'->new(\$appConfig, \$objModel );
	$objRdrDb = $objRdrDbsFcry->doSpawn("$rdbms_type");
   ($ret, $msg , $hsr2 ) = $objRdrDb->doGlobalSrchIntoHashRef(\$objModel );

   if ( $ret == 0 ) {
      my $list = ();
      my $objCnrHsr2ToArray = 
         'Qto::App::Cnvr::CnrHsr2ToArray'->new ( \$appConfig , \$objModel ) ; 
      ( $ret , $msg , $list , $rows_count ) = $objCnrHsr2ToArray->doConvert ($hsr2 , '>', 'relevancy') ;

      $self->SUPER::doRenderJSON(200,$msg,'GET',$msr2,$rows_count,$list);
   } elsif ( $ret == 204 ) {
      $self->SUPER::doRenderJSON(204,$msg,'GET','','0','');
   } else {
      $self->SUPER::doRenderJSON(400,$msg,'GET','','0','');
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

# feature-guid: ecd424d7-e5bd-45f1-90c8-10fae1316bf9
