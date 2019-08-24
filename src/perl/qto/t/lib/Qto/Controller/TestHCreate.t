use strict ; use warnings ; 

use Test::Most ; 
use Test::Mojo;
use Data::Printer ; 
use FindBin;
use Mojo::UserAgent;

die_on_fail ; 

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../qto/lib" }

   my $tm            = '' ; # the test message for each test 
   my $res           = {} ; 
   my $url           = {} ; 
   my $exp_err_msg   = '' ; 
   my $t             = Test::Mojo->new('Qto');
   my $config        = $t->app->get('AppConfig') ; 
   my $db            = $config->{'env'}->{'db'}->{'postgres_db_name'} ; # because each instance has it's own ...
   my $ua            = $t->ua ; # the user agent , aka http client
   my $objTimer      = {} ;
   my $id            = undef ; # an id to test
   my $seq           = undef ; # a sequence to test

   # the HCreate back-end web action requires the following json format : 
   # the id which is BY DESIGN a requirement for ANY qto app table to work ... 
   # the content should be json format as follows
   #
   $tm = 'the table is truncated' ; 
   $url = '/' . $db . '/truncate/test_hcreate_table' ; 
   ok ( $t->get_ok($url )->status_is(200) , $tm ) ;
	
   my $table_name = 'non_existent_table' ; 
	$url = '/' . $db . '/hcreate/' . $table_name ;
   ok ( $t->post_ok($url => json => {"id" =>0,"seq"=>1,"item"=>'test_hcreate_table'})->status_is(400) , $tm );

	$db = 'non_existent_db' ; 
	$url = '/' . $db . '/hcreate/test_hcreate_table' ;
   ok ( $t->post_ok($url => json => {"id" =>0,"seq"=>1,"item"=>'test_hcreate_table'})->status_is(400) , $tm );
   
   $tm            = 'the string "not_an_integer" should not qualify for an id ...' ; 
   $id            = 'not_an_integer' ; 
   $exp_err_msg   = 'the id must be a whole positive number, but not_an_integer was provided !' ;
   $db            = $config->{'env'}->{'db'}->{ 'postgres_db_name' } ; 
   $url           = '/' . $db . '/hcreate/test_hcreate_table' ; 
   ok ($t->post_ok($url => json => {"id"=> $id ,"seq"=>1})
      ->json_is({"ret" => 400
            , "req" => 'POST http://' . $t->tx->local_address . ':' . $t->tx->remote_port . $url 
            , "msg" => "$exp_err_msg"
            , "dat" => {}
            }), $tm );

   $tm = 'the id should be a positive integer' ; 
   $id = '-1' ; 
   $exp_err_msg = 'the id must be a whole positive number, but -1 was provided !' ;
   $url = '/' . $db . '/hcreate/test_hcreate_table' ; 
   ok ($t->post_ok($url => json => {"id"=> $id ,"seq"=>1})
      ->json_is({"ret" => 400
            , "req" => 'POST http://' . $t->tx->local_address . ':' . $t->tx->remote_port . $url 
            , "msg" => "$exp_err_msg"
            , "dat" => {}
        }), $tm );
   
   $tm            = 'the string "not_an_integer" should not qualify for an seq ...' ; 
   $seq           = 'not_an_integer' ; 
   $exp_err_msg   = 'the seq must be a whole positive number, but not_an_integer was provided !' ;
   $url           = '/' . $db . '/hcreate/test_hcreate_table' ; 
   ok ($t->post_ok($url => json => {"id"=> 1 ,"seq"=>$seq})
      ->json_is({"ret" => 400
            , "req" => 'POST http://' . $t->tx->local_address . ':' . $t->tx->remote_port . $url 
            , "msg" => "$exp_err_msg"
            , "dat" => {}
            }), $tm );

   $tm = 'the seq should be a positive integer' ; 
   $seq = '-1' ; 
   $exp_err_msg = 'the seq must be a whole positive number, but -1 was provided !' ;
   $url = '/' . $db . '/hcreate/test_hcreate_table' ; 
   ok ($t->post_ok($url => json => {"id"=> 1 ,"seq"=>$seq})
      ->json_is({"ret" => 400
            , "req" => 'POST http://' . $t->tx->local_address . ':' . $t->tx->remote_port . $url 
            , "msg" => "$exp_err_msg"
            , "dat" => {}
        }), $tm );
   
   $tm = 'the first item BY DEFINITION always knows that it has an id of 0 and seq of 1' ;
   $url = '/' . $db . '/hcreate/test_hcreate_table' ; 
   ok ( $t->post_ok($url => json => {"id" =>0,"seq"=>1,"item"=>'test_hcreate_table'})->status_is(200) , $tm );

	$id = 0 ; $seq = 1 ; # the values of the root element by definition 
   $tm = 'the a new row has been created with the new id: ' . $id . " with the other default values" ; 
   $res = $ua->get('/' . $db . '/select/test_hcreate_table?with=id-eq-0' )->result->json ; 
   ok ( $res->{'dat'}[0]->{'id'} eq $id , $tm ) ; 
   
	$tm = 'the a new row has been created with the new seq: ' . $seq . " with the other default values" ; 
   ok ( $res->{'dat'}[0]->{'seq'} eq $seq , $tm ) ; 

done_testing();
