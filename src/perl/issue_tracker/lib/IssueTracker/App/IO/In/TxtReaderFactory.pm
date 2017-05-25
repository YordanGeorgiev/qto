package IssueTracker::App::IO::In::TxtReaderFactory ; 

   use strict; use warnings;
	
	use Data::Printer ; 

	our $appConfig 		= {} ; 
	our $term			   = $ENV{'period'} || 'daily' ; 
	our $objItem			= {} ; 
	our $objController 	= {} ; 
   our $objLogger       = {} ; 

	# use IssueTracker::App::Db::ReaderTxtWeekly  ; 
   use IssueTracker::App::IO::In::ReaderTxtTerm ;  

	#
	# -----------------------------------------------------------------------------
	# fabricates different ReaderTxt object 
	# -----------------------------------------------------------------------------
	sub doInstantiate {

		my $self 			= shift ; 	
		my $term			= shift // $term ; # the default is mysql

		my @args 			= ( @_ ) ; 
		my $ReaderTxt 		= {}   ; 

		# get the application cnfiguration hash
		# global app cnfig hash

		if ( $term eq 'daily' ) {
			$ReaderTxt 				= 'ReaderTxtTerm' ; 
		}
		elsif ( $term eq 'weekly' ) {
			$ReaderTxt 				= 'ReaderTxtTerm' ; 
		}
		elsif ( $term eq 'monthly' ) {
			$ReaderTxt 				= 'ReaderTxtTerm' ; 
		}
		elsif ( $term eq 'yearly' ) {
			$ReaderTxt 				= 'ReaderTxtTerm' ; 
		}
		else {
			# future support for different RDBMS 's should be added here ...
			$ReaderTxt 				= 'ReaderTxtTerm' ; 
		}

		my $package_file     	= "IssueTracker/App/IO/In/$ReaderTxt.pm";
		my $objReaderTxt   		= "IssueTracker::App::IO::In::$ReaderTxt";

		require $package_file;

		return $objReaderTxt->new( \$appConfig , $objController , $term , @args);

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
