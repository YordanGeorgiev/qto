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
	our $appConfig						   = {} ; 
	our $objLogger						   = {} ; 
	our $objModel                    = {} ; 

   # 
   # read the cmd args and set them into the global app config 
   sub doRead {
      my $self = shift ;   

      $objModel->set('env.postgres_db_name' , $ENV{'postgres_db_name'});
   }

#SYNOPSIS

=head1 SYNOPSIS
      my $objRdrEnv = 
         'Qto::App::IO::In::RdrEnv'->new ( \$appConfig ) ; 
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
		$appConfig     = ${ shift @_ } || { 'foo' => 'bar' ,} ; 
		$objModel     = ${ shift @_ } || croak "objModel not passed !!!" ; 
      $module_test_run = shift if @_ ; 
		my $self = {};        # Anonymous hash reference holds instance attributes
		bless( $self, $class );    # Say: $self is a $class
      $self = $self->doInitialize() ; 
		return $self;
	}  
	#eof const
	
   #
	# --------------------------------------------------------
	# intializes this object 
	# --------------------------------------------------------
   sub doInitialize {
      my $self = shift ; 

      %$self = (
           appConfig => $appConfig
      );
	   $objLogger 			= 'Qto::App::Utils::Logger'->new( \$appConfig ) ;
      return $self ; 
	}	
	#eof sub doInitialize


1;

__END__

