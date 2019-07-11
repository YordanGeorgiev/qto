package Qto::Controller::HCreate ; 
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
our $appConfig      = {};
our $objLogger      = {} ;
our $rdbms_type     = 'postgre';

#
# --------------------------------------------------------
# HCreate - create an item in a hierachichal table
# --------------------------------------------------------
sub doHCreateById {

   my $self             = shift;
   my $item             = $self->stash('item');
   my $db               = $self->stash('db');
   my $objCnrPostPrms   = {} ; 
   my $objWtrDbsFcry = {} ; 
   my $objWtrDb         = {} ; 
   my $ret              = 1;
   my $http_code        = 400 ;
   my $msg              = 'unknown error during HCreate item';
   my $hsr2             = {};
   my $json             = $self->req->body;
   my $perl_hash        = decode_json($json) ; 
   my $id               = $perl_hash->{'id'};
   my $seq              = $perl_hash->{'seq'}; # the sequence of the hierarchy item
   $db                  = toEnvName ( $db , $appConfig) ;
   # todo:ysg !!!
   # return unless ( $self->SUPER::isAuthenticated($db) == 1 );

   $self->SUPER::doReloadProjDbMeta( $db ) ;
   $appConfig		      = $self->app->get('AppConfig');
   
   my $objModel         = 'Qto::App::Mdl::Model'->new ( \$appConfig , $db , $item ) ;
   $objCnrPostPrms = 
      'Qto::App::IO::In::CnrPostPrms'->new(\$appConfig , \$objModel);
   
   #"unless ( $objCnrPostPrms->doValidateAndSetHCreate ( $perl_hash ) == 1 ) {
    #  my $http_code = $objCnrPostPrms->get('http_code') ; 
    #  $msg = $objCnrPostPrms->get('msg') ; 
    #  $self->res->code($http_code ) ;
    #  $self->render( 'json' =>  { 
    #     'msg'   => $msg,
    #     'ret'   => $http_code , 
    #     'req'   => "POST " . $self->req->url->to_abs
    #  });
    #  return ; 
   #} 

   $objWtrDbsFcry = 'Qto::App::Db::Out::WtrDbsFcry'->new(\$appConfig, \$objModel );
   $objWtrDb = $objWtrDbsFcry->doSpawn("$rdbms_type");
   ($http_code, $msg) = $objWtrDb->doHInsertRow($db,$item,$id,$seq);

   $self->res->code($http_code);
   $self->render( 'json' =>  { 
        'msg'   => $msg
      , 'ret'   => $http_code
      , 'req'   => "POST " . $self->req->url->to_abs
   });
}



1;

__END__

