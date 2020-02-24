package Qto::Auth::Role ; 
use strict ; use warnings ; 

require Exporter; our @ISA = qw(Exporter );
our $AUTOLOAD =();
use AutoLoader;

use Data::Printer ; 



sub hasAccessToPage {
   my $self    = shift ; 
   my $page    = shift ; 

}

sub new {
   my $class   = shift; 
   my $self    = {}; 
   bless( $self, $class );    
   return $self;
}  


1;

__END__

