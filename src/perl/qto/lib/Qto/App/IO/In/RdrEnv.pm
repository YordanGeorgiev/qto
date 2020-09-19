package Qto::App::IO::In::RdrEnv ; 

	use strict; use warnings; use utf8 ; 

	my $VERSION = '1.0.0';    

	require Exporter;
	our @ISA = qw(Exporter Qto::App::Utils::OO::SetGetable Qto::App::Utils::OO::AutoLoadable) ;
	our $AUTOLOAD =();
	use AutoLoader;
   use Carp ;
   use Data::Printer ; 
   use Getopt::Long;

   use parent 'Qto::App::Utils::OO::SetGetable' ; 
   use parent 'Qto::App::Utils::OO::AutoLoadable' ;

   use Qto::App::Utils::Logger ; 
   use Qto::App::Mdl::Model ; 

	our $module_trace                = 0 ; 
   our $module_test_run             = 0 ; 
	our $config						   = {} ; 
	our $objLogger						   = {} ; 
	our $objModel                    = {} ; 

   # 
   # read the cmd args and set them into the global app config 
   sub doRead {
      my $self = shift ;   

      $objModel->set('env.postgres_app_db' , $ENV{'postgres_app_db'});
   }

#SYNOPSIS

=head1 SYNOPSIS
      my $objRdrEnv = 
         'Qto::App::IO::In::RdrEnv'->new ( \$config ) ; 
      ( $ret , $msg ) = $objRdrEnv->doRun ( $actions ) ; 
=cut 
=head1 EXPORT
	A list of functions that can be exported.  You can delete this section
	if you don't export anything, such as for a purely object-oriented module.
=cut 

=head1 SUBROUTINES/METHODS

=cut


	

=head1 WIP

	
=cut

=head1 SUBROUTINES/METHODS

=cut


=head2 new
=cut 

	# -----------------------------------------------------------------------------
	# the constructor 
	# -----------------------------------------------------------------------------
	sub new {

		my $class      = shift;    # Class name is in the first parameter
		$config     = ${ shift @_ } || { 'foo' => 'bar' ,} ; 
		$objModel     = ${ shift @_ } || croak "objModel not passed !!!" ; 
      $module_test_run = shift if @_ ; 
		my $self = {};        # Anonymous hash reference holds instance attributes
		bless( $self, $class );    # Say: $self is a $class
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
           config => $config
      );
	   $objLogger 			= 'Qto::App::Utils::Logger'->new( \$config ) ;
      return $self ; 
	}	
	#eof sub doInitialize


1;

__END__

