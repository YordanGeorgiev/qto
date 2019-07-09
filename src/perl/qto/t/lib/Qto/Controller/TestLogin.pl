use strict ; use warnings ; 

use FindBin;
use Data::Printer ; 
use Test::Most ; 
use Test::Mojo;

die_on_fail;

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../qto/lib" }

   my $tm = '' ; # the test message for each test 
   my $t = Test::Mojo->new('Qto');
   $t->ua->max_redirects(10);
   my $appConfig = $t->app->get('AppConfig') ; 
   my $db_name= $appConfig->{ 'postgres_db_name' } ; 
   my $url = '/' . $db_name . '/login' ; 
   
   # 01..03
   $tm = "the email posted should not be empty"; 
   ok ( $t->post_ok( $url => 'form'  => {'email' =>'','pass' => ''})->status_is(400) , $tm );

   # 04..06
   $tm = "the email posted should not be undefined"; 
   ok ( $t->post_ok($url => 'form' => {'email'=>undef})->status_is(400) , $tm );
  
   # 07..09
   $tm = "the pass posted should not be empty "; 
   ok ( $t->post_ok($url => 'form'  => {'email' =>'email', 'pass' => ''})->status_is(400) , $tm );
 
   # 10..12
   $tm = "the pass posted should not be undefined"; 
   ok ( $t->post_ok( $url => 'form'  => {'email' =>'email', 'pass' => undef})->status_is(400) , $tm );
   
   # 13..15
   $tm = "400 unauthorized is returned if the email is not valid"; 
   ok ( $t->post_ok( $url => 'form'  => {'email' =>'test.user@gmail', 'pass' => 'invalid'})->status_is(400) , $tm );

   # 16..18
   $tm = "401 unauthorized is returned if the pass does not match"; 
   ok ( $t->post_ok( $url => 'form'  => {'email' =>'test.user@gmail.com', 'pass' => 'invalid'})->status_is(401) , $tm );

   # 19..21
   $tm = "both email and pass are filled in and the pass matches - see users create table";
   ok ( $t->post_ok( $url => 'form'  => {'email' =>'test.user@gmail.com', 'pass' => 'secret'}) , $tm );

   # 22..24
   $tm = "a successfull result redirects to the home page";
   my $tx = $t->ua->post( $url => 'form'  => {'email' =>'test.user@gmail.com', 'pass' => 'secret'});
   ok ( $tx->result->dom->all_text =~ "$db_name home" , $tm );
   # debug p $tx->result->dom ;

done_testing();
