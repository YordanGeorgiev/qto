use strict ; use warnings ; 

use Test::Mojo;
use Test::Most ; 
use Data::Printer ; 
use FindBin;
use Mojo::UserAgent;

die_on_fail ; 
   $ENV{'QTO_NO_AUTH'} = 1 ;

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../qto/lib" }

   my $res           = {} ; 
   my $url           = {} ; 
   my $tm            = '' ; # the test message for each test 
   my $exp_err_msg   = '' ; 
   my $t             = Test::Mojo->new('Qto');
   my $config     = $t->app->config ; 
   my $db            = $config->{'env'}->{'db'}->{ 'postgres_app_db' } ; 
   my $env           = $config->{'env'}->{ 'ENV' } ;

#insert into test_update_table ( id,seq,name,description) values (1,1,'name-1','the name should be updated to updated-name-1'); 
#insert into test_update_table ( id,seq,name,description) values (2,2,'name-2','the name attr should NOT be updated'); 
#insert into test_update_table ( id,seq,name,description) values (3,3,'name-3','the name attr should be updated to updated-name-3'); 
#insert into test_update_table ( id,seq,name,description) values (4,4,'name-4','the password testing row'); 
   my $ua  = $t->ua ; 


   $tm = 'the table is truncated' ; 
   $url = '/' . $db . '/truncate/test_update_table' ; 
   ok ( $t->get_ok($url )->status_is(200) , $tm ) ;

	for (1..5) { 
      my $id             = $_ ;
      $url = '/' . $db . '/create/test_update_table' ; 
      ok ( $t->post_ok($url => json => {"id" => "$id" })->status_is(200) , $tm );

      $tm = 'the a new row has been created with the new id: ' . $id . " with the default name " ; 
      $res = $ua->get('/' . $db . '/select/test_update_table?with=id-eq-' . $id )->result->json ; 
      ok ( $res->{'dat'}[0]->{'name'} eq 'name...' , $tm ) ; 
   }

   # the update by attribute requires the following json format : 
   # the name of the attribute
   # the id which is BY DESIGN a requirement for ANY qto app table to work ... 
   # the content should be json format as follows
   $url              = '/' . $db . '/update/test_update_table' ; 
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
   ok ( $res->{'dat'}[0]->{'name'} eq 'name...' , $tm ) ; 
   
   $tm = 'the ret var from the response should be the same as the http code => 200'; 
   ok ( $res->{'ret'} eq 200 , $tm ) ; 
   # debug p $res ; 

   $exp_err_msg = 'update failed :: FATAL:  database "' . $env . '_non_existent_db" does not exist' ;
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
' the update failed ! :: ERROR:  invalid input syntax for type integer: "should be integer but string passed"
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
