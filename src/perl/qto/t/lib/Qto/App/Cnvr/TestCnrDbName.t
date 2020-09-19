use strict ; use warnings ; 
use Test::Most ; 
use Test::Mojo;
use Data::Printer ; 
use FindBin;

BEGIN { 
   use FindBin ; 
   unshift @INC, "$FindBin::Bin/../../../../../lib";
   unshift @INC, "$FindBin::Bin/../../../../../t/lib"; 
}

use Qto::App::Cnvr::CnrDbName qw(toPlainName toEnvName);

   die_on_fail; $ENV{'QTO_NO_AUTH'} = 1 ;

   my $tm      = '' ; # the test message for each test 
   my $t       = Test::Mojo->new('Qto');
   my $config  = $t->app->config ; 
   my $db      = $config->{'env'}->{'db'}->{ 'postgres_app_db' } ; 

   $tm         = "the $db db is not change while changed to env name";
   $db         = toEnvName ( $db , $config) ;
ok ( $db eq $db , $tm);
   
   $db         = '[_ss' ;
   $tm         = "no special regex chars are allowed in the $db";
   $db         = toEnvName ( $db , $config) ;
   ok ( $db eq $db , $tm);
done_testing();
