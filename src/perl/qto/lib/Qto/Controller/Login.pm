package Qto::Controller::Login ;
use strict ; use warnings ; 

use Mojo::Base 'Mojolicious::Controller';
use Mojolicious::Sessions ;
use Data::Printer ; 

use Qto::App::Utils::Timer ; 
use Qto::App::IO::In::CnrPostPrms ; 
use Qto::App::Db::In::RdrDbsFcry ; 
use Qto::App::Cnvr::CnrDbName qw(toPlainName toEnvName);

our $config          = {} ;
our $objLogger       = {} ;
our $rdbms_type      = 'postgres';

#
# --------------------------------------------------------
# called after the users presses the login button
# --------------------------------------------------------
sub doLoginUser {

   my $self             = shift;
   my $db               = $self->stash('db');
   my $ret              = 1 ; 
   my $msg              = 'unknown error during global text search ';
   my $msg_color        = 'red' ;
   my $objRdrDbsFcry    = {} ; 
   my $objRdrDb         = {} ; 
   my $hsr              = {};
   my $http_code        = 400 ;
   my $rows_count       = 0 ; 
   my $msr2             = {}  ; 
   my $dat              = {}  ; 
   $config		 		   = $self->app->get('AppConfig');
   $objLogger           = 'Qto::App::Utils::Logger'->new( \$config );
   $db                  = toEnvName ( $db , $config) ;
	#print STDOUT "Logon.pm ::: url: " . $self->req->url->to_abs . "\n\n" if $module_trace == 1 ; 

   my $pass             = $self->param('pass');
   my $epass            = undef ; 
   my $email            = $self->param('email' );
   my $redirect_url     = $self->param('redirect-url' );
   $redirect_url        = '/' . $db . '/home' unless $redirect_url ;
   
   my $objModel         = 'Qto::App::Mdl::Model'->new ( \$config , $db) ;
   $objModel->set('postgres_db_name' , $db ) ; 
   $objLogger->doLogInfoMsg ( "login attempt for " . $self->setEmptyIfNull($email)) ; 

   my $objCnrPostPrms   = 'Qto::App::IO::In::CnrPostPrms'->new(\$config , \$objModel );
   ( $ret , $msg , $epass) = $objCnrPostPrms->doSetLoginUrlParams('Login' , $email , $pass );

   if ( $ret != 0 ) {
      $objLogger->doLogInfoMsg ( 'login failed for "' . $self->setEmptyIfNull($email) . '"') ; 
      $msg = 'login failed! ' . $msg ;
      $redirect_url = '/' . $db . '/login' ; 
      $self->doRenderPageTemplate($ret, $msg ,$msg_color,$db,$redirect_url);
      return ;
   } 

   $objRdrDbsFcry       = 'Qto::App::Db::In::RdrDbsFcry'->new(\$config, \$objModel );
	$objRdrDb            = $objRdrDbsFcry->doSpawn("$rdbms_type");
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


sub doShowLoginForm {

   my $self             = shift;
   my $db               = $self->stash('db');
   my $msg              = '' ; 
   my $msg_color        = 'grey' ; 
   
   $config		 		   = $self->app->get('AppConfig');
   my $alConfig         = $config->{'env'}->{'app'} ; 
   my $instance_domain  = $alConfig->{ 'web_host' } . $alConfig->{ 'port' } . '.' . $db ;
   my $proj             = toEnvName ( $db , $config) ;

   my $sessions = () ; 
   $sessions = Mojolicious::Sessions->new  ;
   $sessions->load($self);
   $sessions->cookie_name('qto.' . $db) unless $sessions->cookie_name ;
   $sessions->default_expiration(86400);
   $sessions->cookie_domain( $instance_domain) unless $sessions->cookie_domain( $instance_domain);
   my $redirect_url = $self->session( 'app.' . $db . '.url' ) if defined $self->session( 'app.' . $db . '.url' ) ; 
   $self->session( 'app.' . $db . '.user' => undef);
   $self->doRenderPageTemplate(200,$msg,$msg_color,$db,$redirect_url) ;
   return ;
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

   my $objTimer         = 'Qto::App::Utils::Timer'->new( $config->{'env'}->{'log'}->{ 'TimeFormat' } );
   my $page_load_time   = $objTimer->GetHumanReadableTime();

   $self->render(
      'template'        => $template 
    , 'msg'             => $msg
    , 'msg_color'       => $msg_color
    , 'db' 		         => $db
    , 'EnvType' 		   => $config->{'env'}->{'run'}->{'ENV_TYPE'}
    , 'ProductVersion' 	=> $config->{'env'}->{'run'}->{'VERSION'}
    , 'GitShortHash'    => $config->{'env'}->{'run'}->{'GitShortHash'}
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
