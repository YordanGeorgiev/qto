use strict ; use warnings ; 

use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../lib" }

use IssueTracker::App::Utils::Initiator ; 
use IssueTracker::App::Utils::Configurator ; 

use Test::More tests => 10 ; 
use Data::Printer ; 
use Scalar::Util qw/reftype/;

my $msg              = (); 
my $objInitiator     = {} ; 
my $objConfigurator  = {} ; 
my $appConfig        = {} ; 
my $ConfFile         = {} ; 
$objInitiator 		   = 'IssueTracker::App::Utils::Initiator'->new();	
$appConfig           = $objInitiator->get('AppConfig');

  $objConfigurator
    = 'IssueTracker::App::Utils::Configurator'->new($objInitiator->{'ConfFile'},
    \$appConfig);

$appConfig           = $objConfigurator->getConfHolder()  ;

# 1.
$msg                 = 'the objConfigurator produces the appConfig hash' ; 
ok ( reftype $appConfig eq reftype {} , $msg ) ; 
p($appConfig) ; 

# 2. 
$msg = "the AppConfig has the PrintConsoleMsgs key" ; 
ok ( exists $appConfig->{'PrintConsoleMsgs'} , $msg ) ; 

# 3. 
$msg = "the AppConfig has the PrintDebugMsgs key" ; 
ok ( exists $appConfig->{'PrintDebugMsgs'} , $msg ) ; 

# 4.
$msg = "the AppConfig has the PrintErrorMsgs key" ; 
ok ( exists $appConfig->{'PrintErrorMsgs'} , $msg ) ; 

# 5.
$msg = "the AppConfig has the PrintInfoMsgs key" ; 
ok ( exists $appConfig->{'PrintInfoMsgs'} , $msg ) ; 

# 6.
$msg = "the AppConfig has the PrintTraceMsgs key" ; 
ok ( exists $appConfig->{'PrintTraceMsgs'} , $msg ) ; 

# 7.
$msg = "the AppConfig has the PrintWarningMsgs key" ; 
ok ( exists $appConfig->{'PrintWarningMsgs'} , $msg ) ; 

# 8.
$msg = "the AppConfig has the LogDir key" ; 
ok ( exists $appConfig->{'LogDir'} , $msg ) ; 

# 9.
$msg = "the AppConfig has the LogFile key" ; 
ok ( exists $appConfig->{'LogFile'} , $msg ) ; 

# 10.
$msg = "the AppConfig has the LogToFile key" ; 
ok ( exists $appConfig->{'LogToFile'} , $msg ) ; 

#
#db_host
#postgres_db_name
#db_port
#DbType
#postgres_db_user
#Emails
#HostName
#issue_tracker_project
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
