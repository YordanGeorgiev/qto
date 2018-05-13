package IssueTracker::Controller::List ; 
use strict ; use warnings ; 
use Mojo::Base 'Mojolicious::Controller';

use Data::Printer ; 
use Data::Dumper; 
use Scalar::Util qw /looks_like_number/;

use IssueTracker::App::Db::In::RdrDbsFactory;
use IssueTracker::App::Utils::Logger;
use IssueTracker::App::Cnvr::CnrHsr2ToArray ; 

our $module_trace   = 0 ;
our $appConfig      = {};
our $objLogger      = {} ;
our $rdbms_type     = 'postgre';
our $objModel       = {} ; 


#
# --------------------------------------------------------
# Select all the rows from db by passed db and table name
# --------------------------------------------------------
sub doListItems {

   my $self        = shift;
   my $item        = $self->stash('item');
   my $db          = $self->stash('db');
   my $rdbms_type  = 'postgres';

   $appConfig		= $self->app->get('AppConfig');
   $objModel       = ${$self->app->get('ObjModel')} ; 
   $objModel->set('postgres_db_name' , $db ) ; 
   
	$self->res->headers->accept_charset('UTF-8');
   $self->res->headers->accept_language('fi, en');

   # and render the result
   $self->render(
      template             => 'pages/list'
    , item                 => $item
    , db 						=> $db
   ); 
}






1;

__END__

