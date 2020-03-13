package Qto::Controller::Truncate ; 

use strict ; use warnings ; 
require Exporter; our @ISA = qw(Exporter Mojo::Base Qto::Controller::BaseController);
our $AUTOLOAD =();
use AutoLoader;
use parent qw(Qto::Controller::BaseController);

use Data::Printer ; 
use Data::Dumper; 
use JSON;

use Qto::App::Db::Out::WtrDbsFcry;
use Qto::App::Cnvr::CnrHsr2ToArray ; 
use Qto::App::IO::In::CnrPostPrms ; 
use Qto::App::Cnvr::CnrDbName qw(toPlainName toEnvName);
use Qto::App::Mdl::Model ;

our $module_trace   = 0 ;
our $config         = {};
our $rdbms_type     = 'postgre';


# --------------------------------------------------------
# Truncate all the rows from db by passed db and table name
# --------------------------------------------------------
sub doTruncateItem {


   my $self             = shift;
   my $item             = $self->stash('item');
   my $db               = $self->stash('db');
   my $objCnrPostPrms   = {} ; 
   my $objWtrDbsFcry    = {} ; 
   my $objWtrDb         = {} ; 
   my $ret              = 0;
   my $msg              = 'unknown error during Truncate item';
   my $hsr2             = {};
   $config		         = $self->app->config ; 
   $db                  = toEnvName ( $db , $config ) ;

   my $objModel         = 'Qto::App::Mdl::Model'->new ( \$config , $db , $item ) ; 
   $self->SUPER::doReloadProjDbMeta( \$objModel , $db , $item) ;

   $objCnrPostPrms      = 'Qto::App::IO::In::CnrPostPrms'->new(\$config , \$objModel );
   $objWtrDbsFcry       = 'Qto::App::Db::Out::WtrDbsFcry'->new(\$config, \$objModel );
   $objWtrDb            = $objWtrDbsFcry->doSpawn("$rdbms_type");
   ($ret, $msg)         = $objWtrDb->doTruncateTable(\$objModel, $db , $item);

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
