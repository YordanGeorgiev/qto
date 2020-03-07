package Qto::App::Db::In::RdrDbsFcry ; 

	use strict; use warnings;
	
	use Data::Printer ; 
   use Carp ; 	

	our $config 		= {} ; 
	our $rdbms_type      = 'postgres' ; 
	our $objItem			= {} ; 
   our $objModel        = {} ; 

   use Qto::App::Db::In::Postgres::RdrPostgresDb ; 

	#
	# -----------------------------------------------------------------------------
	# fabricates / produces different RdrDb object 
	# -----------------------------------------------------------------------------
	sub doSpawn {

		my $self 			= shift ; 	
		my $rdbms_type	   = shift // $rdbms_type ; # the default is postgres
		my @args 			= ( @_ ) ; 

		my $package_file  = () ; 
		my $objRdrDb   	= () ; 

		if ( $rdbms_type eq 'postgres' ) {
		   $package_file     = "Qto/App/Db/In/Postgres/RdrPostgresDb.pm";
		   $objRdrDb   		= "Qto::App::Db::In::Postgres::RdrPostgresDb";
		}
		else {
			# future support for different RDBMS 's should be added here ...
		   $package_file     = "Qto/App/Db/In/Postgres/RdrPostgresDb.pm";
		   $objRdrDb   		= "Qto::App::Db::In::Postgres::RdrPostgresDb";
		}
		#if ( $rdbms_type eq 'mariadb' ) {
		#   $package_file     = "Qto/App/Db/In/MariaDb/RdrMariaDb.pm";
		#   $objRdrDb   		= "Qto::App::Db::In::MariaDb::RdrMariaDb";
		#}
		#elsif ( $rdbms_type eq 'mysql' ) {
		#   $package_file     = "Qto/App/Db/In/MariaDb/RdrMariaDb.pm";
		#   $objRdrDb   		= "Qto::App::Db::In::MariaDb::RdrMariaDb";
		#}

		require $package_file;
		return $objRdrDb->new( \$config , \$objModel , @args);
	}
	

	sub new {

		my $invocant   = shift ;    
		$config     = ${ shift @_ } || { 'foo' => 'bar' ,} ; 
		$objModel      = ${ shift @_ } || croak 'objModel not passed !!!' ; 
		my $class      = ref ( $invocant ) || $invocant ; 
		my $self = {}; bless( $self, $class ) ; 
      $self = $self->doInit() ; 
		return $self;
	}  
	
   sub doInit {
      my $self = shift ; 

      %$self = (
           config => $config
      );
	   #$objLogger 			= 'Qto::App::Utils::Logger'->new( \$config ) ;
      return $self ; 
	}	

1;


__END__
