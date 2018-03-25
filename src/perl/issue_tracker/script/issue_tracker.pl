#!/usr/bin/env perl
package issue_tracker;

use strict;
use warnings qw< FATAL  utf8     >;
use autodie qw(:all);
use utf8;
use open qw< :std  :utf8     >;
use charnames qw< :full >;
use feature qw< unicode_strings >;
use 5.12.0;

require Exporter;
our @ISA         = qw(Exporter);
our %EXPORT_TAGS = ('all' => [qw()]);
our @EXPORT_OK   = (@{$EXPORT_TAGS{'all'}});
our @EXPORT      = qw($appConfig);
our $AUTOLOAD    = ();

use Cwd qw ( abs_path );
use File::Basename qw< basename >;
use Carp qw< carp croak confess cluck >;
use Encode qw< encode decode >;
use Unicode::Normalize qw< NFD NFC >;
use Data::Printer;

$| = 1;


BEGIN {
  use Cwd qw (abs_path);
  my $my_inc_path = Cwd::abs_path($0);

  $my_inc_path =~ m/^(.*)(\\|\/)(.*?)(\\|\/)(.*)/;
  $my_inc_path = $1;

  # debug ok print "\$my_inc_path $my_inc_path \n" ;

  unless (grep { $_ eq "$my_inc_path" } @INC) {
    push(@INC, "$my_inc_path");
    $ENV{'PERL5LIB'} .= "$my_inc_path";
  }

  unless (grep { $_ eq "$my_inc_path/lib" } @INC) {
    push(@INC, "$my_inc_path/lib");
    $ENV{'PERL5LIB'} .= ":$my_inc_path/lib";
  }
}

END { close STDOUT }


# use own modules ...
use IssueTracker::App::Utils::Initiator;
use IssueTracker::App::Utils::Configurator;
use IssueTracker::App::Utils::Logger;
use IssueTracker::App::Utils::Timer;
use IssueTracker::App::Ctrl::Dispatcher;
use IssueTracker::App::Mdl::Model ; 
use IssueTracker::App::IO::In::RdrCmdArgs ; 

# give a full stack dump on any untrapped exceptions
local $SIG{__DIE__} = sub {
  $0 = basename($0);    # shorter messages
  confess "\n\n\n FATAL Uncaught exception: @_" unless $^S;
};

# now promote run-time warnings into stackdumped exceptions
#   *unless* we're in an try block, in which
#   case just generate a clucking stackdump instead
local $SIG{__WARN__} = sub {
  $0 = basename($0);    # shorter messages
  if   ($^S) { cluck "\n\n WARN Trapped warning: @_" }
  else       { cluck "\n\n WARN Deadly ?! warning: @_" }
};


our $appConfig    = {};
our $objModel     = {};
our $objLogger    = {};
my $module_trace  = 0;
my $md_file       = '';
my $objInitiator  = {};
my $objConfigurator       = {};
my $xls_dir               = q{};
my $xls_file              = q{};
my $issue_tracker_project = q{};
my $period                = q{};
my $tables                = 'daily' ;
my $rdbms_type            = 'postgre';                 #todo: parametrize to

#
# the main shell entry point of the application
sub main {

  my $msg = 'error during initialization of the tool !!! ';
  my $ret = 1;

  print " issue_tracker.pl START  \n ";
  ($ret, $msg) = doInitialize();
  doExit($ret, $msg) unless ($ret == 0);

  my $objDispatcher = 'IssueTracker::App::Ctrl::Dispatcher'->new(\$appConfig , \$objModel);

  ($ret, $msg) = $objDispatcher->doRunActions($objModel->get('ctrl.actions'));

  doExit($ret, $msg);

}



sub doInitialize {

   my $msg          = 'error during initialization !!!';
   my $ret          = 1;
   $objInitiator    = 'IssueTracker::App::Utils::Initiator'->new();
   $appConfig       = $objInitiator->get('AppConfig');

   $objConfigurator = 'IssueTracker::App::Utils::Configurator'->new(
      $objInitiator->{'ConfFile'}, \$appConfig);
   $appConfig       = $objConfigurator->getConfHolder()  ;
   # p($appConfig)  ; 

   $objLogger = 'IssueTracker::App::Utils::Logger'->new(\$appConfig);
   my $m = "START MAIN";
   $objLogger->doLogInfoMsg($m);

   $objModel               = 'IssueTracker::App::Mdl::Model'->new ( \$appConfig ) ; 
   my $objRdrCmdArgs 	   = 'IssueTracker::App::IO::In::RdrCmdArgs'->new(\$appConfig , \$objModel ) ; 


   $issue_tracker_project  = $ENV{"issue_tracker_project"};
   $period                 = $ENV{"period"} unless $period;
   $period                 = 'daily' unless $period;

  unless ($issue_tracker_project) {
    $msg = "set you current project by: \n";
    $msg
      .= "doParseCnfEnvVars <<path-to-issue-tracker-project-configuration-file>>";
    $objLogger->doLogErrorMsg($msg);
    $objLogger->doLogFatalMsg($msg);
    return ($ret, $msg);
  }

  $appConfig->{'issue_tracker_project'} = $issue_tracker_project;

  $ret = 0;
  return ($ret, $msg);
}

# eof sub doInitialize


#
# pass the exit msg and the exit to the calling process
#
sub doExit {

  my $exit_code = shift;
  my $exit_msg = shift || 'exit issue_tracker.pl';

  if ($exit_code == 0) {
    $objLogger->doLogInfoMsg($exit_msg);
  }
  else {
    $objLogger->doLogErrorMsg($exit_msg);
    $objLogger->doLogFatalMsg($exit_msg);
  }

  my $msg = "STOP MAIN";
  $objLogger->doLogInfoMsg($msg);
  $msg = "19d94b2c-096c-4bf9-b6ba-780c3f90bf70";
  $objLogger->doRunLogMsg($msg);
  exit($exit_code);
}


# Action !!!
main();

