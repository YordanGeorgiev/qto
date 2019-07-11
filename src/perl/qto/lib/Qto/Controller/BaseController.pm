package Qto::Controller::BaseController ; 
use strict ; use warnings ; 

use Mojo::Base 'Mojolicious::Controller';
use Mojolicious::Sessions; 
use Data::Printer ; 

our $module_trace    = 0 ; 
our $appConfig       = {};
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

   $appConfig		 		   = $self->app->get('AppConfig');
   $db = toEnvName ( $db , $appConfig ) ;

   # reload the columns meta data ONLY after the meta_columns has been requested
   return if ( exists ( $appConfig->{ $db . '.meta' } ) && $item ne 'meta_columns' ); 

   my $objRdrDbsFcry    = {} ; 
   my $objRdrDb            = {} ; 
   my $msr2                = {} ; 
   my $ret                 = 1 ; 
   my $msg                 = "fatal error while reloading project database meta data " ; 
   my $objModel            = {} ; 

   $objModel               = 'Qto::App::Mdl::Model'->new ( \$appConfig ) ;
   $objModel->set('postgres_db_name' , $db ) ; 
    
   $objRdrDbsFcry       = 'Qto::App::Db::In::RdrDbsFcry'->new( \$appConfig, \$objModel );
   $objRdrDb               = $objRdrDbsFcry->doSpawn( $rdbms_type );
   ($ret, $msg , $msr2 )   = $objRdrDb->doLoadProjDbMeta( $db ) ; 

   $appConfig->{ "$db" . '.meta' } = $msr2 ; # chk: it-181101180808
   $self->app->set('AppConfig', $appConfig );
   $self->render('text' => $msg ) unless $ret == 0 ; 
}


sub isAuthenticated {

   my $self                = shift ;
   my $db                  = shift ;

   $appConfig		 		   = $self->app->get('AppConfig');
   $db                     = toEnvName ( $db , $appConfig ) ;

   return 1 if $ENV{'QTO_ONGOING_TEST'}; # no authentication when testing if desired so !!!

   unless ( defined ( $self->session( 'app.' . $db . '.user')) ) {
      my $url = '/' . $db . '/login' ;
      $self->session( 'app.' . $db . '.msg' => 'please login first into ' . $db);
      $self->session( 'app.' . $db . '.url' => $self->req->url->to_abs );
      $self->redirect_to( $url );
      return 0 ;
   }

   my $htpasswd_file = $appConfig->{ 'ProductInstanceDir'} . '/cnf/sec/passwd/' . $db . '.htpasswd' ;
   return 1 unless -f $htpasswd_file ;  # open by default !!! ( temporary till v0.5 if desired so !!!
   return 1 if $self->basic_auth(
      $db => {
         'path' => $htpasswd_file
      }
   );

   $self->render('text' => 'Refresh your page to login ');
   return 0  ;

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

