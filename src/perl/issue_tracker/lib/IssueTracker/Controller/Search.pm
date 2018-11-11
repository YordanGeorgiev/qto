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

use IssueTracker::Controller::PageFactory ; 
use IssueTracker::App::Db::In::RdrDbsFactory;
use IssueTracker::App::Utils::Logger;
use IssueTracker::App::Cnvr::CnrHsr2ToArray ; 
use IssueTracker::App::IO::In::RdrUrlParams ; 
use IssueTracker::App::Utils::Timer ; 

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
   my $as               = 'grid' ; 
   my $srch_control     = 'srch-grid' ; 
   
   unless ( $self->SUPER::isAuthorized($db) == 1 ) {
      $self->render('text' => 'Refresh your page to login ');
      return ; 
   } 
   
   $appConfig		 		= $self->app->get('AppConfig');
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

   $objModel         = 'IssueTracker::App::Mdl::Model'->new ( \$appConfig ) ;
   $objModel->set('postgres_db_name' , $db ) ; 
   
   my $query_params = $self->req->query_params ; 
   $objRdrUrlParams = 'IssueTracker::App::IO::In::RdrUrlParams'->new();
   ( $ret , $msg ) = $objRdrUrlParams->doSetQueryGlobalTxtSrchParams(\$objModel, $query_params , 'Search' );

   if ( ! defined ($self->req->query_params ) or $ret != 0 ) {
   
      my $objTimer         = 'IssueTracker::App::Utils::Timer'->new( $appConfig->{ 'TimeFormat' } );
      my $page_load_time   = $objTimer->GetHumanReadableTime();
  
      $self->render(
         'template'        => 'controls/srch-grid/srch-grid'
       , 'as'              => 'grid'
       , 'item'            => 'search'
       , 'msg'             => ''
       , 'db' 		         => $db
       , 'ProductType' 		=> $appConfig->{'ProductType'}
       , 'ProductVersion' 	=> $appConfig->{'ProductVersion'}
       , 'ShortCommitHash' => $appConfig->{'ShortCommitHash'}
       , 'page_load_time'  => $page_load_time
       , 'srch_control'    => "['name']" 
      ) ; 
      return ; 
   }  else {
      # do render without the table 
      $as = $self->req->query_params->param('as') || $as ; # decide which type of Search page to build
      ( $ret , $msg , $srch_control ) = $self->doBuildSearchControl ( \$objModel , $msg , $db , $as  ) ; 
      
      #$msg = $self->doSetPageMsg ( $ret , $msg ) ; 
      $self->doRenderPageTemplate( \$objModel , $msg , $db , $srch_control , $as) ; 
   }

}

sub doBuildSearchControl {

   my $self             = shift ; 
   my $objModel         = ${ shift @_ } ; 
   my $msg              = shift ; 
   my $db               = shift ; 
   my $as               = shift || 'grid' ; 

   my $ui_type          = 'page/srch-grid' ; 
   my $ret              = 1 ; 
   my $srch_control     = '' ; 
   my $objPageBuilder   = {} ; 
   my $objPageFactory   = {} ; 

   my $lables_pages = { 
          'grid'   => 'srch-grid'
#      ,  'lbls'   => 'srch-labels'
#      ,  'cloud'  => 'srch-cloud' 
#      ,  'print-table'  => 'srch-print-table'
   };

   $ui_type = 'page/' . $lables_pages->{ $as } ; 
  

   $objPageFactory                  = 'IssueTracker::Controller::PageFactory'->new(\$appConfig, \$objModel );
   $objPageBuilder                  = $objPageFactory->doInstantiate( $ui_type );
   ( $ret , $msg , $srch_control )  = $objPageBuilder->doBuildSearchControl( $msg , $db  , $as ) ;

   return ( $ret , $msg , $srch_control ) ; 

}



sub doRenderPageTemplate {
   
   my $self             = shift ; 
   my $objModel         = ${ shift @_ } ; 
   my $msg              = shift ; 
   my $db               = shift ; 
   my $srch_control     = shift ; 
   my $as               = shift || 'grid' ; 

   
   my $as_templates = { 
        'grid'          => 'srch-grid' 
#      ,  'lbls'        => 'srch-labels'
#      ,  'cloud'       => 'srch-cloud' 
#      ,  'table'       => 'srch-rgrid' 
#      ,  'print-table' => 'srch-print-table' 
   };
  
   my $template_name    = $as_templates->{ $as } || 'srch-grid' ; 
   my $template         = 'controls/' . $template_name . '/' . $template_name ; 

   my $objTimer         = 'IssueTracker::App::Utils::Timer'->new( $appConfig->{ 'TimeFormat' } );
   my $page_load_time   = $objTimer->GetHumanReadableTime();

   $self->render(
      'template'        => $template 
    , 'as'              => $as
    , 'item'            => 'search'
    , 'msg'             => $msg
    , 'db' 		         => $db
    , 'ProductType' 		=> $appConfig->{'ProductType'}
    , 'ProductVersion' 	=> $appConfig->{'ProductVersion'}
    , 'ShortCommitHash' => $appConfig->{'ShortCommitHash'}
    , 'page_load_time'  => $page_load_time
    , 'srch_control'    => $srch_control
	) ; 

   return ; 
}



1;

__END__
