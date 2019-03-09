package Qto::App::IO::In::RdrTextFactory ; 

   use strict; use warnings;
	
	use Data::Printer ; 

	our $appConfig 		= {} ; 
	our $term			   = $ENV{'period'} || 'daily' ; 
	our $objItem			= {} ; 
	our $objController 	= {} ; 
   our $objLogger       = {} ; 

	# use Qto::App::Db::RdrTextWeekly  ; 
   use Qto::App::IO::In::RdrText ;  

	#
	# -----------------------------------------------------------------------------
	# fabricates different RdrText object 
	# -----------------------------------------------------------------------------
	sub doInit {

		my $self 	      = shift ; 	
		my $table			= shift // 'daily_issues' ; 

		my @args 			= ( @_ ) ; 
		my $RdrText 		= {}   ; 

		# get the application cnfiguration hash
		# global app cnfig hash

		if ( $term eq 'daily' ) {
			$RdrText 				= 'RdrText' ; 
		}
		elsif ( $term eq 'weekly' ) {
			$RdrText 				= 'RdrText' ; 
		}
		elsif ( $term eq 'monthly' ) {
			$RdrText 				= 'RdrText' ; 
		}
		elsif ( $term eq 'yearly' ) {
			$RdrText 				= 'RdrText' ; 
		}
		else {
			# future support for different RDBMS 's should be added here ...
			$RdrText 				= 'RdrText' ; 
		}

		my $package_file     	= "Qto/App/IO/In/$RdrText.pm";
		my $objRdrText   		   = "Qto::App::IO::In::$RdrText";

		require $package_file;

		return $objRdrText->new( \$appConfig , $objController , $term , @args);

	}
	# eof sub doInit
	

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

	   $objLogger 			= 'Qto::App::Utils::Logger'->new( \$appConfig ) ;


      return $self ; 
	}	
	#eof sub doInitialize

1;


__END__
