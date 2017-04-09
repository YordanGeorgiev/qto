use strict ; use warnings ; 

use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../lib" }

use Test::More tests => 3 ; 
use Data::Printer ; 

use IssueTracker::App::Utils::Initiator ; 
use IssueTracker::App::Utils::Logger ; 
use IssueTracker::App::Controller::FileIOController ; 

my $objInitiator 				= 'IssueTracker::App::Utils::Initiator'->new();	
my $appConfig					= {} ;
my $ProductBaseDir 			= $objInitiator->doResolveMyProductBaseDir();
my $ProductDir 				= $objInitiator->doResolveMyProductDir();
my $ProductInstanceDir 		= $objInitiator->doResolveMyProductInstanceDir();
my $EnvironmentName 			= $objInitiator->doResolveMyEnvironmentName();
my $ProductName 				= $objInitiator->doResolveMyProductName();
my $ProductVersion 			= $objInitiator->doResolveMyProductVersion();
my $ProductType 				= $objInitiator->doResolveMyProductType();
my $ProductOwner 				= $objInitiator->doResolveMyProductOwner();
my $ConfFile 					= $objInitiator->doResolveMyConfFile();
my $HostName					= $objInitiator->doResolveMyHostName();

$appConfig						= $objInitiator->get ('AppConfig'); 
my $objLogger					= 'IssueTracker::App::Utils::Logger'->new(\$appConfig);

my $LogFile						= $objLogger->get('LogFile') ; 
my $test_counter				= 1 ; 
my $issues_file            = $ProductInstanceDir . "/non/existent/file.txt" ; 
my $ret                    = 0 ; 
my $msg                    = {} ; 

my $objFileIOController = 
   'IssueTracker::App::Controller::FileIOController'->new ( \$appConfig ) ; 

isa_ok($objFileIOController, "IssueTracker::App::Controller::FileIOController");
$test_counter++ ; 

can_ok($objFileIOController, $_) for qw(doLoadIssuesFileToDb);
$test_counter++ ; 

( $ret , $msg )            = $objFileIOController->doLoadIssuesFileToDb ( $issues_file ) ; 

ok ( $ret eq 1 ) 

# test that the return code is 1 if a non-existign isssue file is passed
