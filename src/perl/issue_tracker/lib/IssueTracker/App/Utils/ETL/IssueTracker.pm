package IssueTracker::App::Utils::ETL::IssueTracker ; 

	use strict; use warnings;

	my $VERSION = '1.1.0';    #doc at the end

	require Exporter;
	our @ISA = qw(Exporter);
	our $AUTOLOAD =();
	our $ModuleDebug = 0 ; 
	use AutoLoader;


	use Cwd qw/abs_path/;
	use File::Path qw(make_path) ;
	use File::Find ; 
	use File::Copy;
	use File::Copy::Recursive ; 
	use Sys::Hostname;
	use Carp qw /cluck confess shortmess croak carp/ ; 
	use IssueTracker::App::Utils::IO::FileHandler ; 
	use IssueTracker::App::Utils::Logger ;
	use Data::Printer ; 

   our $module_trace             = 1 ; 	
	our $appConfig						= {} ; 
	our $RunDir 						= '' ; 
	our $ProductBaseDir 				= '' ; 
	our $ProductDir 					= '' ; 
	our $ProductVersionDir 			= ''; 
	our $EnvironmentName 			= '' ; 
	our $ProductName 					= '' ; 
	our $ProductType 					= '' ; 
	our $ProductVersion 				= ''; 
	our $ProductOwner 				= '' ; 
	our $HostName 						= '' ; 
	our $ConfFile 						= '' ; 
	our $objLogger						= {} ; 
	our $objFileHandler				= {} ; 

=head1 SYNOPSIS

	doResolves the product version and base dirs , bootstraps cnfig files if needed

		use IssueTracker::App::Utils::ETL::IssueTracker ;
		my $objIssueTracker = 
			'IssueTracker::App::Utils::ETL::IssueTracker'->new ( \$appConfig ) ; 
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
	# --------------------------------------------------------
	# just and example method
	# --------------------------------------------------------
	sub doReadIssueFile {

      my $self       = shift ; 
      my $issue_file = shift ; 
      my $msg  = '' ; 
      my $ret  = 1 ; 
      
      my $str_issue_file = q{} ; 

      $objLogger->doLogDebugMsg ( " START doReadIssueFile" ) ; 


      unless ( -r $issue_file ) {
         $msg = "the issue_file : $issue_file does not exist !!!" ; 
         $objLogger->doLogFatalMsg ( $msg ) ; 
      }
      else {

         $str_issue_file = $objFileHandler->ReadFileReturnString ( $issue_file ) ; 
         $ret = 0 ; 
         $msg = "read successfully issue_file : $issue_file" ; 
         $objLogger->doLogDebugMsg ( $str_issue_file ) if ( $module_trace == 1 ) ; 
      }
   
      $objLogger->doLogDebugMsg ( " STOP  doReadIssueFile" ) ;
      return ( $ret , $msg , $str_issue_file ) ; 
	}
	# eof sub doConvertMdFileToBigSqlHash
	


	#
	# --------------------------------------------------------
	# intializes this object 
	# --------------------------------------------------------
	sub doInitialize {
		
		$objLogger 	      = "IssueTracker::App::Utils::Logger"->new( \$appConfig ) ; 
		$objFileHandler 	= "IssueTracker::App::Utils::IO::FileHandler"->new( \$appConfig ) ; 
	}	
	#eof sub doInitialize
	

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
		
		my $invocant = shift;    
		# might be class or object, but in both cases invocant
		my $class = ref ( $invocant ) || $invocant ; 

		my $self = {};        # Anonymous hash reference holds instance attributes
		bless( $self, $class );    # Say: $self is a $class

      $self->doInitialize();
		return $self;
	}  
	#eof const

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
	# return a field's value
	# -----------------------------------------------------------------------------
	sub get {

		my $self = shift;
		my $name = shift;
		croak "\@IssueTracker.pm sub get TRYING to get undefined name" unless $name ;  
		croak "\@IssueTracker.pm sub get TRYING to get undefined value" unless ( $self->{"$name"} ) ; 

		return $self->{ $name };
	}    #eof sub get


	# -----------------------------------------------------------------------------
	# set a field's value
	# -----------------------------------------------------------------------------
	sub set {

		my $self  = shift;
		my $name  = shift;
		my $value = shift;
		$self->{ "$name" } = $value;
	}
	# eof sub set


	# -----------------------------------------------------------------------------
	# return the fields of this obj instance
	# -----------------------------------------------------------------------------
	sub dumpFields {
		my $self      = shift;
		my $strFields = ();
		foreach my $key ( keys %$self ) {
			$strFields .= " $key = $self->{$key} \n ";
		}

		return $strFields;
	}    
	# eof sub dumpFields
		

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

=head1 NAME

IssueTracker 

=head1 SYNOPSIS

use IssueTracker  ; 


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




# ---------------------------------------------------------
# VersionHistory: 
# ---------------------------------------------------------
#
1.2.0 --- 2014-09-11 20:44:26 -- tests on Windows 
1.1.0 --- 2014-08-27 11:29:25 -- tests passed with Test::More
1.0.0 --- 2014-08-25 08:25:15 -- refactored away from main calling script

=cut 

