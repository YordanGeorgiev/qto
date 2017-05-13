use strict ; use warnings ; 

use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../lib" }

use IssueTracker::App::Utils::Initiator ; 
use Test::More tests => 20 ; 
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

# p($appConfig) ; 
# sleep 6 ; 

ok ( $ProductBaseDir 		eq '/opt/csitea' ) ; 
ok ( $ProductDir 				eq '/opt/csitea/issue-tracker' ) ; 
ok ( $ProductInstanceDir 	eq '/opt/csitea/issue-tracker/issue-tracker.0.1.3.dev.ysg' ); 
ok ( $ProductVersion 		eq '0.1.3' ); 
ok ( $EnvironmentName 		eq 'issue-tracker.0.1.3.dev.ysg' ); 
ok ( $ProductType 			eq 'dev' ) ;
ok ( $ProductType 			ne 'tst' ) ;
ok ( $ProductType 			ne 'prd' ) ;
ok ( $ProductOwner 			eq 'ysg' ) ;
my $cmd_out						= `hostname -s` ; 
chomp ( $cmd_out ) ; 
ok ( $HostName 				eq "$cmd_out" ) ;
ok ( $ConfFile					eq 
'/opt/csitea/issue-tracker/issue-tracker.0.1.3.dev.ysg/cnf/issue-tracker.' . $ProductType . '.' . $cmd_out . '.cnf' ) ; 

ok ( $ProductBaseDir 		eq $appConfig->{'ProductBaseDir'} ) ; 
ok ( $ProductDir 				eq $appConfig->{'ProductDir'} ) ; 
ok ( $ProductInstanceDir 	eq $appConfig->{'ProductInstanceDir'} ) ; 
ok ( $ProductVersion 		eq $appConfig->{'ProductVersion' } ); 
ok ( $EnvironmentName 		eq $appConfig->{'ProductInstanceEnvironment'} ); 
ok ( $ProductType 			eq $appConfig->{'ProductType'} ) ;
ok ( $ProductOwner 			eq $appConfig->{'ProductOwner'} ) ;
ok ( $HostName 				eq $appConfig->{'HostName'} ) ;
ok ( $ConfFile 				eq $appConfig->{'ConfFile'} ) ;

