use strict ; use warnings ; 

use FindBin;
use Data::Printer ; 
use Test::Most ; 
use Test::Mojo;

die_on_fail;

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../issue_tracker/lib" }

   my $tm = '' ; # the test message for each test 
   my $t = Test::Mojo->new('IssueTracker');
   my $appConfig = $t->app->get('AppConfig') ; 
   my $db_name= $appConfig->{ 'postgres_db_name' } ; 
   my $url = '/' . $db_name . '/query?for=' ; 

   print "testing the following url: $url \n" ; 
   $t->get_ok($url)
      ->status_is(400) 
   ;

   my $ua  = $t->ua ; 
   #my $response = $ua->get('/' . $db_name . '/select-tables')->result->json ; 
   #my $list = $response->{ 'dat' } ; 

done_testing();

