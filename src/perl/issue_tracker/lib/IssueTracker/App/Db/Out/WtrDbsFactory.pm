package IssueTracker::App::Db::Out::WtrDbsFactory ; 

	use strict; use warnings;
	
	use Data::Printer ; 
	

	our $appConfig 		= {} ; 
	our $db_type			= 'mariadb' ; 
	our $objItem			= {} ; 
	our $objController 	= {} ; 
   our $objLogger       = {} ; 

	# use IssueTracker::App::Db::MariaWtrDb  ; 
   use IssueTracker::App::Db::Out::Postgres::WtrPostgresDb ; 
   use IssueTracker::App::Db::Out::MariaDb::WtrMariaDb ; 

   our $rdbms_type  = 'postgres' ; 
	#
	# -----------------------------------------------------------------------------
	# fabricates different WtrDb object 
	# -----------------------------------------------------------------------------
	sub doInstantiate {

		my $self 			= shift ; 	
		my $db_type			= shift // $db_type ; # the default is mysql

		my @args 			= ( @_ ) ; 
		my $WtrDb 		= {}   ; 

		# get the application cnfiguration hash
		# global app cnfig hash
		my $package_file     	= () ; 
		my $objWtrDb   		= () ;

		if ( $db_type eq 'postgres' ) {
		   $package_file     = "IssueTracker/App/Db/Out/Postgres/WtrPostgresDb.pm";
		   $objWtrDb   		= "IssueTracker::App::Db::Out::Postgres::WtrPostgresDb" ; 
		}
		elsif ( $db_type eq 'mysql' ) {
			$WtrDb 				= 'WtrDbMariaDb' ; 
		   $package_file     	= "IssueTracker/App/Db/Out/MariaDb/WtrMariaDb.pm";
		   $objWtrDb   		= "IssueTracker::App::Db::Out::MariaDb::WtrMariaDb";
		}
		elsif ( $db_type eq 'mariadb' ) {
			$WtrDb 				= 'WtrDbMariaDb' ; 
		   $package_file     = "IssueTracker/App/Db/Out/MariaDb/WtrMariaDb.pm";
		   $objWtrDb   		= "IssueTracker::App::Db::Out::MariaDb::WtrMariaDb";
		}
		else {
			# future support for different RDBMS 's should be added here ...
		   $package_file     = "IssueTracker/App/Db/Out/Postgres/WtrMariaDb.pm";
		   $objWtrDb   		= "IssueTracker::App::Db::Out::Postgres::WtrMariaDb";
		}


		require $package_file;

		return $objWtrDb->new( \$appConfig , @args);
	}
	# eof sub doInstantiate
	

   #
	# -----------------------------------------------------------------------------
	# the constructor 
	# -----------------------------------------------------------------------------
	sub new {

		my $invocant 			= shift ;    
		$appConfig     = ${ shift @_ } || { 'foo' => 'bar' ,} ; 
      $objController       = shift ; 
      $rdbms_type          = shift || 'postgres' ; 
		
      # might be class or object, but in both cases invocant
		my $class = ref ( $invocant ) || $invocant ; 

		my $self = {};        # Anonymous hash reference holds instance attributes
		bless( $self, $class );    # Say: $self is a $class
      $self = $self->doInitialize() ; 
		return $self;
	}  
	#eof const
	
   #
	# --------------------------------------------------------
	# intializes this object 
	# --------------------------------------------------------
   sub doInitialize {
      my $self = shift ; 

      %$self = (
           appConfig => $appConfig
      );

	   $objLogger 			= 'IssueTracker::App::Utils::Logger'->new( \$appConfig ) ;


      return $self ; 
	}	
	#eof sub doInitialize

1;


__END__
