package Qto::Controller::Upload ;
use strict ; use warnings ; 

require Exporter;
our @ISA = qw(Exporter Mojo::Base Qto::Controller::BaseController);
our $AUTOLOAD =();
use AutoLoader;
use Carp qw /carp cluck croak/;
use File::Path qw/make_path/ ;


use Mojo::Upload;
use Data::Printer ; 
use parent qw(Qto::Controller::BaseController);
use Qto::App::Utils::Logger;
use Qto::App::Utils::Timer ; 
use Qto::App::Cnvr::CnrDbName qw(toPlainName toEnvName);

our $config  = {};


sub doUploadFiles {
   my $self      = shift;
   my @files;
   $config		      = $self->app->config ; 
   my $landing_dir   = $config->{'env'}->{'run'}->{ 'ProductInstanceDir' } . '/src/perl/qto/public/uploads';
   make_path( "$landing_dir" ) || carp ( "cannot create dir: " . $landing_dir ) ;  

   for my $file (@{$self->req->uploads('files')}) {
      my $size = $file->size;
      my $name = $file->filename;
      push @files, "$name ($size)";
      $file->move_to("$landing_dir/".$name);
   }
   $self->render(text => "@files");
}


1;

__END__

