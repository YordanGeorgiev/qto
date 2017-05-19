package IssueTracker::App::IO::In::TxtReaderFactory ; 

   use strict; use warnings;
	
	use Data::Printer ; 

	our $appConfig 		= {} ; 
	our $period			   = $ENV{'period'} || 'daily' ; 
	our $objItem			= {} ; 
	our $objController 	= {} ; 
   our $objLogger       = {} ; 

	# use IssueTracker::App::Db::ReaderTxtWeekly  ; 
   use IssueTracker::App::IO::In::ReaderTxtDaily ;  
   use IssueTracker::App::IO::In::ReaderTxtWeekly ;  
   use IssueTracker::App::IO::In::ReaderTxtMonthly ;  
   use IssueTracker::App::IO::In::ReaderTxtYearly ;  

	#
	# -----------------------------------------------------------------------------
	# fabricates different ReaderTxt object 
	# -----------------------------------------------------------------------------
	sub doInstantiate {

		my $self 			= shift ; 	
		my $period			= shift // $period ; # the default is mysql

		my @args 			= ( @_ ) ; 
		my $ReaderTxt 		= {}   ; 

		# get the application cnfiguration hash
		# global app cnfig hash

		if ( $period eq 'daily' ) {
			$ReaderTxt 				= 'ReaderTxtDaily' ; 
		}
		elsif ( $period eq 'weekly' ) {
			$ReaderTxt 				= 'ReaderTxtWeekly' ; 
		}
		elsif ( $period eq 'monthly' ) {
			$ReaderTxt 				= 'ReaderTxtMonthly' ; 
		}
		elsif ( $period eq 'yearly' ) {
			$ReaderTxt 				= 'ReaderTxtYearly' ; 
		}
		else {
			# future support for different RDBMS 's should be added here ...
			$ReaderTxt 				= 'ReaderTxtDaily' ; 
		}

		my $package_file     	= "IssueTracker/App/IO/In/$ReaderTxt.pm";
		my $objReaderTxt   		= "IssueTracker::App::IO::In::$ReaderTxt";

		require $package_file;

		return $objReaderTxt->new( \$appConfig , $objController , @args);

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
