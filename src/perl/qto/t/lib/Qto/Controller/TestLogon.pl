use strict ; use warnings ; 

use FindBin;
use Data::Printer ; 
use Test::Most ; 
use Test::Mojo;

die_on_fail;

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../qto/lib" }

   my $tm = '' ; # the test message for each test 
   my $t = Test::Mojo->new('Qto');
   my $appConfig = $t->app->get('AppConfig') ; 
   my $db_name= $appConfig->{ 'postgres_db_name' } ; 
   my $url = '/' . $db_name . '/logon' ; 
   
   # 01..03
   $tm = "the email posted should not be empty"; 
   ok ( $t->post_ok($url => json => {"email" =>''})->status_is(400) , $tm );

   # 04..06
   $tm = "the email posted should not be undefined"; 
   ok ( $t->post_ok($url => json => {"email" =>undef})->status_is(400) , $tm );
  
   # 07..09
   $tm = "the password posted should not be empty "; 
   ok ( $t->post_ok($url => json => {"email" =>'email', 'password' => ''})->status_is(400) , $tm );
 
   #10..12
   $tm = "the password posted should not be undefined"; 
   ok ( $t->post_ok($url => json => {"email" =>'email', 'password' => undef})->status_is(400) , $tm );
   
   #13..15
   $tm = "both email and password are filled in and the password matches - see users create table";
   ok ( $t->post_ok($url => json => {"email" =>'test.user@gmail.com', 'password' => 'password'})->status_is(200) , $tm );

   #16..18
   $tm = "401 unauthorized is returned if the password does not match"; 
   ok ( $t->post_ok($url => json => {"email" =>'test.user@gmail.com', 'password' => 'invalid'})->status_is(401) , $tm );


done_testing();
