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
my $db                     = $config->{'env'}->{'db'}->{ 'postgres_app_db' } ; 
my $ENV               = $config->{'env'}->{'run'}->{'ENV'} ; 
my $jwt_private_key_file   = $ENV{'HOME'} . '/.ssh/qto.' . "$ENV" . '.jwtRS256.key';
my $jwt_public_key_file    = $ENV{'HOME'} . '/.ssh/qto.' . "$ENV" . '.jwtRS256.key.pub';
$objGuardian      = 'Qto::App::Sec::Guardian'->new ( \$config ) ;

$tn = 'test-01' ; 
$tm = $tn . " the guardian can issue a RS256 PRIVATE key signed token"; 
my $hsr = {} ;
my @app_roles = ('anonymous');
$hsr->{1}->{'user_name'}  = 'user_name' ;
$hsr->{1}->{'user_id'}    = '1' ;
$hsr->{1}->{'email'}      = 'test.user@gmail.com' ;
$hsr->{1}->{'app_roles'}      = \@app_roles ; 

my ( $rv, $msg , $jwt ) = $objGuardian->doGrantAccessToken($db,$hsr);
p $jwt ; 
ok (defined($jwt) , $tm);
ok (length($jwt) > 0, $tm);

$tn = 'test-02' ; 
$tm = $tn . " the token can be verfied back with the PUBLIC key";
my $pub_secret          = $objGuardian->doGetPublicKeySecret();
$msg = '' ; 
( $rv, my $claims_from_token ) = $objGuardian->hasValidTokenAndClaims(\$msg,$jwt,$pub_secret);
ok ( $rv == 1 ,$tm);
ok ( $msg eq '' ,$tm);

$tn = 'test-03' ; 
$tm = $tn . " the claims before the token grant are the same as those got from the token";
ok ( $claims_from_token->{'sub'} eq $hsr->{1}->{'user_id'} ,$tm);
ok ( $claims_from_token->{'email'} eq $hsr->{1}->{'email'} ,$tm);
ok ( $claims_from_token->{'name'} eq $hsr->{1}->{'user_name'} ,$tm);

$tn = 'test-03' ; 
$tm = $tn . " ";

















done_testing(); 

1; 
