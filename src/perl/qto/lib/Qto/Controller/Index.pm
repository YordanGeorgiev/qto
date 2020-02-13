package Qto::Controller::Index ;
use strict ; use warnings ;

require Exporter;
our @ISA = qw(Exporter Mojo::Base Qto::Controller::BaseController);
our $AUTOLOAD =();
our $ModuleDebug = 0 ;
use AutoLoader;

use parent qw(Qto::Controller::BaseController);


sub doServeIndex {

   my $self             = shift;
   $self->reply->static('index.html');
}


1;

__END__
