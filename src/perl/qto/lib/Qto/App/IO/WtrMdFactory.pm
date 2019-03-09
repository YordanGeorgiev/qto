package Qto::App::IO::WtrMdFactory ; 

	use strict; use warnings;
	
	use Data::Printer ; 
   use Carp ; 

   use Qto::App::IO::Out::WtrGitHubMd ; 
   use Qto::App::IO::Out::WtrParadoxMd ; 

	our $appConfig 		= {} ; 
	our $objModel        = {} ; 
   our $export_type     = 'md' ; 


	sub doSpawn{

		my $self 			= shift ; 	
		my $export_type	= shift // $export_type ; # the default is "md"

		my @args 			= ( @_ ) ; 

		my $package_file  = () ; 
		my $objWtrMd      = () ;

		if ( $export_type eq 'md' or $export_type eq 'github-md' ) {
		   $package_file     = "Qto/App/IO/Out/WtrGitHubMd.pm" ; 
		   $objWtrMd    = "Qto::App::IO::Out::WtrGitHubMd" ; 
		} elsif ( $export_type eq 'paradox-md' ) {
		   $package_file     = "Qto/App/IO/Out/WtrParadoxMd.pm" ; 
		   $objWtrMd    = "Qto::App::IO::Out::WtrParadoxMd" ; 
		}
		else {
	      croak "not implemented !!!" ; 	
      }

		require $package_file;
		return $objWtrMd->new( \$appConfig , \$objModel , @args);
	}
	

	sub new {
		my $invocant   = shift ;    
		$appConfig     = ${ shift @_ } || { 'foo' => 'bar' ,} ; 
		$objModel      = ${ shift @_ } || croak 'missing objModel !!!' ; 
      $export_type   = shift || 'Pages' ; 
		my $class      = ref ( $invocant ) || $invocant ; 
		my $self       = {}; bless( $self, $class );    # Say: $self is a $class
      $self          = $self->doInit() ; 
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
