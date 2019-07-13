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

use Qto::App::Db::Out::WtrDbsFcry;
use Qto::App::Cnvr::CnrHsr2ToArray ; 
use Qto::App::IO::In::CnrPostPrms ; 
use Qto::App::Cnvr::CnrDbName qw(toPlainName toEnvName);

our $module_trace   = 0 ;
our $appConfig      = {};
our $rdbms_type     = 'postgre';


# --------------------------------------------------------
# Update all the rows from db by passed db and table name
# --------------------------------------------------------
sub doUpdateById {

   my $self             = shift;
   my $item             = $self->stash('item');
   my $db               = $self->stash('db');
   my $rdbms_type       = 'postgres';
   my $objCnrPostPrms  = {} ; 
   my $objWtrDbsFcry = {} ; 
   my $objWtrDb         = {} ; 
   my $ret              = 0;
   my $msg              = 'unknown error during Update item';
   my $hsr2             = {};

   my $json             = $self->req->body;
   my $perl_hash        = decode_json($json) ; 

   $appConfig		      = $self->app->get('AppConfig');
   $db                  = toEnvName ( $db , $appConfig) ;
   my $objModel         = 'Qto::App::Mdl::Model'->new ( \$appConfig , $db , $item ) ;
   $objModel->set('postgres_db_name' , $db ) ; 
   
   return unless ( $self->SUPER::isAuthenticated($db) == 1 );
   $self->SUPER::doReloadProjDbMeta( $db,$item ) ;
   
   $objCnrPostPrms = 
      'Qto::App::IO::In::CnrPostPrms'->new(\$appConfig , \$objModel );
   
   unless ( $objCnrPostPrms->doValidateAndSetUpdate ( $perl_hash , $item ) == 1 ) {
      my $http_code = $objCnrPostPrms->get('http_code') ; 
      $self->res->code($http_code);
      $self->render( 'json' =>  { 
           'msg'   => $objCnrPostPrms->get('msg')
         , 'ret'   => $http_code
         , 'req'   => "POST " . $self->req->url->to_abs
      });
      return ; 
   } 


   $objWtrDbsFcry
      = 'Qto::App::Db::Out::WtrDbsFcry'->new(\$appConfig, \$objModel );
   $objWtrDb = $objWtrDbsFcry->doSpawn("$rdbms_type");
   ($ret, $msg) = $objWtrDb->doUpdateItemBySingleColToDb(\$objModel, $item);

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
