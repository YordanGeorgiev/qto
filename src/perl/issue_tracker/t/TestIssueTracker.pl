use strict ; use warnings ; 

use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../lib" }
use Test::More tests => 3 ; 
use Data::Printer ; 
use Carp ; 

use IssueTracker::App::Utils::Initiator ; 
use IssueTracker::App::Utils::Logger ; 
use IssueTracker::App::Utils::Configurator ; 
use IssueTracker::App::Ctrl::Dispatcher ; 

my $m = 'the issue-tracker calling shell needs always a set of pre-defined env vars,
thus you need to define your issue tracker project by :
doParseCnfEnvVars <<path-to-your-issue-tracker-projects-cnf-files>>/<<issue-tracker-cnf-file>>
for example:
doParseCnfEnvVars /vagrant/var/csitea/cnf/projects/issue-tracker/ysg-issues.dev.host-name.cnf'  ; 
croak $m unless ( defined ( $ENV{ "issue_tracker_project" } )) ; 

my $tn                     = '' ; # the test number 
my $cmd                    = '' ; # the cmd to run 
my $cmd_out                = '' ; # the output of the cmd command

my $objInitiator 				= 'IssueTracker::App::Utils::Initiator'->new();	
my $appConfig              = $objInitiator->get('AppConfig');
my $objConfigurator        = 'IssueTracker::App::Utils::Configurator'->new(
                                 $objInitiator->{'ConfFile'}, \$appConfig);
$appConfig                 = $objConfigurator->getConfHolder()  ;
my $ProductInstanceDir     = $appConfig->{'ProductInstanceDir' } ; 
my $DataDir                = $ENV{'DataDir'} ; 

print "using the following DataDir in test : $DataDir \n" ; 

$ENV{'do_truncate_tables'} = 1 ; 
$ENV{'load_model'} = 'upsert' ; 
$ENV{'rdbms_type'} = 'postgres' ; 

$tn      = 'test-01' ; 
$m       = "$tn:
   test the xls-to-db action - the script should exit with 0" ; 
$cmd = "$ProductInstanceDir/src/perl/issue_tracker/script/issue_tracker.pl --do xls-to-db -t daily_issues" ; 

print "running :\n $cmd \n" ; # and Action !!!
# $cmd_out = `$cmd 2>&1 1>/dev/null` ; 
$cmd_out = `$cmd` ; 
ok ( $?  == 0  , $m ); 

my $exp_file               = "$DataDir/json/daily_issues.json" ; 
unlink $exp_file if ( -f $exp_file ) ; 

$cmd = 
   "$ProductInstanceDir/src/perl/issue_tracker/script/issue_tracker.pl --do db-to-json -t daily_issues" ; 
$tn      = 'test-02' ; 
$m       = "$tn:
   test the db-to-json action - the script should exit with 0" ; 

print "running :\n $cmd \n" ; # and Action !!!
$cmd_out = `$cmd 2>&1 1>/dev/null` ; 
# debug $cmd_out = `$cmd`; 
ok ( $?  == 0  , $m ); 

$tn      = 'test-03' ; 
$m       = "$tn:
   for the create of json file: $exp_file " ; 
ok ( -f $exp_file  , $m ) ; 


# FILE-UUID c8782cdd-371f-4c65-b07e-60ee9d38fad1
# eof file: src/perl/issue_tracker/t/TestIssueTracker.pl
