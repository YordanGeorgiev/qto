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
   our $appConfig       = {} ;
   our $objLogger       = {} ;
   our $db              = {} ;


   sub new {
		my $invocant   = shift ;    
		$appConfig     = ${ shift @_ } || croak 'appConfig not passed in MojoPgWrapper !!!' ; 
		$objModel      = ${ shift @_ } || croak 'objModel not passed in MojoPgWrapper !!!' ; 
		$db            = shift ;    
		my $class      = ref ( $invocant ) || $invocant ; 
		my $self       = {} ; bless( $self, $class ) ;  
      $self          = $self->doInit($db) ; 
		return $self;
	}  


   sub doInit {

      my $self       = shift ; 
      my $db         = shift ; 
      
      %$self = (
           appConfig => $appConfig
      );

      $objLogger 			      = 'Qto::App::Utils::Logger'->new( \$appConfig ) ;
		my $postgres_db_host    = $ENV{'postgres_db_host'} || $appConfig->{'postgres_db_host'} or croak 'postgres_db_host is not set !!!' ; 
		my $postgres_db_port    = $ENV{'postgres_db_port'} || $appConfig->{'postgres_db_port'} or croak 'postgres_db_port is not set !!!' ; 
		my $postgres_db_user 	= $ENV{'postgres_db_user'} || $appConfig->{'postgres_db_user'} or croak 'postgres_db_user is not set !!!' ; 
		my $postgres_db_user_pw = $ENV{'postgres_db_user_pw'} || $appConfig->{'postgres_db_user_pw'}  or croak 'postgres_db_user_pw is not set !!!' ; 
      my $conn_str            = 'postgresql://' . $postgres_db_user . ':' . $postgres_db_user_pw .  '@' . $postgres_db_host . ':' . $postgres_db_port . '/' . $db . '?sslmode=disable'; 
      $objLogger->doLogDebugMsg ( "conn_str: $conn_str " ) ; 
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
