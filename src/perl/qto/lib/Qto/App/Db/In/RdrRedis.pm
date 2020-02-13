package Qto::App::Db::In::RdrRedis ; 

my $VERSION = '1.0.0';    
require Exporter;
use AutoLoader  ;
our @ISA    = qw(Exporter);
@EXPORT_OK = qw(getData);
use Storable qw(freeze thaw );
use Carp qw(cluck croak);
use Redis ; 
use Data::Printer ; 


sub getData {
   my $self       = shift ; 
	my $config = ${ shift @_ } || croak 'no config provided !!!' ; 
   my $key        = shift ; 
   my $server  = $config->{'env'}->{'redis'}->{'server'};
   my $port    = $config->{'env'}->{'redis'}->{'port'};
   my $redis = Redis->new('server' => "$server:$port");
   my $serialized = $redis->get($key);
   my $data = thaw($serialized);
   return $data ;
}


sub new {
   my $class   = shift; 
   my $self    = {}; 
   bless( $self, $class );    
   return $self;
}  


sub RunBeforeExit {
   my $self = shift;
}


sub DESTROY {
   my $self = shift;

   $self->RunBeforeExit();
   return;
}   


sub AUTOLOAD {

   my $self = shift;
   no strict 'refs';
   my $name = our $AUTOLOAD;
   *$AUTOLOAD = sub {
      my $msg =
        "\n\n\n[FATAL] RunTime Error !!! Undefined sub $name(@_) ";
      croak ( "$self , $msg" .  "$!" ) ; 
   };
   goto &$AUTOLOAD;    # Restart the new routine.
}   


=head1 SYNOPSIS

   the qto redis reader module
   use Qto::App::Db::In::RdrRedis

   my $config        = $t->app->config ; # the app config
   my $objRdrRedis   = 'Qto::App::Db::In::RdrRedis'->new(\$config);
   my $data          = $objRdrRedis->getDataa('key');


=head1 EXPORT
   our @EXPORT = qw(getDataa);
=cut 


1 ; 
__END__
