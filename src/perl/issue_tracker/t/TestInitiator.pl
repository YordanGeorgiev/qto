use strict ; use warnings ; 

use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../lib" }

use IssueTracker::App::Utils::Initiator ; 
use Test::More tests => 19 ; 
use Data::Printer ; 

my $msg                    = (); 
my $objInitiator 				= 'IssueTracker::App::Utils::Initiator'->new();	
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
my $appConfig					= {} ;
$appConfig						= $objInitiator->get ('AppConfig'); 

# p($appConfig) ; 
# sleep 6 ; 
# 1. 
# todo: remove hardcoding ...
$msg                       = 'The ProductBaseDir is the BaseDir + the organisation dir' ; 
ok ( $ProductBaseDir 		eq '/opt/csitea' , $msg ) ; 

# 2.
$msg                       = 'The ProductDir is the ProductBaseDir + the ProductName' ; 
ok ( $ProductDir 				eq '/opt/csitea/issue-tracker' , $msg ) ; 

# 3. # if not set , set in in the shell by:
# export product_instance_dir=/opt/csitea/issue-tracker/issue-tracker.0.2.8.dev.ysg
$msg                       = 'The ProductInstanceDir is the next level' ; 
ok ( $ProductInstanceDir 	eq $ENV{'product_instance_dir'} , $msg ) ; 

# 4.
my $EnvNameToCompare       = $ProductInstanceDir; 
$EnvNameToCompare          =~ s/$ProductDir\///g  ; 
$msg                       = 'The environment name is defined by the version , product type and the owner' ; 
ok ( $EnvironmentName 		eq $EnvNameToCompare , $msg ) ; 

# 5.
$msg                       = 'check the product-name ...' ; 
ok ( $ProductName          eq 'issue-tracker' , $msg ) ; 

# 6. 
my $ProductVerChmp         = `git tag|sort -nr|head -n 1` ; chomp($ProductVerChmp) ; 
$msg                       = 'The product version should be the same as the git tag command' ; 
ok ( $ProductVersion 		eq $ProductVerChmp , $msg) ; 

# 7. 
my $ProdTypeToCompare      = $EnvNameToCompare ; 
$ProdTypeToCompare         =~ s/$ProductName\.//g ; 
$ProdTypeToCompare         =~ s/$ProductVersion\.//g ; 
$ProdTypeToCompare         =~ s/([a-z]{1,3})\.(.*)/$1/g ; 
$msg                       = 'Should be one of the following: dev,tst,qas,prd' ; 
ok ( $ProductType 			eq $ProdTypeToCompare , $msg ) ; 

# 8.
$msg                       = 'The personal account of the person PERSONALLY !!! responsible for this instance' ; 
ok ( $ProductOwner 			eq $2 , $msg ) ;

# 9.
my $cmd_out						= `hostname -s` ; chomp ( $cmd_out ) ; 

$msg                       = 'The hostname of this machine' ; 
ok ( $HostName 				eq "$cmd_out" , $msg ) ;

# 10.
my $CnfFileToCompare       = "$ProductInstanceDir/cnf/issue-tracker." . $ProductType . '.' . $cmd_out . '.cnf' ; 
$msg                       = 'The file naming convention for the configuration file: ' . "\n" . $CnfFileToCompare ; 
ok ( $ConfFile					eq $CnfFileToCompare , $msg ) ; 

# 11.
$msg                       = 'The value of the ProductBaseDir from the appConfig ' ; 
ok ( $ProductBaseDir 		eq $appConfig->{'ProductBaseDir'} , $msg ) ; 

# 12.
$msg                       = 'The value of the ProductDir from the appConfig ' ; 
ok ( $ProductDir 				eq $appConfig->{'ProductDir'} , $msg ) ; 

# 13.
$msg                       = 'The value of the ProductDir from the appConfig ' ; 
ok ( $ProductInstanceDir 	eq $appConfig->{'ProductInstanceDir'} , $msg ) ; 

# 14.
$msg                       = 'The value of the ProductVersion from the appConfig ' ; 
ok ( $ProductVersion 		eq $appConfig->{'ProductVersion' } , $msg ); 

# 15.
$msg                       = 'The value of the ProductInstanceEnvironment' ; 
ok ( $EnvironmentName 		eq $appConfig->{'ProductInstanceEnvironment'} , $msg ); 

# 16.
$msg                       = 'The value of the ProductType from the appConfig' ; 
ok ( $ProductType 			eq $appConfig->{'ProductType'} , $msg ) ;

# 17.
$msg                       = 'The value of the ProductOwner from the appConfig' ; 
ok ( $ProductOwner 			eq $appConfig->{'ProductOwner'} , $msg ) ;

# 18.
$msg                       = 'The value of the HostName from the appConfig' ; 
ok ( $HostName 				eq $appConfig->{'HostName'} , $msg) ;

# 19.
$msg                       = 'The value of the ConfFile from the appConfig' ; 
ok ( $ConfFile 				eq $appConfig->{'ConfFile'} , $msg ) ;

# 20.
# todo: how-to test that the method fails ?!
# nok ( $objInitiator->doRunNonExistentMethod ) ; 
