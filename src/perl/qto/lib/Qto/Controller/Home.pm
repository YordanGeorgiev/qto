package Qto::Controller::Home ;
use strict ; use warnings ; 

require Exporter;
our @ISA = qw(Exporter Mojo::Base Qto::Controller::BaseController);
our $AUTOLOAD =();
our $ModuleDebug = 0 ; 
use AutoLoader;

use parent qw(Qto::Controller::BaseController);
use Data::Printer ; 

use Qto::App::Utils::Timer ; 
use Qto::App::IO::In::CnrPostPrms ; 
use Qto::App::Db::In::RdrDbsFcry ; 
use Qto::App::Cnvr::CnrDbName qw(toPlainName toEnvName);

our $config      = {} ;
our $objLogger      = {} ;
our $rdbms_type     = 'postgres';

#
# --------------------------------------------------------
# Select all the rows from db by passed db and table name
# --------------------------------------------------------
sub doLanding {

   my $self             = shift;
   my $db               = $self->stash('db');
   my $ret              = 1 ; 
   my $msg              = '' ;
   my $rows_count       = 0 ; 
   my $dat              = {}  ; 
   
   $config		 		= $self->app->get('AppConfig');
   $db                  = toEnvName ( $db , $config) ;
   return unless ( $self->SUPER::isAuthenticated($db) == 1 );
   $self->SUPER::doReloadProjDbMeta( $db, 'home' ) ;
   
   my $http_code        = 200  ; 

   $self->doRenderPageTemplate($http_code,$msg,$db);
}



sub doRenderPageTemplate {
   
   my $self             = shift ; 
   my $http_code        = shift ; 
   my $msg              = shift ;
   my $db               = shift ; 
   my $notice           = '' ;

   $msg = "$db home" unless $msg ; 
   $self->res->code($http_code) ; 

   my $template_name    = 'home' ; 
   my $template         = 'pages/' . $template_name . '/' . $template_name ; 

   my $objTimer         = 'Qto::App::Utils::Timer'->new( $config->{'env'}->{'log'}->{ 'TimeFormat' } );
   my $page_load_time   = $objTimer->GetHumanReadableTime();

   $self->render(
      'template'        => $template 
    , 'msg'             => $msg
    , 'db' 		         => $db
    , 'WsProtocol' 	   => $config->{'env'}->{'app'}->{'ws_protocol'}
    , 'EnvType' 		   => $config->{'env'}->{'run'}->{'ENV_TYPE'}
    , 'ProductVersion' 	=> $config->{'env'}->{'run'}->{'VERSION'} 
    , 'GitShortHash'    => $config->{'env'}->{'run'}->{'GitShortHash'}
    , 'page_load_time'  => $page_load_time
    , 'notice'          => $notice
	) ; 

   return ; 
}

sub setEmptyIfNull {
   my $self = shift ; 
   my $word = shift ; 
   $word = '' unless defined $word ; 
   return $word ; 
}


1;

__END__

