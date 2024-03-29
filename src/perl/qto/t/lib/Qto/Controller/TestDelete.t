use strict ; use warnings ; 

use Test::Most ; 
use Test::Mojo;
use Data::Printer ; 
use FindBin;
use Mojo::UserAgent;

die_on_fail ; 

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../qto/lib" }
   $ENV{'QTO_NO_AUTH'} = 1;

   my $res           = {} ; # the result set for a call
   my $url           = {} ; 
   my $tm            = '' ; # the test message for each test 
   my $t             = Test::Mojo->new('Qto');
   my $config        = $t->app->config ; 
   my $exp_err_msg   = '' ; 
   my $db            = $config->{'env'}->{'db'}->{ 'postgres_app_db' } ; # OBS instance specific !!!
   my $env           = $config->{'env'}->{'ENV' };
   my $ua            = $t->ua ; 
   my $objTimer      = {} ;
   
   $tm = 'the table is truncated' ; 
   $url = '/' . $db . '/truncate/test_delete_table' ; 
   ok ( $t->get_ok($url )->status_is(200) , $tm ) ;

   #insert into test_delete_table ( id,name,description) values (1,'name-1','the name should be deleted to deleted-name-1'); 
   #insert into test_delete_table ( id,name,description) values (2,'name-2','the name attr should NOT be deleted'); 
   #insert into test_delete_table ( id,name,description) values (3,'name-3','the name attr should be deleted to deleted-name-3'); 
   
   $tm = 'can add the new 3 ids to the test_delete_table' ; 
   $url = '/' . $db . '/create/test_delete_table' ; 
   ok ( $t->delete_ok($url => json => {"id" =>"1"})->status_is(200) , $tm );
   ok ( $t->delete_ok($url => json => {"id" =>"2"})->status_is(200) , $tm );
   ok ( $t->delete_ok($url => json => {"id" =>"3"})->status_is(200) , $tm );

   $url  = '/' . $db . '/delete/test_delete_table' ; 

   # the delete by attribute requires the following json format : 
   # the name of the attribute
   # the id which is BY DESIGN a requirement for ANY qto app table to work ... 
   # the content should be json format as follows
   $tm = 'can delete the item to delete ' ; 
   ok ( $t->delete_ok($url => json => {"id" =>"1"})->status_is(200) , $tm );

   $url = '/' . $db . '/select/test_delete_table?with=id-eq-1' ; 
   $tm = 'the name-1 was deleted , no data could be retrieved for the id with value 1' ; 
   ok ( $t->get_ok($url )->status_is(200) , $tm ) ;
   $res = $ua->get($url)->result->json ; 
   $tm = 'the name-1 was deleted , no data could be retrieved for the id with value 1, res is 204' ; 
   ok ( $res->{'ret'} == 204, $tm);
   
  
   $tm = 'no data could be fetched with this id' ; 
   $url = '/' . $db . '/delete/test_delete_table' ; 
   $t->delete_ok($url => json => {"attribute"=>"name", "id" =>"3", "cnt"=>"name-3-deleted"})->status_is(200);
   $url = '/' . $db . '/select/test_delete_table?with=id-eq-3' ; 
   ok ( $t->get_ok($url )->status_is(200) , $tm ) ;
   $res = $ua->get($url)->result->json ; 
   ok ( $res->{'ret'} == 204, $tm . "and res is 204");
   
   # the create back-end web action requires the following json format : 
   # the id which is BY DESIGN a requirement for ANY qto app table to work ... 
   # the content should be json format as follows

   $objTimer               = 'Qto::App::Utils::Timer'->new( 'YYYYmmDDhhMMss' );
   my $id                  = $objTimer->GetHumanReadableTime();
   $url = '/' . $db . '/create/test_delete_table' ; 
   ok ($t->post_ok($url => json => {"id" =>$id})->status_is(200), $tm);

   $tm = 'the default name should NOT be deleted' ; 
   $url = '/' . $db . '/select/test_delete_table?with=id-eq-' . $id ; 
   $res = $ua->get($url)->result->json ; 
   ok ( $res->{'dat'}[0]->{'name'} eq 'name ...' , $tm ) ; 
   
   $tm = 'the ret var from the response should be the same as the http code => 200'; 
   ok ( $res->{'ret'} eq 200 , $tm ) ; 

   $tm = 'present the correct msg when non_existent_db is provided' ; 
   $exp_err_msg = 'FATAL:  database "' . $env . '_non_existent_db" does not exist' ; 
   $url = '/non_existent_db/delete/test_delete_table' ; 
   ok ( $t->delete_ok($url => json => {"attribute"=>"name", "id" =>"1", "cnt"=>"name-1-deleted"})
      ->json_is({"ret" => 400 , "req" => 'POST http://' . $t->tx->local_address . ':' . $t->tx->remote_port . '/non_existent_db/delete/test_delete_table' , "msg" => "$exp_err_msg"}),$tm);
   #p $t->tx ; 

   $tm = 'the correct error is returned for a non_existent_table' ; 
   $exp_err_msg = " the table non_existent_table does not exist in the $db database " ; 
   $url = '/' . $db . '/delete/non_existent_table' ; 
   ok($t->delete_ok($url => json => {"attribute"=>"name", "id" =>"1", "cnt"=>"name-1-deleted"})
      ->json_is({"ret" => 400 , "req" => 'POST http://' . $t->tx->local_address . ':' . $t->tx->remote_port . $url , 
                 "msg" => "$exp_err_msg"}),$tm);

   $tm = 'if a string is provided for an id an error should be returned with the proper error code' ;    
   $url = '/' . $db . '/delete/test_delete_table' ; 
   $exp_err_msg = 'the id must be a whole positive number, but a_string was provided !' ; 
   ok ($t->delete_ok($url => json => {"attribute"=>"seq", "id" =>"a_string", "cnt"=>"should be integer but string passed"})
      ->json_is({"ret" => 400 , "req" => 'POST http://' . $t->tx->local_address . ':' . $t->tx->remote_port . $url , 
                 "msg" => "$exp_err_msg"}),$tm );

   $tm = 'if a non-positive integer is provided for an id an error should be returned with the proper error code' ;    
   $exp_err_msg = 'the id must be a whole positive number, but -1 was provided !' ; 
   ok ($t->delete_ok($url => json => {"attribute"=>"seq", "id" =>"-1", "cnt"=>"should be integer but string passed"})
      ->json_is({"ret" => 400 , "req" => 'POST http://' . $t->tx->local_address . ':' . $t->tx->remote_port . $url , 
                 "msg" => "$exp_err_msg"}),$tm );


done_testing();
#
## feature-guid: 
