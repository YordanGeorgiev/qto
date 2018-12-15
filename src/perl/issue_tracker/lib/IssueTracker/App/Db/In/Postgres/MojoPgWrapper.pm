package IssueTracker::App::Db::In::Postgres::MojoPgWrapper ; 

   use strict ; use warnings ; use utf8 ; 
   require Exporter; our @ISA = qw(Exporter Mojo::Pg) ; 
   our $AUTOLOAD =();
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

   use IssueTracker::App::Utils::Logger ; 
   use IssueTracker::App::Mdl::Model ; 

   our $objModel        = {} ;
   our $appConfig       = {} ;
   our $objLogger       = {} ;


   sub new {
		my $invocant   = shift ;    
		$appConfig     = ${ shift @_ } || croak 'appConfig not passed in MojoPgWrapper !!!' ; 
		$objModel      = ${ shift @_ } || croak 'objModel not passed in MojoPgWrapper !!!' ; 
		my $class      = ref ( $invocant ) || $invocant ; 
		my $self       = {} ; bless( $self, $class ) ;  
      $self          = doInit() ; 
		return $self;
	}  


   sub doInit {

      my $self                = shift ; 
      
      %$self = (
           appConfig => $appConfig
      );

      $objLogger 			      = 'IssueTracker::App::Utils::Logger'->new( \$appConfig ) ;
		my $db                  = $appConfig->{'postgres_db_name'} or croak 'postgres_db_name is not set !!!'  ;
		my $db_host 			   = $appConfig->{'db_host'} or croak 'db_host is not set !!!' ; 
		my $db_port 			   = $appConfig->{'db_port'} or croak 'db_port is not set !!!' ; 
		my $postgres_db_user 	= $appConfig->{'postgres_db_user'} or croak 'postgres_db_user is not set !!!' ; 
		my $postgres_db_user_pw = $appConfig->{'postgres_db_user_pw'}  or croak 'postgres_db_user_pw is not set !!!' ; 
      my $conn_str            = 'postgresql://' . $postgres_db_user . ':' . $postgres_db_user_pw .  '@' . $db_host . ':' . $db_port . '/' . $db . '?sslmode=disable'; 
      #my $conn_str            = 'postgresql://postgres@' . $db_host . ':' . $db_port . '/' . $db . '?sslmode=disable' ; 
      #debug $objLogger->doLogDebugMsg ( "conn_str: $conn_str " ) ; 
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
