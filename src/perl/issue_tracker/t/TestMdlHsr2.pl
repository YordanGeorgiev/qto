use strict ; use warnings ; 

use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../lib" }
use Data::Printer ; 

use Test::More tests => 4 ; 
use IssueTracker::App::Utils::Initiator ; 
use IssueTracker::App::Utils::Logger ; 
use IssueTracker::App::Utils::Configurator ; 
use IssueTracker::App::Ctrl::Dispatcher ; 
use IssueTracker::App::Mdl::MdlHsr2 ; 


my $msg = ();
my $objInitiator 				= 'IssueTracker::App::Utils::Initiator'->new();	
my $appConfig					= {} ;

$appConfig                 = $objInitiator->get('AppConfig');

my  $objConfigurator
    = 'IssueTracker::App::Utils::Configurator'->new($objInitiator->{'ConfFile'},
    \$appConfig);

$appConfig                 = $objConfigurator->getConfHolder()  ;

my $objMdlHsr2             = 'IssueTracker::App::Mdl::MdlHsr2'->new ( \$appConfig ) ; 

$msg = 'test that the objMdlHsr2 is created' ; 
ok ( ref($objMdlHsr2) eq 'IssueTracker::App::Mdl::MdlHsr2' , $msg ) ;

#
# -----
$msg = 'check that the appConfig is passed correctly' ; 
my $chkAppConfig  = $objMdlHsr2->get('appConfig' ) ; 
ok ( $chkAppConfig == $appConfig , $msg ) ;

#
# -----
# or how-to check that a perl hash is empty 
# src: https://stackoverflow.com/a/9444948/65706
$msg = 'check that an empty hsr2 is created during initializatin' ; 
my $hsr2  = $objMdlHsr2->get('hsr2' ) ; 

ok ( !%$hsr2 , $msg ) ;

#
# -----
$msg = 'check that an empty mhsr2 is created during initializatin' ; 
my $mhsr2  = $objMdlHsr2->get('mhsr2' ) ; 
ok ( !%$mhsr2 , $msg ) ;















