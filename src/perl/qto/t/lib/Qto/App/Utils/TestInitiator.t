use strict ; use warnings ; 

use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../../../../../lib" }

use Qto::App::Utils::Initiator ; 
use Data::Printer ; 
use Test::More ; 


my $msg                    = (); 
my $tn                     = '' ; # my test number
my $objInitiator 				= 'Qto::App::Utils::Initiator'->new();	
my $ProductBaseDir 			= $objInitiator->get('ProductBaseDir') ;
my $ProductDir 			   = $objInitiator->get('ProductDir') ;
my $ProductInstanceDir 		= $objInitiator->get('ProductInstanceDir');
my $ProductInstanceEnv 	   = $objInitiator->get('ProductInstanceEnv');
my $ProductName 				= $objInitiator->doResolveMyProductName();
my $ProductVersion 			= $objInitiator->doResolveMyProductVersion();
my $ProductType 				= $objInitiator->doResolveMyProductType();
my $ProductOwner 				= $objInitiator->doResolveMyProductOwner();
my $ConfFile 					= $objInitiator->doResolveMyConfFile();
my $HostName					= $objInitiator->doResolveMyHostName();
my $appConfig					= {} ;
$appConfig						= $objInitiator->get ('AppConfig'); 

use Carp ; 
my $m = 'the qto calling shell needs always a set of pre-defined env vars,
thus you need to define your issue tracker project by :
doParseCnfEnvVars <<path-to-your-qto-projects-cnf-files>>/<<qto-cnf-file>>
for example:
doParseCnfEnvVars /vagrant/var/csitea/cnf/projects/qto/ysg-issues.dev.host-name.cnf'  ; 
croak $m unless ( defined ( $ENV{ "qto_project" } )) ; 

# p($appConfig) ; 
# sleep 6 ; 
# todo: remove hardcoding ...
my $product_base_dir       = $ENV { 'product_instance_dir' } ; 
$product_base_dir          =~ s/(.*)([\/\\])(.*)/$1/g ; 
$product_base_dir          =~ s/(.*)([\/\\])(.*)/$1/g ; 
my $product_dir            = "$product_base_dir/$3" ; 


$tn = 'test-01' ; 
$msg                       = "$tn ::: " . 'The ProductBaseDir is the BaseDir + the organisation dir' ; 
# ok ( $ProductBaseDir 		eq '/vagrant/opt/csitea' , $msg ) ; 
ok ( $ProductBaseDir 		eq $product_base_dir, $msg ) ; 


$tn = 'test-02' ; 
$msg                       = "$tn ::: " . 'The ProductDir is the ProductBaseDir + the ProductName ' ; 
$msg .= " : $product_dir " ; 
ok ( $ProductDir 				eq $product_dir , $msg ) ; 


$tn = 'test-03' ; 
# 3. # if not set , set in in the shell by:
# export product_instance_dir=/opt/csitea/qto/qto.0.2.8.dev.ysg
$msg                       = "$tn ::: " .'The ProductInstanceDir is the next level' ; 
ok ( $ProductInstanceDir 	eq $ENV{'product_instance_dir'} , $msg ) ; 


$tn = 'test-04' ; 
my $EnvNameToCompare       = $ProductInstanceDir; 
$EnvNameToCompare          =~ s/$ProductDir\///g  ; 
$msg                       = "$tn ::: " . 'The environment name is defined by the version , product type and the owner' ; 
ok ( $ProductInstanceEnv   eq $EnvNameToCompare , $msg ) ; 


$tn = 'test-05' ; 
$msg                       = "$tn ::: " . 'check the product-name ...' ; 
ok ( $ProductName          eq 'qto' , $msg ) ; 


$tn = 'test-06' ; 
my $ProductVerChmp         = `git tag|sort -nr|head -n 1` ; chomp($ProductVerChmp) ; 
$msg                       = "$tn ::: " . 'The product version should be the same as the git tag command' ; 
ok ( $ProductVersion 		eq $ProductVerChmp , $msg) ; 

$tn = 'test-07' ; 
my $ProdTypeToCompare      = $EnvNameToCompare ; 
$ProdTypeToCompare         =~ s/$ProductName\.//g ; 
$ProdTypeToCompare         =~ s/$ProductVersion\.//g ; 
$ProdTypeToCompare         =~ s/([a-z]{1,3})\.(.*)/$1/g ; 
$msg                       = "$tn ::: " . 'Should be one of the following: dev,tst,qas,prd' ; 
ok ( $ProductType 			eq $ProdTypeToCompare , $msg ) ; 


$tn = 'test-08' ; 
$msg                       = "$tn ::: " . 'The personal account of the person PERSONALLY !!! responsible for this instance' ; 
ok ( $ProductOwner 			eq $2 , $msg ) ;

$tn = 'test-09' ; 
my $cmd_out						= `hostname -s` ; chomp ( $cmd_out ) ; 
$msg                       = "$tn ::: " . 'The hostname of this machine' ; 
ok ( $HostName 				eq "$cmd_out" , $msg ) ;


$tn = 'test-10' ; 
my $CnfFileToCompare       = "$ProductInstanceDir/cnf/qto." . $ProductType . '.' . $cmd_out . '.cnf' ; 
$msg                       = "$tn ::: " . 'The file naming convention for the configuration file: ' . "\n" . $CnfFileToCompare ; 
ok ( $ConfFile					eq $CnfFileToCompare , $msg ) ; 


$tn = 'test-11' ; 
$msg                       = "$tn ::: " . 'The value of the ProductBaseDir from the appConfig ' ; 
ok ( $ProductBaseDir 		eq $appConfig->{'ProductBaseDir'} , $msg ) ; 


$tn = 'test-12' ; 
$msg                       = "$tn ::: " . 'The value of the ProductDir from the appConfig ' ; 
ok ( $ProductDir 				eq $appConfig->{'ProductDir'} , $msg ) ; 


$tn = 'test-13' ; 
$msg                       = "$tn ::: " . 'The value of the ProductDir from the appConfig ' ; 
ok ( $ProductInstanceDir 	eq $appConfig->{'ProductInstanceDir'} , $msg ) ; 


$tn = 'test-14' ; 
$msg                       = "$tn ::: " . 'The value of the ProductVersion from the appConfig ' ; 
ok ( $ProductVersion 		eq $appConfig->{'ProductVersion' } , $msg ); 


$tn = 'test-15' ; 
$msg                       = "$tn ::: " . 'The value of the ProductInstanceEnv' ; 
ok ( $ProductInstanceEnv eq $appConfig->{'ProductInstanceEnv'} , $msg ); 

$tn = 'test-16' ; 
$msg                       = "$tn ::: " . 'The value of the ProductType from the appConfig' ; 
ok ( $ProductType 			eq $appConfig->{'ProductType'} , $msg ) ;


$tn = 'test-17' ; 
$msg                       = "$tn ::: " . 'The value of the ProductOwner from the appConfig' ; 
ok ( $ProductOwner 			eq $appConfig->{'ProductOwner'} , $msg ) ;


$tn = 'test-18' ; 
$msg                       = "$tn ::: " . 'The value of the HostName from the appConfig' ; 
ok ( $HostName 				eq $appConfig->{'HostName'} , $msg) ;


$tn = 'test-19' ; 
$msg                       = "$tn ::: " . 'The value of the ConfFile from the appConfig' ; 
ok ( $ConfFile 				eq $appConfig->{'ConfFile'} , $msg ) ;

done_testing(); 

1; 
# 20.
# todo: how-to test that the method fails ?!
# nok ( $objInitiator->doRunNonExistentMethod ) ; 
