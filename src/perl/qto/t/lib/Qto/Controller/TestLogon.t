use strict ; use warnings ; 

use FindBin;
use Data::Printer ; 
use Test::Most ; 
use Test::Mojo;
use JSON ; 

die_on_fail;

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../qto/lib" }
use Qto::App::Cnvr::CnrDbName qw(toPlainName toEnvName);
   $ENV{'QTO_NO_AUTH'} = 0 ; # !!!
   $ENV{'QTO_JWT_AUTH'} = 1 ; # !!!

   my $tm         = '' ; # the test message for each test 
   my $emsg       = '' ; # the expected msg on the ui
   my $t          = Test::Mojo->new('Qto');
   my $config     = $t->app->config ; 
   my $db         = $config->{'env'}->{'db'}->{'postgres_app_db'} ; 
   my $tx         = {}  ; # the transaction object 
   my $url        = '/' . $db . '/logon' ; 
   my $email      = '' ; 
   my $pass       = '' ; 
   my $pdb        = toPlainName($db);
   my $edb        = toEnvName($db,$config);
   $t->ua->max_redirects(10);

   sub rndStr{ join'', @_[ map{ rand @_ } 1 .. shift ] }

   $t->get_ok($url)
      ->status_is(200) 
      ->header_is('Accept-Charset' => 'UTF-8')
      ->header_is('Accept-Language' => 'fi, en')
   ;
   $tm = "the email posted should not be empty"; 
   my $email_input_name = $edb . '_email' ; 
   ok ( $t->post_ok( $url => 'form'  => {$email_input_name =>'','pass' => ''})->status_is(400) , $tm );
   printf "\n";

   
   $emsg = 'logon failed! empty email !';
   $tm = "the $emsg msg is returned when the email is empty" ;
   $tx = $t->ua->post( $url => 'form'  => {$email_input_name =>'', 'pass' => 'invalid'});
   ok ( $tx->result->dom->all_text =~ "$emsg" , $tm );
   printf "\n";

   $tm = "the email posted should not be undefined"; 
   ok ( $t->post_ok($url => 'form' => {$email_input_name=>undef})->status_is(400) , $tm );
   $emsg = 'logon failed! empty email !';
   $tm = "the $emsg msg is returned when the email is empty" ;
   $tx = $t->ua->post( $url => 'form'  => {$email_input_name =>undef, 'pass' => 'foo'});
   ok ( $tx->result->dom->all_text =~ "$emsg" , $tm );
   printf "\n";
  
   $tm = "the pass posted should not be empty "; 
   ok ( $t->post_ok($url => 'form'  => {$email_input_name =>'test.anonymous.user@gmail.com', 'pass' => ''})->status_is(400) , $tm );
   $emsg = 'logon failed!  empty password !';
   $tm = "the $emsg msg is returned when the pass is empty" ;
   $tx = $t->ua->post( $url => 'form'  => {$email_input_name =>'test.anonymous.user@gmail.com', 'pass' => ''});
   # debug p $tx->result->dom->all_text ; 
   ok ( $tx->result->dom->all_text =~ "$emsg" , $tm );
   printf "\n";
 
   $tm = "the pass posted should not be undefined"; 
   ok ( $t->post_ok( $url => 'form'  => {$email_input_name =>$email_input_name, 'pass' => undef})->status_is(400) , $tm );
   $emsg = 'logon failed!  empty password !';
   $tm = "the $emsg msg is returned when the pass is empty" ;
   $tx = $t->ua->post( $url => 'form'  => {$email_input_name =>'test.anonymous.user@gmail.com', 'pass' => undef});
   # debug p $tx->result->dom->all_text ; 
   ok ( $tx->result->dom->all_text =~ "$emsg" , $tm );
   printf "\n";
   
   $tm = "400 unauthorized is returned if the email is not valid"; 
   ok ( $t->post_ok( $url => 'form'  => {$email_input_name =>'test.anonymous.user@gmail', 'pass' => 'invalid'})->status_is(400) , $tm );
   $tm = "the email is not valid msg is returned" ;
   $tx = $t->ua->post( $url => 'form'  => {$email_input_name =>'test.anonymous.user@gmail', 'pass' => 'invalid'});
   ok ( $tx->result->dom->all_text =~ 'logon failed! test.anonymous.user@gmail is not a valid email!' , $tm );
   printf "\n";

   $tm = "401 unauthorized is returned if the pass does not match"; 
   ok ( $t->post_ok( $url => 'form'  => {$email_input_name =>'test.anonymous.user@gmail.com', 'pass' => 'invalid'})->status_is(401) , $tm );
   $tm = "wrong password msg is returned" ;
   $tx = $t->ua->post( $url => 'form'  => {$email_input_name =>'test.anonymous.user@gmail.com', 'pass' => 'invalid'});
   ok ( $tx->result->dom->all_text =~ 'wrong password for test.anonymous.user@gmail.com' , $tm );
   printf "\n";

   $tm = "non registered user"; 
   ok ( $t->post_ok( $url => 'form'  => {$email_input_name =>'not.registered.user@gmail.com', 'pass' => 'invalid'})->status_is(401) , $tm );
   $tx = $t->ua->post( $url => 'form'  => {$email_input_name =>'not.registered.user@gmail.com', 'pass' => 'invalid'});
   ok ( $tx->result->dom->all_text =~ 'not.registered.user@gmail.com not registered' , $tm );
   printf "\n";
   $tm = "non registered user"; 
   $pass = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';
   ok ( $t->post_ok( $url => 'form'  => {$email_input_name =>'not.registered.user@gmail.com', 'pass' => $pass})->status_is(401) , $tm );
   $tx = $t->ua->post( $url => 'form'  => {$email_input_name =>'not.registered.user@gmail.com', 'pass' => 'invalid'});
   ok ( $tx->result->dom->all_text =~ 'not.registered.user@gmail.com not registered' , $tm );
   printf "\n";
   # todos: check for buffer overflows ... 
   $tm = 'the email should be no longer than 100 chars' ; # test for buffer overflows ...
   $tm = 'the pass should be no longer than 100 chars' ; # test for buffer overflows ...

   $tm = "a successfull result redirects to the search page";
   $email = 'test.anonymous.user@gmail.com' ;
   $pass = 'test.anonymous.user-pass';
   $tx = $t->ua->post( $url => 'form'  => {$email_input_name =>$email, pass=>$pass});
   ok ( $tx->result->dom->to_string =~ "<title> search $pdb </title>", $tm );
   # debug p $tx->result->dom->to_string ;
   printf "\n";
   
   # check that the product version , and the short hash are on the page
   my $env = $config->{'env'}->{'run'}->{'ENV'} ; 
   my $dom = {} ;                                # the mojo dom parser 

   $dom = Mojo::DOM->new($tx->result->dom->all_text) ; 
   # debug p $tx->result->dom->all_text;
   my $GitShortHash = $config->{'env'}->{'run'}->{ 'GitShortHash' } ; 
   my $ProductVersion = $config->{'env'}->{'run'}->{'VERSION'} ;
   $tm = "logon product version of this product instance: $ProductVersion " ; 
   ok ( $tx->result->dom->all_text =~ m/$db $ProductVersion  $env  $GitShortHash/ , $tm ) ;
   
   sub matches {
      my $first = shift ; 
      my $second = shift ; 
      return $first =~ m/$second/gm;
   }

   $tm='the db requested has ANY <<env>>_ prefix it MUST be removed during the intial logon' ;
   $url = '/' . $db . '/logon' ;
   ok ( $t->get_ok($url)->status_is(200) , $tm ) ;
   $tx = $t->ua->get( $url); 
   #debug p $tx->result->dom->to_string ; print "eof result->dom->to_string in TestLogin.t \n";
   ok ( $tx->result->dom->to_string =~ "<title>$pdb login </title>" , $tm );

   sub toPlainName {
      my $db  = shift ; 
      $db =~ s/^|dev_|tst_|qas_|prd_|//g;
      return $db ;
   }

   $ENV{'QTO_JWT_AUTH'} = 1 ; 
   $tm = "a successfull result redirects to the search page";
   $email = 'test.anonymous.user@gmail.com' ;
   $pass = 'test.anonymous.user-pass';
   $tx = $t->ua->post( $url => 'form'  => {$email_input_name =>$email, pass=>$pass});
   ok ( $tx->result->dom->to_string =~ "<title> search $pdb </title>", $tm );

   # debug p $tx->result->dom->to_string ;
   printf "\n";
   $tm = 'a forbidden backend route should be redirected to the error page';
   $url = '/' . $db . '/select/app_roles';
   $t->get_ok( $url )->status_is(403 , $tm ) ; 
   my $ua  = $t->ua ; 
   my $res = $ua->get($url )->result->json ; 
   #debug p $res ; print "eof res TestLogon.t todo:ysg \n";
   ok ( $res->{'ret'} == 403 , $tm);
   $tm = "the ANONYMOUS role SHOULD NOT not have the permission to select the app_roles item!";
   ok ( $res->{'msg'} eq "the ANONYMOUS role does not have the permission to select the app_roles item!", $tm);
   printf "\n";
   
   $url = '/' . $db . '/list/app_roles';
   $t->get_ok( $url )->status_is(200 , $tm ) ; 
   $ua  = $t->ua ; 
   $tm = 'a forbidden ui route should be redirected to the search page';
   ok ( $tx->result->dom->to_string =~ "<title> search $pdb </title>", $tm );


done_testing();
