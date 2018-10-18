use strict ; use warnings ; 
use Test::More;
use Test::Most ; 
use Test::Mojo;
use Data::Printer ; 
use FindBin;
use Mojo::UserAgent;

die_on_fail ; 

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../issue_tracker/lib" }

   my $res = {} ; 
   my $url = {} ; 
   my $tm = '' ; # the test message for each test 
   my $t = Test::Mojo->new('IssueTracker');
   my $appConfig = $t->app->get('AppConfig') ; 
   # if the product instance id tst -> tst_issue_tracker
   my $db_name= $appConfig->{ 'postgres_db_name' } ; 
   $url = '/' . $db_name . '/create/test_create_table' ; 

   my $ua  = $t->ua ; 
   my $objTimer = {} ;
   # the create back-end web action requires the following json format : 
   # the id which is BY DESIGN a requirement for ANY issue-tracker app table to work ... 
   # the content should be json format as follows

   $objTimer               = 'IssueTracker::App::Utils::Timer'->new( 'YYYYmmDDhhMMss' );
   my $id = $objTimer->GetHumanReadableTime();
   $t->post_ok($url => json => {"id" =>$id})->status_is(200);

   $res = $ua->get('/' . $db_name . '/select/test_create_table?with=id-eq-' . $id )->result->json ; 
   $tm = 'the a new row has been created with the new id: ' . $id . " with the default name " ; 
   ok ( $res->{'dat'}[0]->{'name'} eq 'type the name ...' , $tm ) ; 
   $tm = 'the a new row has been created with the new id: ' . $id . " with the default description " ; 
   ok ( $res->{'dat'}[0]->{'description'} eq 'type the description ...' , $tm ) ; 

   $tm = 'the ret var from the response should be the same as the http code => 200'; 
   ok ( $res->{'ret'} eq 200 , $tm ) ; 
#  
#
   my $exp_err_msg = '' ; 
   $exp_err_msg = 'cannot connect to the "non_existent_db" database: FATAL:  database "non_existent_db" does not exist' ; 
   $url = '/non_existent_db/create/test_create_table' ; 
   $t->post_ok($url => json => {"id"=> $id })
      ->json_is({"ret" => 400 , "req" => 'POST http://' . $t->tx->local_address . ':' . $t->tx->remote_port . '/non_existent_db/create/test_create_table' , "msg" => "$exp_err_msg"});
   # p $t->tx ; 

  
   $exp_err_msg = " the table non_existent_table does not exist in the $db_name database " ; 
   $url = '/' . $db_name . '/create/non_existent_table' ; 
   $t->post_ok($url => json => {"id"=> $id+1 })
      ->json_is({"ret" => 400 , "req" => 'POST http://' . $t->tx->local_address . ':' . $t->tx->remote_port . $url , 
                 "msg" => "$exp_err_msg"});


done_testing();

# feature-guid: 
