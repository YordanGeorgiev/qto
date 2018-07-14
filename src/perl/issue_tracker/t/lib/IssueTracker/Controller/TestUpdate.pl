use strict ; use warnings ; 
use Test::More;
use Test::Mojo;
use Data::Printer ; 
use FindBin;
use Mojo::UserAgent;

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../issue_tracker/lib" }

   my $res = {} ; 
   my $tm = '' ; # the test message for each test 
   my $t = Test::Mojo->new('IssueTracker');
   my $appConfig = $t->app->get('AppConfig') ; 
   # if the product instance id tst -> tst_issue_tracker
   my $db_name= $appConfig->{ 'postgres_db_name' } ; 
   my $url = '/' . $db_name . '/update/test_update_table' ; 

   my $ua  = $t->ua ; 
   # the update by attribute requires the following json format : 
   # the name of the attribute
   # the id which is BY DESIGN a requirement for ANY issue-tracker app table to work ... 
   # the content
   $t->post_ok($url => json => {"attribute"=>"name", "id" =>"1", "cnt"=>"name-1-updated"})->status_is(200);

   $res = $ua->get('/' . $db_name . '/select/test_update_table?with=id-eq-1' )->result->json ; 
   $tm = 'the name-1 was updated' ; 
   ok ( $res->{'dat'}[0]->{'name'} eq 'name-1-updated' , $tm ) ; 
   
   $tm = 'the ret var from the response should be the same as the http code => 200'; 
   ok ( $res->{'ret'} eq 200 , $tm ) ; 
  

   $t->post_ok($url => json => {"attribute"=>"name", "id" =>"3", "cnt"=>"name-3-updated"})->status_is(200);
   $res = $ua->get('/' . $db_name . '/select/test_update_table?with=id-eq-3' )->result->json ; 
   
   $tm = 'the name-3 was updated' ; 
   ok ( $res->{'dat'}[0]->{'name'} eq 'name-3-updated' , $tm ) ; 
   
   $tm = 'the ret var from the response should be the same as the http code => 200'; 
   ok ( $res->{'ret'} eq 200 , $tm ) ; 
   
   $res = $ua->get('/' . $db_name . '/select/test_update_table?with=id-eq-2' )->result->json ; 
   
   $tm = 'the name-2 should NOT be updated' ; 
   ok ( $res->{'dat'}[0]->{'name'} eq 'name-2' , $tm ) ; 
   
   $tm = 'the ret var from the response should be the same as the http code => 200'; 
   ok ( $res->{'ret'} eq 200 , $tm ) ; 
   # debug p $res ; 

done_testing();

# feature-guid: 
