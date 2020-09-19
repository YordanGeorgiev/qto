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
   my $db= $config->{'env'}->{'db'}->{ 'postgres_app_db' } ; 
   my $url = '/' . $db . '/call-func/get_all_app_user_roles';

   $tm = "call the func";
   ok ( $t->get_ok($url)->status_is(200) , $tm ) ;
  
   my $ua  = $t->ua ; 
   $tm = 'an array of values is returned with valid CallFunc which sure will have hits ... ' ; 
   my $response = $ua->get($url)->result->json ; 
   my $list = $response->{ 'dat' } ; 
   ok (ref($list) eq 'ARRAY' , $tm) ; 
   
   $tm = 'more than 5 items are returned in the data';
   $response = $ua->get($url)->result->json ; 
   $list = $response->{ 'dat' } ; 
   ok (scalar(@$list) > 2 , $tm) ; 
   
   $tm = 'more than 3 items are returned in the meta data';
   $response = $ua->get($url)->result->json ; 
   my $hsr2 = $response->{ 'met' }->{'meta_cols'};
   ok (scalar(keys %$hsr2) > 3 , $tm) ; 
   
   $tm = 'a hash ref  is returned for the meta data with valid CallFunc which sure will have hits ... ' ; 
   $response = $ua->get($url)->result->json ; 
   my $mshr2 = $response->{ 'met' } ; 
   ok (ref($mshr2) eq 'HASH' , $tm) ; 
   
   $tm = 'a wrong type of pg-size url param is specified' ;
   $url = '/' . $db . '/call-func/get_all_users_app_roles?pg-size=a';
   ok ( $t->get_ok($url)->status_is(400) , $tm ) ;
   
   $tm = 'a wrong type of pg-num url param is specified' ;
   $url = '/' . $db . '/call-func/get_all_users_app_roles?pg-num=a';
   ok ( $t->get_ok($url)->status_is(400) , $tm ) ;
   
   $tm = 'a non-existent function is called' ;
   $url = '/' . $db . '/call-func/non_existent?pg-num=a';
   ok ( $t->get_ok($url)->status_is(400) , $tm ) ;

done_testing();
