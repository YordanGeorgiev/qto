package IssueTracker::App::IO::In::TxtReaderFactory ; 

   use strict; use warnings;
	
	use Data::Printer ; 

	our $appConfig 		= {} ; 
	our $term			   = $ENV{'period'} || 'daily' ; 
	our $objItem			= {} ; 
	our $objController 	= {} ; 
   our $objLogger       = {} ; 

	# use IssueTracker::App::Db::TxtReaderWeekly  ; 
   use IssueTracker::App::IO::In::TxtReader ;  

	#
	# -----------------------------------------------------------------------------
	# fabricates different TxtReader object 
	# -----------------------------------------------------------------------------
	sub doInstantiate {

		my $self 	      = shift ; 	
		my $table			= shift // 'daily_issues' ; 

		my @args 			= ( @_ ) ; 
		my $TxtReader 		= {}   ; 

		# get the application cnfiguration hash
		# global app cnfig hash

		if ( $term eq 'daily' ) {
			$TxtReader 				= 'TxtReader' ; 
		}
		elsif ( $term eq 'weekly' ) {
			$TxtReader 				= 'TxtReader' ; 
		}
		elsif ( $term eq 'monthly' ) {
			$TxtReader 				= 'TxtReader' ; 
		}
		elsif ( $term eq 'yearly' ) {
			$TxtReader 				= 'TxtReader' ; 
		}
		else {
			# future support for different RDBMS 's should be added here ...
			$TxtReader 				= 'TxtReader' ; 
		}

		my $package_file     	= "IssueTracker/App/IO/In/$TxtReader.pm";
		my $objTxtReader   		= "IssueTracker::App::IO::In::$TxtReader";

		require $package_file;

		return $objTxtReader->new( \$appConfig , $objController , $term , @args);

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
