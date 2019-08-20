use strict ; use warnings ; 

use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../../../../../lib" }
use Test::More ; 

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

my $msg                    = q{} ; 
my $objInitiator 				= 'Qto::App::Utils::Initiator'->new();	
my $config              = $objInitiator->get('AppConfig');
my $ConfFile               = $objInitiator->{'ConfFile'} ; 
my $objConfigurator        = 'Qto::App::Utils::Configurator'->new($ConfFile , \$config);
$config                 = $objConfigurator->getConfHolder()  ;
my $objLogger					= 'Qto::App::Utils::Logger'->new(\$config);
my $objModel               = 'Qto::App::Mdl::Model'->new ( \$config ) ; 
my $objRdrCmdArgs 			= 'Qto::App::IO::In::RdrCmdArgs'->new(\$config , \$objModel ) ; 


$ARGV[0] = '--do' unless $ARGV[0]  ; 
$ARGV[1] = 'run' unless $ARGV[1]  ; 
$msg = 'test-01 - ensure the objRdrCmdArgs can be created ' ; 
ok ( ref $objRdrCmdArgs eq 'Qto::App::IO::In::RdrCmdArgs' , $msg ) ; 

$objRdrCmdArgs->doRead() ; 
# those will fail if you do not use the run-functional-tests.func.sh wrapper
# as the cmd args are passed from there - fin: run-functional-tests.func.sh
$msg = 'test-02 - ensure the actions are passed to the model' ; 
ok ( $objModel->get('ctrl.actions') eq 'run' , $msg ) ; 

my $ProductInstanceDir = $config->{'ProductInstanceDir' } ; 
my $cmd = "$ProductInstanceDir/src/perl/qto/script/qto.pl" ; 

$ARGV[0] = '' ; 
$ARGV[1] = '' ; 
$msg = 'test-03 - the whole script should fail because the --do <<action>> is not defined ' ; 
my $cmd_out = `$cmd 2>&1 1>/dev/null` ; 
ok ( $?  != 0  , $msg  ) ; 


done_testing();

1;
# FILE-UUID 7bf7ee86-58f3-417a-8413-929131912912
