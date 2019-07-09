package Qto::Controller::Login ;
use strict ; use warnings ; 

use Mojo::Base 'Mojolicious::Controller';
use Data::Printer ; 
use Qto::App::Utils::Timer ; 
use Qto::App::IO::In::CnrPostPrms ; 
use Qto::App::Db::In::RdrDbsFactory ; 

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
   my $objRdrDbsFactory = {} ; 
   my $objRdrDb         = {} ; 
   my $hsr              = {};
   my $http_code        = 400 ;
   my $rows_count       = 0 ; 
   my $msr2             = {}  ; 
   my $dat              = {}  ; 
   $appConfig		 		= $self->app->get('AppConfig');
   $objLogger           = 'Qto::App::Utils::Logger'->new( \$appConfig );
   $db                  = $self->doResolveDbName ( $db ) ;
	#print STDOUT "Logon.pm ::: url: " . $self->req->url->to_abs . "\n\n" if $module_trace == 1 ; 

   my $pass         = $self->param('pass');
   my $epass        = undef ; 
   my $email        = $self->param('email' );
   my $objModel     = 'Qto::App::Mdl::Model'->new ( \$appConfig , $db) ;
   $objModel->set('postgres_db_name' , $db ) ; 
   $objLogger->doLogInfoMsg ( "login attempt for " . $self->setEmptyIfNull($email)) ; 

   my $objCnrPostPrms = 
      'Qto::App::IO::In::CnrPostPrms'->new(\$appConfig , \$objModel );
   ( $ret , $msg , $epass) = $objCnrPostPrms->doSetLoginUrlParams('Login' , $email , $pass );

   if ( $ret != 0 ) {
      $objLogger->doLogInfoMsg ( 'login failed for "' . $self->setEmptyIfNull($email) . '"') ; 
      $self->doRenderPageTemplate($ret , 'validation failed! ' . $msg , $db);
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
           my $home_page = '/' . $db . '/home' ; 
           $objLogger->doLogInfoMsg ( "login ok for $email") ; 
           $self->redirect_to( $home_page );
           return ;
         }
      }
   } else {
      $http_code = 401 ; 
      $objLogger->doLogErrorMsg ( "login failed for $email") ; 
   }
   $self->doRenderPageTemplate($http_code,$msg,$db);
}
#eof sub doLoginUser


sub doShowLoginForm {

   my $self             = shift;
   my $db               = $self->stash('db');
   my $msg              = undef ; 
   $db = $self->doResolveDbName ( $db ) ; 

   $appConfig		 		= $self->app->get('AppConfig');

   #$self->render('text' => 'the login page is presented') ;
   $self->doRenderPageTemplate(200,$msg,$db) ;
   return
}


sub doRenderPageTemplate {
   
   my $self             = shift ; 
   my $http_code        = shift ; 
   my $msg              = shift ;
   my $db               = shift ; 
   my $notice           = '' ;

   $msg = "$db login" unless $msg ; 
   $self->res->code($http_code) ; 

   my $template_name    = 'login' ; 
   my $template         = 'pages/' . $template_name . '/' . $template_name ; 

   my $objTimer         = 'Qto::App::Utils::Timer'->new( $appConfig->{ 'TimeFormat' } );
   my $page_load_time   = $objTimer->GetHumanReadableTime();

   $self->render(
      'template'        => $template 
    , 'msg'             => $msg
    , 'db' 		         => $db
    , 'ProductType' 		=> $appConfig->{'ProductType'}
    , 'ProductVersion' 	=> $appConfig->{'ProductVersion'}
    , 'GitShortHash'    => $appConfig->{'GitShortHash'}
    , 'page_load_time'  => $page_load_time
    , 'notice'          => $notice
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


sub doResolveDbName {
   my $self                = shift ; 
   my $db                  = shift ; 
   my $item                = shift ; 
   my @env_prefixes        = ( 'dev_' , 'tst_' , 'qas_' , 'prd_' );
 
   my $db_prefix           = substr($db,0,4);
   $appConfig		 		   = $self->app->get('AppConfig');
   unless ( grep ( /^$db_prefix$/, @env_prefixes)) {
      $db = $appConfig->{ 'ProductType' } . '_' . $db ; 
   } 
   return $db ;
}

1;

__END__

