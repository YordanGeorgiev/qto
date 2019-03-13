use strict ; use warnings ; 

use Test::Mojo;
use Test::Most ; 
use Data::Printer ; 
use FindBin;
use Mojo::UserAgent;

die_on_fail ; 

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../qto/lib" }

   my $res           = {} ; 
   my $url           = {} ; 
   my $tm            = '' ; # the test message for each test 
   my $exp_err_msg   = '' ; 
   my $t             = Test::Mojo->new('Qto');
   my $appConfig     = $t->app->get('AppConfig') ; 
   my $db            = $appConfig->{ 'postgres_db_name' } || 'dev_qto' ; 
   $url              = '/' . $db . '/update/test_update_table' ; 

   my $ua  = $t->ua ; 
   # the update by attribute requires the following json format : 
   # the name of the attribute
   # the id which is BY DESIGN a requirement for ANY qto app table to work ... 
   # the content should be json format as follows
   $tm = 'ok case with valid json format, id , attributed and cnt ' ; 
   ok ( $t->post_ok($url => json => {"attribute"=>"name", "id" =>"1", "cnt"=>"name-1-updated"})->status_is(200), $tm);

   $tm = 'the name-1 was updated' ; 
   $res = $ua->get('/' . $db . '/select/test_update_table?with=id-eq-1' )->result->json ; 
   ok ( $res->{'dat'}[0]->{'name'} eq 'name-1-updated' , $tm ) ; 
   
   $tm = 'the ret var from the response should be the same as the http code => 200'; 
   ok ( $res->{'ret'} eq 200 , $tm ) ; 
  
   $tm = 'the name-3 was updated' ; 
   $t->post_ok($url => json => {"attribute"=>"name", "id" =>"3", "cnt"=>"name-3-updated"})->status_is(200);
   $res = $ua->get('/' . $db . '/select/test_update_table?with=id-eq-3' )->result->json ; 
   ok ( $res->{'dat'}[0]->{'name'} eq 'name-3-updated' , $tm ) ; 
   
   $tm = 'the ret var from the response should be the same as the http code => 200'; 
   ok ( $res->{'ret'} eq 200 , $tm ) ; 
   
   $tm = 'the name-2 should NOT be updated' ; 
   $res = $ua->get('/' . $db . '/select/test_update_table?with=id-eq-2' )->result->json ; 
   ok ( $res->{'dat'}[0]->{'name'} eq 'name-2' , $tm ) ; 
   
   $tm = 'the ret var from the response should be the same as the http code => 200'; 
   ok ( $res->{'ret'} eq 200 , $tm ) ; 
   # debug p $res ; 


   $exp_err_msg = 'update failed :: cannot connect to the "non_existent_db" database: FATAL:  database "non_existent_db" does not exist' ; 
   $url = '/non_existent_db/update/test_update_table' ; 


   $tm = "the correct expected error message on non_existent_db is provided" ; 
   ok ($t->post_ok($url => json => {"attribute"=>"name", "id" =>"1", "cnt"=>"name-1-updated"})
      ->json_is({"ret" => 400 , "req" => 'POST http://' . $t->tx->local_address . ':' . $t->tx->remote_port . $url , "msg" => "$exp_err_msg"}), $tm );

  
   $tm = "the correct expected error message on non_existent_table is provided" ; 
   $exp_err_msg = "update failed ::  the table non_existent_table does not exist in the $db database " ; 
   $url = '/' . $db . '/update/non_existent_table' ; 
   ok ($t->post_ok($url => json => {"attribute"=>"name", "id" =>"1", "cnt"=>"name-1-updated"})
      ->json_is({"ret" => 400 , "req" => 'POST http://' . $t->tx->local_address . ':' . $t->tx->remote_port . $url , 
                 "msg" => "$exp_err_msg"}),$tm);

   $exp_err_msg = 'update failed ::  the table non_existent_table does not exist in the ' . $db . ' database ' ; 
   $t->post_ok($url => json => {"attribute"=>"non_existent_column", "id" =>"1", "cnt"=>"name-1-updated"})
      ->json_is({"ret" => 400 , "req" => 'POST http://' . $t->tx->local_address . ':' . $t->tx->remote_port . $url , 
                 "msg" => "$exp_err_msg"});

   # feature-id: 0a683caa-44ba-4d44-95ee-a22651dc22bd
   
   $url = '/' . $db . '/update/test_update_table' ; 
$exp_err_msg = 
' the update failed ! :: ERROR:  invalid input syntax for integer: "should be integer but string passed"
LINE 3:          SET seq = \'should be integer but string passed\'
                           ^ while updating the "seq" attribute value for the following id: 1' ;
   $t->post_ok($url => json => {"attribute"=>"seq", "id" =>"1", "cnt"=>"should be integer but string passed"})
      ->json_is({"ret" => 404 , "req" => 'POST http://' . $t->tx->local_address . ':' . $t->tx->remote_port . $url , 
                 "msg" => "$exp_err_msg"});

   $tm = "passwords should be hashed" ; 
   $t->post_ok($url => json => {"attribute"=>"password", "id" =>"4", "cnt"=>"secret"})->status_is(200);

   $url = '/' . $db . '/select/test_update_table?pick=password&with=id-eq-4' ; 
   $t->get_ok($url )->status_is(200) ;

   $tm = 'the "password" attribute in the app_user and test_update_table tables is encrypted ' ; 
   $res = $ua->get($url)->result->json ; 
   ok ( match_passphrase_against_crypto_hash($res->{'dat'}->[0]->{'password'},'secret') == 1 , $tm ) ; 


   sub match_passphrase_against_crypto_hash {
      my ($crypto_hash, $passphrase) = @_;
      return Authen::Passphrase::BlowfishCrypt
            ->from_rfc2307($crypto_hash)->match($passphrase);
   }

done_testing();

# feature-guid: 
