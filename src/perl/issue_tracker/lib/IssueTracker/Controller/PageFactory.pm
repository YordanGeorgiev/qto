package IssueTracker::Controller::PageFactory ; 

	use strict; use warnings;
   use Carp ; 
	use Data::Printer ; 

   use IssueTracker::Controller::ListGrid ; 
   use IssueTracker::Controller::ListLabels ; 
   use IssueTracker::Controller::ListCloud ; 
   use IssueTracker::Controller::ListPrintTable ; 
   use IssueTracker::Controller::SearchGrid ; 

	our $appConfig 		   = {} ; 
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
		   $package_file     = "IssueTracker/Controller/ListLabels.pm" ; 
		   $objPageBuilder   = "IssueTracker::Controller::ListLabels" ; 
		}
		elsif ( $ui_type eq 'page/list-cloud' ) {
		   $package_file     = "IssueTracker/Controller/ListCloud.pm" ; 
		   $objPageBuilder   = "IssueTracker::Controller::ListCloud" ; 
		}
		elsif ( $ui_type eq 'page/list-grid' ) {
		   $package_file     = "IssueTracker/Controller/ListGrid.pm" ; 
		   $objPageBuilder   = "IssueTracker::Controller::ListGrid" ; 
		}
		elsif ( $ui_type eq 'page/list-print-table' ) {
		   $package_file     = "IssueTracker/Controller/ListPrintTable.pm" ; 
		   $objPageBuilder   = "IssueTracker::Controller::ListPrintTable" ; 
		}
		elsif ( $ui_type eq 'page/srch-grid' ) {
		   $package_file     = "IssueTracker/Controller/SearchGrid.pm" ; 
		   $objPageBuilder   = "IssueTracker::Controller::SearchGrid" ; 
		}
		elsif ( $ui_type eq 'page/view-doc' ) {
		   $package_file     = "IssueTracker/Controller/ViewDoc.pm" ; 
		   $objPageBuilder   = "IssueTracker::Controller::ViewDoc" ; 
		}
		else {
	      croak "ui_type : $ui_type is not implemented !!!" ; 	
      }

		require $package_file;

		return $objPageBuilder->new( \$appConfig , \$objModel , @args);
	}


	sub new {

		my $invocant 			= shift ;    
		$appConfig           = ${ shift @_ } || croak 'appConfig not set !!!' ; 
		$objModel            = ${ shift @_ } || croak 'objModel not set !!!' ; 
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
