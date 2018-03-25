use strict ; use warnings ; 

use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../lib" }
use Test::More tests => 5 ; 

use Getopt::Long;
use Data::Printer ; 
use Carp ; 
my $m = 'the issue-tracker calling shell needs always a set of pre-defined env vars,
thus you need to define your issue tracker project by :
doParseCnfEnvVars <<path-to-your-issue-tracker-projects-cnf-files>>/<<issue-tracker-cnf-file>>
for example:
doParseCnfEnvVars /vagrant/var/csitea/cnf/projects/issue-tracker/ysg-issues.dev.host-name.cnf'  ; 
croak $m unless ( defined ( $ENV{ "issue_tracker_project" } )) ; 

use IssueTracker::App::Utils::Initiator ; 
use IssueTracker::App::Utils::Logger ; 
use IssueTracker::App::Utils::Configurator ; 
use IssueTracker::App::Ctrl::Dispatcher ; 

my $objInitiator 				= 'IssueTracker::App::Utils::Initiator'->new();	
my $appConfig					= {} ;

$appConfig                 = $objInitiator->get('AppConfig');

my  $objConfigurator
    = 'IssueTracker::App::Utils::Configurator'->new($objInitiator->{'ConfFile'},
    \$appConfig);

$appConfig                 = $objConfigurator->getConfHolder()  ;

my $tn           = '' ;     # the test number for easier reading 
my $actions      = 'db-to-xls' ; 
my $objLogger	  = 'IssueTracker::App::Utils::Logger'->new(\$appConfig);
my $objModel     = 'IssueTracker::App::Mdl::Model'->new ( \$appConfig ) ; 
my $objDispatcher= 'IssueTracker::App::Ctrl::Dispatcher'->new(\$appConfig , \$objModel , 1);
my $functions    = $objDispatcher->doRunActions($actions);

$tn = 'test-01' ; 
$m  = "$tn:
   ensure the db-to-xls action calls the doDbToXls func" ; 
ok ( $functions eq 'doDbToXls' , $m );

$tn = 'test-02' ; 
$m  = "$tn: 
   ensure the db-to-xls action calls the doDbToXls func" ; 
$actions         = 'xls-to-db' ; 
$functions       = $objDispatcher->doRunActions($actions);
ok ( $functions eq 'doXlsToDb' , $m );

$tn = 'test-03' ; 
$m  = "$tn:
   ensure the txt-to-db action calls the doTxtToDb func" ; 
$actions         = 'txt-to-db' ; 
$functions       = $objDispatcher->doRunActions($actions);
ok ( $functions eq 'doTxtToDb' , "$m" );

my $ProductInstanceDir = $appConfig->{'ProductInstanceDir' } ; 
my $cmd = "$ProductInstanceDir/src/perl/issue_tracker/script/issue_tracker.pl -t daily_issues" ; 

$tn = 'test-04' ; 
$m  = "$tn:
   ensure the txt-to-db action calls the doTxtToDb func" ;
# src: http://perldoc.perl.org/perlop.html#Quote-Like-Operators
my $cmd_out = `$cmd 2>&1 1>/dev/null` ; 
# print "\$? is : $? \n" ; 
ok ( $?  != 0  , $m );

$tn = 'test-05' ; 
$m  = "$tn:
   ensure the json-to-db action calls the doJsonToDb func" ;
$actions         = 'json-to-db' ; 
$functions       = $objDispatcher->doRunActions($actions);
ok ( $functions eq 'doJsonToDb' , $m ) ;


# FILE-UUID b341825c-5e91-4b42-8359-a036284f0c2a
