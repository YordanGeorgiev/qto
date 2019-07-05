use strict ; use warnings ; 

use FindBin;
use Data::Printer ; 
use Test::Most ; 
use Test::Mojo;

die_on_fail;

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../qto/lib" }

   my $tm = '' ; # the test message for each test 
   my $t = Test::Mojo->new('Qto');
   my $appConfig = $t->app->get('AppConfig') ; 
   my $db_name= $appConfig->{ 'postgres_db_name' } ; 
   my $url = '/' . $db_name . '/logon' ; 

   $tm = "ok for post user"; 
   ok ( $t->post_ok($url => json => {"user" =>'user'})->status_is(200) , $tm );

done_testing();
