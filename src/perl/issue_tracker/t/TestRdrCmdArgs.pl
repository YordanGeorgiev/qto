use strict ; use warnings ; 

use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../lib" }
use Test::More tests => 2 ; 

use Getopt::Long;
use IssueTracker::App::Utils::Initiator ; 
use IssueTracker::App::Utils::Logger ; 
use Data::Printer ; 
use IssueTracker::App::Utils::Configurator ; 
use IssueTracker::App::IO::In::RdrCmdArgs ; 


my $objInitiator 				= 'IssueTracker::App::Utils::Initiator'->new();	
my $appConfig					= {} ;
my $msg                    = q{} ; 

$appConfig                 = $objInitiator->get('AppConfig');

my  $objConfigurator
    = 'IssueTracker::App::Utils::Configurator'->new($objInitiator->{'ConfFile'},
    \$appConfig);

$appConfig                 = $objConfigurator->getConfHolder()  ;

my $objLogger					= 'IssueTracker::App::Utils::Logger'->new(\$appConfig);
my $objModel               = 'IssueTracker::App::Mdl::Model'->new ( \$appConfig ) ; 
my $objRdrCmdArgs 			= 'IssueTracker::App::IO::In::RdrCmdArgs'->new(\$appConfig , \$objModel ) ; 

$msg = 'test-01 - ensure the objRdrCmdArgs can be created ' ; 
ok ( ref $objRdrCmdArgs eq 'IssueTracker::App::IO::In::RdrCmdArgs' , $msg ) ; 

# those will fail if you do not use the run-perl-tests.func.sh wrapper
# as the cmd args are passed from there - fin: run-perl-tests.func.sh
$msg = 'test-02 - ensure the actions are passed to the model' ; 
ok ( $objModel->get('ctrl.actions') eq 'run' , $msg ) ; 


# FILE-UUID 7bf7ee86-58f3-417a-8413-929131912912
