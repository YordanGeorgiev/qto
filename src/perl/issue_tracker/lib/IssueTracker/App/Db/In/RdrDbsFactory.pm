package IssueTracker::App::Db::In::RdrDbsFactory ; 

	use strict; use warnings;
	
	use Data::Printer ; 
	

	our $appConfig 		= {} ; 
	our $db_type			= 'postgres' ; 
	our $objItem			= {} ; 
	our $objController 	= {} ; 
   our $objLogger       = {} ; 

	# use IssueTracker::App::Db::RdrDbMariaDb  ; 
   use IssueTracker::App::Db::In::Postgres::RdrDb ; 

	#
	# -----------------------------------------------------------------------------
	# fabricates different RdrDb object 
	# -----------------------------------------------------------------------------
	sub doInstantiate {

		my $self 			= shift ; 	
		my $db_type			= shift // $db_type ; # the default is mysql

		my @args 			= ( @_ ) ; 
		my $package_file     	= () ; 
		my $objRdrDb   		= () ; 

		# get the application cnfiguration hash
		# global app cnfig hash

		if ( $db_type eq 'mariadb' ) {
		   $package_file     	= "IssueTracker/App/Db/In/MariaDb/RdrDb.pm";
		   $objRdrDb   		= "IssueTracker::App::Db::In::MariaDb::RdrDb";
		}
		if ( $db_type eq 'postgre' ) {
		   $package_file     	= "IssueTracker/App/Db/In/Postgres/RdrDb.pm";
		   $objRdrDb   		= "IssueTracker::App::Db::In::Postgres::RdrDb";
		}
		else {
			# future support for different RDBMS 's should be added here ...
		   $package_file     	= "IssueTracker/App/Db/In/Postgres/RdrDb.pm";
		   $objRdrDb   		= "IssueTracker::App::Db::In::Postgres::RdrDb";
		}


		require $package_file;

		return $objRdrDb->new( \$appConfig , $objController , @args);
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
