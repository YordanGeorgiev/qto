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
      my $rdbms_type    = 'postgres' ; # the default

     # get the cmd args
     GetOptions(
       'do=s'          => \$actions,
       'xls-dir=s'     => \$xls_dir,
       'xls-file=s'    => \$xls_file,
       'period=s'      => \$period ,
       'tables=s'      => \$tables ,
       'rdbms-type=s'  => \$rdbms_type
     );

      $rdbms_type      = 'postgres' unless $rdbms_type ; 
      $period          = 'daily' unless $period ; 

      confess "no actions defined - Nothing to do !!!" unless $actions ; 

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


1;

__END__

