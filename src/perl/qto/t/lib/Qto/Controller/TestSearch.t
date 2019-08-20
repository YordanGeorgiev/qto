use strict ; use warnings ; 

use FindBin;
use Data::Printer ; 
use Test::Most ; 
use Test::Mojo;

die_on_fail;

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../qto/lib" }

   my $tm = '' ; # the test message for each test 
   my $t = Test::Mojo->new('Qto');
   my $config = $t->app->get('AppConfig') ; 
   my $db_name= $config->{ 'postgres_db_name' } ; 
   my $url = '/' . $db_name . '/search?for=' ; 

   $tm = "not at all for search param specified, presents blank search" ; 
   ok ( $t->get_ok($url)->status_is(200) , $tm ) ;
  
   $tm = 'not at all for search param specified - a blank search page is presented' ; 
   $url = '/' . $db_name . '/search' ; 
   ok ( $t->get_ok($url)->status_is(200) , $tm ) ;

   $tm = 'some foo search param is specified ' ; 
   $url = '/' . $db_name . '/search?for=meta-data' ; 
   ok ( $t->get_ok($url)->status_is(200) , $tm ) ;

done_testing();
