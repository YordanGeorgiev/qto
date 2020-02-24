package Qto::Auth::User ; 
use strict ; use warnings ; 

require Exporter; our @ISA = qw(Exporter );
our $AUTOLOAD =();
use AutoLoader;

use Data::Printer ; 



our $roles ; 



sub new {
   my $class   = shift; 
   my $self    = {}; 
   bless( $self, $class );    
   return $self;
}  

1;

__END__

