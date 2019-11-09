use strict ; use warnings ; 

use FindBin;
use Data::Printer ; 
use Test::Most ; 
use Test::Mojo;

die_on_fail;

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../qto/lib" }

   my $tm         = '' ; # the test message for each test 
   my $emsg       = '' ; # the expected msg on the ui
   my $t          = Test::Mojo->new('Qto');
   $t->ua->max_redirects(10);
   my $config  = $t->app->config ; 
   my $db    = $config->{'env'}->{'db'}->{'postgres_db_name'} ; 
   my $url        = '/' . $db . '/login' ; # the login url to test for 
   my $tx         = {}  ; # the transaction object 

   $tm = "the email posted should not be empty"; 
   ok ( $t->post_ok( $url => 'form'  => {'email' =>'','pass' => ''})->status_is(400) , $tm );
   $emsg = 'login failed! empty email !';
   $tm = "the $emsg msg is returned when the email is empty" ;
   $tx = $t->ua->post( $url => 'form'  => {'email' =>'', 'pass' => 'invalid'});
   ok ( $tx->result->dom->all_text =~ "$emsg" , $tm );
   printf "\n";

   $tm = "the email posted should not be undefined"; 
   ok ( $t->post_ok($url => 'form' => {'email'=>undef})->status_is(400) , $tm );
   $emsg = 'login failed! empty email !';
   $tm = "the $emsg msg is returned when the email is empty" ;
   $tx = $t->ua->post( $url => 'form'  => {'email' =>undef, 'pass' => 'foo'});
   ok ( $tx->result->dom->all_text =~ "$emsg" , $tm );
   printf "\n";
  
   $tm = "the pass posted should not be empty "; 
   ok ( $t->post_ok($url => 'form'  => {'email' =>'test.user@gmail.com', 'pass' => ''})->status_is(400) , $tm );
   $emsg = 'login failed!  empty password !';
   $tm = "the $emsg msg is returned when the pass is empty" ;
   $tx = $t->ua->post( $url => 'form'  => {'email' =>'test.user@gmail.com', 'pass' => ''});
   # debug p $tx->result->dom->all_text ; 
   ok ( $tx->result->dom->all_text =~ "$emsg" , $tm );
   printf "\n";
 
   $tm = "the pass posted should not be undefined"; 
   ok ( $t->post_ok( $url => 'form'  => {'email' =>'email', 'pass' => undef})->status_is(400) , $tm );
   $emsg = 'login failed!  empty password !';
   $tm = "the $emsg msg is returned when the pass is empty" ;
   $tx = $t->ua->post( $url => 'form'  => {'email' =>'test.user@gmail.com', 'pass' => undef});
   # debug p $tx->result->dom->all_text ; 
   ok ( $tx->result->dom->all_text =~ "$emsg" , $tm );
   printf "\n";
   
   $tm = "400 unauthorized is returned if the email is not valid"; 
   ok ( $t->post_ok( $url => 'form'  => {'email' =>'test.user@gmail', 'pass' => 'invalid'})->status_is(400) , $tm );
   $tm = "the email is not valid msg is returned" ;
   $tx = $t->ua->post( $url => 'form'  => {'email' =>'test.user@gmail', 'pass' => 'invalid'});
   ok ( $tx->result->dom->all_text =~ 'login failed! test.user@gmail is not a valid email!' , $tm );
   printf "\n";

   $tm = "401 unauthorized is returned if the pass does not match"; 
   ok ( $t->post_ok( $url => 'form'  => {'email' =>'test.user@gmail.com', 'pass' => 'invalid'})->status_is(401) , $tm );
   $tm = "wrong password msg is returned" ;
   $tx = $t->ua->post( $url => 'form'  => {'email' =>'test.user@gmail.com', 'pass' => 'invalid'});
   ok ( $tx->result->dom->all_text =~ "wrong password for test.user\@gmail.com" , $tm );
   printf "\n";

   $tm = "both email and pass are filled in and the pass matches - see users create table";
   ok ( $t->post_ok( $url => 'form'  => {'email' =>'test.user@gmail.com', 'pass' => 'secret'}) , $tm );
   printf "\n";

   $tm = "a successfull result redirects to the home page";
   $tx = $t->ua->post( $url => 'form'  => {'email' =>'test.user@gmail.com', 'pass' => 'secret'});
   ok ( $tx->result->dom->all_text =~ "$db home" , $tm );
   printf "\n";
   # debug p $tx->result->dom ;
   
   $tm = "non registered user"; 
   ok ( $t->post_ok( $url => 'form'  => {'email' =>'not.registered.user@gmail.com', 'pass' => 'invalid'})->status_is(401) , $tm );
   $tx = $t->ua->post( $url => 'form'  => {'email' =>'not.registered.user@gmail.com', 'pass' => 'invalid'});
   ok ( $tx->result->dom->all_text =~ 'not.registered.user@gmail.com not registered' , $tm );
   printf "\n";
  
   # check that the product version , and the short hash are on the page
   my $env = $config->{'env'}->{'run'}->{'ENV_TYPE'} ; 
   my $dom = {} ;                                # the mojo dom parser 

   $tm = "login product_type: $env " ; 
   $url = '/' . $db . '/login' ; 

   $dom = Mojo::DOM->new($t->ua->get($url)->result->body) ; 
   ok ( $dom->find('div')->[2] =~ m/$env/ , $tm ) ;

   my $GitShortHash = $config->{'env'}->{'run'}->{ 'GitShortHash' } ; 
   $tm = "the app label contains the short git hash of this product instance: $GitShortHash" ; 
   ok ( $dom->find('div')->[2] =~ m/$GitShortHash/ , $tm ) ;
  
   my $ProductVersion = $config->{'env'}->{'run'}->{'VERSION'} ;
   $tm = "login product version of this product instance: $ProductVersion " ; 
   ok ( $dom->find('div')->[2] =~ m/$ProductVersion/ , $tm ) ;

done_testing();
