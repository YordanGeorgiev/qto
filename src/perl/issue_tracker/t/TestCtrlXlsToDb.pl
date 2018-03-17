use strict ; use warnings ; 

use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../lib" }
use Test::More tests => 1 ; 

use Data::Printer ; 
use IssueTracker::App::Utils::Initiator ; 
use IssueTracker::App::Utils::Logger ; 
use IssueTracker::App::Utils::Configurator ; 
use IssueTracker::App::Ctrl::Dispatcher ; 

my $objInitiator 				= 'IssueTracker::App::Utils::Initiator'->new();	
my $appConfig					= {} ;
$appConfig                 = $objInitiator->get('AppConfig');
my $objConfigurator       = 'IssueTracker::App::Utils::Configurator'->new(
                               $objInitiator->{'ConfFile'}, \$appConfig);
$appConfig                 = $objConfigurator->getConfHolder()  ;
my $actions               	= 'db-to-xls' ; 
my $objLogger					= 'IssueTracker::App::Utils::Logger'->new(\$appConfig);
my $objModel               = 'IssueTracker::App::Mdl::Model'->new ( \$appConfig ) ; 
my $objDispatcher 			= 'IssueTracker::App::Ctrl::Dispatcher'->new(\$appConfig , \$objModel , 1);


my $ProductInstanceDir = $appConfig->{'ProductInstanceDir' } ; 
my $cmd = "$ProductInstanceDir/src/perl/issue_tracker/script/issue_tracker.pl -t daily_issues" ; 

# src: http://perldoc.perl.org/perlop.html#Quote-Like-Operators
$cmd = "$cmd --do xls-to-db" ; 
my $cmd_out = `$cmd 2>&1 1>/dev/null` ; 
ok ( $?  != 0  , 'the whole script should fail because the --xls-file is not defined ' ) ; 

# FILE-UUID c2053bc2-60a7-44f9-a375-aa5303650f91
