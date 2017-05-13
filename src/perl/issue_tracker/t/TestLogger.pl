use strict ; use warnings ; 

use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../lib" }


use IssueTracker::App::Utils::Initiator ; 
use IssueTracker::App::Utils::Logger ; 
use Test::More tests => 1 ; 
use Data::Printer ; 


my $objInitiator 				= 'IssueTracker::App::Utils::Initiator'->new();	
my $appConfig					= {} ;
my $ProductBaseDir 			= $objInitiator->doResolveMyProductBaseDir();
my $ProductDir 				= $objInitiator->doResolveMyProductDir();
my $ProductInstanceDir 		= $objInitiator->doResolveMyProductInstanceDir();
my $EnvironmentName 			= $objInitiator->doResolveMyProductInstanceEnvironment();
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

print "test-$test_counter -- test that the log file is set to the name of the script.log" . "\n" ; 
print " aka $0.log == $LogFile  \n" ; 
ok ( "$0.log" eq $LogFile ) ; 
$test_counter++ ; 

# FILE-UUID b206b220-85ab-40c7-a8c7-a73c0fcd31d8
