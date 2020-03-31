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
# called after the users get only the login page
# --------------------------------------------------------
sub doInitShowLoginUI {

   my $self             = shift;
   my $db               = $self->stash('db');
   my $msg_color        = 'grey' ; 
   my $pdb              = toPlainName($db);
   my $msg              = "$pdb   login"; 
   
   my $config		      = $self->app->config ; 
   my $alConfig         = $config->{'env'}->{'app'} ; 
   my $instance_domain  = $alConfig->{ 'web_host' } . $alConfig->{ 'port' } . '.' . $db ;
   my $proj             = toEnvName ( $db , $config) ;
   $db                  = toEnvName ( $db , $config) ;

   my $sessions = () ; 
   $sessions            = Mojolicious::Sessions->new  ;
   $sessions->load($self);
   my $redirect_url     = '/' . $pdb . '/search' ;
   # store the url to redirect to ... to give it to the form
   $redirect_url = $self->session( 'app.' . $db . '.url' ) 
      if (defined $self->session( 'app.' . $db . '.url' ));
   $sessions->cookie_name('qto.' . $db) unless $sessions->cookie_name ;
   $sessions->default_expiration(86400);
   $sessions            = $sessions->secure(0);
   $sessions            = $sessions->samesite('Strict');
   $sessions->cookie_domain( $instance_domain) unless $sessions->cookie_domain( $instance_domain);
   $self->session( 'app.' . $db . '.user' => undef);
   $self->session($sessions);

   $self->doRenderPageTemplate(200,$msg,$msg_color,$proj,$redirect_url) ;
   return ;
}


#
# --------------------------------------------------------
# called after the users presses the login button
# --------------------------------------------------------
sub doLoginUser {

   my $self             = shift;
   my $db               = $self->stash('db');
   my $ret              = 1 ; 
   my $msg              = "$db login";
   my $msg_color        = 'red' ;
   my $objRdrDbsFcry    = {} ; 
   my $objRdrDb         = {} ; 
   my $hsr              = {};
   my $http_code        = 400 ;
   my $rows_count       = 0 ; 
   my $msr2             = {}  ; 
   my $dat              = {}  ; 

   $config		         = $self->app->config ; 
   $objLogger           = 'Qto::App::Utils::Logger'->new( \$config );


   $db                  = toEnvName ( $db , $config) ;
   my $pdb              = toPlainName($db);
	#print STDOUT "Logon.pm ::: url: " . $self->req->url->to_abs . "\n\n" if $module_trace == 1 ; 

   my $pass             = $self->param('pass');
   my $email            = $self->param('email' );
   my $redirect_url     = $self->param('redirect-url' );
   $redirect_url        = '/' . $pdb . '/search' unless $redirect_url ;
   
   my $objModel         = 'Qto::App::Mdl::Model'->new ( \$config , $db , 'login') ;
   $objModel->set('postgres_db_name' , $db ) ; 
   $objLogger->doLogInfoMsg ( "login attempt for " . $self->setEmptyIfNull($email)) ; 

   my $objCnrPostPrms   = 'Qto::App::IO::In::CnrPostPrms'->new(\$config , \$objModel );
   ($ret, $msg) = $objCnrPostPrms->doValidateLoginParams('Login' , $email , $pass );

   if ( $ret != 0 ) {
      $objLogger->doLogInfoMsg ( 'login failed for "' . $self->setEmptyIfNull($email) . '"') ; 
      $msg = 'login failed! ' . $msg ;
      $redirect_url = '/' . $pdb . '/login' ; 
      $self->doRenderPageTemplate($ret, $msg ,$msg_color,$db,$redirect_url);
      return ;
   } 

   $objRdrDbsFcry       = 'Qto::App::Db::In::RdrDbsFcry'->new(\$config, \$objModel );
	$objRdrDb            = $objRdrDbsFcry->doSpawn("$rdbms_type");
   ($http_code, $msg , $hsr ) = $objRdrDb->doNativeLoginAuth($db,$email);

   if ( $http_code == 200 ) {
      my $objCnrEncrypter  = 'Qto::App::IO::In::CnrEncrypter'->new();
      foreach my $key ( keys %$hsr ) {
         my $dbepass = $hsr->{$key}->{ 'password' } ; 
         unless ( $objCnrEncrypter->match_passphrase_against_crypto_hash($dbepass,$pass)  ) {
           $http_code = 401 ; 
           $msg = "wrong password for $email" ;
         } else {
           $objLogger->doLogInfoMsg ( "login ok for $email") ; 
           $self->session( 'app.' . $db . '.user' => $email);
           if (defined $self->session( 'app.' . $db . '.url' )) {
               $redirect_url = $self->session( 'app.' . $db . '.url' );
               $self->session( 'app.' . $db . '.url' => undef);
           }
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


# $self->doRenderPageTemplate($ret, $msg ,$msg_color,$db,$redirect_url);
sub doRenderPageTemplate {
   
   my $self             = shift ; 
   my $http_code        = shift ; 
   my $msg              = shift ;
   my $msg_color        = shift || 'red' ;
   my $db               = shift ; 
   my $redirect_url     = shift ; 
   my $notice           = '' ;

   $config		         = $self->app->config ; 
   my $pdb              = toPlainName($db);
   $msg = "$pdb login" unless $msg ; 

   $self->res->code($http_code) ; 

   my $template_name    = 'login' ; 
   my $template         = 'pages/' . $template_name . '/' . $template_name ; 
   my $objTimer         = 'Qto::App::Utils::Timer'->new( $config->{'env'}->{'log'}->{ 'TimeFormat' } );
   my $page_load_time   = $objTimer->GetHumanReadableTime();
   my $ProductVersion   = $config->{'env'}->{'run'}->{'VERSION'} ;

   $self->render(
      'template'        => $template 
    , 'msg'             => $msg
    , 'msg_color'       => $msg_color
    , 'db' 		         => $pdb
    , 'EnvType' 		   => $config->{'env'}->{'run'}->{'ENV_TYPE'}
    , 'ProductVersion' 	=> $ProductVersion
    , 'GitShortHash'    => $config->{'env'}->{'run'}->{'GitShortHash'}
    , 'page_load_time'  => $page_load_time
    , 'notice'          => $notice
    , 'redirect_url'    => $redirect_url
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
