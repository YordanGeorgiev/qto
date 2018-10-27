use strict ; use warnings ; 

use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../../../../../lib" }

use IssueTracker::App::Utils::Initiator ; 
use IssueTracker::App::Utils::Configurator ; 

use Test::More tests => 10 ; 
use Data::Printer ; 
use Scalar::Util qw/reftype/;

use Carp ; 
my $m = 'the issue-tracker calling shell needs always a set of pre-defined env vars,
thus you need to define your issue tracker project by :
doParseCnfEnvVars <<path-to-your-issue-tracker-projects-cnf-files>>/<<issue-tracker-cnf-file>>
for example:
doParseCnfEnvVars /vagrant/var/csitea/cnf/projects/issue-tracker/ysg-issues.dev.host-name.cnf'  ; 
croak $m unless ( defined ( $ENV{ "issue_tracker_project" } )) ; 
my $msg              = (); 
my $n                = (); 
my $objInitiator     = {} ; 
my $objConfigurator  = {} ; 
my $appConfig        = {} ; 
my $ConfFile         = {} ; 
$objInitiator 		   = 'IssueTracker::App::Utils::Initiator'->new(4);
$appConfig           = $objInitiator->get('AppConfig');

  $objConfigurator
    = 'IssueTracker::App::Utils::Configurator'->new($objInitiator->{'ConfFile'},
    \$appConfig);

$appConfig           = $objConfigurator->getConfHolder()  ;

$n = 'test-01' ; 
$msg                 = 'the objConfigurator produces the appConfig hash' ; 
ok ( reftype $appConfig eq reftype {} , $msg ) ; 
p($appConfig) ; 

$n = 'test-02' ; 
$msg = "$n " .  "the AppConfig has the PrintConsoleMsgs key" ; 
ok ( exists $appConfig->{'PrintConsoleMsgs'} , $msg ) ; 

$n = 'test-03' ; 
$msg = "$n " .  "the AppConfig has the PrintDebugMsgs key" ; 
ok ( exists $appConfig->{'PrintDebugMsgs'} , $msg ) ; 

$n = 'test-04' ; 
$msg = "$n " .  "the AppConfig has the PrintErrorMsgs key" ; 
ok ( exists $appConfig->{'PrintErrorMsgs'} , $msg ) ; 

$n = 'test-05' ; 
$msg = "$n " .  "the AppConfig has the PrintInfoMsgs key" ; 
ok ( exists $appConfig->{'PrintInfoMsgs'} , $msg ) ; 

$n = 'test-06' ; 
$msg = "$n " .  "the AppConfig has the PrintTraceMsgs key" ; 
ok ( exists $appConfig->{'PrintTraceMsgs'} , $msg ) ; 

$n = 'test-07' ; 
$msg = "$n " .  "the AppConfig has the PrintWarningMsgs key" ; 
ok ( exists $appConfig->{'PrintWarningMsgs'} , $msg ) ; 

$n = 'test-08' ; 
$msg = "$n " .  "the AppConfig has the LogDir key" ; 
ok ( exists $appConfig->{'LogDir'} , $msg ) ; 

$n = 'test-09' ; 
$msg = "$n " .  "the AppConfig has the LogFile key" ; 
ok ( exists $appConfig->{'LogFile'} , $msg ) ; 

$n = 'test-10' ; 
$msg = "$n " .  "the AppConfig has the LogToFile key" ; 
ok ( exists $appConfig->{'LogToFile'} , $msg ) ; 

#
#db_host
#postgres_db_name
#db_port
#postgres_db_user
#Emails
#HostName
#issue_tracker_project
#LogDir
#LogFile
#LogTimeToTextSeparator
#LogToFile
#ProductBaseDir
#ProductInstanceDir
#ProductInstanceEnvironment
#ProductName
#ProductOwner
#ProductType
#ProductVersion
#TimeFormat
