package Qto::Controller::Create ; 
use strict ; use warnings ; 

require Exporter; our @ISA = qw(Exporter Mojo::Base Qto::Controller::BaseController);
our $AUTOLOAD =();
use AutoLoader;
use parent qw(Qto::Controller::BaseController);

use Data::Printer ; 
use Data::Dumper; 
use Scalar::Util qw /looks_like_number/;
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
# create all the rows from db by passed db and table name
# --------------------------------------------------------
sub doCreateById {

   my $self             = shift;
   my $item             = $self->stash('item');
   my $db               = $self->stash('db');
   my $rdbms_type       = 'postgres';
   my $objCnrPostPrms   = {} ; 
   my $objWtrDbsFcry    = {} ; 
   my $objWtrDb         = {} ; 
   my $ret              = 0;
   my $msg              = 'unknown error during create item';
   my $hsr2             = {};
   my $json             = $self->req->body;
   my $perl_hash        = decode_json($json) ; 
   $appConfig		      = $self->app->get('AppConfig');
   $db                  = toEnvName ( $db , $appConfig) ;


   return unless ( $self->SUPER::isAuthenticated($db) == 1 );
   $self->SUPER::doReloadProjDbMeta( $db ) ;
   
   my $objModel         = 'Qto::App::Mdl::Model'->new ( \$appConfig , $db , $item ) ;
   $objCnrPostPrms      = 'Qto::App::IO::In::CnrPostPrms'->new(\$appConfig , \$objModel );
   
   unless ( $objCnrPostPrms->doValidateAndSetCreate ( $perl_hash ) == 1 ) {
      my $http_code = $objCnrPostPrms->get('http_code') ; 
      $msg = $objCnrPostPrms->get('msg') ; 
      $self->res->code($http_code ) ;
      $self->render( 'json' =>  { 
         'msg'   => $msg,
         'ret'   => $http_code , 
         'req'   => "POST " . $self->req->url->to_abs
      });
      return ; 
   } 

   $objWtrDbsFcry  = 'Qto::App::Db::Out::WtrDbsFcry'->new(\$appConfig, \$objModel );
   $objWtrDb = $objWtrDbsFcry->doSpawn("$rdbms_type");
   ($ret, $msg) = $objWtrDb->doInsertByItemId($item);

   if ( $ret == 0 ) {
      my $http_code = 200 ; 
      my $rows_count = 0 ; 
      $msg = "create OK for table: $item" ; 

      $self->res->code($http_code);
      $self->render( 'json' =>  { 
           'msg'   => $msg
         , 'ret'   => $http_code
         , 'req'   => "POST " . $self->req->url->to_abs
      });
   } elsif ( $ret == 400 ) {

      $self->res->code(400);
      $self->render( 'json' =>  { 
           'msg'   => $msg
         , 'ret'   => 400
         , 'req'   => "POST " . $self->req->url->to_abs
      });
   } elsif ( $ret == 2 ) {

      $self->res->code(400);
      $self->render( 'json' =>  { 
         'msg'   => $msg
         ,'ret'   => 400
         ,'req'   => "POST " . $self->req->url->to_abs
      });
   } elsif ( $ret == 409) {

      my $post_msg = ' while creating a new item ' ; 
      $post_msg .= 'with the following id: ' . $perl_hash->{'id'} ; 
      $msg .= $post_msg ; 
      $self->res->code($ret);
      $self->render( 'json' => { 
         'msg'   => $msg
         ,'ret' => $ret
         ,'req'   => "POST " . $self->req->url->to_abs
      })
      ;
   }
}



1;

__END__

