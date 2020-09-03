use strict ; use warnings ; 

use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../../../../../lib" }

use Carp ; 
use Test::More ; 
use Data::Printer ; 

use Qto::App::Utils::Initiator ; 
use Qto::App::Utils::Logger ; 
use JSON::Parse 'json_file_to_perl';

my $m = 'the tst msg' ; 
my $msg              = q{} ; 
my $objInitiator 		= 'Qto::App::Utils::Initiator'->new();	
my $config           = $objInitiator->get('AppConfig');
$config = json_file_to_perl ($objInitiator->doResolveConfFile());
$config->{'env'}->{'run'}->{'ProductInstanceDir'} = $objInitiator->doResolveProductInstanceDir(-1);
$config->{'env'}->{'run'}->{'ProductName'} = $objInitiator->doResolveProductName();
$config->{'env'}->{'run'}->{'VERSION'} = $objInitiator->doResolveVersion();
$config->{'env'}->{'run'}->{'ENV_TYPE'} = $objInitiator->doResolveEnvType();
my $ConfFile         = $objInitiator->{'ConfFile'} ; 

ok ( defined ( $config ) , "test-01 the config is defineD") ; 

my $objLogger			= 'Qto::App::Utils::Logger'->new(\$config);
my $LogFile				= $objLogger->get('LogFile') ; 
my $LogDir           =  $config->{'env'}->{'log'}->{'LogDir'} ; 
ok ( defined ( $LogDir) , "test-02 test that the LogDir is defined "  ); 

$objLogger->info ( "START TestLogger");

ok ( (-f $LogFile) ,       "test-03 test that the LogFile exists "  ); 


done_testing();

1;

# FILE-UUID b206b220-85ab-40c7-a8c7-a73c0fcd31d8
