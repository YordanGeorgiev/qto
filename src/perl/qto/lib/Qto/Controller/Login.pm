package Qto::Controller::Login ;
use strict ; use warnings ; 

use Mojo::Base 'Mojolicious::Controller';
use Mojolicious::Sessions ;
use Data::Printer ; 
use Qto::App::Utils::Timer ; 
use Qto::App::IO::In::CnrPostPrms ; 
use Qto::App::Db::In::RdrDbsFactory ; 
use Qto::App::Cnvr::CnrDbName qw(toPlainName toEnvName);

our $appConfig      = {} ;
our $objLogger      = {} ;
our $rdbms_type     = 'postgres';

#
# --------------------------------------------------------
# Select all the rows from db by passed db and table name
# --------------------------------------------------------
sub doLoginUser {

   my $self             = shift;
   my $db               = $self->stash('db');
   my $ret              = 1 ; 
   my $msg              = 'unknown error during global text search ';
   my $msg_color        = 'red' ;
   my $objRdrDbsFactory = {} ; 
   my $objRdrDb         = {} ; 
   my $hsr              = {};
   my $http_code        = 400 ;
   my $rows_count       = 0 ; 
   my $msr2             = {}  ; 
   my $dat              = {}  ; 
   $appConfig		 		= $self->app->get('AppConfig');
   $objLogger           = 'Qto::App::Utils::Logger'->new( \$appConfig );
   $db                  = toEnvName ( $db , $appConfig) ;
	#print STDOUT "Logon.pm ::: url: " . $self->req->url->to_abs . "\n\n" if $module_trace == 1 ; 

   my $pass         = $self->param('pass');
   my $epass        = undef ; 
   my $email        = $self->param('email' );
   my $redirect_url = $self->param('redirect-url' );
   $redirect_url    = '/' . toPlainName ($db) . '/home' unless $redirect_url ;
   
   my $objModel     = 'Qto::App::Mdl::Model'->new ( \$appConfig , $db) ;
   $objModel->set('postgres_db_name' , $db ) ; 
   $objLogger->doLogInfoMsg ( "login attempt for " . $self->setEmptyIfNull($email)) ; 

   my $objCnrPostPrms = 
      'Qto::App::IO::In::CnrPostPrms'->new(\$appConfig , \$objModel );
   ( $ret , $msg , $epass) = $objCnrPostPrms->doSetLoginUrlParams('Login' , $email , $pass );

   if ( $ret != 0 ) {
      $objLogger->doLogInfoMsg ( 'login failed for "' . $self->setEmptyIfNull($email) . '"') ; 
      $self->doRenderPageTemplate($ret , 'login failed! ' . $msg , $msg_color,$db,$redirect_url);
      return ;
   } 

   $objRdrDbsFactory = 'Qto::App::Db::In::RdrDbsFactory'->new(\$appConfig, \$objModel );
	$objRdrDb = $objRdrDbsFactory->doSpawn("$rdbms_type");
   ($http_code, $msg , $hsr ) = $objRdrDb->doNativeLogonAuth($email,$epass);
   if ( $http_code == 200 ) {
      my $objCnrEncrypter  = 'Qto::App::IO::In::CnrEncrypter'->new();
      foreach my $key ( keys %$hsr ) {
         my $dbepass = $hsr->{$key}->{ 'password' } ; 
         unless ( $objCnrEncrypter->match_passphrase_against_crypto_hash($dbepass,$pass) == 1 ) {
           $http_code = 401 ; 
           $msg = "wrong password for $email" ;
         } else {
           $objLogger->doLogInfoMsg ( "login ok for $email") ; 
           $self->session( 'app.' . $db . '.user' => $email);
           $self->redirect_to( $redirect_url);
           return ;
         }
      }
   } else {
      $http_code = 401 ; 
      $objLogger->doLogErrorMsg ( "login failed for $email") ; 
   }
   $self->doRenderPageTemplate($http_code,$msg,$msg_color,$db,$redirect_url);
}
#eof sub doLoginUser


sub doShowLoginForm {

   my $self             = shift;
   my $db               = $self->stash('db');
   my $msg              = undef ; 
   my $msg_color        = 'grey' ; 
   
   $db                  = toEnvName ( $db , $appConfig) ;
   $appConfig		 		= $self->app->get('AppConfig');

   my $redirect_url = $self->session( 'app.' . $db . '.url' ) if defined $self->session( 'app.' . $db . '.url' ) ; 
   #$self->session(expires => 1);
   my $session = Mojolicious::Sessions->new ;
   $session->cookie_name('qto.' . $db);
   $session->default_expiration(86400);
   my $instance_domain = $appConfig->{ 'web_host' } . ':' . $appConfig->{ 'mojo_hypnotoad_port' } . '.' . $db ;
   $session  = $session->cookie_domain( $instance_domain);

   $self->doRenderPageTemplate(200,$msg,$msg_color,$db,$redirect_url) ;
   return
}


sub doRenderPageTemplate {
   
   my $self             = shift ; 
   my $http_code        = shift ; 
   my $msg              = shift ;
   my $msg_color        = shift || 'red' ;
   my $db               = shift ; 
   my $redirect_url     = shift ; 

   my $notice           = '' ;

   $msg = "$db login" unless $msg ; 
   $msg = $self->session( 'app.' , $db . '.msg' ) if defined $self->session( 'app.' . $db . '.msg' ) ;

   $self->res->code($http_code) ; 

   my $template_name    = 'login' ; 
   my $template         = 'pages/' . $template_name . '/' . $template_name ; 

   my $objTimer         = 'Qto::App::Utils::Timer'->new( $appConfig->{ 'TimeFormat' } );
   my $page_load_time   = $objTimer->GetHumanReadableTime();

   $self->render(
      'template'        => $template 
    , 'msg'             => $msg
    , 'msg_color'       => $msg_color
    , 'db' 		         => $db
    , 'ProductType' 		=> $appConfig->{'ProductType'}
    , 'ProductVersion' 	=> $appConfig->{'ProductVersion'}
    , 'GitShortHash'    => $appConfig->{'GitShortHash'}
    , 'page_load_time'  => $page_load_time
    , 'notice'          => $notice
    , 'redirect_url'    => $redirect_url
	) ; 

   return ; 
}


sub doRender {
   my $self       = shift ; 
   my $http_code  = shift ; 
   my $msg        = shift ; 

   $self->res->headers->content_type('application/json; charset=utf-8');
   $self->res->code($http_code);
   $self->render( 'json' =>  { 
         'ret'   => $http_code
        ,'msg'   => $msg
   });

}


sub setEmptyIfNull {
   my $self = shift ; 
   my $word = shift ; 
   $word = '' unless defined $word ; 
   return $word ; 
}



1;

__END__

