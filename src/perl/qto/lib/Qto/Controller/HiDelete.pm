package Qto::Controller::HiDelete ;
use strict ; use warnings ; 

require Exporter; our @ISA = qw(Exporter Mojo::Base Qto::Controller::BaseController);
our $AUTOLOAD =();
use AutoLoader;
use parent qw(Qto::Controller::BaseController);

use Data::Printer ; 
use Data::Dumper; 
use JSON;

use Qto::App::Db::Out::WtrDbsFcry;
use Qto::App::Utils::Logger;
use Qto::App::Cnvr::CnrHsr2ToArray ; 
use Qto::App::IO::In::CnrPostPrms ; 
use Qto::App::Cnvr::CnrDbName qw(toPlainName toEnvName);

our $module_trace   = 0 ;
our $config      = {};
our $objLogger      = {} ;
our $rdbms_type     = 'postgre';

#
# --------------------------------------------------------
# HiDelete - delete an item from hierachichal table
# --------------------------------------------------------
sub doHiDelete {

   my $self             = shift;
   my $item             = $self->stash('item');
   my $db               = $self->stash('db');
   my $objCnrPostPrms   = {} ; 
   my $objWtrDbsFcry    = {} ; 
   my $objWtrDb         = {} ; 
   my $ret              = 1;
   my $dat              = {} ;
   my $http_code        = 400 ;
   my $msg              = 'unknown error during HiCreate item';
   my $hsr2             = {};
   my $json             = $self->req->body;
   my $perl_hash        = decode_json($json) ; 
   my $oid              = $perl_hash->{'oid'} || 0 ;

   return unless ( $self->SUPER::isAuthenticated($db) == 1 );
   $self->SUPER::doReloadProjDbMeta( $db ,$item) ;

   $config		         = $self->app->get('AppConfig');
   $db                  = toEnvName ( $db , $config) ;
   
   my $objModel         = 'Qto::App::Mdl::Model'->new ( \$config , $db , $item ) ;
   $objCnrPostPrms      = 'Qto::App::IO::In::CnrPostPrms'->new(\$config , \$objModel);

   unless ( $objCnrPostPrms->chkHiDeleteHasValidParams( $perl_hash ) == 1 ) {
      my $http_code = $objCnrPostPrms->get('http_code') ; 
      $msg = $objCnrPostPrms->get('msg') ; 
      $self->res->code($http_code ) ;
      $self->render( 'json' =>  { 
         'msg'   => $msg,
         'dat'   => $dat,
         'ret'   => $http_code , 
         'req'   => "POST " . $self->req->url->to_abs
      });
      return ; 
   } 

   $objWtrDbsFcry = 'Qto::App::Db::Out::WtrDbsFcry'->new(\$config, \$objModel );
   $objWtrDb = $objWtrDbsFcry->doSpawn("$rdbms_type");
   ($http_code, $msg,$dat) = $objWtrDb->doHiDeleteRow($db,$item,$oid);

   $self->res->code($http_code);
   $self->render( 'json' =>  { 
        'msg'   => $msg
      , 'dat'   => $dat
      , 'ret'   => $http_code
      , 'req'   => "POST " . $self->req->url->to_abs
   });
}



1;

__END__

