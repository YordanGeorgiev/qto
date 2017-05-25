package IssueTracker::App::IO::In::ReaderTxtYearly ; 

	use strict; use warnings;
   use utf8 ; 
	my $VERSION = '1.1.1';    #doc at the end

	require Exporter;
	our @ISA = qw(Exporter);
	our $AUTOLOAD =();
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
      
   binmode(STDIN,  ':utf8');
   binmode(STDOUT, ':utf8');
   binmode(STDERR, ':utf8');

   our $module_trace             = 0 ; 
	our $appConfig						= {} ; 
	our $HostName 						= '' ; 
	our $objLogger						= {} ; 
	our $objFileHandler				= {} ; 
   our $hsrStatus                = {} ; 
   our %inverse_hsrStatus        = (); 





=head1 SYNOPSIS

	doResolves the product version and base dirs , bootstraps cnfig files if needed

		use IssueTracker::App::ETL::IssueTracker ;
		my $objIssueTracker = 
			'IssueTracker::App::ETL::IssueTracker'->new ( \$appConfig ) ; 
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
	# read the issues file for the Yearly period
	# --------------------------------------------------------
	sub doReadIssueFile {

      my $self       = shift ; 
      my $issues_file = shift ; 

      my $msg  = '' ; 
      my $ret  = 1 ; 
      my $str_issues_file = q{} ; 

      $msg =  "START doReadIssueFile" ; 
      $objLogger->doLogInfoMsg ( $msg ) ; 

      unless ( -r $issues_file ) {
         $msg = "the issues_file : $issues_file does not exist !!!" ; 
         $objLogger->doLogFatalMsg ( $msg ) ; 
      }
      else {
         # src: http://ahinea.com/en/tech/perl-unicode-struggle.html
         ( $ret , $msg , $str_issues_file ) 
            = $objFileHandler->doReadFileReturnString ( $issues_file , 'utf8' ) ; 
         return ( $ret , $msg ) unless $ret == 0 ; 

         $ret = 0 ; 
         $msg = "read successfully issues_file : $issues_file" ; 
         $objLogger->doLogDebugMsg ( $str_issues_file ) if ( $module_trace == 1 ) ; 
      }
      
      $msg =  "STOP  doReadIssueFile with ret: $ret" ; 
      $objLogger->doLogInfoMsg ( $msg ) ; 
      return ( $ret , $msg , $str_issues_file ) ; 
	}
	# eof sub doConvertMdFileToBigSqlHash


	#
	# --------------------------------------------------------
	# used to calculate the amount of levels 
	# --------------------------------------------------------
   sub doFillInLevelsPerRow {

      my $self                = shift ; 
      my $str_dashes          = shift ; 
      my $ref_item_levels     = shift ; 
      my $item_levels         = $$ref_item_levels ; 

      my $row_num = scalar keys %$$ref_item_levels || 0 ; 
      my $num_of_dashes = () = $str_dashes =~ /\-/gi;
      $item_levels->{ $row_num } = $num_of_dashes ; 

   } 

	
	
   #
	# -----------------------------------------------------------------------------
	# the constructor 
	# -----------------------------------------------------------------------------
	sub new {

		my $invocant 			= shift ;    
		$appConfig     = ${ shift @_ } || { 'foo' => 'bar' ,} ; 
		
      # might be class or object, but in both cases invocant
		my $class = ref ( $invocant ) || $invocant ; 

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
      my $self          = shift ; 

      %$self = (
           appConfig => $appConfig
       );

	   $objLogger 			= 'IssueTracker::App::Utils::Logger'->new( \$appConfig ) ;
	   $objFileHandler   = 'IssueTracker::App::Utils::IO::FileHandler'->new ( \$appConfig ) ; 
      
      $hsrStatus = {
           'eval'    => '01-eval'      # evaluate whether or not to do it
         , 'todo'    => '02-todo'      # must do it till the end of the period
         , 'rem'     => '02-rem'       # remember to act till the end of the period
         , 'wip'     => '03-wip'       # is work in progress - aka is being done right now
         , 'act'     => '03-act'       # is being actively done , aka more of an activity type
         , 'actv'    => '03-actv'      # is being actively done , aka more of an activity type
         , 'diss'    => '04-diss'      # to dissmiss or disgard
         , 'late'    => '04-late'      # too late
         , 'fail'    => '04-fail'      # to failmiss or disgard
         , 'test'    => '05-test'      # to test some implementation
         , 'tst'     => '05-tst'       # to test some implementation
         , 'hld'     => '06-onhold'    # the issue is on hold - 
         , 'hold'    => '06-onhold'    # the issue is on hold - 
         , 'part'    => '06-part'      # the issue has been partly completed - might have more work
         , 'flow'    => '06-flow'      # follow an event or action to occur
         , 'qas'     => '07-qas'       # the issue is in quality assurance mode
         , 'qa'      => '07-qa'        # the issue is in quality assurance mode
         , 'blck'    => '08-blocked'   # the issue is blocked
         , 'done'    => '09-done'      # the issue is done
      }; 
      
      %inverse_hsrStatus = reverse %$hsrStatus;

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

1;


__END__
