package Qto::Controller::Logon ;
use strict ; use warnings ; 

require Exporter; our @ISA = qw(Exporter Mojo::Base Qto::Controller::BaseController);
our $AUTOLOAD=();
use AutoLoader;
use parent qw(Qto::Controller::BaseController);
use Qto::App::Cnvr::CnrDbName qw(toPlainName toEnvName);
use Qto::App::Mdl::Model ; 
use Qto::App::IO::In::CnrPostPrms ; 

use Data::Printer ; 
use JSON;

my $config           = {} ; 
my $objLogger        = {} ; 

sub doShowLogon {
   my $self = shift ; 
   my $http_code     = 200 ; 
   my $msg           = '' ; 
   my $http_method   = 'GET' ; 
   my $met           = '' ; 
   my $cnt           = 0 ; 
   my $dat           = '' ; 

   $self->SUPER::doRenderJSON($http_code,$msg,$http_method,$met,$cnt,$dat);
}


sub doLogonUser {
   my $self             = shift;
   my $db               = $self->stash('db');
   my $ret              = 1 ; 
   my $msg              = "$db logon";
   my $msg_color        = 'red' ;
   my $objRdrDbsFcry    = {} ; 
   my $objRdrDb         = {} ; 
   my $hsr              = {};
   my $http_code        = 400 ;
   my $met              = '' ; 
   my $http_method      = 'POST' ; 
   my $msr2             = {}  ; 
   my $dat              = '' ; 
   my $cnt              = 0 ; 

   $config		         = $self->app->config ; 
   $objLogger           = 'Qto::App::Utils::Logger'->new( \$config );
   $db                  = toEnvName ( $db , $config) ;
	#print STDOUT "Logon.pm ::: url: " . $self->req->url->to_abs . "\n\n" if $module_trace == 1 ; 
   
   my $json             = $self->req->body;
   my $perl_hash        = decode_json($json) ; 
   my $pass             = $perl_hash->{'pass'} ; 
   my $email            = $perl_hash->{'email'} ; 
   my $redirect_url     = $perl_hash->{'redirect-url'} or '/' . $db . '/search' ;

   my $objModel         = 'Qto::App::Mdl::Model'->new ( \$config , $db ) ;
   my $objCnrPostPrms   = 'Qto::App::IO::In::CnrPostPrms'->new(\$config , \$objModel );
   
   if ( $objCnrPostPrms->hasValidLogonParams($email , $pass , 'Logon') == 0) {
      $http_code = 400 ; 
      $msg = "login failed! " . $objCnrPostPrms->get('msg');
   } 

   $self->SUPER::doRenderJSON($http_code,$msg,$http_method,$met,$cnt,$dat);
}


1 ; 

__END__
