use strict ; use warnings ; 

use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../../../../../lib" }

use Carp ; 
use Test::More ; 
use Data::Printer ; 

use Qto::App::Utils::Initiator ; 
use Qto::App::Utils::Logger ; 
use JSON::Parse 'json_file_to_perl';

my $m = 'the qto calling shell needs always a set of pre-defined env vars,
thus you need to define your issue tracker project by :
doParseCnfEnvVars <<path-to-your-qto-projects-cnf-files>>/<<qto-cnf-file>>
for example:
doParseCnfEnvVars /vagrant/var/csitea/cnf/projects/qto/ysg-issues.dev.host-name.cnf'  ; 
croak $m unless ( defined ( $ENV{ "qto_project" } )) ; 

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

$objLogger->doLogInfoMsg ( "START TestLogger");

ok ( (-f $LogFile) ,       "test-03 test that the LogFile exists "  ); 


done_testing();

1;

# FILE-UUID b206b220-85ab-40c7-a8c7-a73c0fcd31d8
