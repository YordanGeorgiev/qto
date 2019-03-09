use strict ; use warnings ; 

use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../lib" }
use Test::More tests => 3 ; 

use Getopt::Long;
use Qto::App::Utils::Initiator ; 
use Qto::App::Utils::Logger ; 
use Data::Printer ; 
use Qto::App::Utils::Configurator ; 
use Qto::App::IO::In::RdrCmdArgs ; 

use Carp ; 
my $m = 'the qto calling shell needs always a set of pre-defined env vars,
thus you need to define your issue tracker project by :
doParseCnfEnvVars <<path-to-your-qto-projects-cnf-files>>/<<qto-cnf-file>>
for example:
doParseCnfEnvVars /vagrant/var/csitea/cnf/projects/qto/ysg-issues.dev.host-name.cnf'  ; 
croak $m unless ( defined ( $ENV{ "qto_project" } )) ; 

my $objInitiator 				= 'Qto::App::Utils::Initiator'->new();	
my $appConfig					= {} ;
my $msg                    = q{} ; 

$appConfig                 = $objInitiator->get('AppConfig');

my  $objConfigurator
    = 'Qto::App::Utils::Configurator'->new($objInitiator->{'ConfFile'},
    \$appConfig);

$appConfig                 = $objConfigurator->getConfHolder()  ;

my $objLogger					= 'Qto::App::Utils::Logger'->new(\$appConfig);
my $objModel               = 'Qto::App::Mdl::Model'->new ( \$appConfig ) ; 
my $objRdrCmdArgs 			= 'Qto::App::IO::In::RdrCmdArgs'->new(\$appConfig , \$objModel ) ; 


$ARGV[0] = '--do' unless $ARGV[0]  ; 
$ARGV[1] = 'run' unless $ARGV[1]  ; 
$msg = 'test-01 - ensure the objRdrCmdArgs can be created ' ; 
ok ( ref $objRdrCmdArgs eq 'Qto::App::IO::In::RdrCmdArgs' , $msg ) ; 

$objRdrCmdArgs->doRead() ; 
# those will fail if you do not use the run-perl-unit-tests.func.sh wrapper
# as the cmd args are passed from there - fin: run-perl-unit-tests.func.sh
$msg = 'test-02 - ensure the actions are passed to the model' ; 
ok ( $objModel->get('ctrl.actions') eq 'run' , $msg ) ; 

my $ProductInstanceDir = $appConfig->{'ProductInstanceDir' } ; 
my $cmd = "$ProductInstanceDir/src/perl/qto/script/qto.pl" ; 

$ARGV[0] = '' ; 
$ARGV[1] = '' ; 
$msg = 'test-03 - the whole script should fail because the --do <<action>> is not defined ' ; 
my $cmd_out = `$cmd 2>&1 1>/dev/null` ; 
ok ( $?  != 0  , $msg  ) ; 

# FILE-UUID 7bf7ee86-58f3-417a-8413-929131912912
