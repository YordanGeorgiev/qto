package Qto::Controller::MultiCreate ; 
use strict ; use warnings ; 

require Exporter; our @ISA = qw(Exporter Mojo::Base Qto::Controller::BaseController);
our $AUTOLOAD =();
use AutoLoader;
use parent qw(Qto::Controller::BaseController);

use Data::Printer ; 
use JSON;
use Carp qw /cluck confess shortmess croak carp/;

use Qto::App::Mdl::Model ;
use Qto::App::Db::Out::WtrDbsFcry;
use Qto::App::Cnvr::CnrHsr2ToArray ; 
use Qto::App::IO::In::CnrPostPrms ; 
use Qto::App::Cnvr::CnrDbName qw(toPlainName toEnvName);

our $module_trace   = 0 ;
our $config         = {};
our $rdbms_type     = 'postgre';

#
# --------------------------------------------------------
# create all the rows from db by passed db and table name
# --------------------------------------------------------
sub doMultiCreate {

   my $self             = shift;
   my $item             = $self->stash('item');
   my $db               = $self->stash('db');
   my $json             = $self->req->body;
   my $rdbms_type       = 'postgres';
   my $objCnrPostPrms   = {} ; 
   my $objWtrDbsFcry    = {} ; 
   my $objWtrDb         = {} ; 
   my $ret              = 0;
   my $msg              = 'unknown error during create item';
   my $hsr2             = {};
   my $arr_hashes       = decode_json($json);
   $config		         = $self->app->config ; 
   $db                  = toEnvName ( $db , $config) ;

   # p $arr_hashes ; 
   # print "arr_hashes \n\n";

   my $objModel         = 'Qto::App::Mdl::Model'->new ( \$config , $db , $item ) ; 
   $self->SUPER::doReloadProjDbMeta( \$objModel , $db , $item) ;

   $objWtrDbsFcry  = 'Qto::App::Db::Out::WtrDbsFcry'->new(\$config, \$objModel );
   $objWtrDb = $objWtrDbsFcry->doSpawn("$rdbms_type");
   ($ret, $msg) = $objWtrDb->doInsertJsonToTable($db,$item,$arr_hashes);

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

      my $post_msg = ' while loading json ' ; 
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

