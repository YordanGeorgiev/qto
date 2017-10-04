package IssueTracker::App::IO::Out::TxtWriter;

use strict;
use warnings;
use utf8;
my $VERSION = '1.1.1';    #doc at the end

require Exporter;
our @ISA      = qw(Exporter);
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
our $term              = 'daily';
our $issues_file       = () ; 


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

sub doConvertHashRefToStr {

  my $self = shift;
  my $hsr2 = shift;

  my $msg
    = 'unknown error during hash ref of hash references to string conversion !!!';
  my $ret        = 1;
  my $str_issues = q{};
  my $str_activity_issues = " ";
  my $objTimer         = 'IssueTracker::App::Utils::Timer'->new( $appConfig->{ 'TimeFormat' } );
  my $run_time         = $objTimer->GetHumanReadableTime();
  p($hsr2) if $module_trace == 1;
  my $str_header = '# START ' . uc($term) . ' @%run_time%
   
## what will I do till the next ' . uc($term) . ':
#---------------------------
#';
  #

  my $str_footer = '

# STOP  ' . uc($term) . ' @%run_time%
';

  $str_issues .= $str_header . "\n\n";
  my $prev_category = q{};
  my @attributes
    = qw (guid seq run_time category current description level name prio start_time stop_time status);
  my $items_order_by_attribute = $ENV{'items_order_by_attribute'} || 'start_time' ; 

  unless (grep(/^$items_order_by_attribute$/, @attributes)) {
    $msg
      = 'Did not find the value of the pre-defined items_order_by_attribute: "';
    $msg
      .= $items_order_by_attribute
      . '" from the issues attributes list: "'
      . " \n @attributes \n" . '"';
    $objLogger->doLogWarningMsg($msg);
    $items_order_by_attribute = 'start_time';
    $msg = 'using the "start_time" as the default sorting attribute';
    $objLogger->doLogWarningMsg($msg);
  }

  my $operator = '<=>';
  $operator = 'cmp' unless (looks_like_number($items_order_by_attribute));

  foreach my $issue_id (
      eval 'sort {      '
    . '$hsr2->{$a}->{ $items_order_by_attribute }'
    . $operator
    . '$hsr2->{$b}->{ $items_order_by_attribute }'
    . '} keys (%$hsr2)')  {

    my $row = $hsr2->{$issue_id};
   
   # ignore camel case named cols and sheets
   my %row_h = %$row ; 
   %row_h = map { lc $_ => $row_h{$_} } keys %row_h;
   $row = \%row_h ; 
   
    p $row ; 

    my $str_row = q{} ; 


    my $category    = $row->{'category'};
    my $current     = $row->{'current'};
    my $description = $row->{'description'};
    my $issue_id    = $row->{'issue_id'};
    my $level       = $row->{'level'};
    my $name        = $row->{'name'} || $row->{'description' } ; 
    $name =~ s/(\r){0,1}\n/ ;/gm ; 
    my $prio        = $row->{'prio'};
    my $start_time  = $row->{'start_time'};
    my $stop_time   = $row->{'stop_time'};
    my $status      = $row->{'status'};

    $status = $inverse_hsrStatus{$status} if $status ; 
    $status = 'unknwn' unless $status;
    $description =~ s/\r\n/\n/gm;
    $str_row .= "\n" if ($prev_category ne $category);
    $str_row .= $category . "\n" unless ($prev_category eq $category);
    my $levels_dash = '';

    for (my $i = 0; $i < $level; $i++) {
      $str_row  .= ' ';
      $levels_dash .= '-';
    }
    $str_row .= $levels_dash . ' ';
    $str_row .= $status . "\t\t" if $level == 1 ; 
    $str_row .= $status . "\t" if $level == 2;
    $str_row .= $status . " " if $level == 3;

    $str_row .= ($start_time . " ")
      if (defined($start_time) && $start_time ne 'NULL');

    if (defined $stop_time && $stop_time ne 'NULL' && $stop_time ne '') {
      $str_row .= ('- ' . $stop_time . " ");
    }
    $str_row .= $name . "\n";
    $prev_category = $category;


    # because we want activities to be printed at the end of the txt file
    if ( $items_order_by_attribute eq 'start_time' && $start_time eq "") {
      $str_activity_issues .= $str_row ; 
    } 
    else {
      $str_issues .= $str_row ; 
    }
  }


  $str_issues .= $str_activity_issues ; 
  $str_issues .= $str_footer . "\n\n";
  $str_issues =~ s|%run_time%|$run_time|g;
  $msg = " OK for hsr2 to txt conversion ";
  $ret = 0;

  return ($ret, $msg, $issues_file , $str_issues);
}
# eof sub doConvertHashRefToStr


#
# -----------------------------------------------------------------------------
# the constructor
# -----------------------------------------------------------------------------
sub new {

  my $invocant = shift;
  $appConfig     = ${shift @_} || {'foo' => 'bar',};
  $table         = shift || 'daily_issues' ; 
  $term          = $table ; 
  $term          =~ s/_issues//g ; 

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
# return a field's value
# -----------------------------------------------------------------------------
sub get {

  my $self = shift;
  my $name = shift;
  croak "\@IssueTracker.pm sub get TRYING to get undefined name" unless $name;
  croak "\@IssueTracker.pm sub get TRYING to get undefined value"
    unless ($self->{"$name"});

  return $self->{$name};
}    #eof sub get

# -----------------------------------------------------------------------------
# set a field's value
# -----------------------------------------------------------------------------
sub set {

  my $self  = shift;
  my $name  = shift;
  my $value = shift;
  $self->{"$name"} = $value;
}

# eof sub set

# -----------------------------------------------------------------------------
# return the fields of this obj instance
# -----------------------------------------------------------------------------
sub dumpFields {
  my $self      = shift;
  my $strFields = ();
  foreach my $key (keys %$self) {
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

=cut 
1;

__END__
