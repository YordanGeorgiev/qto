package Qto::Controller::Serve;
use strict ; use warnings ; 

require Exporter; our @ISA = qw(Exporter Mojo::Base Qto::Controller::BaseController);
our $AUTOLOAD =();
use AutoLoader;
use parent qw(Qto::Controller::BaseController);

use Data::Printer ; 
use Data::Dumper; 

use Qto::App::Utils::Logger;
use Qto::App::Db::In::RdrDbsFcry;
use Qto::App::Cnvr::CnrHsr2ToArray ; 
use Qto::App::IO::In::CnrUrlPrms ; 
use Qto::App::Cnvr::CnrDbName qw(toPlainName toEnvName);

my $module_trace     = 0 ;
our $config          = {};
our $objLogger       = {} ;
our $rdbms_type      = 'postgres';


#
# --------------------------------------------------------
# Serve all the rows from db by passed db and table name
# src: https://en.wikipedia.org/wiki/List_of_HTTP_status_codes
# --------------------------------------------------------
sub doServe {
   my $self             = shift;
   my $db               = $self->stash('db');
   my $item             = $self->stash('item');
   my $http_code        = 404 ; 
   my $msg              = $self->req->query_params->param('msg');

   $http_code = 403 if $item eq 'forbidden' ; 

   $self->res->headers->content_type('application/json; charset=utf-8');
   $self->res->code($http_code);
   $self->render( 'json' =>  { 
        'ret'   => $http_code
      , 'msg'   => $msg
      , 'req'   => 'GET'
      , 'met'   => undef
      , 'cnt'   => 0
      , 'dat'   => undef
   });
}


1;

__END__
