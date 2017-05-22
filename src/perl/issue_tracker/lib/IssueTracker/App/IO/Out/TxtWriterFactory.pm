package IssueTracker::App::IO::Out::TxtWriterFactory ; 

   use strict; use warnings;
	
	use Data::Printer ; 

	our $appConfig 		= {} ; 
	our $period			   = $ENV{'period'} || 'daily' ; 
	our $objItem			= {} ; 
	our $objController 	= {} ; 
   our $objLogger       = {} ; 

	# use IssueTracker::App::Db::WriterTxtWeekly  ; 
   use IssueTracker::App::IO::Out::WriterTxtDaily ;  
   use IssueTracker::App::IO::Out::WriterTxtWeekly ;  
   use IssueTracker::App::IO::Out::WriterTxtMonthly ;  
   use IssueTracker::App::IO::Out::WriterTxtYearly ;  

	#
	# -----------------------------------------------------------------------------
	# fabricates different WriterTxt object 
	# -----------------------------------------------------------------------------
	sub doInstantiate {

		my $self 			= shift ; 	
		my $period			= shift // $period ; # the default is mysql

		my @args 			= ( @_ ) ; 
		my $WriterTxt 		= {}   ; 

		# get the application cnfiguration hash
		# global app cnfig hash

		if ( $period eq 'daily' ) {
			$WriterTxt 				= 'WriterTxtDaily' ; 
		}
		elsif ( $period eq 'weekly' ) {
			$WriterTxt 				= 'WriterTxtWeekly' ; 
		}
		elsif ( $period eq 'monthly' ) {
			$WriterTxt 				= 'WriterTxtMonthly' ; 
		}
		elsif ( $period eq 'yearly' ) {
			$WriterTxt 				= 'WriterTxtYearly' ; 
		}
		else {
			# future support for different RDBMS 's should be added here ...
			$WriterTxt 				= 'WriterTxtDaily' ; 
		}

		my $package_file     	= "IssueTracker/App/IO/Out/$WriterTxt.pm";
		my $objWriterTxt   		= "IssueTracker::App::IO::Out::$WriterTxt";

		require $package_file;

		return $objWriterTxt->new( \$appConfig , $objController , @args);

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
