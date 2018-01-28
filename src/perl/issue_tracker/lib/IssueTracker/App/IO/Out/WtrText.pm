package IssueTracker::App::IO::Out::WtrText;

use strict;
use warnings;
use utf8;
my $VERSION = '1.1.2';    #doc at the end

require Exporter;
our @ISA = qw(Exporter IssueTracker::App::Utils::OO::SetGetable);
our $AUTOLOAD = ();
use AutoLoader;

use Cwd qw/abs_path/;
use File::Path qw(make_path);
use File::Find;
use File::Copy;
use File::Copy::Recursive;
use Sys::Hostname;
use Carp qw /cluck confess shortmess croak carp/;
use Scalar::Util qw /looks_like_number/;
use Data::Printer;

use base qw(IssueTracker::App::Utils::OO::SetGetable);
use IssueTracker::App::Utils::IO::FileHandler ; 
use IssueTracker::App::Utils::Logger ; 
use IssueTracker::App::Utils::Timer ; 

binmode(STDIN,  ':utf8');
binmode(STDOUT, ':utf8');
binmode(STDERR, ':utf8');

our $module_trace      = 0;
our $appConfig         = {};
our $HostName          = '';
our $objLogger         = {};
our $objController     = {};
our $objFileHandler    = {};
our $hsrStatus         = {};
our %inverse_hsrStatus = ();
our $table              = 'daily_issues' ; 
our $issues_file       = () ; 


=head1 SYNOPSIS

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
# doPrintIssuesFile - obvious ... 
# -----------------------------------------------------------------------------
sub doPrintIssuesFile {
   my $self       = shift ; 
   my $objMdlHsr2 = ${ shift @_ } ; 
   my $str_issues = $objMdlHsr2->get('str_issues' ) ; 

   $objFileHandler->PrintToFile ( $issues_file , $str_issues , 'utf8' ) ; 
}
# eof sub doPrintIssuesFile

#
# -----------------------------------------------------------------------------
# the constructor
# -----------------------------------------------------------------------------
sub new {

  my $invocant = shift;
  $appConfig     = ${shift @_} || {'foo' => 'bar',};
  $table         = shift || 'daily_issues' ; 

  # might be class or object, but in both cases invocant
  my $class = ref($invocant) || $invocant;
  my $self = {};    # Anonymous hash reference holds instance attributes
  bless($self, $class);    # Say: $self is a $class
  $self = $self->doInitialize();
  return $self;
}

#eof const

#
# --------------------------------------------------------
# intializes this object
# --------------------------------------------------------
sub doInitialize {
  my $self = shift;

   my $msg = '' ; 
   my $ret = 1 ; 


   $objFileHandler   = 'IssueTracker::App::Utils::IO::FileHandler'->new ( \$appConfig ) ; 

  %$self = (appConfig => $appConfig);

  $objLogger = 'IssueTracker::App::Utils::Logger'->new(\$appConfig);
  $objFileHandler
    = 'IssueTracker::App::Utils::IO::FileHandler'->new(\$appConfig);

  $hsrStatus = {
    'eval' => '01-eval'    # evaluate whether or not to do it
    , 'todo' => '02-todo'  # must do it till the end of the period
    , 'rem'  => '02-rem'   # remember to act till the end of the period
    , 'late' => '02-late'      # too late
    , 'wip'  => '03-wip'   # is work in progress - aka is being done right now
    , 'act'  => '03-act'    # is being actively done , aka more of an activity type
    , 'actv' => '03-actv'  # is being actively done ,more of an activity type
    , 'diss' => '04-diss'      # to dissmiss or disgard
    , 'fail' => '04-fail'      # to failmiss or disgard
    , 'test' => '05-test'      # to test some implementation
    , 'tst'  => '05-tst'       # to test some implementation
    , 'hld'  => '06-onhold'    # the issue is on hold -
    , 'hold' => '06-onhold'    # the issue is on hold -
    , 'part' => '06-part'      # only partially completed - might have more work
    , 'flow' => '06-flow'       # follow an event or action to occur
    , 'qas'  => '07-qas'        # the issue is in quality assurance mode
    , 'qa'   => '07-qa'         # the issue is in quality assurance mode
    , 'blck' => '08-blocked'    # the issue is blocked
    , 'done' => '09-done'       # the issue is done
  };

  %inverse_hsrStatus = reverse %$hsrStatus;

   my $issue_tracker_project = $appConfig->{ 'issue_tracker_project' } ; 

  
    my $objTimer = 'IssueTracker::App::Utils::Timer'->new();
    my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst)
      = $objTimer->GetTimeUnits();
    my $nice_month = "$year" . '-' . "$mon";
    my $nice_date  = "$year" . '-' . "$mon" . '-' . $mday;

    $msg = 'proj_daily_data_root_dir: ' . $ENV{'proj_daily_data_root_dir'};
    $objLogger->doLogDebugMsg($msg);
    $table =~ s/_/-/g ; 
    $issues_file
      = $ENV{'proj_daily_data_root_dir'}
      . "/$year/$nice_month/$nice_date/$issue_tracker_project"
      . '.'
      . "$table"
      . '.'
      . "$nice_date"
      . '.txt';

    $msg = 'issues_file: ' . $issues_file;
    $objLogger->doLogDebugMsg($msg);

    my $ProductInstanceDir = $appConfig->{'ProductInstanceDir'};
    $issues_file = $ProductInstanceDir . "/" . $issues_file
      unless ($issues_file =~ m/^\//g);

  $appConfig->{'issues_file'} = $issues_file;
  return $self;
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
    my $msg
      = "BOOM! BOOM! BOOM! \n RunTime Error !!! \n Undefined Function $name(@_) \n ";
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

=head1 NAME

WtrText

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

=cut 
1;

__END__
