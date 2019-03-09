package Qto::Controller::Update ; 
use strict ; use warnings ; 

require Exporter;
our @ISA = qw(Exporter Mojo::Base Qto::Controller::BaseController);
our $AUTOLOAD =();
our $ModuleDebug = 0 ; 
use AutoLoader;

use parent qw(Qto::Controller::BaseController);

use Data::Printer ; 
use Data::Dumper; 
use Scalar::Util qw /looks_like_number/;
use JSON;

use Qto::App::Db::Out::WtrDbsFactory;
use Qto::App::Utils::Logger;
use Qto::App::Cnvr::CnrHsr2ToArray ; 
use Qto::App::IO::In::CnrUrlPrms ; 

our $module_trace   = 0 ;
our $appConfig      = {};
our $objLogger      = {} ;
our $rdbms_type     = 'postgre';


# --------------------------------------------------------
# Update all the rows from db by passed db and table name
# --------------------------------------------------------
sub doUpdateItemBySingleCol {

   my $self             = shift;
   my $item             = $self->stash('item');
   my $db               = $self->stash('db');
   my $rdbms_type       = 'postgres';
   my $objCnrUrlPrms  = {} ; 
   my $objWtrDbsFactory = {} ; 
   my $objWtrDb         = {} ; 
   my $ret              = 0;
   my $msg              = 'unknown error during Update item';
   my $hsr2             = {};

   my $json             = $self->req->body;
   my $perl_hash        = decode_json($json) ; 

   $appConfig		      = $self->app->get('AppConfig');
   my $objModel         = 'Qto::App::Mdl::Model'->new ( \$appConfig , $db , $item ) ;
   $objModel->set('postgres_db_name' , $db ) ; 
   
   return unless ( $self->SUPER::isAuthorized($db) == 1 );
   $self->SUPER::doReloadProjDbMeta( $db ) ;
   
   $objCnrUrlPrms = 
      'Qto::App::IO::In::CnrUrlPrms'->new(\$appConfig , \$objModel , $self->req->query_params);
   
   unless ( $objCnrUrlPrms->doValidateAndSetUpdate ( $perl_hash ) == 1 ) {
      my $http_code = $objCnrUrlPrms->get('http_code') ; 
      $self->res->code($http_code);
      $self->render( 'json' =>  { 
           'msg'   => $objCnrUrlPrms->get('msg')
         , 'ret'   => $http_code
         , 'req'   => "POST " . $self->req->url->to_abs
      });
      return ; 
   } 

   $objWtrDbsFactory
      = 'Qto::App::Db::Out::WtrDbsFactory'->new(\$appConfig, \$objModel );
   $objWtrDb = $objWtrDbsFactory->doSpawn("$rdbms_type");
   ($ret, $msg) = $objWtrDb->doUpdateItemBySingleCol(\$objModel, $item);

   $self->res->headers->accept_charset('UTF-8');
   $self->res->headers->accept_language('fi, en');
   $self->res->headers->content_type('application/json; charset=utf-8');

   

   if ( $ret == 0 ) {
      my $http_code = 200 ; 
      my $rows_count = 0 ; 
      $msg = '' ; 

      $self->res->code($http_code);
      $self->render( 'json' =>  { 
           'msg'   => $msg
         , 'ret'   => $http_code
         , 'req'   => "POST " . $self->req->url->to_abs
      });
   } elsif ( $ret == 400 ) {
      $msg = 'update failed :: ' . $msg ; 
      $self->res->code(400);
      $self->render( 'json' =>  { 
           'msg'   => $msg
         , 'ret'   => 400
         , 'req'   => "POST " . $self->req->url->to_abs
      });
   } elsif ( $ret == 2 ) {

      $msg = 'update failed :: ' . $msg ; 
      $self->res->code(400);
      $self->render( 'json' =>  { 
          'msg'   => $msg
         ,'ret'   => 400
         ,'req'   => "POST " . $self->req->url->to_abs
      });
   } else {

      my $post_msg = ' while updating the "' . $perl_hash->{'attribute'} . '" attribute value ' ; 
      $post_msg .= 'for the following id: ' . $perl_hash->{'id'} ; 
      $msg .= $post_msg ; 
      $msg = ' the update failed ! :: ' . $msg ; 
      $self->res->code(400);
      $self->render( 'json' => { 
         'msg'   => $msg
         ,'ret' => 404
         ,'req'   => "POST " . $self->req->url->to_abs
      })
      ;
   }
}



1;

__END__

# feature-guid: 
