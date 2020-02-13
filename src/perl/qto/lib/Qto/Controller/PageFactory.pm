package Qto::Controller::PageFactory ; 

	use strict; use warnings;
   use Carp ; 
	use Data::Printer ; 

   use Qto::Controller::ListGrid ; 
   use Qto::Controller::ListLabels ; 
   use Qto::Controller::ListPrintTable ; 
   use Qto::Controller::SearchGrid ; 

	our $config 		   = {} ; 
	our $objModel           = {} ; 
   our $ui_type            = 'page/list-grid' ; 

   
   # objPageFactory->doInit
   # 
	sub doSpawn {

		my $self 			   = shift ; 	
		my $ui_type			   = shift // $ui_type ; 
		my @args 			   = ( @_ ) ; 

		my $package_file     = () ; 
		my $objPageBuilder   = () ;

		if ( $ui_type eq 'page/list-labels' ) {
		   $package_file     = "Qto/Controller/ListLabels.pm" ; 
		   $objPageBuilder   = "Qto::Controller::ListLabels" ; 
		}
		elsif ( $ui_type eq 'page/list-grid' ) {
		   $package_file     = "Qto/Controller/ListGrid.pm" ; 
		   $objPageBuilder   = "Qto::Controller::ListGrid" ; 
		}
		elsif ( $ui_type eq 'page/list-print-table' ) {
		   $package_file     = "Qto/Controller/ListPrintTable.pm" ; 
		   $objPageBuilder   = "Qto::Controller::ListGrid" ; 
		}
		elsif ( $ui_type eq 'page/srch-grid' ) {
		   $package_file     = "Qto/Controller/SearchGrid.pm" ; 
		   $objPageBuilder   = "Qto::Controller::SearchGrid" ; 
		}
		elsif ( $ui_type eq 'page/view-doc' ) {
		   $package_file     = "Qto/Controller/ViewDoc.pm" ; 
		   $objPageBuilder   = "Qto::Controller::ViewDoc" ; 
		}
		else {
	      croak "ui_type : $ui_type is not implemented !!!" ; 	
      }

		require $package_file;

		return $objPageBuilder->new( \$config , \$objModel , @args);
	}


	sub new {
		my $invocant 			= shift ;    
		$config           = ${ shift @_ } || croak 'config not set !!!' ; 
		$objModel            = ${ shift @_ } || croak 'objModel not set !!!' ; 
      my $class            = ref ( $invocant ) || $invocant ; 
		my $self             = {}; bless( $self, $class );   
      $self                = $self->doInit() ; 
		return $self;
	}  


   sub doInit {
      my $self = shift ; 

      %$self = (
           config => $config
      );

      return $self ; 
	}	


1;


__END__
