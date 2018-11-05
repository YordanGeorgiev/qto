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
   my $url = '/' . $db_name . '/search?for=' ; 

   $tm = "not at all for search param specified "; 
   ok ( $t->get_ok($url)->status_is(400) , $tm ) ;
  
   $tm = 'not at all for search param specified ' ; 
   $url = '/' . $db_name . '/search' ; 
   ok ( $t->get_ok($url)->status_is(400) , $tm ) ;

   $tm = 'some foo search param is specified ' ; 
   $url = '/' . $db_name . '/search?for=meta-data' ; 
   ok ( $t->get_ok($url)->status_is(200) , $tm ) ;

#   my $ua  = $t->ua ; 
#   $tm = 'an array of values is returned with valid search which sure will have hits ... ' ; 
#   my $response = $ua->get($url)->result->json ; 
#   my $list = $response->{ 'dat' } ; 
#   ok (ref($list) eq 'ARRAY' , $tm) ; 
#   
#   $tm = 'a hash ref  is returned for the meta data with valid search which sure will have hits ... ' ; 
#   $response = $ua->get($url)->result->json ; 
#   my $mshr2 = $response->{ 'met' } ; 
#   ok (ref($mshr2) eq 'HASH' , $tm) ; 

done_testing();
