package Qto::Controller::BaseController ; 
use strict ; use warnings ; 

use Mojo::Base 'Mojolicious::Controller';
use Mojolicious::Sessions; 
use Data::Printer ; 
use Carp qw /croak carp/ ;

our $module_trace    = 0 ; 
our $config          = {};
our $objLogger       = {} ;
our $rdbms_type      = 'postgres' ; 

use Qto::App::Mdl::Model ; 
use Qto::App::Db::In::RdrDbsFcry ; 
use Qto::App::Cnvr::CnrHsr2ToHsr2 ; 
use Qto::App::Cnvr::CnrDbName qw(toPlainName toEnvName);
use Qto::App::UI::WtrUIFactory ;
use Qto::Controller::MetaDataController;


sub doReloadProjDbMeta {

   my $self                = shift ;
	my $objModel            = ${ shift @_ } || croak 'objModel not passed !!!' ; 
   my $db                  = shift ;
   my $item                = shift || '' ; 

   $config		 		      = $self->app->config ;
   $db                     = toEnvName ( $db , $config ) ;

   my $objMetaDataController = 'Qto::Controller::MetaDataController'->new(\$config, \$objModel);
   $objMetaDataController->doReloadProjDbMetaData($db,$item);
   return;
}


sub isAuthenticated {

   my $self                = shift ;
   my $db                  = shift ;

   $config		            = $self->app->config ; 
   $db                     = toEnvName ( $db , $config ) ;

   # non-authentication mode IF the app has been stared with this env var
   return 1 if $ENV{'QTO_NO_AUTH'}; # no authentication when testing if desired so !!!

   # basic native authentication mode if NOT started with this env var
   unless ( defined ( $self->session( 'app.' . $db . '.user')) ) {
      my $url = '/' . toPlainName($db) . '/login' ;
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
   my $ret           = shift || $http_code ; 
   my $req           = "$http_method " . $self->req->url->to_abs ; 

   unless ( $cnt ) {
      $cnt              = @{$dat} if ( $dat ); 
   }

   $self->res->headers->content_type('application/json; charset=utf-8');
   $self->res->code($http_code);
   $self->render( 'json' =>  { 
        'ret'   => $ret
      , 'msg'   => $msg
      , 'req'   => $req
      , 'met'   => $met
      , 'cnt'   => $cnt
      , 'dat'   => $dat
   });
}

1;

__END__

=head1 NAME

BaseController

=head1 SYNOPSIS

require Exporter;
our @ISA = qw(Exporter Mojo::Base Qto::Controller::BaseController);
our $AUTOLOAD =();
our $ModuleDebug = 0 ; 
use AutoLoader;

use parent qw(Qto::Controller::BaseController);


=head1 DESCRIPTION
the parent for all Qto application controllers

=head2 EXPORT


=head1 SEE ALSO


Qto::Controller::BaseController ; 
https://mojolicious.org/perldoc/Mojolicious/Controller


=head1 AUTHOR

yordan.georgiev@gmail.com

=head1 




=cut 

