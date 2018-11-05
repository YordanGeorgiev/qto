package IssueTracker::Controller::Search ; 
use strict ; use warnings ; 

require Exporter;
our @ISA = qw(Exporter Mojo::Base IssueTracker::Controller::BaseController);
our $AUTOLOAD =();
our $ModuleDebug = 0 ; 
use AutoLoader;

use parent qw(IssueTracker::Controller::BaseController);

use Data::Printer ; 
use Data::Dumper; 
use Scalar::Util qw /looks_like_number/;

use IssueTracker::App::Db::In::RdrDbsFactory;
use IssueTracker::App::Utils::Logger;
use IssueTracker::App::Cnvr::CnrHsr2ToArray ; 
use IssueTracker::App::IO::In::RdrUrlParams ; 

my $module_trace    = 0 ;
our $appConfig      = {};
our $objLogger      = {} ;
our $rdbms_type     = 'postgres';



sub doSearchItems {
   my $self             = shift;
   my $db               = $self->stash('db');
   
   my $objModel         = {} ;
   my $objRdrUrlParams  = {} ; 
   my $objRdrDbsFactory = {} ; 
   my $objRdrDb         = {} ; 
   my $ret              = 0;
   my $msg              = 'unknown error during search';
   my $hsr2             = {};
   my $msr2             = {};
   my $http_code        = 200 ; 
   my $rows_count       = 0 ; 
   
   unless ( $self->SUPER::isAuthorized($db) == 1 ) {
      $self->render('text' => 'Refresh your page to login ');
      return ; 
   } 
   
   unless ( exists ( $appConfig->{ $db . '.meta' } )  ) {
      
      ( $ret , $msg , $msr2 ) = $self->SUPER::doReloadProjectDbMetaData( $db ) ; 
      unless ( $ret == 0 ) { 
         $self->render('text' => $msg ) unless $ret == 0 ; 
         return ; 
      }
      else { 
         $appConfig->{ $db . '.meta' } = $msr2 ; 
      }
   } 

	# print "Search.pm ::: url: " . $self->req->url->to_abs . "\n\n" if $module_trace == 1 ; 

   $objModel         = 'IssueTracker::App::Mdl::Model'->new ( \$appConfig ) ;
   $objModel->set('postgres_db_name' , $db ) ; 

   my $query_params = $self->req->query_params ; 
   $objRdrUrlParams = 'IssueTracker::App::IO::In::RdrUrlParams'->new();
   ( $ret , $msg ) = $objRdrUrlParams->doSetQueryGlobalTxtSrchParams(\$objModel, $query_params , 'Query' );
   if ( $ret != 0 ) {
      $self->res->code(400);
      $self->render( 'json' =>  { 
         'msg'   => $msg,
         'ret'   => 400, 
         'met'   => '',
         'req'   => "GET " . $self->req->url->to_abs
      });
      return ; 
   } 

}

1;

__END__
