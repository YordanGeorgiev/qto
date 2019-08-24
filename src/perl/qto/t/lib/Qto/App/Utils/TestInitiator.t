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
my $ProductName 				= $objInitiator->doResolveProductName();
my $EnvType 				   = $objInitiator->doResolveEnvType();
my $HostName					= $objInitiator->doResolveHostName();
my $config					   = {} ;
$config						   = $objInitiator->get ('AppConfig'); 

use Carp ; 

my $product_base_dir       = $ENV { 'PRODUCT_INSTANCE_DIR' } ; 
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
# export PRODUCT_INSTANCE_DIR=`pwd`
$msg                       = "$tn ::: " .'The ProductInstanceDir is the next level' ; 
ok ( $ProductInstanceDir 	eq $ENV{'PRODUCT_INSTANCE_DIR'} , $msg ) ; 


$tn = 'test-04' ; 
$msg                       = "$tn ::: " . 'check the product-name ...' ; 
ok ( $ProductName          eq 'qto' , $msg ) ; 


$tn = 'test-05' ; 
$msg                       = "$tn ::: " . 'The product version should be the same as the git tag command' ; 
my $ProductVersion 			= $objInitiator->doResolveVersion();
my $ProductVerChmp         = `git tag|sort -nr|head -n 1` ; chomp($ProductVerChmp) ; 
ok ( $ProductVersion 		eq $ProductVerChmp , $msg) ; 

$tn = 'test-06' ; 
my $cmd_out						= `hostname -s` ; chomp ( $cmd_out ) ; 
$msg                       = "$tn ::: " . 'The hostname of this machine' ; 
ok ( $HostName 				eq "$cmd_out" , $msg ) ;


$tn = 'test-07' ; 
$msg                       = "$tn ::: " . 'The value of the ProductBaseDir from the config ' ; 
ok ( $ProductBaseDir 		eq $config->{'ProductBaseDir'} , $msg ) ; 


$tn = 'test-08' ; 
$msg                       = "$tn ::: " . 'The value of the ProductDir from the config ' ; 
ok ( $ProductDir 				eq $config->{'ProductDir'} , $msg ) ; 


$tn = 'test-09' ; 
$msg                       = "$tn ::: " . 'The value of the ProductDir from the config ' ; 
ok ( $ProductInstanceDir 	eq $config->{'ProductInstanceDir'} , $msg ) ; 



$tn = 'test-10' ; 
$msg                       = "$tn ::: " . 'The value of the EnvType from the config' ; 
ok ( $EnvType 			eq $config->{'EnvType'} , $msg ) ;



$tn = 'test-11' ; 
$msg                       = "$tn ::: " . 'The value of the HostName from the config' ; 
ok ( $HostName 				eq $config->{'HostName'} , $msg) ;

done_testing(); 

1; 
