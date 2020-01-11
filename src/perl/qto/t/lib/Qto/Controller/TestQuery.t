use strict ; use warnings ; 

use FindBin;
use Data::Printer ; 
use Test::Most ; 
use Test::Mojo;

die_on_fail;

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../qto/lib" }
   $ENV{'QTO_NO_AUTH'} = 1;

   my $tm = '' ; # the test message for each test 
   my $t = Test::Mojo->new('Qto');
   my $config = $t->app->config ; 
   my $db= $config->{'env'}->{'db'}->{ 'postgres_db_name' } ; 
   my $url = '/' . $db . '/query?for=' ; 

   $tm = "not at all for query param specified "; 
   ok ( $t->get_ok($url)->status_is(200) , $tm ) ;
  
   $tm = 'not at all for query param specified ' ; 
   $url = '/' . $db . '/query' ; 
   ok ( $t->get_ok($url)->status_is(200) , $tm ) ;

   $tm = 'some foo query param is specified ' ; 
   $url = '/' . $db . '/query?for=meta-data' ; 
   ok ( $t->get_ok($url)->status_is(200) , $tm ) ;

   my $ua  = $t->ua ; 
   $tm = 'an array of values is returned with valid query which sure will have hits ... ' ; 
   my $response = $ua->get($url)->result->json ; 
   my $list = $response->{ 'dat' } ; 
   ok (ref($list) eq 'ARRAY' , $tm) ; 
   
   $tm = 'a hash ref  is returned for the meta data with valid query which sure will have hits ... ' ; 
   $response = $ua->get($url)->result->json ; 
   my $mshr2 = $response->{ 'met' } ; 
   ok (ref($mshr2) eq 'HASH' , $tm) ; 
   
   $tm = 'some foo query param is specified ' ; 
   $url = '/' . $db . '/query?for=чичковитечервенотиквеничета' ; 
   ok ( $t->get_ok($url)->status_is(204) , $tm ) ;

done_testing();
