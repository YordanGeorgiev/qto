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
   
   $tm = "both username and password are filled in"; 
   ok ( $t->post_ok($url => json => {"user" =>'user', 'password' => 'password'})->status_is(200) , $tm );

   $tm = "the user posted should not empty"; 
   ok ( $t->post_ok($url => json => {"user" =>''})->status_is(400) , $tm );

   $tm = "the user posted should not be undefined"; 
   ok ( $t->post_ok($url => json => {"user" =>undef})->status_is(400) , $tm );
   
   $tm = "the password posted should not be empty "; 
   ok ( $t->post_ok($url => json => {"user" =>'user', 'password' => ''})->status_is(400) , $tm );
   
   $tm = "the password posted should not be undefined"; 
   ok ( $t->post_ok($url => json => {"user" =>'user', 'password' => undef})->status_is(400) , $tm );


done_testing();
