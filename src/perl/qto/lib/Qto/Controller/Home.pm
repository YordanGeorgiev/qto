package Qto::Controller::Home ;
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
sub doLanding {

   my $self             = shift;
   my $db               = $self->stash('db');
   my $ret              = 1 ; 
   my $msg              = '' ;
   my $objRdrDbsFactory = {} ; 
   my $objRdrDb         = {} ; 
   my $hsr              = {};
   my $http_code        = 200 ;
   my $rows_count       = 0 ; 
   my $dat              = {}  ; 
   $appConfig		 		= $self->app->get('AppConfig');
   $objLogger           = 'Qto::App::Utils::Logger'->new( \$appConfig );
   $db                  = $self->doResolveDbName ( $db ) ;

   $self->doRenderPageTemplate($http_code,$msg,$db);
}
#eof sub doHomeUser



sub doRenderPageTemplate {
   
   my $self             = shift ; 
   my $http_code        = shift ; 
   my $msg              = shift ;
   my $db               = shift ; 
   my $notice           = '' ;

   $msg = "$db home" unless $msg ; 
   $self->res->code($http_code) ; 

   my $template_name    = 'Home' ; 
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

