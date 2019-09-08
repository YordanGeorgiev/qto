use strict ; use warnings ; 

use FindBin; BEGIN { unshift @INC, "$FindBin::Bin/../../../../../lib" }
use Getopt::Long;
use Test::More ; 
use Data::Printer ; 
use Test::Mojo ; 
use JSON::Parse 'json_file_to_perl';

use Qto::App::Utils::Initiator ; 
use Qto::App::IO::In::RdrCmdArgs ; 

use Carp ; 
my $m                      = 'the tst msg' ; 
my $msg                    = q{} ; 
my $objInitiator 		      = 'Qto::App::Utils::Initiator'->new();	
my $config                 = $objInitiator->get('AppConfig');
$config                    = json_file_to_perl ($objInitiator->doResolveConfFile());
$config->{'env'}->{'run'}->{'ProductInstanceDir'} = $objInitiator->doResolveProductInstanceDir(-1);
$config->{'env'}->{'run'}->{'ProductName'} = $objInitiator->doResolveProductName();
$config->{'env'}->{'run'}->{'VERSION'} = $objInitiator->doResolveVersion();
$config->{'env'}->{'run'}->{'ENV_TYPE'} = $objInitiator->doResolveEnvType();
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

my $ProductInstanceDir = $config->{'env'}->{'run'}->{'ProductInstanceDir' } ; 
my $cmd = "$ProductInstanceDir/src/perl/qto/script/qto.pl" ; 

$ARGV[0] = '' ; 
$ARGV[1] = '' ; 
$msg = 'test-03 - the whole script should fail because the --do <<action>> is not defined ' ; 
my $cmd_out = `$cmd 2>&1 1>/dev/null` ; 
ok ( $?  != 0  , $msg  ) ; 


done_testing();

1;
# FILE-UUID 7bf7ee86-58f3-417a-8413-929131912912
