package IssueTracker::App::Db::In::RdrDbsFactory ; 

	use strict; use warnings;
	
	use Data::Printer ; 
	

	our $appConfig 		= {} ; 
	our $rdbms_type      = 'postgres' ; 
	our $objItem			= {} ; 
   our $objLogger       = {} ; 
   our $objModel         = {} ; 

	# use IssueTracker::App::Db::RdrDbMariaDb  ; 
   use IssueTracker::App::Db::In::Postgres::RdrPostgresDb ; 
   use IssueTracker::App::Db::In::MariaDb::RdrMariaDb ; 

	#
	# -----------------------------------------------------------------------------
	# fabricates different RdrDb object 
	# -----------------------------------------------------------------------------
	sub doInstantiate {

		my $self 			= shift ; 	
		my $rdbms_type	   = shift // $rdbms_type ; # the default is postgres

		my @args 			= ( @_ ) ; 
		my $package_file  = () ; 
		my $objRdrDb   	= () ; 

		# get the application cnfiguration hash
		# global app cnfig hash

		if ( $rdbms_type eq 'mariadb' ) {
		   $package_file     = "IssueTracker/App/Db/In/MariaDb/RdrMariaDb.pm";
		   $objRdrDb   		= "IssueTracker::App::Db::In::MariaDb::RdrMariaDb";
		}
		elsif ( $rdbms_type eq 'mysql' ) {
		   $package_file     = "IssueTracker/App/Db/In/MariaDb/RdrMariaDb.pm";
		   $objRdrDb   		= "IssueTracker::App::Db::In::MariaDb::RdrMariaDb";
		}
		elsif ( $rdbms_type eq 'postgres' ) {
		   $package_file     = "IssueTracker/App/Db/In/Postgres/RdrPostgresDb.pm";
		   $objRdrDb   		= "IssueTracker::App::Db::In::Postgres::RdrPostgresDb";
		}
		else {
			# future support for different RDBMS 's should be added here ...
		   $package_file     = "IssueTracker/App/Db/In/Postgres/RdrPostgresDb.pm";
		   $objRdrDb   		= "IssueTracker::App::Db::In::Postgres::RdrPostgresDb";
		}

		require $package_file;
		return $objRdrDb->new( \$appConfig , \$objModel , @args);
	}
	# eof sub doInstantiate
	

   #
	# -----------------------------------------------------------------------------
	# the constructor 
	# -----------------------------------------------------------------------------
	sub new {

		my $invocant 			= shift ;    
		$appConfig     = ${ shift @_ } || { 'foo' => 'bar' ,} ; 
		
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
