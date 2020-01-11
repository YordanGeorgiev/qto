package Qto::Controller::Logon ;
use strict ; use warnings ; 

require Exporter; our @ISA = qw(Exporter Mojo::Base Qto::Controller::BaseController);
our $AUTOLOAD =();
use AutoLoader;
use parent qw(Qto::Controller::BaseController);


sub doShowLogon {
   my $self = shift ; 

   my $http_code     = 200 ; 
   my $msg           = '' ; 
   my $http_method   = 'GET' ; 
   my $met           = '' ; 
   my $cnt           = 0 ; 
   my $dat           = '' ; 

   $self->SUPER::doRenderJSON($http_code,$msg,$http_method,$met,$cnt,$dat);
}

1 ; 

__END__
