package IssueTracker::App::Ctrl::CtrlDbToXls ; 

	use strict; use warnings;

	my $VERSION = '1.0.0';    

	require Exporter;
	our @ISA = qw(Exporter  IssueTracker::App::Utils::OO::SetGetable);
	our $AUTOLOAD =();
	use AutoLoader;
   use utf8 ;
   use Carp ;
   use Data::Printer ; 

   use parent 'IssueTracker::App::Utils::OO::SetGetable' ;
   use IssueTracker::App::Utils::Logger ; 
   use IssueTracker::App::Db::In::RdrDbsFactory ; 
   use IssueTracker::App::IO::Out::WtrXls ; 
   use IssueTracker::App::Mdl::Model ; 

	our $module_trace                = 0 ; 
	our $appConfig						   = {} ; 
	our $objLogger						   = {} ; 
   our $rdbms_type                  = 'postgres' ; 
	our $objModel						   = {} ; 

=head1 SYNOPSIS
      my $objCtrlDbToFile = 
         'IssueTracker::App::Ctrl::CtrlDbToFile'->new ( \$appConfig ) ; 
      ( $ret , $msg ) = $objCtrlDbToFile->doLoadIssuesFileToDb ( $issues_file ) ; 
=cut 

=head1 EXPORT

	A list of functions that can be exported.  You can delete this section
	if you don't export anything, such as for a purely object-oriented module.
=cut 

=head1 SUBROUTINES/METHODS

	# -----------------------------------------------------------------------------
	START SUBS 
=cut


   # 
	# -----------------------------------------------------------------------------
   # read the passed issue file , convert it to hash ref of hash refs 
   # and insert the hsr into a db
	# -----------------------------------------------------------------------------
   sub doReadAndLoad {

      my $self                = shift ; 
      my $issues_file          = shift ; 	

      my $ret                 = 1 ; 
      my $msg                 = 'unknown error while loading db issues to xls file' ; 
      my @tables              = ();
      my $tables              = $objModel->get( 'ctrl.tables' ) || 'daily_issues' ; 
      my $hsr2                = {} ;      # this is the data hash ref of hash reffs 
      my $msr2                = {} ;      # this is the meta hash describing the data hash ^^
      my $amsr2               = {} ;      # this is the meta hash describing the data hash ^^
      
      my $db                  = $appConfig->{ 'postgres_db_name' } ; 
	   push ( @tables , split(',',$tables ) ) ; 

      my $objRdrDbsFactory = 'IssueTracker::App::Db::In::RdrDbsFactory'->new( \$appConfig , \$objModel  ) ; 
      my $objRdrDb 			= $objRdrDbsFactory->doInstantiate ( "$rdbms_type" , \$objModel );
      ($ret, $msg , $amsr2 )   = $objRdrDb->doLoadProjDbMetaData( $appConfig->{ 'postgres_db_name' } ) ;
      return ( $ret , $msg ) unless $ret == 0 ; 
      $appConfig->{ "$db" . '.meta' } = $amsr2 ;
         
      $objModel->set('select.web-action.page-size' , 1000000000) ; #set the maximum size

      for my $table ( @tables ) { 
         ( $ret , $msg , $msr2 ) = $objModel->doGetTableMeta ( $appConfig , $db , $table ) ;
         return ( $ret , $msg ) unless $ret == 0 ; 
         ( $ret , $msg , $hsr2)  = $objRdrDb->doSelectTableIntoHashRef( \$objModel , $table ) ; 
         return ( $ret , $msg ) unless $ret == 0 ; 

         my $objWtrXls    = 'IssueTracker::App::IO::Out::WtrXls'->new( \$appConfig ) ;
         $ret = $objWtrXls->doBuildXlsFromHashRef ( \$objModel , $table , $hsr2 , $msr2) ;
         return ( $ret , $msg ) unless $ret == 0 ; 
      }

      return ( $ret , $msg  ) ; 
   } 
   
   
	

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

		my $class   = shift;    # Class name is in the first parameter
		$appConfig  = ${ shift @_ } || { 'foo' => 'bar' ,} ; 
		$objModel   = ${ shift @_ } || croak 'objModel not passed !!!' ; 
		my $self = {};        # Anonymous hash reference holds instance attributes
		bless( $self, $class );    # Say: $self is a $class
      $self = $self->doInitialize( ) ; 
		return $self;
	}  
	#eof const


   #
	# --------------------------------------------------------
	# intializes this object 
	# --------------------------------------------------------
   sub doInitialize {
      my $self          = shift ; 

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

=head1 NAME

UrlSniper 

=head1 SYNOPSIS

use UrlSniper  ; 


=head1 DESCRIPTION
the main purpose is to initiate minimum needed environment for the operation 
of the whole application - man app cnfig hash 

=head2 EXPORT


=head1 SEE ALSO

perldoc perlvars

No mailing list for this module


=head1 AUTHOR

yordan.georgiev@gmail.com

=head1 



=cut 

