package IssueTracker::App::IO::In::RdrText;

use strict;
use warnings;
use utf8;
my $VERSION = '1.1.1';    #doc at the end

require Exporter;
our @ISA = qw(Exporter  IssueTracker::App::Utils::OO::SetGetable IssueTracker::App::Utils::OO::AutoLoadable) ;
our $AUTOLOAD = ();
use AutoLoader;

use Cwd qw/abs_path/;
use File::Path qw(make_path);
use File::Find;
use File::Copy;
use File::Copy::Recursive;
use Sys::Hostname;
use Carp qw /cluck confess shortmess croak carp/;

use base qw(IssueTracker::App::Utils::OO::SetGetable IssueTracker::App::Utils::OO::SetGetable);
use IssueTracker::App::IO::In::RdrFiles ; 
use IssueTracker::App::Utils::Logger;
use IssueTracker::App::Utils::Timer ; 
use Data::Printer;
use IssueTracker::App::Utils::Timer ; 

binmode(STDIN,  ':utf8');
binmode(STDOUT, ':utf8');
binmode(STDERR, ':utf8');

our $module_trace      = 0;
our $appConfig         = {};
our $HostName          = '';
our $objLogger         = {};
our $objRdrFiles    = {};
our $hsrStatus         = {};
our %inverse_hsrStatus = ();
our $term              = 'daily';
our $issues_file       = () ; 
our $table             = () ; 
our $objController     = () ; 

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


sub doConvertStrToHashRef {

  my $self  = shift;
  my $str   = shift;
  my $table = shift || 'daily_issue';

  my $ret = 1;
  my $msg = 'unknown error while converting string to hash reference';
  my $hsr = {};

  my $objTimer = 'IssueTracker::App::Utils::Timer'->new();
  my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst)
    = $objTimer->GetTimeUnits();
  my $nice_date = $year . '-' . $mon . '-' . $mday;

  # each item starts with new line may be some space and -
  my @arr_category_items = split '\n(\s*)\n', $str;
  my $i = 0;

  my $prev_start_time = q{};
  my $prev_stop_time  = q{};

  if ($str) {
    $msg = 'START CnrHsr2ToTxt::doConvertStrToHashRef';
    $objLogger->doLogInfoMsg($msg);

    foreach my $category_item (@arr_category_items) {
      last
        if ($category_item
        =~ m/^\s*#\s*STOP\s+$term\s+(@[\d]{4}\-[\d]{2}\-[\d]{2})(.*)/g);


      my $debug_msg = "category_item: $category_item ";
      $objLogger->doLogDebugMsg($debug_msg) if $module_trace == 1;

      # debug $msg = "category_item starts with ##" ;
      # debug $objLogger->doLogDebugMsg ( $msg ) if $category_item =~ m/^##/g ;

      # one or two # are either the file start , stop or the act , plan sections
      next if $category_item =~ m/^[#]{1,2} /g;
      next if $category_item =~ m/^--/g;

      # the first line of the category_item is the category
      my $category = (split /\n/, $category_item)[0];
      next unless ($category);
      $category =~ s/([\s\t]{0,5})(\w)([\s\t]{0,5})/$2/g;
      $category_item =~ s/$category//mg;
      my $tmp_category_item = $category_item;
      my $item_levels       = {};
      $tmp_category_item
        =~ s/\n(\s*)([\-]{1,7})/$self->doFillInLevelsPerRow( $2 , \$item_levels )/emg;

      # debug p ( $item_levels ) ;
      # debug $objLogger->doLogDebugMsg ( "stop item_levels" );

      # $objLogger->doLogDebugMsg ( "start category_item" );
      # p ( $category_item );
      # $objLogger->doLogDebugMsg ( "stop  category_item" );
      # debug p($category_item);
      my @arr_items = split /\n^\s*([\-]{1,7})\s*/m, $category_item;

      my $category_item_count = 0;
      foreach my $item (@arr_items) {

        # debug rint "\$item : $item \n" ;
        # debug rint "\$i : $i \n" ;
        next unless $item;

        # which creates the duplicates
        next
          if $item
          =~ m/^\s*([\-]{1,7})/g;    # because of the buggy split above ...

        my $debug_msg = "item: $item ";
        $objLogger->doLogDebugMsg($debug_msg) if $module_trace == 1;
        $item =~ m/^\s*([a-zA-Z0-9]+)\s*(\t{1,5})(.*)/;
        my $status = q{};
        my $name   = q{};
        $status = $1;
        $name   = $3;
        next unless $name;
        $hsr->{$i} = {};

        $hsr->{$i}->{'id'} = $i;

        $item_levels->{$category_item_count} = 1
          unless (exists $item_levels->{$category_item_count});
        $hsr->{$i}->{'level'} = $item_levels->{$category_item_count} + 1;

        # $hsr->{ $i }->{ 'item' } = $item ;
        $hsr->{$i}->{'prio'}     = $i;
        $hsr->{$i}->{'category'} = $category;
        $hsr->{$i}->{'status'}   = $hsrStatus->{$status};

        # the title is the first line of the title description
        my $title = (split /\n/, $name)[0];

        # extract the start_time if any exists, example:
        # 2017-06-03 15:00 - 19:00 some issue title
        $title
          =~ m/^\s*(([\d]{2,4}-[\d]{2}-[\d]{2})?\s*[\d]{2}:[\d]{2})\s+(.*)$/g;
        my $start_time = q{};
        $start_time = 'NULL' if $status eq $1;
        $start_time = $1 unless $status eq $1;
        $title =~ s/$start_time//g unless $start_time eq 'NULL';

        # extract the stop_time if any exists
        $title =~ m/^\s+[\-]\s+([\d]{2}:[\d]{2})(.*)/g;
        my $stop_time = q{};

        if ($start_time eq 'NULL') {
          $stop_time = 'NULL';
        }
        elsif (!(defined $1)) {
          $stop_time = 'NULL';
        }
        elsif ($status eq $1) {
          $stop_time = 'NULL';
        }
        elsif (defined $1) {
          $stop_time = $1;
        }
        else {
          $stop_time = $1;
        }
        $title =~ s/^\s*[\-]\s*$stop_time\s+//g unless $stop_time eq 'NULL';
        $title =~ s/^\s+(.*)/$1/g;    #remove trailing and fronting spaces

        # debug $objLogger->doLogDebugMsg ( "\$item is $item" ) ;
        # debug $objLogger->doLogDebugMsg ( "\status is $status" ) ;
        # debug $objLogger->doLogDebugMsg ( "\$title is $title" ) ;
        # debug $objLogger->doLogDebugMsg ( "\$1 is $1" ) ;
        # debug $objLogger->doLogDebugMsg ( "\$start_time is $start_time" ) ;
        # debug $objLogger->doLogDebugMsg ( "\$stop_time is $stop_time" ) ;

        my $description = q{};
        $description .= $start_time unless ($start_time eq 'NULL');
        $description .= ' - ' . $stop_time unless ($stop_time eq 'NULL');
        $description .= "\n" if $description;
        $description .= $title;

        # and the title should not be longer than 90 chars
        # $title = substr($title, 0, 90 ) . ' ...' if length ( $title ) > 90 ;

        # if this is sub-item it should inherit the time of the upper item
        if ($hsr->{$i}->{'level'} > 1 ) {
          $start_time = $prev_start_time;
          $stop_time  = $prev_stop_time;
        }

        $hsr->{$i}->{'start_time'}  = $start_time;
        $hsr->{$i}->{'stop_time'}   = $stop_time;
        $hsr->{$i}->{'name'}        = $title;
        $hsr->{$i}->{'description'} = $description;
        $hsr->{$i}->{'run_date'}    = $nice_date;
        $hsr->{$i}->{'updated_by'}  = $ENV{'USER'} || 'unknown';
        $hsr->{$i}->{'owner'}       = $ENV{'USER'} || 'unknown';

        # start setting the parent id
        for (my $j = $i; $j >= 0; $j--) {
          $hsr->{$i}->{'parent_id'} = undef;
          if (exists $hsr->{$i - 1}) {
            if ($hsr->{$i}->{'level'} > $hsr->{$j}->{'level'}) {
              $hsr->{$i}->{'parent_id'} = $j;
              last;
            }
          }
        }

        # stop  setting the parent id

        #debug p ( $hsr->{ $i } );

        if ($module_trace == 1) {
          $debug_msg = " START :::: $i"
            if $objLogger->doLogDebugMsg($debug_msg);
          p($hsr->{$i});
          $debug_msg = " STOP  :::: $i";
          $objLogger->doLogDebugMsg($debug_msg);
        }
        $i++;
        $category_item_count++;

        $prev_start_time = $start_time;
        $prev_stop_time  = $stop_time;
      }

      #eof foreach my $item
      #
    }

    #eof foreach my $category_item
    $ret = 0;
    $msg = '';

  }

  $msg = 'STOP  CnrHsr2ToTxt::doConvertStrToHashRef';
  $objLogger->doLogInfoMsg($msg);
  return ($ret, $msg, $hsr);
}


#
# --------------------------------------------------------
# used to calculate the amount of levels
# --------------------------------------------------------
sub doFillInLevelsPerRow {

  my $self            = shift;
  my $str_dashes      = shift;
  my $ref_item_levels = shift;
  my $item_levels     = $$ref_item_levels;

  my $row_num = scalar keys %$$ref_item_levels || 0;
  my $num_of_dashes = () = $str_dashes =~ /\-/gi;
  $item_levels->{$row_num} = $num_of_dashes;

}

#
# --------------------------------------------------------
# read the issues file for the Daily term
# --------------------------------------------------------
sub doReadIssueFile {

  my $self        = shift;
  my $table       = shift ; 

  my $msg             = '';
  my $ret             = 1;
  my $str_issues_file = q{};
  my $table_file_name = $table ; 
  $table_file_name =~ s/_/-/g ; 
  
  $msg = "START doReadIssueFile";
  $objLogger->doLogInfoMsg($msg);
   
  my $issue_tracker_project = $ENV{"issue_tracker_project"};
  my $objTimer = 'IssueTracker::App::Utils::Timer'->new();
  my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst)
   = $objTimer->GetTimeUnits();
  my $nice_month = "$year" . '-' . "$mon";
  my $nice_date  = "$year" . '-' . "$mon" . '-' . $mday;

    $issues_file
      = $ENV{'mix_data_dir'}
      . '/issues'
      . "/$year/$nice_month/$nice_date/$issue_tracker_project"
      . '.' .$table_file_name . '.'
      . "$nice_date" . '.txt' ; 

  unless (-r $issues_file) {
    $msg = "the issues_file : $issues_file does not exist !!!";
    $objLogger->doLogFatalMsg($msg);
  }
  else {
    # src: http://ahinea.com/en/tech/perl-unicode-struggle.html
    ($ret, $msg, $str_issues_file)
      = $objRdrFiles->doReadFileReturnString($issues_file, 'utf8');
    return ($ret, $msg) unless $ret == 0;

    $ret = 0;
    $msg = "read successfully issues_file : $issues_file";
    $objLogger->doLogDebugMsg($str_issues_file) if ($module_trace == 1);
  }

  $msg = "STOP  doReadIssueFile with ret: $ret";
  $objLogger->doLogInfoMsg($msg);
  return ($ret, $msg, $str_issues_file);
}

# eof sub doConvertMdFileToBigSqlHash

#
# -----------------------------------------------------------------------------
# the constructor
# -----------------------------------------------------------------------------
sub new {

  my $invocant = shift;
  $appConfig = ${shift @_} || {'foo' => 'bar',};
  $objController = shift ; 
  $objController = shift ; 
  $term = shift || 'daily_issues' ;

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
  $objRdrFiles
    = 'IssueTracker::App::Utils::IO::RdrFiles'->new(\$appConfig);

  $hsrStatus = {
      'eval' => '01-eval'    # evaluate whether or not to do it
    , 'todo' => '02-todo'    # must do it till the end of the term
    , 'late' => '02-late'    # too late
    , 'rem'  => '02-rem'     # remember to act till the end of the term
    , 'wip'  => '03-wip'     # is work in progress - aka is being done right now
    , 'act'  => '03-act'     # is being actively done, aka an activity
    , 'actv' => '03-actv'    # is being actively done, aka an activity
    , 'disg' => '03-disg'      # to discard - a more positive
    , 'diss' => '04-diss'      # to dissmiss - a more negative
    , 'fail' => '04-fail'    # to failmiss or discard
    , 'test' => '05-test'    # to test some implementation
    , 'tst'  => '05-tst'     # to test some implementation
    , 'hld'  => '06-onhold'  # the issue is on hold -
    , 'hold' => '06-hold'  # the issue is on hold -
    , 'part' => '06-part'    # the issue has been partly completed
    , 'flow' => '06-flow'    # follow an event or action to occur
    , 'qas'  => '07-qas'     # the issue is in quality assurance mode
    , 'qa'   => '07-qa'      # the issue is in quality assurance mode
    , 'blck' => '08-blocked' # the issue is blocked
    , 'done' => '09-done'    # the issue is done
  };

  %inverse_hsrStatus = reverse %$hsrStatus;


  return $self;
}

#eof sub doInitialize


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
