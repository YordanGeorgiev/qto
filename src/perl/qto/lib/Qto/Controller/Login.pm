package Qto::Controller::Login ;
use strict ; use warnings ; 

use Mojo::Base 'Mojolicious::Controller';


use Data::Printer ; 
use Qto::App::Utils::Timer ; 

our $appConfig      = {};


sub doShowLoginForm {

   my $self             = shift;
   my $db               = $self->stash('db');

   my $msg              = '' ; 

   $db = $self->doResolveDbName ( $db ) ; 

   $appConfig		 		= $self->app->get('AppConfig');

   #$self->render('text' => 'the login page is presented') ;
   $self->doRenderPageTemplate( $msg ,$db ) ;
   return
}


sub doRenderPageTemplate {
   
   my $self             = shift ; 
   my $msg              = shift ; 
   my $db               = shift ; 
   my $notice           = '' ;

   $self->res->code(200) ; 

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

