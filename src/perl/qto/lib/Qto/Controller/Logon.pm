package Qto::Controller::Logon ; 
use strict ; use warnings ; 
	
require Exporter;
our @ISA = qw(Exporter Mojo::Base Qto::Controller::BaseController);
our $AUTOLOAD =();
our $ModuleDebug = 0 ; 
use AutoLoader;

use Data::Printer ; 

use parent qw(Qto::Controller::BaseController);

use Qto::App::Db::In::RdrDbsFactory;
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
sub doLogonUser {

   my $self             = shift;
   my $db               = $self->stash('db');
   my $ret              = 1 ; 
   my $msg              = 'unknown error during global text search ';
   my $objRdrDbsFactory = {} ; 
   my $objRdrDb         = {} ; 
   my $hsr2             = {};
   my $http_code        = 400 ;
   my $rows_count       = 0 ; 
   my $msr2             = {}  ; 

	#print STDOUT "Logon.pm ::: url: " . $self->req->url->to_abs . "\n\n" if $module_trace == 1 ; 

   my $objModel         = 'Qto::App::Mdl::Model'->new ( \$appConfig , $db) ;
   $objModel->set('postgres_db_name' , $db ) ; 

   $objRdrDbsFactory = 'Qto::App::Db::In::RdrDbsFactory'->new(\$appConfig, \$objModel );
	$objRdrDb = $objRdrDbsFactory->doSpawn("$rdbms_type");
   ($ret, $msg , $hsr2 ) = $objRdrDb->doNativeLogonAuth(\$objModel );

   $ret = 0 ; #todo:ysg
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


1;

__END__

# feature-guid: ecd424d7-e5bd-45f1-90c8-10fae1316bf9
