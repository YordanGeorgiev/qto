package IssueTracker::Controller::HSelect;
use strict ; use warnings ; 

require Exporter; our @ISA = qw(Exporter Mojo::Base IssueTracker::Controller::BaseController);
our $AUTOLOAD =();
use AutoLoader;
use parent qw(IssueTracker::Controller::BaseController);

use Data::Printer ; 
use Data::Dumper; 
use Scalar::Util qw /looks_like_number/;

use IssueTracker::App::Utils::Logger;
use IssueTracker::App::Db::In::RdrDbsFactory ; 
use IssueTracker::App::IO::In::CnrUrlParams ; 
use IssueTracker::App::Cnvr::CnrHsr2ToArray ; 
use IssueTracker::App::Cnvr::CnrHashesArrRefToHashesArrRef ; 

our $appConfig          = {} ; 

sub doHSelectItems {

   my $self = shift ; 
   my $db               = $self->stash('db');
   my $item             = $self->stash('item');
   my $rv               = 1 ; 
   my $msg              = '' ; 
   my $http_code        = 400 ; 
   my $http_method      = 'GET' ; 
   my $met              = {} ; 
   my $ret              = 1 ; 
   my $cnt              = 0 ; 
   my $objRdrDbsFactory = {} ; 
   my $objRdrDb         = {} ; 
   my $rdbms_type       = 'postgres' ; 
   my $objModel         = {} ; 
   my $dat              = {} ; 
   my $seq              = $self->req->query_params->param('seq') || 1 ; 
 
   return unless ( $self->SUPER::isAuthorized($db) == 1 );
   $self->SUPER::doReloadProjDbMetaData( $db ) ;
   $appConfig		 		= $self->app->get('AppConfig');
   $objModel            = 'IssueTracker::App::Mdl::Model'->new ( \$appConfig ) ;

   if ( looks_like_number ( $seq )) {
      $objRdrDbsFactory 	= 'IssueTracker::App::Db::In::RdrDbsFactory'->new(\$appConfig, \$objModel );
      $objRdrDb 				= $objRdrDbsFactory->doInit("$rdbms_type");

      my $objCnrUrlParams = 'IssueTracker::App::IO::In::CnrUrlParams'->new();
      ( $ret , $msg ) = $objCnrUrlParams->doSetView(\$objModel, $self->req->query_params );
      return ( $ret , $msg ) unless $ret == 0 ; 

      ( $ret , $msg ) = $objCnrUrlParams->doSetSelect(\$objModel, $self->req->query_params );
      return ( $ret , $msg ) unless $ret == 0 ; 

      ($rv, $msg, $dat) 	= $objRdrDb->doHSelectBranch($db , $item, $seq);
      $http_code 				= $rv ;  
      p $dat ; 
      my $objCnrHashesArrRefToHashesArrRef = 'IssueTracker::App::Cnvr::CnrHashesArrRefToHashesArrRef'->new (\$appConfig  ) ; 
      # p ( $dat ) ; 
      $dat = $objCnrHashesArrRefToHashesArrRef->doConvert ( $dat) ; 
   } else {
      $msg = 'the seq ( aka sequence ) url parameter should be a whole number' ; 
      $http_code = 400 ; 
   }
   
   $self->SUPER::doRenderJSON($http_code,$msg,$http_method,$met,$cnt,$dat);
   return ; 
}

1 ; 

__END__
