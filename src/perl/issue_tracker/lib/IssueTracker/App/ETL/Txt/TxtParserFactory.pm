package IssueTracker::App::ETL::Txt::TxtParserFactory ; 
	use strict; use warnings;
	
	use Data::Printer ; 
	

	our $appConfig 		= {} ; 
	our $period			   = $ENV{'period'} || 'daily' ; 
	our $objItem			= {} ; 
	our $objController 	= {} ; 
   our $objLogger       = {} ; 

	# use IssueTracker::App::Db::TxtParserWeekly  ; 
   use IssueTracker::App::ETL::Txt::TxtParserDaily ; 
   use IssueTracker::App::ETL::Txt::TxtParserWeekly ; 
   use IssueTracker::App::ETL::Txt::TxtParserMonthly ; 
   use IssueTracker::App::ETL::Txt::TxtParserYearly ; 


	#
	# -----------------------------------------------------------------------------
	# fabricates different TxtParser object 
	# -----------------------------------------------------------------------------
	sub doInstantiate {

		my $self 			= shift ; 	
		my $period			= shift // $period ; # the default is mysql

		my @args 			= ( @_ ) ; 
		my $TxtParser 		= {}   ; 

		# get the application cnfiguration hash
		# global app cnfig hash

		if ( $period eq 'daily' ) {
			$TxtParser 				= 'TxtParserDaily' ; 
		}
		elsif ( $period eq 'weekly' ) {
			$TxtParser 				= 'TxtParserWeekly' ; 
		}
		elsif ( $period eq 'monthly' ) {
			$TxtParser 				= 'TxtParserMonthly' ; 
		}
		elsif ( $period eq 'yearly' ) {
			$TxtParser 				= 'TxtParserYearly' ; 
		}
		else {
			# future support for different RDBMS 's should be added here ...
			$TxtParser 				= 'TxtParserDaily' ; 
		}

		my $package_file     	= "IssueTracker/App/ETL/Txt/$TxtParser.pm";
		my $objTxtParser   		= "IssueTracker::App::ETL::Txt::$TxtParser";

		require $package_file;

		return $objTxtParser->new( \$appConfig , $objController , @args);

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
