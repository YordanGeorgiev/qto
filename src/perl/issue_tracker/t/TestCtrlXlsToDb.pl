use strict ; use warnings ; 

use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../lib" }
use Test::More tests => 1 ; 
use Carp ; 

use Data::Printer ; 
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

my $objInitiator 				= 'IssueTracker::App::Utils::Initiator'->new();	
my $appConfig					= {} ;
$appConfig                 = $objInitiator->get('AppConfig');
my $objConfigurator       = 'IssueTracker::App::Utils::Configurator'->new(
                               $objInitiator->{'ConfFile'}, \$appConfig);
$appConfig                 = $objConfigurator->getConfHolder()  ;
my $actions               	= 'db-to-xls' ; 
my $objLogger					= 'IssueTracker::App::Utils::Logger'->new(\$appConfig);
my $objModel               = 'IssueTracker::App::Mdl::Model'->new ( \$appConfig ) ; 
my $objDispatcher 			= 'IssueTracker::App::Ctrl::Dispatcher'->new(\$appConfig , \$objModel , 1);


my $ProductInstanceDir = $appConfig->{'ProductInstanceDir' } ; 
my $cmd = "$ProductInstanceDir/src/perl/issue_tracker/script/issue_tracker.pl -t daily_issues" ; 

# src: http://perldoc.perl.org/perlop.html#Quote-Like-Operators
print "this will take at least 10 seconds ... or even more .. be patient ... \n" ; 
$cmd = "$cmd --do xls-to-db 2>&1 1>/dev/null" ; 
# my $cmd_out = `$cmd 2>&1 1>/dev/null` ; 
my $cmd_out = `$cmd` ; 
$m = " if the xls file is not provided on the cmd line 
       the newest xls file from the mix data dir :\n" . 
       `find $ENV{mix_data_dir} -name "*.xlsx"|sort -nr |head -n 1` .
       "should be used and the script should still exit with 0" ; 
ok ( $?  == 0  , $m ); 


# FILE-UUID c2053bc2-60a7-44f9-a375-aa5303650f91
