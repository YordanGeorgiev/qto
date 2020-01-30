package Qto::App::Db::Out::WtrRedis ; 
	
my $VERSION = '1.0.0';    
require Exporter;
use AutoLoader  ;
our @ISA    = qw(Exporter);
use Storable qw(freeze thaw );
use Carp qw(cluck croak);
use Redis ; 
use Data::Printer ; 
@EXPORT_OK = qw(setData);

# Serializing to memory
# $serialized = freeze \%table;
# %table_clone = %{ thaw($serialized) };


sub setData {
   my $self       = shift ; 
	my $config = ${ shift @_ } || croak 'no config provided !!!' ; 
   my $key        = shift ; 
   my $data       = shift ; 
   my $server  = $config->{'env'}->{'redis'}->{'server'};
   my $port    = $config->{'env'}->{'redis'}->{'port'};
   my $serialized = freeze ($data);
   my $redis = Redis->new('server' => "$server:$port");
   $redis->set($key => $serialized);
}


sub new {
   my $class = shift; 
   my $self = {}; 
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

   the qto redis writer module
   use Qto::App::Db::Out::WtrRedis;

   my $config        = $t->app->config ; # the app config
   my $objWtrRedis   = 'Qto::App::Db::Out::WtrRedis'->new(\$config);
   $objWtrRedis->setDataa('key',$data);


=head1 EXPORT
   our @EXPORT = qw(getData);
=cut 

1; 
__END__
