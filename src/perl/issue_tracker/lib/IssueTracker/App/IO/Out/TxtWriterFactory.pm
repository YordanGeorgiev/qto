package IssueTracker::App::IO::Out::TxtWriterFactory ; 

   use strict; use warnings;
	
	use Data::Printer ; 

	our $appConfig 		= {} ; 
	our $term			   = $ENV{'period'} || 'daily' ; 
	our $objItem			= {} ; 
	our $objController 	= {} ; 
   our $objLogger       = {} ; 

	# use IssueTracker::App::Db::WriterTxtWeekly  ; 
   use IssueTracker::App::IO::Out::WriterTxtTerm ;  

	#
	# -----------------------------------------------------------------------------
	# fabricates different WriterTxt object 
	# -----------------------------------------------------------------------------
	sub doInstantiate {

		my $self 			= shift ; 	
		my $term			   = shift // $term ; # the default is 'daily'

		my @args 			= ( @_ ) ; 
		my $WriterTxt 		= {}   ; 

		# get the application cnfiguration hash
		# global app cnfig hash

		if ( $term eq 'daily' ) {
			$WriterTxt 				= 'WriterTxtTerm' ; 
		}
		elsif ( $term eq 'weekly' ) {
			$WriterTxt 				= 'WriterTxtTerm' ; 
		}
		elsif ( $term eq 'monthly' ) {
			$WriterTxt 				= 'WriterTxtTerm' ; 
		}
		elsif ( $term eq 'yearly' ) {
			$WriterTxt 				= 'WriterTxtTerm' ; 
		}
		else {
			# future support for different RDBMS 's should be added here ...
			$WriterTxt 				= 'WriterTxtTerm' ; 
		}

		my $package_file     	= "IssueTracker/App/IO/Out/$WriterTxt.pm";
		my $objWriterTxt   		= "IssueTracker::App::IO::Out::$WriterTxt";

		require $package_file;

		return $objWriterTxt->new( \$appConfig , $objController , $term , @args);

	}
	# eof sub doInstantiate
	

   #
	# -----------------------------------------------------------------------------
	# the constructor 
	# -----------------------------------------------------------------------------
	sub new {

		my $invocant 			= shift ;    
		$appConfig           = ${ shift @_ } || { 'foo' => 'bar' ,} ; 
      $objController       = shift ; 
      $term                = shift || 'daily' ; 
		
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
