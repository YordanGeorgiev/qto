package Qto::Controller::BaseController ; 
use strict ; use warnings ; 

use Mojo::Base 'Mojolicious::Controller';
use Mojolicious::Sessions; 
use Data::Printer ; 

our $module_trace    = 0 ; 
our $config          = {};
our $objLogger       = {} ;
our $rdbms_type      = 'postgres' ; 

use Qto::App::Mdl::Model ; 
use Qto::App::Db::In::RdrDbsFcry ; 
use Qto::App::Cnvr::CnrHsr2ToHsr2 ; 
use Qto::App::Cnvr::CnrDbName qw(toPlainName toEnvName);


sub doReloadProjDbMeta {

   my $self                = shift ;
   my $db                  = shift ;
   my $item                = shift || '' ; 

   $config		 		   = $self->app->get('AppConfig');
   $db = toEnvName ( $db , $config ) ;

   # reload the columns meta data ONLY after the meta_columns has been requested
   #return if ( exists ( $config->{ $db . '.meta' } ) && $item ne 'meta_columns' ); 
   if ( defined ( $config->{ $db . '.meta' } ) ) {
      if ( $item ne 'meta_columns' ) {
         return ; 
      }
   }

   my $objRdrDbsFcry       = {} ; 
   my $objRdrDb            = {} ; 
   my $msr2                = {} ; 
   my $ret                 = 1 ; 
   my $msg                 = "fatal error while reloading project database meta data " ; 
   my $objModel            = {} ; 

   $objModel               = 'Qto::App::Mdl::Model'->new ( \$config ) ;
   $objModel->set('postgres_db_name' , $db ) ; 
    
   $objRdrDbsFcry       = 'Qto::App::Db::In::RdrDbsFcry'->new( \$config, \$objModel );
   $objRdrDb               = $objRdrDbsFcry->doSpawn( $rdbms_type );
   ($ret, $msg , $msr2 )   = $objRdrDb->doLoadProjDbMeta( $db ) ; 

   $config->{ "$db" . '.meta' } = $msr2 ; # chk: it-181101180808
   $self->app->set('AppConfig', $config );
   $self->render('text' => $msg ) unless $ret == 0 ; 
}


sub isAuthenticated {

   my $self                = shift ;
   my $db                  = shift ;

   $config		 		      = $self->app->get('AppConfig');
   $db                     = toEnvName ( $db , $config ) ;

   # non-authentication mode IF the app has been stared with this env var
   return 1 if $ENV{'QTO_ONGOING_TEST'}; # no authentication when testing if desired so !!!

   # basic native authentication mode if NOT started with this env var
   unless ( defined ( $self->session( 'app.' . $db . '.user')) ) {
      my $url = '/' . toPlainName($db) . '/login' ;
      $self->session( 'app.' . $db . '.msg' => 'please login to ' . $db);
      $self->session( 'app.' . $db . '.url' => $self->req->url->to_abs );
      $self->redirect_to( $url );
      return 0 ;
   } else {
      return 1 
   }

}


# 
# call-by : $self->SUPER::doRenderJSON($http_code,$msg,$http_method,$met,$cnt,$dat);
#
sub doRenderJSON {

   my $self          = shift ; 
   my $http_code     = shift ; 
   my $msg           = shift ; 
   my $http_method   = shift || 'GET' ; 
   my $met           = shift ; # the meta data
   my $cnt           = shift ; # the count of the data
   my $dat           = shift ; # the data 
   my $req           = "$http_method " . $self->req->url->to_abs ; 

   unless ( $cnt ) {
      $cnt              = @{$dat} if ( $dat ); 
   }

   $self->res->headers->content_type('application/json; charset=utf-8');
   $self->res->code($http_code);
   $self->render( 'json' =>  { 
        'ret'   => $http_code
      , 'msg'   => $msg
      , 'req'   => $req
      , 'met'   => $met
      , 'cnt'   => $cnt
      , 'dat'   => $dat
   });
}

1;

__END__

