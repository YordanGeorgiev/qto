use strict ; use warnings ; 
use Test::More;
use Test::Mojo;
use Data::Printer ; 
use FindBin;
use Mojo::UserAgent;

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../issue_tracker/lib" }

   my $res = {} ; 
   my $url = {} ; 
   my $tm = '' ; # the test message for each test 
   my $t = Test::Mojo->new('IssueTracker');
   my $appConfig = $t->app->get('AppConfig') ; 
   # if the product instance id tst -> tst_issue_tracker
   my $db_name= $appConfig->{ 'postgres_db_name' } ; 
   $url = '/' . $db_name . '/delete/test_delete_table' ; 

   my $ua  = $t->ua ; 
   # the delete by attribute requires the following json format : 
   # the name of the attribute
   # the id which is BY DESIGN a requirement for ANY issue-tracker app table to work ... 
   # the content should be json format as follows
   $t->post_ok($url => json => {"attribute"=>"name", "id" =>"1", "cnt"=>"name-1-deleted"})->status_is(200);

   $res = $ua->get('/' . $db_name . '/select/test_delete_table?with=id-eq-1' )->result->json ; 
   $tm = 'the name-1 was deleted' ; 
   #debug p $res ; 
   # debug p $res->{'dat'} ; 
   
   no warnings 'uninitialized' ; 
   ok ( @{$res->{'dat'}} == () , $tm ) ; 
   use warnings 'uninitialized' ; 
   
   $tm = 'the ret var from the response should be the same as the http code => 200'; 
   ok ( $res->{'ret'} eq 200 , $tm ) ; 
  

   $t->post_ok($url => json => {"attribute"=>"name", "id" =>"3", "cnt"=>"name-3-deleted"})->status_is(200);
   $res = $ua->get('/' . $db_name . '/select/test_delete_table?with=id-eq-3' )->result->json ; 
   $tm = 'the name-3 was deleted' ; 
   #debug p $res ; 
   #debug p $res->{'dat'} ; 
   
   no warnings 'uninitialized' ; 
   ok ( @{$res->{'dat'}} == () , $tm ) ; 
   use warnings 'uninitialized' ; 
   
   $tm = 'the ret var from the response should be the same as the http code => 200'; 
   ok ( $res->{'ret'} eq 200 , $tm ) ; 
   
   $res = $ua->get('/' . $db_name . '/select/test_delete_table?with=id-eq-2' )->result->json ; 
   
   $tm = 'the name-2 should NOT be deleted' ; 
   ok ( $res->{'dat'}[0]->{'name'} eq 'name-2' , $tm ) ; 
   
   $tm = 'the ret var from the response should be the same as the http code => 200'; 
   ok ( $res->{'ret'} eq 200 , $tm ) ; 
   # debug p $res ; 


   my $exp_err_msg = '' ; 
   $exp_err_msg = 'cannot connect to the "non_existent_db" database: FATAL:  database "non_existent_db" does not exist' ; 
   $url = '/non_existent_db/delete/test_delete_table' ; 
   $t->post_ok($url => json => {"attribute"=>"name", "id" =>"1", "cnt"=>"name-1-deleted"})
      ->json_is({"ret" => 400 , "req" => 'POST http://' . $t->tx->local_address . ':' . $t->tx->remote_port . '/non_existent_db/delete/test_delete_table' , "msg" => "$exp_err_msg"});
   #p $t->tx ; 

  
   $exp_err_msg = " the table non_existent_table does not exist in the $db_name database " ; 
   $url = '/' . $db_name . '/delete/non_existent_table' ; 
   $t->post_ok($url => json => {"attribute"=>"name", "id" =>"1", "cnt"=>"name-1-deleted"})
      ->json_is({"ret" => 400 , "req" => 'POST http://' . $t->tx->local_address . ':' . $t->tx->remote_port . $url , 
                 "msg" => "$exp_err_msg"});

   $url = '/' . $db_name . '/delete/test_delete_table' ; 
#
#   
$exp_err_msg = 
'ERROR:  invalid input syntax for integer: "a"
LINE 2:       DELETE FROM test_delete_table WHERE id = \'a\'
                                                       ^' ; 
   $t->post_ok($url => json => {"attribute"=>"seq", "id" =>"a", "cnt"=>"should be integer but string passed"})
      ->json_is({"ret" => 400 , "req" => 'POST http://' . $t->tx->local_address . ':' . $t->tx->remote_port . $url , 
                 "msg" => "$exp_err_msg"});

done_testing();

# feature-guid: 
