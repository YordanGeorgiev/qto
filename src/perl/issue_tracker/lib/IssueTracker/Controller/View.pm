package IssueTracker::Controller::View ; 
use strict ; use warnings ; 

require Exporter;
our @ISA = qw(Exporter Mojo::Base IssueTracker::Controller::BaseController);
our $AUTOLOAD =();
our $ModuleDebug = 0 ; 
use AutoLoader;

use parent qw(IssueTracker::Controller::BaseController);

use Data::Printer ; 
use Scalar::Util qw /looks_like_number/;

use IssueTracker::App::Utils::Logger;
use IssueTracker::App::Utils::Timer ; 

our $module_trace   = 0 ; 
our $appConfig      = {};
our $objLogger      = {} ;


#
# --------------------------------------------------------
# View all the items according to the "as" url param output type
# --------------------------------------------------------
sub doViewItems {

   my $self             = shift;
   my $db               = $self->stash('db');
   my $item             = $self->stash('item');

   my $ret              = 1 ; 
   my $msg              = '' ; 
   my $objModel         = {} ; 
   my $view_control     = '' ; 
   my $as               = 'doc' ; 

   return unless ( $self->SUPER::isAuthorized($db) == 1 );
   $self->SUPER::doReloadProjDbMetaData( $db ) ;

   #$self->render('text' => 'view page is presented');
   ( $ret , $msg , $view_control ) = $self->doBuildViewPageType ( $msg , \$objModel , $db , $item , $as  ) ; 

}

sub doBuildViewPageType {

   my $self             = shift ; 
   my $msg              = shift ; 
   my $objModel         = ${ shift @_ } ; 
   my $db               = shift ; 
   my $item             = shift ; 
   my $as               = shift ; 

   my $ui_type          = 'page/View-grid' ; 
   my $ret              = 1 ; 
   my $view_control     = '' ; 
   my $objPageBuilder   = {} ; 
   my $objPageFactory   = {} ; 

   my $lables_pages = { 
         'doc'        => 'view-doc'
      ,  'print-doc'  => 'view-print-doc'
   };

   my $page_type = $lables_pages->{ $as } || 'view-doc' ; 
   $ui_type = "page/$page_type" ;

   $objPageFactory                  = 'IssueTracker::Controller::PageFactory'->new(\$appConfig, \$objModel );
   $objPageBuilder                  = $objPageFactory->doSpawn( $ui_type );
   ( $ret , $msg , $view_control )  = $objPageBuilder->doBuildViewControl( $msg , \$objModel , $db , $item , $as ) ;

   return ( $ret , $msg , $view_control ) ; 

}

1;

__END__

