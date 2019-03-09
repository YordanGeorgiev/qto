package Qto::App::IO::WtrExportFactory ; 

	use strict; use warnings;
	
	use Data::Printer ; 
   use Carp ; 

   use Qto::App::IO::Out::WtrExporterXls ; 
   use Qto::App::IO::Out::WtrExporterMd ; 

	our $appConfig 		= {} ; 
	our $objModel        = {} ; 
   our $export_type     = 'xls' ;  # the default one


	sub doSpawn {

		my $self 			= shift ; 	
		my $export_type   = shift // $export_type ; # the default is control

		my @args 			= ( @_ ) || () ; 
      unshift @args, $export_type ;

		my $package_file  = () ; 
		my $objWtrExporter = () ;

		if ( $export_type eq 'xls' ) {
		   $package_file     = "Qto/App/IO/Out/WtrExporterXls.pm" ; 
		   $objWtrExporter   = "Qto::App::IO::Out::WtrExporterXls" ; 
		}
		elsif ( $export_type eq 'md' or $export_type eq 'github-md' ) {
		   $package_file     = "Qto/App/IO/Out/WtrExporterMd.pm" ; 
		   $objWtrExporter   = "Qto::App::IO::Out::WtrExporterMd" ; 
		}
		elsif ( $export_type eq 'paradox-md' ) {
		   $package_file     = "Qto/App/IO/Out/WtrExporterMd.pm" ; 
		   $objWtrExporter   = "Qto::App::IO::Out::WtrExporterMd" ; 
		}
		else {
	      croak "the export type: \"$export_type\" is not implemented !!!" ; 	
      }

		require $package_file;

		return $objWtrExporter->new( \$appConfig , \$objModel , @args);
	}
	

	sub new {
		my $invocant 			= shift ;    
		$appConfig           = ${ shift @_ } || croak 'missing appConfig !!!' ; 
		$objModel            = ${ shift @_ } || croak 'missing objModel !!!' ; 
      $export_type         = shift || $export_type ; 
		my $class            = ref ( $invocant ) || $invocant ; 
		my $self             = {}; bless( $self, $class ); 
      $self                = $self->doInit() ; 
		return $self;
	}  


   sub doInit {
      my $self = shift ; 

      %$self = (
           appConfig => $appConfig
      );

      return $self ; 
	}	

1;


__END__
