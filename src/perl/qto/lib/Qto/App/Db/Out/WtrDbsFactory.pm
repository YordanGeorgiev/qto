package Qto::App::Db::Out::WtrDbsFactory ; 

	use strict; use warnings;
	
	use Data::Printer ; 
   use Carp ; 


	our $appConfig 		= {} ; 
	our $db_type			= 'postgres' ; 
	our $objItem			= {} ; 
	our $objController 	= {} ; 
	our $objModel        = {} ; 
   our $objLogger       = {} ; 

   use Qto::App::Db::Out::Postgres::WtrPostgresDb ; 



	#
	# -----------------------------------------------------------------------------
	# fabricates different WtrDb object 
	# -----------------------------------------------------------------------------
	sub doSpawn {

		my $self 			= shift ; 	
		my $db_type			= shift // $db_type ; # the default is mysql

		my @args 			= ( @_ ) ; 
		my $WtrDb 		= {}   ; 

		my $package_file     	= () ; 
		my $objWtrDb   		= () ;

		if ( $db_type eq 'postgres' ) {
		   $package_file     = "Qto/App/Db/Out/Postgres/WtrPostgresDb.pm";
		   $objWtrDb   		= "Qto::App::Db::Out::Postgres::WtrPostgresDb" ; 
		}
		else {
		   $package_file     = "Qto/App/Db/Out/Postgres/WtrPostgresDb.pm";
		   $objWtrDb   		= "Qto::App::Db::Out::Postgres::WtrPostgresDb" ; 
		}
		# future support for different RDBMS 's should be added as follows
		#elsif ( $db_type eq 'mysql' ) {
		#	$WtrDb 				= 'WtrDbMariaDb' ; 
		#   $package_file     	= "Qto/App/Db/Out/MariaDb/WtrMariaDb.pm";
		#   $objWtrDb   		= "Qto::App::Db::Out::MariaDb::WtrMariaDb";
		#}
		#elsif ( $db_type eq 'mariadb' ) {
		#	$WtrDb 				= 'WtrDbMariaDb' ; 
		#   $package_file     = "Qto/App/Db/Out/MariaDb/WtrMariaDb.pm";
		#   $objWtrDb   		= "Qto::App::Db::Out::MariaDb::WtrMariaDb";
		#}

		require $package_file;

		return $objWtrDb->new( \$appConfig , \$objModel , @args);
	}
	

	sub new {

		my $invocant 			= shift ;    
		$appConfig           = ${ shift @_ } || { 'foo' => 'bar' } ; 
		$objModel            = ${ shift @_ } || croak 'objModel not passed !!!' ; 
      $db_type             = shift || 'postgres' ; 
		my $class = ref ( $invocant ) || $invocant ; 
	   my $self = {}; bless( $self, $class );    
      $self = $self->doInitialize() ; 
		return $self;
	}  
	
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
