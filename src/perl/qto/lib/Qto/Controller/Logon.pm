package Qto::Controller::Logon ;
use strict ; use warnings ; 

require Exporter; our @ISA = qw(Exporter Mojo::Base Qto::Controller::BaseController);
our $AUTOLOAD=();
use AutoLoader;
use parent qw(Qto::Controller::BaseController);

use Data::Printer ; 
use JSON;

use Qto::App::Cnvr::CnrDbName qw(toPlainName toEnvName);
use Qto::App::Mdl::Model ; 
use Qto::App::IO::In::CnrPostPrms ; 
use Qto::App::Sec::Guardian ;

my $config           = {} ; 
my $objLogger        = {} ; 
my $rdbms_type       = 'postgres' ; 


# called when the login button is clicked aka on form and not json post
sub doLogonUser {

   my $self             = shift;
   my $db               = $self->stash('db');
   my $ret              = 1 ; 
   my $msg_color        = 'red' ;
   my $hsr              = {};
   my $rv               = 400 ;
   my $met              = '' ; 
   my $http_method      = 'POST' ; 
   my $msr2             = {}  ; 
   my $dat              = '' ; 
   my $cnt              = 0 ; 

   $config		         = $self->app->config ; 
   $objLogger           = 'Qto::App::Utils::Logger'->new( \$config );
   $db                  = toEnvName ( $db , $config) ;
   my $msg              = "$db logon";
   my $pdb              = toPlainName( $db ) ;
	#print STDOUT "Logon.pm ::: url: " . $self->req->url->to_abs . "\n\n" if $module_trace == 1 ; 
   
   my $post_params      = $self->req->body_params->to_hash;
   # p $post_params ; print "eof post_params \n";
   my $pass             = $post_params->{'pass'} ; # this is the pass from the UI !!!
   my $email            = $post_params->{'email'} ; 
   my $redirect_url     = $post_params->{'redirect-url'} or '/' . $db . '/search' ;
   $redirect_url = $self->session( 'app.' . $db . '.redirect-url' ) 
         if defined $self->session( 'app.' . $db . '.redirect-url' ) ; 
   my $objModel         = 'Qto::App::Mdl::Model'->new ( \$config , $db , 'app_users') ;
   my $objCnrPostPrms   = 'Qto::App::IO::In::CnrPostPrms'->new(\$config , \$objModel );
 
   $msg .= " attempt for $email ";
   $objLogger->doLogInfoMsg ( $msg );

   unless ( $objCnrPostPrms->hasValidLogonParams(\$msg , $email , $pass , 'Logon') ) {
      $rv = 400 ; 
      $msg = "logon failed! " . $msg ; 
      $objLogger->doLogErrorMsg ( $msg );
      $redirect_url = '/' . $pdb . '/logon' ; 
      $self->doRenderPageTemplate($rv, $msg ,$msg_color,$db,$redirect_url);
      return ;
   } else {

      my $objGuardian      = 'Qto::App::Sec::Guardian'->new ( \$config ) ;
      my $objRdrDbsFcry    = 'Qto::App::Db::In::RdrDbsFcry'->new(\$config, \$objModel );
      my $objRdrDb         = $objRdrDbsFcry->doSpawn("$rdbms_type");
      ($rv, $msg , $hsr )  = $objRdrDb->doNativeLogonAuth($db,$email);

      if ( $rv == 200 ) {
         foreach my $key ( keys %$hsr ) {
            my $dbepass = $hsr->{$key}->{ 'pass' } ; # this is the pass from the db !!!

            if ( $objGuardian->passwordsMatch ($dbepass,$pass) ){
               $self->session( 'app.' . $db . '.user' => $email);
               if ( !defined $ENV{'QTO_JWT_AUTH'} or $ENV{'QTO_JWT_AUTH'} != 1 ){
                  $msg = "$db login ok for $email via single native auth";
                  $objLogger->doLogInfoMsg ( $msg );
                  $self->redirect_to($redirect_url) ; 
                  return ;
               }

               my ( $rv, $msg , $jwt ) = $objGuardian->doGrantAccessToken($db, $hsr);
               if ( $rv == 0 ) { 
                  my $pub_secret          = $objGuardian->doGetPublicKeySecret();
                  $self->session( 'app.' . $db . '.jwt' => $jwt);
                  $self->session( 'app.' . $db . '.user' => $email);
                  $redirect_url = '/' . $pdb . '/search' ; 
                  if (defined $self->session( 'app.' . $db . '.url' )) {
                     $redirect_url = $self->session( 'app.' . $db . '.url' );
                     $self->session( 'app.' . $db . '.url' => undef);
                  }

                  $msg = "$db login ok for $email via JWT based native auth";
                  $objLogger->doLogInfoMsg ( $msg );
                  $self->redirect_to( $redirect_url);
                  return;
               } else {
                  $rv = 500 ; 
                  $msg = "an error occurref in the token granting process for $email" ;
                  $msg .= "for the following user: " . $hsr->{$key}->{ 'user_id' } ;
                  $objLogger->doLogErrorMsg ( $msg ) ; 
               }
            } else {
               $rv = 401 ; 
               $msg = "wrong password for $email" ;
               $objLogger->doLogErrorMsg ( $msg ) ; 
            }
         }
      } else {
         $rv = 401 ; 
         $objLogger->doLogErrorMsg ( "logon failed for $email") ; 
      }
      $self->doRenderPageTemplate($rv, $msg ,$msg_color,$db,$redirect_url);
   }
}


# called on the initial showing of the UI ,aka on get
sub doInitShowLogonUI {
   my $self             = shift ; 
   my $db               = $self->stash('db');
   my $rv               = 200 ; 
   my $msg              = "$db   logon"; 
   my $http_method      = 'GET' ; 
   my $met              = '' ; 
   my $cnt              = 0 ; 
   my $dat              = '' ; 
   my $msg_color        = 'grey' ; 
   
   my $config		      = $self->app->config ; 
   my $edb              = toEnvName ( $db , $config) ;
   my $pdb              = toPlainName($db);
   my $alConfig         = $config->{'env'}->{'app'} ; 
   my $instance_domain  = $alConfig->{ 'web_host' } . $alConfig->{ 'port' } . '.' . $db ;

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
   $self->session( 'app.' . $edb . '.user' => undef);
   $self->session($sessions);
   

   # do not allow login to land on a <<env>>_<<proj-db>>/login to avoid mixing of envs
   if ( $db ne $pdb){
      my $login_redirect_url        = '/' . $pdb . '/logon';
      $self->redirect_to( $login_redirect_url);
      return ;
   }

   $self->doRenderPageTemplate(200,$msg,$msg_color,$db,$redirect_url) ;
   return ;
}




# $self->doRenderPageTemplate($ret, $msg ,$msg_color,$db,$redirect_url);
sub doRenderPageTemplate {
   
   my $self             = shift ; 
   my $rv               = shift ; 
   my $msg              = shift ;
   my $msg_color        = shift || 'red' ;
   my $db               = shift ; 
   my $redirect_url     = shift ; 
   my $notice           = '' ;

   $config		         = $self->app->config ; 
   my $pdb              = toPlainName($db);
   $msg                 = "$pdb login" unless $msg ; 

   $self->res->code($rv) ; 

   my $template_name    = 'logon' ; 
   my $template         = 'pages/' . $template_name . '/' . $template_name ; 
   my $objTimer         = 'Qto::App::Utils::Timer'->new( $config->{'env'}->{'log'}->{ 'TimeFormat' } );
   my $page_load_time   = $objTimer->GetHumanReadableTime();
   my $ProductVersion   = $config->{'env'}->{'run'}->{'VERSION'} ;

   $self->render(
      'template'        => $template 
    , 'msg'             => $msg
    , 'msg_color'       => $msg_color
    , 'db' 		         => $db
    , 'pdb' 		      => $pdb
    , 'EnvType' 		   => $config->{'env'}->{'run'}->{'ENV_TYPE'}
    , 'ProductVersion' 	=> $ProductVersion
    , 'GitShortHash'    => $config->{'env'}->{'run'}->{'GitShortHash'}
    , 'page_load_time'  => $page_load_time
    , 'notice'          => $notice
    , 'redirect_url'    => $redirect_url
	) ; 

   return ; 
}


1 ; 

__END__
