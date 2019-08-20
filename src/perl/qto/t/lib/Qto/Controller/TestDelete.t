use strict ; use warnings ; 

use Test::Most ; 
use Test::Mojo;
use Data::Printer ; 
use FindBin;
use Mojo::UserAgent;

die_on_fail ; 

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../qto/lib" }

   my $res           = {} ; # the result set for a call
   my $url           = {} ; 
   my $tm            = '' ; # the test message for each test 
   my $t             = Test::Mojo->new('Qto');
   my $config     = $t->app->get('AppConfig') ; 
   my $exp_err_msg   = '' ; 
   my $db            = $config->{ 'postgres_db_name' } ; # OBS instance specific !!!
   my $ua            = $t->ua ; 
   my $objTimer      = {} ;
   $url              = '/' . $db . '/delete/test_delete_table' ; 
   my $env           = $config->{'EnvType' };

   # the delete by attribute requires the following json format : 
   # the name of the attribute
   # the id which is BY DESIGN a requirement for ANY qto app table to work ... 
   # the content should be json format as follows
   $tm = 'can create the item to delete ' ; 
   ok ( $t->post_ok($url => json => {"attribute"=>"name", "id" =>"1", "cnt"=>"name-1-deleted"})->status_is(200) , $tm );

   $url = '/' . $db . '/select/test_delete_table?with=id-eq-1' ; 
   $tm = 'the name-1 was deleted , no data could be retrieved for the id with value 1' ; 
   ok ( $t->get_ok($url )->status_is(204) , $tm ) ;
   
  
   $tm = 'no data could be fetched with this id' ; 
   $url = '/' . $db . '/delete/test_delete_table' ; 
   $t->post_ok($url => json => {"attribute"=>"name", "id" =>"3", "cnt"=>"name-3-deleted"})->status_is(200);
   $url = '/' . $db . '/select/test_delete_table?with=id-eq-3' ; 
   ok ( $t->get_ok($url )->status_is(204) , $tm ) ;
   
   # the create back-end web action requires the following json format : 
   # the id which is BY DESIGN a requirement for ANY qto app table to work ... 
   # the content should be json format as follows

   $objTimer               = 'Qto::App::Utils::Timer'->new( 'YYYYmmDDhhMMss' );
   my $id                  = $objTimer->GetHumanReadableTime();
   $url = '/' . $db . '/create/test_delete_table' ; 
   $t->post_ok($url => json => {"id" =>$id})->status_is(200);

   $tm = 'the default name should NOT be deleted' ; 
   $url = '/' . $db . '/select/test_delete_table?with=id-eq-' . $id ; 
   $res = $ua->get($url)->result->json ; 
   ok ( $res->{'dat'}[0]->{'name'} eq 'name ...' , $tm ) ; 
   
   $tm = 'the ret var from the response should be the same as the http code => 200'; 
   ok ( $res->{'ret'} eq 200 , $tm ) ; 

   $tm = 'present the correct msg when non_existent_db is provided' ; 
   $exp_err_msg = 'cannot connect to the "' . $env . '_non_existent_db" database: FATAL:  database "' . $env . '_non_existent_db" does not exist' ; 
   $url = '/non_existent_db/delete/test_delete_table' ; 
   ok ( $t->post_ok($url => json => {"attribute"=>"name", "id" =>"1", "cnt"=>"name-1-deleted"})
      ->json_is({"ret" => 400 , "req" => 'POST http://' . $t->tx->local_address . ':' . $t->tx->remote_port . '/non_existent_db/delete/test_delete_table' , "msg" => "$exp_err_msg"}),$tm);
   #p $t->tx ; 

   $tm = 'the correct error is returned for a non_existent_table' ; 
   $exp_err_msg = " the table non_existent_table does not exist in the $db database " ; 
   $url = '/' . $db . '/delete/non_existent_table' ; 
   ok($t->post_ok($url => json => {"attribute"=>"name", "id" =>"1", "cnt"=>"name-1-deleted"})
      ->json_is({"ret" => 400 , "req" => 'POST http://' . $t->tx->local_address . ':' . $t->tx->remote_port . $url , 
                 "msg" => "$exp_err_msg"}),$tm);

   $tm = 'if a string is provided for an id an error should be returned with the proper error code' ;    
   $url = '/' . $db . '/delete/test_delete_table' ; 
   $exp_err_msg = 'the id must be a whole positive number, but a_string was provided !' ; 
   ok ($t->post_ok($url => json => {"attribute"=>"seq", "id" =>"a_string", "cnt"=>"should be integer but string passed"})
      ->json_is({"ret" => 400 , "req" => 'POST http://' . $t->tx->local_address . ':' . $t->tx->remote_port . $url , 
                 "msg" => "$exp_err_msg"}),$tm );

   $tm = 'if a non-positive integer is provided for an id an error should be returned with the proper error code' ;    
   $exp_err_msg = 'the id must be a whole positive number, but -1 was provided !' ; 
   ok ($t->post_ok($url => json => {"attribute"=>"seq", "id" =>"-1", "cnt"=>"should be integer but string passed"})
      ->json_is({"ret" => 400 , "req" => 'POST http://' . $t->tx->local_address . ':' . $t->tx->remote_port . $url , 
                 "msg" => "$exp_err_msg"}),$tm );


done_testing();
#
## feature-guid: 
