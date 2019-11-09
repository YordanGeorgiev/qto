package Qto::App::UI::WtrUIFactory ; 

	use strict; use warnings;
	
	use Data::Printer ; 
   use Carp ; 

   use Qto::App::UI::Controls::WtrListLabels ; 
   use Qto::App::UI::Controls::WtrLeftMenu ; 

	our $config 		= {} ; 
	our $objModel        = {} ; 
   our $ui_type         = 'pages' ; 


	sub doInit {

		my $self 			= shift ; 	
		my $ui_type			= shift // $ui_type ; # the default is control

		my @args 			= ( @_ ) ; 

		my $package_file  = () ; 
		my $objWtrControl = () ;

		if ( $ui_type eq 'control/list-labels' ) {
		   $package_file     = "Qto/App/UI/Controls/WtrListLabels.pm" ; 
		   $objWtrControl    = "Qto::App::UI::Controls::WtrListLabels" ; 
		}
		elsif ( $ui_type eq 'control/left-menu' ) {
		   $package_file     = "Qto/App/UI/Controls/WtrLeftMenu.pm" ; 
		   $objWtrControl    = "Qto::App::UI::Controls::WtrLeftMenu" ; 
		}
		else {
	      croak "not implemented !!!" ; 	
      }

		require $package_file;

		return $objWtrControl->new( \$config , \$objModel , @args);
	}
	

	sub new {

		my $invocant 			= shift ;    
		$config     = ${ shift @_ } || { 'foo' => 'bar' ,} ; 
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
           config => $config
      );

      return $self ; 
	}	

1;


__END__
