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
my $jwt_private_key_file   = $ENV{'HOME'} . '/.ssh/qto.' . "$env_type" . '.jwtRS256.key';
my $jwt_public_key_file    = $ENV{'HOME'} . '/.ssh/qto.' . "$env_type" . '.jwtRS256.key.pub';
#p $config ; 
$objGuardian      = 'Qto::App::Sec::Guardian'->new ( \$config ) ;

$tn = 'test-01' ; 
$tm = $tn . " the guardian can issue a RS256 PRIVATE key signed token"; 
my $hsr = {} ; 
$hsr->{'user_name'}  = 'user_name' ;
$hsr->{'user_id'}    = '1' ;
$hsr->{'email'}      = 'test.user@gmail.com' ;
my ( $rv, $msg , $jwt ) = $objGuardian->doGrantAccessToken($hsr);
p $jwt ; 
ok (defined($jwt) , $tm);
ok (length($jwt) > 0, $tm);

$tn = 'test-02' ; 
$tm = $tn . " the token can be verfied back with the PUBLIC key";
my $pub_secret          = $objGuardian->doGetPublicKeySecret();
( $rv, $msg, my $claims_from_token ) = $objGuardian->hasValidTokenAndClaims($jwt,$pub_secret);
ok ( $rv == 0 ,$tm);
ok ( $msg eq '' ,$tm);

$tn = 'test-03' ; 
$tm = $tn . " the claims before the token grant are the same as those got from the token";
ok ( $claims_from_token->{'sub'} eq $hsr->{'user_id'} ,$tm);
ok ( $claims_from_token->{'email'} eq $hsr->{'email'} ,$tm);
ok ( $claims_from_token->{'name'} eq $hsr->{'user_name'} ,$tm);

$tn = 'test-03' ; 
$tm = $tn . " ";

















done_testing(); 

1; 
