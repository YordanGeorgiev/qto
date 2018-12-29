package IssueTracker::App::IO::WtrExportFactory ; 

	use strict; use warnings;
	
	use Data::Printer ; 
   use Carp ; 

   use IssueTracker::App::IO::Out::WtrExporterXls ; 
   use IssueTracker::App::IO::Out::WtrExporterMd ; 

	our $appConfig 		= {} ; 
	our $objModel        = {} ; 
   our $export_type     = 'xls' ;  # the default one


	sub doSpawn {

		my $self 			= shift ; 	
		my $export_type   = shift // $export_type ; # the default is control

		my @args 			= ( @_ ) ; 

		my $package_file  = () ; 
		my $objWtrExporter = () ;

		if ( $export_type eq 'xls' ) {
		   $package_file     = "IssueTracker/App/IO/Out/WtrExporterXls.pm" ; 
		   $objWtrExporter   = "IssueTracker::App::IO::Out::WtrExporterXls" ; 
		}
		elsif ( $export_type eq 'md' ) {
		   $package_file     = "IssueTracker/App/IO/Out/WtrExporterMd.pm" ; 
		   $objWtrExporter   = "IssueTracker::App::IO::Out::WtrExporterMd" ; 
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
