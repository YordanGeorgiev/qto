package IssueTracker::App::Db::Out::WtrDbsFactory ; 

	use strict; use warnings;
	
	use Data::Printer ; 
	

	our $appConfig 		= {} ; 
	our $db_type			= 'mariadb' ; 
	our $objItem			= {} ; 
	our $objController 	= {} ; 
   our $objLogger       = {} ; 

	# use IssueTracker::App::Db::MariaWtrDb  ; 
   use IssueTracker::App::Db::Out::Postgres::WtrDb ; 
   use IssueTracker::App::Db::Out::MariaDb::WtrDb ; 


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

		if ( $db_type eq 'mariadb' ) {
			$WtrDb 				= 'WtrDbMariaDb' ; 
		   $package_file     	= "IssueTracker/App/Db/Out/MariaDb/WtrDb.pm";
		   $objWtrDb   		= "IssueTracker::App::Db::Out::MariaDb::WtrDb";
		}
		if ( $db_type eq 'postgre' ) {
		   $package_file     	= "IssueTracker/App/Db/Out/Postgres/WtrDb.pm";
		   $objWtrDb   		= "IssueTracker::App::Db::Out::Postgres::WtrDb";
		}
		else {
			# future support for different RDBMS 's should be added here ...
		   $package_file     	= "IssueTracker/App/Db/Out/Postgres/WtrDb.pm";
		   $objWtrDb   		= "IssueTracker::App::Db::Out::Postgres::WtrDb";
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
