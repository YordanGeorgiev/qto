package IssueTracker::App::Model::DbHandlerFactory ; 

	use strict; use warnings;
	
	use Data::Printer ; 
	

	our $appConfig 		= {} ; 
	our $db_type			= 'mariadb' ; 
	our $objItem			= {} ; 
	our $objController 	= {} ; 

	use IssueTracker::App::Model::MariaDbHandler  ; 

	#
	# -----------------------------------------------------------------------------
	# fabricates different dbHandler object 
	# -----------------------------------------------------------------------------
	sub doInstantiate {

		my $self 			= shift ; 	
		my $db_type			= shift // $db_type ; # the default is mysql

		my @args 			= ( @_ ) ; 
		my $DbHandler 		= {}   ; 

		# get the application cnfiguration hash
		# global app cnfig hash

		if ( $db_type eq 'mariadb' ) {
			$DbHandler 				= 'MariaDbHandler' ; 
		}
		if ( $db_type eq 'postgre' ) {
			$DbHandler 				= 'PostGreDbHandler' ; 
		}
		else {
			# future support for different RDBMS 's should be added here ...
			$DbHandler 				= 'MariaDbHandler' ; 
		}

		my $package_file     	= "IssueTracker/App/Model/$DbHandler.pm";
		my $obj    	      		= "IssueTracker::App::Model::$DbHandler";

		require $package_file;

		return $obj->new( \$objController , @args);
	}
	# eof sub doInstantiate
	

	#
	# -----------------------------------------------------------------------------
	# the constructor 
	# -----------------------------------------------------------------------------
	sub new {
		
		my $invocant 			= shift ;    
		my $appConfig 			= shift ;    
		
		# might be class or object, but in both cases invocant
		my $class = ref ( $invocant ) || $invocant ; 

		my $self = {};        # Anonymous hash reference holds instance attributes
		
		bless( $self, $class );    # Say: $self is a $class
		return $self;
	}   
	#eof const


1;


__END__
