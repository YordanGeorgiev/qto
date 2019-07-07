package Qto::Controller::Logon ; 
use strict ; use warnings ; 
	
require Exporter;
our @ISA = qw(Exporter Mojo::Base Qto::Controller::BaseController);
our $AUTOLOAD =();
our $ModuleDebug = 0 ; 
use AutoLoader;

use Data::Printer ; 
use JSON;

use parent qw(Qto::Controller::BaseController);

use Qto::App::Db::In::RdrDbsFactory;
use Qto::App::Utils::Logger;
use Qto::App::IO::In::CnrPostPrms ; 
use Qto::App::IO::In::CnrEncrypter ; 

my $module_trace    = 0 ;
our $appConfig      = {};
our $objLogger      = {} ;
our $rdbms_type     = 'postgres';



#
# --------------------------------------------------------
# Select all the rows from db by passed db and table name
# --------------------------------------------------------
sub doLogonUser {

   my $self             = shift;
   my $db               = $self->stash('db');
   my $ret              = 1 ; 
   my $msg              = 'unknown error during global text search ';
   my $objRdrDbsFactory = {} ; 
   my $objRdrDb         = {} ; 
   my $hsr             = {};
   my $http_code        = 400 ;
   my $rows_count       = 0 ; 
   my $msr2             = {}  ; 
   my $dat              = {}  ; 
   
   $appConfig		 		= $self->app->get('AppConfig');
	#print STDOUT "Logon.pm ::: url: " . $self->req->url->to_abs . "\n\n" if $module_trace == 1 ; 

   my $post_body_data   = decode_json($self->req->body) ; 
   my $password         = $post_body_data->{ 'password' } ; 
   my $objModel      = 'Qto::App::Mdl::Model'->new ( \$appConfig , $db) ;
   $objModel->set('postgres_db_name' , $db ) ; 

   my $objCnrPostPrms = 
      'Qto::App::IO::In::CnrPostPrms'->new(\$appConfig , \$objModel );
   ( $ret , $msg ) = $objCnrPostPrms->doSetLogonUrlParams('Logon' , $post_body_data);

   if ( $ret != 0 ) {
      $self->doRender(400);
      return ;
   } 

   $objRdrDbsFactory = 'Qto::App::Db::In::RdrDbsFactory'->new(\$appConfig, \$objModel );
	$objRdrDb = $objRdrDbsFactory->doSpawn("$rdbms_type");
   ($ret, $msg , $hsr ) = $objRdrDb->doNativeLogonAuth($post_body_data);
   $http_code = $ret ; 
   if ( $ret == 200 ) {
      my $objCnrEncrypter  = 'Qto::App::IO::In::CnrEncrypter'->new();
      foreach my $key ( keys %$hsr ) {
         my $encrypted_pass   = $hsr->{$key}->{ 'password' } ; 
         unless ( $objCnrEncrypter->match_passphrase_against_crypto_hash($encrypted_pass,$password ) == 1 ) {
           $http_code = 401 ; 
         }
      }
   } 

   $self->doRender($http_code);
   #   $self->SUPER::doRenderJSON(400,$msg,'POST','','0','');

}

sub doRender {
   my $self = shift ; 
   my $http_code = shift ; 

   $self->res->headers->content_type('application/json; charset=utf-8');
   $self->res->code($http_code);
   $self->render( 'json' =>  { 
        'ret'   => $http_code
   });

}

1;

__END__

# feature-guid: ecd424d7-e5bd-45f1-90c8-10fae1316bf9
