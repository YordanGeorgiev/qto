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
my $init_config					   = {} ;
$init_config						   = $objInitiator->get ('AppConfig'); 

use Carp ; 

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
$msg                       = "$tn ::: " .'The ProductInstanceDir is the next level' ; 
ok ( $ProductInstanceDir 	eq $ENV{'product_instance_dir'} , $msg ) ; 


$tn = 'test-04' ; 
$msg                       = "$tn ::: " . 'check the product-name ...' ; 
ok ( $ProductName          eq 'qto' , $msg ) ; 


$tn = 'test-05' ; 
my $cmd_out						= `hostname -s` ; chomp ( $cmd_out ) ; 
$msg                       = "$tn ::: " . 'The hostname of this machine' ; 
ok ( $HostName 				eq "$cmd_out" , $msg ) ;


$tn = 'test-06' ; 
$msg                       = "$tn ::: " . 'The value of the ProductBaseDir from the init_config ' ; 
ok ( $ProductBaseDir 		eq $init_config->{'ProductBaseDir'} , $msg ) ; 


$tn = 'test-07' ; 
$msg                       = "$tn ::: " . 'The value of the ProductDir from the init_config ' ; 
ok ( $ProductDir 				eq $init_config->{'ProductDir'} , $msg ) ; 


$tn = 'test-08' ; 
$msg                       = "$tn ::: " . 'The value of the ProductDir from the init_config ' ; 
ok ( $ProductInstanceDir 	eq $init_config->{'ProductInstanceDir'} , $msg ) ; 


$tn = 'test-09' ; 
$msg                       = "$tn ::: " . 'The value of the EnvType from the init_config' ; 
ok ( $EnvType 			      eq $init_config->{'EnvType'} , $msg ) ;



$tn = 'test-10' ; 
$msg                       = "$tn ::: " . 'The value of the HostName from the init_config' ; 
ok ( $HostName 				eq $init_config->{'HostName'} , $msg) ;

done_testing(); 

1; 
