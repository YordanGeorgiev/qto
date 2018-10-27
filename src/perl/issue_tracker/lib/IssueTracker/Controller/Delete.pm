package IssueTracker::Controller::Delete ; 

use strict ; use warnings ; 
use Mojo::Base 'Mojolicious::Controller';

use Data::Printer ; 
use Data::Dumper; 
use Scalar::Util qw /looks_like_number/;
use JSON;

use IssueTracker::App::Db::Out::WtrDbsFactory;
use IssueTracker::App::Utils::Logger;
use IssueTracker::App::Cnvr::CnrHsr2ToArray ; 
use IssueTracker::App::IO::In::RdrUrlParams ; 

our $module_trace   = 0 ;
our $appConfig      = {};
our $objLogger      = {} ;
our $rdbms_type     = 'postgre';


# --------------------------------------------------------
# Delete all the rows from db by passed db and table name
# --------------------------------------------------------
sub doDeleteItemById {

   my $self             = shift;
   my $item             = $self->stash('item');
   my $db               = $self->stash('db');
   my $rdbms_type       = 'postgres';
   my $objRdrUrlParams  = {} ; 
   my $objWtrDbsFactory = {} ; 
   my $objWtrDb         = {} ; 
   my $ret = 0;
   my $msg = 'unknown error during Delete item';
   my $hsr2 = {};

   my $json = $self->req->body;
   my $perl_hash = decode_json($json) ; 

   $appConfig		= $self->app->get('AppConfig');
   my $objModel         = 'IssueTracker::App::Mdl::Model'->new ( \$appConfig ) ;
   $objModel->set('postgres_db_name' , $db ) ; 

   $objRdrUrlParams = 'IssueTracker::App::IO::In::RdrUrlParams'->new();
   ( $ret , $msg ) = $objRdrUrlParams->doSetDeleteUrlParams(\$objModel, $perl_hash ) ; 
   
   if ( $ret != 0 ) {
      $self->res->code(400);
      $self->render( 'json' =>  { 
         'msg'   => $msg,
         'ret'   => 400, 
         'req'   => "POST " . $self->req->url->to_abs
      });
      return ; 
   } 

   $objWtrDbsFactory
      = 'IssueTracker::App::Db::Out::WtrDbsFactory'->new(\$appConfig, \$objModel );
   $objWtrDb = $objWtrDbsFactory->doInstantiate("$rdbms_type");
   ($ret, $msg) = $objWtrDb->doDeleteItemById(\$objModel, $item);

   $self->res->headers->accept_charset('UTF-8');
   $self->res->headers->accept_language('fi, en');
   $self->res->headers->content_type('application/json; charset=utf-8');

   

   if ( $ret == 0 ) {
      my $http_code = 200 ; 
      my $rows_count = 0 ; 
      $msg = "Delete OK for table: $item" ; 

      $self->res->code($http_code);
      $self->render( 'json' =>  { 
           'msg'   => $msg
         , 'ret'   => $http_code
         , 'req'   => "POST " . $self->req->url->to_abs
      });
   } elsif ( $ret == 400 ) {

      $self->res->code(400);
      $self->render( 'json' =>  { 
           'msg'   => $msg
         , 'ret'   => 400
         , 'req'   => "POST " . $self->req->url->to_abs
      });
   } elsif ( $ret == 2 ) {

      $self->res->code(400);
      $self->render( 'json' =>  { 
         'msg'   => $msg
         ,'ret'   => 400
         ,'req'   => "POST " . $self->req->url->to_abs
      });
   } else {

      my $post_msg = ' while deleting the "' . $perl_hash->{'attribute'} . '" attribute value ' ; 
      $post_msg .= 'for the following id: ' . $perl_hash->{'id'} ; 
      $msg .= $post_msg ; 
      $self->res->code(400);
      $self->render( 'json' => { 
         'msg'   => $msg
         ,'ret' => 404
         ,'req'   => "POST " . $self->req->url->to_abs
      })
      ;
   }
}



1;

__END__

# feature-guid: 
