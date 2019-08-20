package Qto::App::IO::Out::WtrTextFactory ; 

   use strict; use warnings;
	
	use Data::Printer ; 

	our $config 		= {} ; 
	our $term			   = $ENV{'period'} || 'daily' ; 
	our $table			   = $ENV{'tables'} || 'daily_issues' ; 
	our $objItem			= {} ; 
	our $objController 	= {} ; 
   our $objLogger       = {} ; 

	# use Qto::App::Db::WtrTextWeekly  ; 
   use Qto::App::IO::Out::WtrText ;  

	#
	# -----------------------------------------------------------------------------
	# fabricates different WtrText object 
	# -----------------------------------------------------------------------------
	sub doInit {

		my $self 			= shift ; 	
		my $table			= shift // $table ; # the default is 'daily'

		my @args 			= ( @_ ) ; 
		my $WtrText 		= {}   ; 
	   $WtrText 				= 'WtrText' ; 

		my $package_file     	= "Qto/App/IO/Out/$WtrText.pm";
		my $objWtrText   		= "Qto::App::IO::Out::$WtrText";

		require $package_file;

		return $objWtrText->new( \$config , $table , @args);

	}
	# eof sub doInit
	

   #
	# -----------------------------------------------------------------------------
	# the constructor 
	# -----------------------------------------------------------------------------
	sub new {

		my $invocant 			= shift ;    
		$config           = ${ shift @_ } || { 'foo' => 'bar' ,} ; 
		
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
           config => $config
      );

	   $objLogger 			= 'Qto::App::Utils::Logger'->new( \$config ) ;


      return $self ; 
	}	
	#eof sub doInitialize

1;


__END__
