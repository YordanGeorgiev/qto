package IssueTracker::Controller::PageFactory ; 

	use strict; use warnings;
   use Carp ; 
	use Data::Printer ; 

   use IssueTracker::Controller::ListCloud ; 
   use IssueTracker::Controller::ListGrid ; 
   use IssueTracker::Controller::SearchGrid ; 
   use IssueTracker::Controller::ListLabels ; 
   use IssueTracker::Controller::ListReadOnlyGrid ; 
   use IssueTracker::Controller::ListPrintTable ; 

	our $appConfig 		= {} ; 
	our $objModel        = {} ; 
   our $ui_type         = 'page/list-grid' ; 


	sub doInstantiate {

		my $self 			   = shift ; 	
		my $ui_type			   = shift // $ui_type ; 
		my @args 			   = ( @_ ) ; 

		my $package_file     = () ; 
		my $objWtrControl    = () ;

		if ( $ui_type eq 'page/list-labels' ) {
		   $package_file     = "IssueTracker/Controller/ListLabels.pm" ; 
		   $objWtrControl    = "IssueTracker::Controller::ListLabels" ; 
		}
		elsif ( $ui_type eq 'page/list-cloud' ) {
		   $package_file     = "IssueTracker/Controller/ListCloud.pm" ; 
		   $objWtrControl    = "IssueTracker::Controller::ListCloud" ; 
		}
		elsif ( $ui_type eq 'page/list-labels' ) {
		   $package_file     = "IssueTracker/Controller/ListLabels.pm" ; 
		   $objWtrControl    = "IssueTracker::Controller::ListLabels" ; 
		}
		elsif ( $ui_type eq 'page/list-rgrid' ) {
		   $package_file     = "IssueTracker/Controller/ListReadOnlyGrid.pm" ; 
		   $objWtrControl    = "IssueTracker::Controller::ListReadOnlyGrid" ; 
		}
		elsif ( $ui_type eq 'page/list-grid' ) {
		   $package_file     = "IssueTracker/Controller/ListGrid.pm" ; 
		   $objWtrControl    = "IssueTracker::Controller::ListGrid" ; 
		}
		elsif ( $ui_type eq 'page/list-print-table' ) {
		   $package_file     = "IssueTracker/Controller/ListPrintTable.pm" ; 
		   $objWtrControl    = "IssueTracker::Controller::ListPrintTable" ; 
		}
		elsif ( $ui_type eq 'page/srch-grid' ) {
		   $package_file     = "IssueTracker/Controller/SearchGrid.pm" ; 
		   $objWtrControl    = "IssueTracker::Controller::SearchGrid" ; 
		}
		else {
	      croak "ui_type : $ui_type is not implemented !!!" ; 	
      }

		require $package_file;

		return $objWtrControl->new( \$appConfig , \$objModel , @args);
	}


	sub new {

		my $invocant 			= shift ;    
		$appConfig           = ${ shift @_ } || { 'foo' => 'bar' ,} ; 
		$objModel            = ${ shift @_ } || croak 'missing objModel !!!' ; 
      my $class            = ref ( $invocant ) || $invocant ; 
		my $self             = {}; bless( $self, $class );   
      $self                = $self->doInitialize() ; 
		return $self;
	}  


   sub doInitialize {
      my $self = shift ; 

      %$self = (
           appConfig => $appConfig
      );

      return $self ; 
	}	

1;


__END__
