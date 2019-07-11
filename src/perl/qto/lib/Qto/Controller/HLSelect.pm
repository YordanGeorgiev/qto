package Qto::Controller::HLSelect;
use strict ; use warnings ; 

require Exporter; our @ISA = qw(Exporter Mojo::Base Qto::Controller::BaseController);
our $AUTOLOAD =();
use AutoLoader;
use parent qw(Qto::Controller::BaseController);

use Data::Printer ; 
use Data::Dumper; 

use Qto::App::Utils::Logger;
use Qto::App::Db::In::RdrDbsFactory ; 
use Qto::App::IO::In::CnrUrlPrms ; 
use Qto::App::Cnvr::CnrHsr2ToArray ;  
use Qto::App::Cnvr::CnrHashesArrRefToHashesArrRef ; 
use Qto::App::Cnvr::CnrDbName qw(toPlainName toEnvName);

our $appConfig          = {} ; 

sub doHLSelectItems {

   my $self          = shift ; 
   my $db            = $self->stash('db');
   my $item          = $self->stash('item');
   my $msg           = '' ; 
   my $http_code     = 400 ; 
   my $http_method   = 'GET' ; 
   my $met           = {} ; 
   my $ret           = 1 ; 
   my $cnt           = 0 ; 
   my $rdbms_type    = 'postgres' ; 
   my $dat           = [] ;
   my $objModel      = {} ; 
   my $appConfig     = {} ; 
   my $objRdrDb      = {} ; 
   my $objRdrDbsFactory = {} ; 
   my $mc            = 0 ; 
 
   $appConfig		   = $self->app->get('AppConfig');
   $db               = toEnvName ( $db , $appConfig) ;
   return unless ( $self->SUPER::isAuthenticated($db) == 1 );
   $self->SUPER::doReloadProjDbMeta( $db ) ;

   $appConfig		   = $self->app->get('AppConfig');
   $objModel         = 'Qto::App::Mdl::Model'->new ( \$appConfig , $db , $item ) ;
   my $objCnrUrlPrms = 'Qto::App::IO::In::CnrUrlPrms'->new(\$appConfig , \$objModel , $self->req->query_params);
   
   return $self->SUPER::doRenderJSON($objCnrUrlPrms->get('http_code'),$objCnrUrlPrms->get('msg'),$http_method,$met,$cnt,$dat) 
      unless $objCnrUrlPrms->doValidateAndSetHSelect();
   
   $objRdrDbsFactory = 'Qto::App::Db::In::RdrDbsFactory'->new(\$appConfig, \$objModel );
   $objRdrDb 			= $objRdrDbsFactory->doSpawn("$rdbms_type");

   ($http_code, $msg, $dat) 	= $objRdrDb->doHSelectBranch( $db , $item );
   my $objCnrHashesArrRefToHashesArrRef = 'Qto::App::Cnvr::CnrHashesArrRefToHashesArrRef'->new (\$appConfig  ) ; 
   $dat = $objCnrHashesArrRefToHashesArrRef->doConvert ( $dat) ; 
   ( $ret , $msg , $met , $mc) = $objModel->doGetTableMeta($appConfig,$db,$item);
   
   $self->SUPER::doRenderJSON($http_code,$msg,$http_method,$met,$cnt,$dat);
   return ; 
}

1 ; 

__END__
