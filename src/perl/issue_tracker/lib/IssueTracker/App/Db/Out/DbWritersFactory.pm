package IssueTracker::App::Db::Out::DbWritersFactory ; 

	use strict; use warnings;
	
	use Data::Printer ; 
	

	our $appConfig 		= {} ; 
	our $db_type			= 'mariadb' ; 
	our $objItem			= {} ; 
	our $objController 	= {} ; 
   our $objLogger       = {} ; 

	# use IssueTracker::App::Db::MariaDbWriter  ; 
   use IssueTracker::App::Db::Out::DbWriterPostgres ; 


	#
	# -----------------------------------------------------------------------------
	# fabricates different DbWriter object 
	# -----------------------------------------------------------------------------
	sub doInstantiate {

		my $self 			= shift ; 	
		my $db_type			= shift // $db_type ; # the default is mysql

		my @args 			= ( @_ ) ; 
		my $DbWriter 		= {}   ; 

		# get the application cnfiguration hash
		# global app cnfig hash

		if ( $db_type eq 'mariadb' ) {
			$DbWriter 				= 'DbWriterMariaDb' ; 
		}
		if ( $db_type eq 'postgre' ) {
			$DbWriter 				= 'DbWriterPostgres' ; 
		}
		else {
			# future support for different RDBMS 's should be added here ...
			$DbWriter 				= 'MariaDbWriter' ; 
		}

		my $package_file     	= "IssueTracker/App/Db/Out/$DbWriter.pm";
		my $objDbWriter   		= "IssueTracker::App::Db::Out::$DbWriter";

		require $package_file;

		return $objDbWriter->new( \$appConfig , $objController , @args);
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
