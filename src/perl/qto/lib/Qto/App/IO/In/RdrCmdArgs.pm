package Qto::App::IO::In::RdrCmdArgs ; 

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
      my $actions       = q{} ; 
      my $xls_dir       = q{} ; 
      my $in_dir        = q{} ; 
      my $out_dir       = q{} ; 
      my $xls_file      = q{} ; 
      my $period        = q{} ; 
      my $tables        = q{} ; 
      my $rdbms_type    = 'postgres' ; # the default

     # get the cmd args
     # obs from now on those vars bellow if not passed will be '' - defined but empty !!!
     GetOptions(
       'do=s'          => \$actions,
       'tables=s'      => \$tables ,
       'xls-dir=s'     => \$xls_dir,
       'in-dir=s'      => \$in_dir,
       'out-dir=s'     => \$out_dir,
       'xls-file=s'    => \$xls_file,
       'period=s'      => \$period ,
       'rdbms-type=s'  => \$rdbms_type
     );
      $rdbms_type      = 'postgres' unless $rdbms_type ; 
      $period          = 'daily' unless $period ; 

      confess "no actions defined - Nothing to do !!!" unless $actions ; 

      $objModel->set('ctrl.actions' , $actions ) ; 
      $objModel->set('ctrl.tables' , $tables ) ; 
      $objModel->set('io.xls-file' , $xls_file ) if $xls_file ne '' ; 
      $objModel->set('io.xls-file' , 'undefined' ) if $xls_file eq '' ; 

      $objModel->set('io.xls-dir' , $xls_dir ) if defined $xls_dir ; 
      $objModel->set('io.in-dir' , $in_dir ) if $in_dir ne '' ; 
      $objModel->set('io.out-dir' , $out_dir ) if $out_dir ne '' ; 
      $objModel->set('io.xls-dir' , 'undefined' ) unless defined $xls_dir ; 
      $objModel->set('ctrl.rdbms-type' , $rdbms_type ) ; 
      $objModel->set('ctrl.period' , $period ) ; 
  
   }
   # eof sub doRead

#SYNOPSIS

=head1 SYNOPSIS
      my $objRdrCmdArgs = 
         'Qto::App::IO::In::RdrCmdArgs'->new ( \$config ) ; 
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
		$config     = ${ shift @_ } || { 'foo' => 'bar' ,} ; 
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
           config => $config
      );
	   $objLogger 			= 'Qto::App::Utils::Logger'->new( \$config ) ;
      return $self ; 
	}	
	#eof sub doInitialize


1;

__END__

