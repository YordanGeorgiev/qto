package IssueTracker::App::UI::WtrUIFactory ; 

	use strict; use warnings;
	
	use Data::Printer ; 
   use Carp ; 

   use IssueTracker::App::UI::Controls::WtrVueListLabelsTemplate ; 
   use IssueTracker::App::UI::Controls::WtrJQCloud ; 

	our $appConfig 		= {} ; 
	our $objModel        = {} ; 
   our $ui_type         = 'pages' ; 


	sub doInstantiate {

		my $self 			= shift ; 	
		my $ui_type			= shift // $ui_type ; # the default is control

		my @args 			= ( @_ ) ; 

		my $package_file  = () ; 
		my $objWtrControl = () ;

		if ( $ui_type eq 'control/list-labels' ) {
		   $package_file     = "IssueTracker/App/UI/Controls/WtrVueListLabelsTemplate.pm" ; 
		   $objWtrControl    = "IssueTracker::App::UI::Controls::WtrVueListLabelsTemplate" ; 
		}
		elsif ( $ui_type eq 'control/list-cloud' ) {
		   $package_file     = "IssueTracker/App/UI/Controls/WtrJQCloud.pm" ; 
		   $objWtrControl    = "IssueTracker::App::UI::Controls::WtrJQCloud" ; 
		}
		else {
	      croak "not implemented !!!" ; 	
      }

		require $package_file;

		return $objWtrControl->new( \$appConfig , \$objModel , @args);
	}
	

	sub new {

		my $invocant 			= shift ;    
		$appConfig     = ${ shift @_ } || { 'foo' => 'bar' ,} ; 
		$objModel      = ${ shift @_ } || croak 'missing objModel !!!' ; 
      $ui_type          = shift || 'Pages' ; 
		
      # might be class or object, but in both cases invocant
		my $class = ref ( $invocant ) || $invocant ; 

		my $self = {};        # Anonymous hash reference holds instance attributes
		bless( $self, $class );    # Say: $self is a $class
      $self = $self->doInitialize() ; 
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
