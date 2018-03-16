package IssueTracker::App::IO::In::RdrCmdArgs ; 

	use strict; use warnings; use utf8 ; 

	my $VERSION = '1.0.0';    

	require Exporter;
	our @ISA = qw(Exporter IssueTracker::App::Utils::OO::SetGetable IssueTracker::App::Utils::OO::AutoLoadable) ;
	our $AUTOLOAD =();
	use AutoLoader;
   use Carp ;
   use Data::Printer ; 
   use Getopt::Long;

   use parent 'IssueTracker::App::Utils::OO::SetGetable' ; 
   use parent 'IssueTracker::App::Utils::OO::AutoLoadable' ;

   use IssueTracker::App::Utils::Logger ; 
   use IssueTracker::App::Mdl::Model ; 

	our $module_trace                = 0 ; 
   our $module_test_run             = 0 ; 
	our $appConfig						   = {} ; 
	our $objLogger						   = {} ; 
	our $objModel                    = {} ; 

   # 
   # read the cmd args and set them into the global app config 
   sub doRead {
      my $self = shift ;   
      my $actions       = q{} ; 
      my $xls_dir       = q{} ; 
      my $xls_file      = q{} ; 
      my $period        = q{} ; 
      my $tables        = q{} ; 
      my $rdbms_type    = q{} ; 

     # get the cmd args
     GetOptions(
       'do=s'          => \$actions,
       'xls_dir=s'     => \$xls_dir,
       'xls-file=s'    => \$xls_file,
       'period=s'      => \$period ,
       'tables=s'      => \$tables ,
       'rdbms-type=s'  => \$rdbms_type
     );

     # set the default action 
     $objModel->set('ctrl.tables' , $tables ) ; 
     $objModel->set('ctrl.period' , $period ) ; 
     $objModel->set('ctrl.actions' , $actions ) ; 
     $objModel->set('ctrl.rdbms-type' , $rdbms_type ) ; 
     $objModel->set('io.xls-file' , $xls_file ) ; 
     $objModel->set('io.xls-dir' , $xls_file ) ; 
   }
   # eof sub doRead

#SYNOPSIS

=head1 SYNOPSIS
      my $objRdrCmdArgs = 
         'IssueTracker::App::IO::In::RdrCmdArgs'->new ( \$appConfig ) ; 
      ( $ret , $msg ) = $objRdrCmdArgs->doRun ( $actions ) ; 
=cut 
=head1 EXPORT
	A list of functions that can be exported.  You can delete this section
	if you don't export anything, such as for a purely object-oriented module.
=cut 

=head1 SUBROUTINES/METHODS

	# -----------------------------------------------------------------------------
	START SUBS 
=cut


	

=head1 WIP

	
=cut

=head1 SUBROUTINES/METHODS

	STOP  SUBS 
	# -----------------------------------------------------------------------------
=cut


=head2 new
	# -----------------------------------------------------------------------------
	# the constructor
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
      $self->doRead() ; 
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

	   $objLogger 			= 'IssueTracker::App::Utils::Logger'->new( \$appConfig ) ;


      return $self ; 
	}	
	#eof sub doInitialize

=head2
	# -----------------------------------------------------------------------------
	# overrided autoloader prints - a run-time error - perldoc AutoLoader
	# -----------------------------------------------------------------------------
=cut
	sub AUTOLOAD {

		my $self = shift;
		no strict 'refs';
		my $name = our $AUTOLOAD;
		*$AUTOLOAD = sub {
			my $msg =
			  "BOOM! BOOM! BOOM! \n RunTime Error !!! \n Undefined Function $name(@_) \n ";
			croak "$self , $msg $!";
		};
		goto &$AUTOLOAD;    # Restart the new routine.
	}   
	# eof sub AUTOLOAD


	# -----------------------------------------------------------------------------
	# wrap any logic here on clean up for this class
	# -----------------------------------------------------------------------------
	sub RunBeforeExit {

		my $self = shift;

		#debug print "%$self RunBeforeExit ! \n";
	}
	#eof sub RunBeforeExit


	# -----------------------------------------------------------------------------
	# called automatically by perl's garbage collector use to know when
	# -----------------------------------------------------------------------------
	sub DESTROY {
		my $self = shift;

		#debug print "the DESTRUCTOR is called  \n" ;
		$self->RunBeforeExit();
		return;
	}   
	#eof sub DESTROY


	# STOP functions
	# =============================================================================

	


1;

__END__

