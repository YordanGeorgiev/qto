use strict ; use warnings ; 

use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../lib" }
use Test::More tests => 3 ; 
use Data::Printer ; 
use Carp ; 

use Qto::App::Utils::Initiator ; 
use Qto::App::Utils::Logger ; 
use Qto::App::Utils::Configurator ; 
use Qto::App::Ctrl::Dispatcher ; 
use Qto::App::Utils::Timer ; 

my $m = 'the qto calling shell needs always a set of pre-defined env vars,
thus you need to define your issue tracker project by :
doParseCnfEnvVars <<path-to-your-qto-projects-cnf-files>>/<<qto-cnf-file>>
for example:
doParseCnfEnvVars /vagrant/var/csitea/cnf/projects/qto/ysg-issues.dev.host-name.cnf'  ; 
croak $m unless ( defined ( $ENV{ "qto_project" } )) ; 
$ENV{ 'load_model' } = 'upsert' ; 

my $tn                     = '' ; # the test number 
my $cmd                    = '' ; # the cmd to run 
my $cmd_out                = '' ; # the output of the cmd command

my $objInitiator 				= 'Qto::App::Utils::Initiator'->new();	
my $config              = $objInitiator->get('AppConfig');
my $objConfigurator        = 'Qto::App::Utils::Configurator'->new(
                                 $objInitiator->{'ConfFile'}, \$config);
$config                 = $objConfigurator->getConfHolder()  ;
my $ProductInstanceDir     = $config->{'ProductInstanceDir' } ; 
my $DataDir                = $ENV{'DataDir'} ; 

print "using the following DataDir in test : $DataDir \n" ; 

$ENV{'do_truncate_tables'} = 1 ; 
$ENV{'load_model'} = 'upsert' ; 
$ENV{'rdbms_type'} = 'postgres' ; 

$tn      = 'test-01' ; 
$m       = "$tn:
   test the xls-to-db action - the script should exit with 0" ; 
$cmd = "$ProductInstanceDir/src/perl/qto/script/qto.pl --do xls-to-db --tables daily_issues" ; 

print "running :\n $cmd \n" ; # and Action !!!
# $cmd_out = `$cmd 2>&1 1>/dev/null` ; 
$cmd_out = `$cmd` ; 
ok ( $?  == 0  , $m ); 
# dat/mix/2018/2018-08/2018-08-23/json/daily_issues.json
my $mix_data_dir    = $ENV{'mix_data_dir' } ;  ;
my $objTimer         = 'Qto::App::Utils::Timer'->new( $config->{'TimeFormat' } );
my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = $objTimer->GetTimeUnits();
# /vagrant/opt/nokia/musa/dat/mix/issues/2018/2018-06/2018-06-11
my $out_dir = "$mix_data_dir/$year/$year-$mon/$year-$mon-$mday/json" ;
my $exp_file               = "$out_dir/daily_issues.json" ; 
unlink $exp_file if ( -f $exp_file ) ; 

$cmd = 
   "$ProductInstanceDir/src/perl/qto/script/qto.pl --do db-to-json --tables daily_issues" ; 
$tn      = 'test-02' ; 
$m       = "$tn:
   test the db-to-json action - the script should exit with 0" ; 

print "running :\n $cmd \n" ; # and Action !!!
$cmd_out = `$cmd 2>&1 1>/dev/null` ; 
# debug $cmd_out = `$cmd`; 
ok ( $?  == 0  , $m ); 

$tn      = 'test-03' ; 
$m       = "$tn:
   for the create of json file: $exp_file " ; 
ok ( -f $exp_file  , $m ) ; 


# FILE-UUID c8782cdd-371f-4c65-b07e-60ee9d38fad1
# eof file: src/perl/qto/t/TestQto.pl
