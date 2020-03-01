package Qto::Controller::Upload ;
use strict ; use warnings ; 

use Mojo::Upload;

require Exporter;
our @ISA = qw(Exporter Mojo::Base Qto::Controller::BaseController);
our $AUTOLOAD =();
use AutoLoader;

use parent qw(Qto::Controller::BaseController);

use Data::Printer ; 
use Qto::App::Utils::Logger;
use Qto::App::Utils::Timer ; 
use Qto::App::Cnvr::CnrDbName qw(toPlainName toEnvName);

our $module_trace    = 0 ; 
our $config          = {};
our $objLogger       = {} ;


sub doUploadFiles {
   my $self = shift;
   my @files;
   for my $file (@{$self->req->uploads('files')}) {
      my $size = $file->size;
      my $name = $file->filename;
      push @files, "$name ($size)";
      $file->move_to("/tmp/".$name);
   }
   $self->render(text => "@files");
}

sub doShowPage {

   my $self                = shift;
   my $db                  = $self->stash('db');
   my $ret                 = 1 ; 
   my $msg                 = '' ; 
   $config		            = $self->app->config ; 
     
   my $template            = 'forms/files-upload-form'; 

   $self->render(
      'template'           => $template 
   ) ; 

   return ; 
}

1;

__END__

