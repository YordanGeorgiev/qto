package Qto::App::Db::In::Postgres::MojoPgWrapper ; 

   use strict ; use warnings ; use utf8 ; 
   require Exporter; our @ISA = qw(Exporter Mojo::Pg) ; 
   our $AUTOLOAD = ();
   use AutoLoader;
   use parent qw(Mojo::Pg);

   require Exporter; 
   use AutoLoader ; 
	use Encode qw( encode_utf8 is_utf8 );
   use POSIX qw(strftime);
	use Carp ; 
   use DBI ; 
   use DBD::Pg ; 
	use Data::Printer ; 

   use Qto::App::Utils::Logger ; 
   use Qto::App::Mdl::Model ; 

   our $objModel        = {} ;
   our $config       = {} ;
   our $objLogger       = {} ;
   our $db              = {} ;


   sub new {
		my $invocant   = shift ;    
		$config        = ${ shift @_ } || croak 'config not passed in MojoPgWrapper !!!' ; 
		$objModel      = ${ shift @_ } || croak 'objModel not passed in MojoPgWrapper !!!' ; 
		$db            = shift ;    
		my $class      = ref ( $invocant ) || $invocant ; 
		my $self       = {} ; bless( $self, $class ) ;  
      $self          = $self->do_init($db) ; 
		return $self;
	}  


   sub do_init {

      my $self       = shift ; 
      my $db         = shift ; 
      
      %$self = (
           config => $config
      );

      $objLogger 			      = 'Qto::App::Utils::Logger'->new( \$config ) ;
      my $dbConfig = $config->{'env'}->{'db'} ; 
		my $postgres_rdbms_host    = $ENV{ 'postgres_rdbms_host' } || $dbConfig->{'postgres_rdbms_host'} || '127.0.0.1' ;
		my $postgres_rdbms_port    = $ENV{ 'postgres_rdbms_port' } || $dbConfig->{'postgres_rdbms_port'} || '15432' ; 
		my $postgres_app_usr 	= $ENV{ 'postgres_app_usr' } || $dbConfig->{'postgres_app_usr'} || 'usrqtoapp' ; 
		my $postgres_app_usr_pw = $ENV{ 'postgres_app_usr_pw' } || $dbConfig->{'postgres_app_usr_pw'} 	|| 'no_pass_provided!!!' ; 
      my $conn_str            = 'postgresql://' . $postgres_app_usr . ':' . $postgres_app_usr_pw .  '@' . $postgres_rdbms_host . ':' . $postgres_rdbms_port . '/' . $db . '?sslmode=disable'; 
      #debug $objLogger->debug ( "conn_str: $conn_str " ) ; 
      $self = 'Mojo::Pg'->new($conn_str);
      return $self ; 
   }


   #
   # -----------------------------------------------------------------------------
   # open the database handle if possible, if not return proper error msgs
   # ( $ret , $msg , $dbh ) = $self->doConnectToDb ( $db ) ; 
   # -----------------------------------------------------------------------------

#   0  Empty query string
#   1  A command that returns no data successfully completed.
#   2  A command that returns data successfully completed.
#   3  A COPY OUT command is still in progress.
#   4  A COPY IN command is still in progress.
#   5  A bad response was received from the backend.
#   6  A nonfatal error occurred (a notice or warning message)
#   7  A fatal error was returned: the last query failed.

1;

__END__
