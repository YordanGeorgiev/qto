use strict ; use warnings ; 

use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../../../../../lib" }
use Test::More tests => 5 ; 

use Getopt::Long;
use Data::Printer ; 
use Carp ; 
use Qto::App::Utils::Initiator ; 
use Qto::App::Utils::Logger ; 
use Qto::App::Ctrl::Dispatcher ; 
use Test::Mojo ; 

my $m          = 'the msg' ; 
my $t          = Test::Mojo->new('Qto');
$t->ua->max_redirects(10);
my $config  = $t->app->config ; 

my $tn           = '' ;     # the test number for easier reading 
my $actions      = 'db-to-xls' ; 
my $objLogger	  = 'Qto::App::Utils::Logger'->new(\$config);
my $objModel     = 'Qto::App::Mdl::Model'->new ( \$config ) ; 
my $objDispatcher= 'Qto::App::Ctrl::Dispatcher'->new(\$config , \$objModel , 1);
my $functions    = $objDispatcher->doRunActions($actions);

$tn = 'test-01' ; 
$m  = "$tn:
   ensure the db-to-xls action calls the doDbToXls func" ; 
ok ( $functions eq 'doDbToXls' , $m );

$tn = 'test-02' ; 
$m  = "$tn: 
   ensure the db-to-xls action calls the doDbToXls func" ; 
$actions         = 'xls-to-db' ; 
$functions       = $objDispatcher->doRunActions($actions);
ok ( $functions eq 'doXlsToDb' , $m );

$tn = 'test-03' ; 
$m  = "$tn:
   ensure the txt-to-db action calls the doTxtToDb func" ; 
$actions         = 'txt-to-db' ; 
$functions       = $objDispatcher->doRunActions($actions);
ok ( $functions eq 'doTxtToDb' , "$m" );

my $ProductInstanceDir = $config->{'env'}->{'run'}->{'ProductInstanceDir' } ; 
my $cmd = "$ProductInstanceDir/src/perl/qto/script/qto.pl -t daily_issues" ; 

$tn = 'test-04' ; 
$m  = "$tn:
   ensure the txt-to-db action calls the doTxtToDb func" ;
# src: http://perldoc.perl.org/perlop.html#Quote-Like-Operators
my $cmd_out = `$cmd 2>&1 1>/dev/null` ; 
# print "\$? is : $? \n" ; 
ok ( $?  != 0  , $m );

$tn = 'test-05' ; 
$m  = "$tn:
   ensure the json-to-db action calls the doJsonToDb func" ;
$actions         = 'json-to-db' ; 
$functions       = $objDispatcher->doRunActions($actions);
ok ( $functions eq 'doJsonToDb' , $m ) ;


# FILE-UUID b341825c-5e91-4b42-8359-a036284f0c2a
