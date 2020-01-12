use strict ; use warnings ; 

use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../../../../../lib" }

use Qto::App::Sec::Guardian; 
use Data::Printer ; 
use Test::More ; 
use Test::Mojo ; 
use Carp ; 
use File::Copy qw /move/;


my $ret                    = undef ; # the return value of the call
my $tm                     = undef ; # the test message
my $tn                     = undef ; # the test number
my $objGuardian            = {} ;
my $t                      = Test::Mojo->new('Qto');
my $config                 = $t->app->config ; 
my $env_type               = $config->{'env'}->{'run'}->{'ENV_TYPE'} ; 
my $private_key_fpath      = $ENV{"HOME"} . '/.ssh/id_rsa.qto.' . $env_type ; 
my $public_key_fpath       = $ENV{"HOME"} . '/.ssh/id_rsa.qto.' . $env_type . '.pub'; 
#p $config ; 

$tn = 'test-01' ; 
$tm = "$tn ::: " . 'the Guardian return error if private key file does not exist';
$objGuardian      = 'Qto::App::Sec::Guardian'->new ( \$config ) ;
move ( $private_key_fpath, "$private_key_fpath.tmp") if -f $private_key_fpath ;
( $ret , $tm , my $prv_secret ) = $objGuardian->getPrivateKeySecret() ; 
move ( "$private_key_fpath.tmp", $private_key_fpath) if -f "$private_key_fpath.tmp";
ok ( $ret == 1 , $tm ) ; 


$tn = 'test-02' ; 
move ( $public_key_fpath, "$public_key_fpath.tmp") if -f $public_key_fpath ;
( $ret , $tm , my $pub_secret ) = $objGuardian->getPublicKeySecret() ;
move ( "$public_key_fpath.tmp", $public_key_fpath) if -f "$public_key_fpath.tmp";
ok ( $ret == 1 , $tm ) ; 



done_testing(); 

1; 
