package Qto::Controller::Truncate ; 

use strict ; use warnings ; 
require Exporter; our @ISA = qw(Exporter Mojo::Base Qto::Controller::BaseController);
our $AUTOLOAD =();
use AutoLoader;
use parent qw(Qto::Controller::BaseController);

use Data::Printer ; 
use Data::Dumper; 
use JSON;

use Qto::App::Db::Out::WtrDbsFactory;
use Qto::App::Utils::Logger;
use Qto::App::Cnvr::CnrHsr2ToArray ; 
use Qto::App::IO::In::CnrPostPrms ; 
use Qto::App::Cnvr::CnrDbName qw(toPlainName toEnvName);

our $module_trace   = 0 ;
our $appConfig      = {};
our $objLogger      = {} ;
our $rdbms_type     = 'postgre';


# --------------------------------------------------------
# Truncate all the rows from db by passed db and table name
# --------------------------------------------------------
sub doTruncateItem {


   my $self             = shift;
   my $item             = $self->stash('item');
   my $db               = $self->stash('db');
   my $objCnrPostPrms   = {} ; 
   my $objWtrDbsFactory = {} ; 
   my $objWtrDb         = {} ; 
   my $ret              = 0;
   my $msg              = 'unknown error during Truncate item';
   my $hsr2             = {};
  
   $appConfig		      = $self->app->get('AppConfig');
   $db                  = toEnvName ( $db , $appConfig);
   
   return unless ( $self->SUPER::isAuthenticated($db) == 1 );
   $self->SUPER::doReloadProjDbMeta( $db ) ;

   my $objModel         = 'Qto::App::Mdl::Model'->new ( \$appConfig , $db , $item ) ;
   $objCnrPostPrms      = 'Qto::App::IO::In::CnrPostPrms'->new(\$appConfig , \$objModel );
   $objWtrDbsFactory    = 'Qto::App::Db::Out::WtrDbsFactory'->new(\$appConfig, \$objModel );
   $objWtrDb            = $objWtrDbsFactory->doSpawn("$rdbms_type");
   ($ret, $msg)         = $objWtrDb->doTruncateTable(\$objModel, $db , $item);

   $self->res->headers->accept_charset('UTF-8');
   $self->res->headers->accept_language('fi, en');
   $self->res->headers->content_type('application/json; charset=utf-8');

   if ( $ret == 0 ) {
      my $http_code = 200 ; 
      my $rows_count = 0 ; 
      $msg = "Truncate OK for table: $item" ; 

      $self->res->code($http_code);
      $self->render( 'json' =>  { 
           'msg'   => $msg
         , 'ret'   => $http_code
         , 'dat'   => {}
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
   } else {
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
