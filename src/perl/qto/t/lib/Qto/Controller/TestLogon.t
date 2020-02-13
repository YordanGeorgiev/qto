use strict ; use warnings ; 

use FindBin;
use Data::Printer ; 
use Test::Most ; 
use Test::Mojo;
use JSON ; 

die_on_fail;

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../qto/lib" }
   $ENV{'QTO_NO_AUTH'} = 1;

   my $tm         = '' ; # the test message for each test 
   my $emsg       = '' ; # the expected msg on the ui
   my $t          = Test::Mojo->new('Qto');
   my $config     = $t->app->config ; 
   my $db         = $config->{'env'}->{'db'}->{'postgres_db_name'} ; 
   my $tx         = {}  ; # the transaction object 
   my $url        = '/' . $db . '/logon' ; 
   my $email      = '' ; 
   my $pass       = '' ; 
   $t->ua->max_redirects(10);

   sub rndStr{ join'', @_[ map{ rand @_ } 1 .. shift ] }

   $t->get_ok($url)
      ->status_is(200) 
      ->header_is('Accept-Charset' => 'UTF-8')
      ->header_is('Accept-Language' => 'fi, en')
   ;
   $email = '' ;
   $pass = 'non-empty' ; 
   $tm = "the email posted should not be empty"; 
   $url = '/' . $db . '/logon' ; 
   ok ( $t->post_ok($url => json => {"email" => "$email","pass" => $pass })->status_is(400) , $tm );

   $emsg = "login failed! empty email ! ";
   $tm = "the $emsg msg is returned when the email is empty" ;
   $tx = $t->ua->post( $url => 'json'  => {'email' =>'', 'pass' => 'invalid'});
   my $json = decode_json($tx->result->dom->all_text ); # p $json
   ok ( $json->{'msg'} eq "$emsg" , $tm );
   printf "\n";

   $tm = "the email posted should not be undefined"; 
   $email = undef ; $pass = 'foo' ; 
   ok ( $t->post_ok($url => 'json' => {'email'=>$email})->status_is(400) , $tm );
   $emsg = "login failed! empty email ! ";
   $tm = "the $emsg msg is returned when the email is empty" ;
   $tx = $t->ua->post( $url => 'json'  => {'email' =>'', 'pass' => 'invalid'});
   $json = decode_json($tx->result->dom->all_text ); # p $json
   ok ( $json->{'msg'} eq "$emsg" , $tm );
   printf "\n";

   $tm = "the pass posted should not be empty "; 
   $email = 'test.user@gmail.com'; $pass = '' ; 
   ok ( $t->post_ok($url => 'json'  => {'email' =>'test.user@gmail.com', 'pass' => $pass})->status_is(400) , $tm );
   $emsg = "login failed!  empty password ! " ;
   $tm = "the $emsg msg is returned when the pass is empty" ;
   $tx = $t->ua->post( $url => 'json'  => {'email' =>'test.user@gmail.com', 'pass' => ''});
   $json = decode_json($tx->result->dom->all_text ); # p $json
   ok ( $json->{'msg'} eq "$emsg" , $tm );
   printf "\n";
 
   $tm = "the pass posted should not be undefined"; 
   $email = 'test.user@gmail.com'; $pass = undef;
   ok ( $t->post_ok($url => 'json'  => {'email' =>'test.user@gmail.com', 'pass' => $pass})->status_is(400) , $tm );
   $emsg = "login failed!  empty password ! " ;
   $tm = "the $emsg msg is returned when the pass is empty" ;
   $tx = $t->ua->post( $url => 'json'  => {'email' =>'test.user@gmail.com', 'pass' => ''});
   $json = decode_json($tx->result->dom->all_text ); # p $json
   ok ( $json->{'msg'} eq "$emsg" , $tm );
   printf "\n";


   $tm = 'the email should be no longer than 100 chars' ; # test for buffer overflows ...
   $email = rndStr 101, 'A'..'Z', 0..9, 'a'..'z' ; $pass = 'foo' ; 
   ok ( $t->post_ok($url => 'json'  => {'email' =>$email, 'pass' => $pass})->status_is(400) , $tm );
   $emsg = "login failed! the email: $email is too long " ;
   $tm = "the $emsg msg is returned when the pass is too long" ; 
   $tx = $t->ua->post( $url => 'json'  => {'email' =>$email, 'pass' => $pass});
   $json = decode_json($tx->result->dom->all_text ); # p $json
   ok ( $json->{'msg'} eq "$emsg" , $tm );
   printf "\n";

   $tm = 'the pass should be no longer than 100 chars' ; # test for buffer overflows ...
   $email = 'test.user@gmail.com' ; $pass = rndStr 101, 'A'..'Z', 0..9, 'a'..'z' ; 
   ok ( $t->post_ok($url => 'json'  => {'email' =>$email, 'pass' => $pass})->status_is(400) , $tm );
   $emsg = "login failed! the password: $pass is too long ";
   $tm = "the $emsg msg is returned when the pass is too long" ; 
   $tx = $t->ua->post( $url => 'json'  => {'email' =>$email, 'pass' => $pass});
   $json = decode_json($tx->result->dom->all_text ); # p $json
   ok ( $json->{'msg'} eq "$emsg" , $tm );
   printf "\n";


done_testing();
