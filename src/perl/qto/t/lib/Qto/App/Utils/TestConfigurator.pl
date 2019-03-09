use strict ; use warnings ; 

use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../../../../../lib" }

use Qto::App::Utils::Initiator ; 
use Qto::App::Utils::Configurator ; 

use Test::More tests => 10 ; 
use Data::Printer ; 
use Scalar::Util qw/reftype/;

use Carp ; 
my $m = 'the qto calling shell needs always a set of pre-defined env vars,
thus you need to define your issue tracker project by :
doParseCnfEnvVars <<path-to-your-qto-projects-cnf-files>>/<<qto-cnf-file>>
for example:
doParseCnfEnvVars /vagrant/var/csitea/cnf/projects/qto/ysg-issues.dev.host-name.cnf'  ; 
croak $m unless ( defined ( $ENV{ "qto_project" } )) ; 
my $msg              = (); 
my $n                = (); 
my $objInitiator     = {} ; 
my $objConfigurator  = {} ; 
my $appConfig        = {} ; 
my $ConfFile         = {} ; 
$objInitiator 		   = 'Qto::App::Utils::Initiator'->new(4);
$appConfig           = $objInitiator->get('AppConfig');

  $objConfigurator
    = 'Qto::App::Utils::Configurator'->new($objInitiator->{'ConfFile'},
    \$appConfig);

$appConfig           = $objConfigurator->getConfHolder()  ;

$n = 'test-01' ; 
$msg                 = 'the objConfigurator produces the appConfig hash' ; 
ok ( reftype $appConfig eq reftype {} , $msg ) ; 
p($appConfig) ; 

$n = 'test-02' ; 
$msg = "$n " .  "the AppConfig has the PrintConsoleMsgs key" ; 
ok ( exists $appConfig->{'PrintConsoleMsgs'} , $msg ) ; 

$n = 'test-03' ; 
$msg = "$n " .  "the AppConfig has the PrintDebugMsgs key" ; 
ok ( exists $appConfig->{'PrintDebugMsgs'} , $msg ) ; 

$n = 'test-04' ; 
$msg = "$n " .  "the AppConfig has the PrintErrorMsgs key" ; 
ok ( exists $appConfig->{'PrintErrorMsgs'} , $msg ) ; 

$n = 'test-05' ; 
$msg = "$n " .  "the AppConfig has the PrintInfoMsgs key" ; 
ok ( exists $appConfig->{'PrintInfoMsgs'} , $msg ) ; 

$n = 'test-06' ; 
$msg = "$n " .  "the AppConfig has the PrintTraceMsgs key" ; 
ok ( exists $appConfig->{'PrintTraceMsgs'} , $msg ) ; 

$n = 'test-07' ; 
$msg = "$n " .  "the AppConfig has the PrintWarningMsgs key" ; 
ok ( exists $appConfig->{'PrintWarningMsgs'} , $msg ) ; 

$n = 'test-08' ; 
$msg = "$n " .  "the AppConfig has the LogDir key" ; 
ok ( exists $appConfig->{'LogDir'} , $msg ) ; 

$n = 'test-09' ; 
$msg = "$n " .  "the AppConfig has the LogFile key" ; 
ok ( exists $appConfig->{'LogFile'} , $msg ) ; 

$n = 'test-10' ; 
$msg = "$n " .  "the AppConfig has the LogToFile key" ; 
ok ( exists $appConfig->{'LogToFile'} , $msg ) ; 

#
#postgres_db_host
#postgres_db_name
#postgres_db_port
#postgres_db_user
#Emails
#HostName
#qto_project
#LogDir
#LogFile
#LogTimeToTextSeparator
#LogToFile
#ProductBaseDir
#ProductInstanceDir
#ProductInstanceEnvironment
#ProductName
#ProductOwner
#ProductType
#ProductVersion
#TimeFormat
