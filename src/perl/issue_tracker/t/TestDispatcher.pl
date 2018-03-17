use strict ; use warnings ; 

use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../lib" }
use Test::More tests => 4 ; 

use Getopt::Long;
use IssueTracker::App::Utils::Initiator ; 
use IssueTracker::App::Utils::Logger ; 
use Data::Printer ; 
use IssueTracker::App::Utils::Configurator ; 
use IssueTracker::App::Ctrl::Dispatcher ; 


my $objInitiator 				= 'IssueTracker::App::Utils::Initiator'->new();	
my $appConfig					= {} ;

$appConfig                 = $objInitiator->get('AppConfig');

my  $objConfigurator
    = 'IssueTracker::App::Utils::Configurator'->new($objInitiator->{'ConfFile'},
    \$appConfig);

$appConfig                 = $objConfigurator->getConfHolder()  ;

my $actions               	= 'db-to-xls' ; 
my $objLogger					= 'IssueTracker::App::Utils::Logger'->new(\$appConfig);
my $objModel               = 'IssueTracker::App::Mdl::Model'->new ( \$appConfig ) ; 
my $objDispatcher 			= 'IssueTracker::App::Ctrl::Dispatcher'->new(\$appConfig , \$objModel , 1);
my $functions              = $objDispatcher->doRunActions($actions);
ok ( $functions eq 'doDbToXls' , "test-01 ensure the db-to-xls action calls the doDbToXls func" );

$actions               		= 'xls-to-db' ; 
$functions              	= $objDispatcher->doRunActions($actions);
ok ( $functions eq 'doXlsToDb' , "test-02 ensure the db-to-xls action calls the doDbToXls func" );
 
$actions               		= 'txt-to-db' ; 
$functions              	= $objDispatcher->doRunActions($actions);
ok ( $functions eq 'doTxtToDb' , "test-03 ensure the txt-to-db action calls the doTxtToDb func" );

my $ProductInstanceDir = $appConfig->{'ProductInstanceDir' } ; 
my $cmd = "$ProductInstanceDir/src/perl/issue_tracker/script/issue_tracker.pl -t daily_issues" ; 

# src: http://perldoc.perl.org/perlop.html#Quote-Like-Operators
my $cmd_out = `$cmd 2>&1 1>/dev/null` ; 
print "\$? is : $? \n" ; 
ok ( $?  != 0  , 'should fail because the --do action is not passed ' ) ; 


# FILE-UUID b341825c-5e91-4b42-8359-a036284f0c2a
