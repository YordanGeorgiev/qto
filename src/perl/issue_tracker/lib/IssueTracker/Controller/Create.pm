package IssueTracker::Controller::Create ; 
use strict ; use warnings ; 

require Exporter; our @ISA = qw(Exporter Mojo::Base IssueTracker::Controller::BaseController);
our $AUTOLOAD =();
use AutoLoader;
use parent qw(IssueTracker::Controller::BaseController);

use Data::Printer ; 
use Data::Dumper; 
use Scalar::Util qw /looks_like_number/;
use JSON;

use IssueTracker::App::Db::Out::WtrDbsFactory;
use IssueTracker::App::Utils::Logger;
use IssueTracker::App::Cnvr::CnrHsr2ToArray ; 
use IssueTracker::App::IO::In::CnrUrlParams ; 

our $module_trace   = 0 ;
our $appConfig      = {};
our $objLogger      = {} ;
our $rdbms_type     = 'postgre';

#
# --------------------------------------------------------
# create all the rows from db by passed db and table name
# --------------------------------------------------------
sub doCreateBySoleId {

   my $self             = shift;
   my $item             = $self->stash('item');
   my $db               = $self->stash('db');
   my $rdbms_type       = 'postgres';
   my $objCnrUrlParams  = {} ; 
   my $objWtrDbsFactory = {} ; 
   my $objWtrDb         = {} ; 
   my $ret              = 0;
   my $msg              = 'unknown error during create item';
   my $hsr2             = {};

   my $json = $self->req->body;
   my $perl_hash = decode_json($json) ; 

   return unless ( $self->SUPER::isAuthorized($db) == 1 );
   $self->SUPER::doReloadProjDbMeta( $db ) ;
   $appConfig		= $self->app->get('AppConfig');
   
   my $objModel         = 'IssueTracker::App::Mdl::Model'->new ( \$appConfig ) ;
   $objModel->set('postgres_db_name' , $db ) ; 

   $objCnrUrlParams = 
      'IssueTracker::App::IO::In::CnrUrlParams'->new(\$appConfig , \$objModel , $self->req->query_params);
   ( $ret , $msg ) = $objCnrUrlParams->doSetCreateUrlParams($perl_hash ) ; 
   
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
   $objWtrDb = $objWtrDbsFactory->doInit("$rdbms_type");
   ($ret, $msg) = $objWtrDb->doInsertByItemId($item);

   $self->res->headers->accept_charset('UTF-8');
   $self->res->headers->accept_language('fi, en');
   $self->res->headers->content_type('application/json; charset=utf-8');

   if ( $ret == 0 ) {
      my $http_code = 200 ; 
      my $rows_count = 0 ; 
      $msg = "create OK for table: $item" ; 

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
   } elsif ( $ret == 409) {

      my $post_msg = ' while creating a new item ' ; 
      $post_msg .= 'with the following id: ' . $perl_hash->{'id'} ; 
      $msg .= $post_msg ; 
      $self->res->code($ret);
      $self->render( 'json' => { 
         'msg'   => $msg
         ,'ret' => $ret
         ,'req'   => "POST " . $self->req->url->to_abs
      })
      ;
   }
}



1;

__END__

