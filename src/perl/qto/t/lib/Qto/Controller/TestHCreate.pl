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
   my $appConfig     = $t->app->get('AppConfig') ; 
   my $db            = $appConfig->{ 'postgres_db_name' } ; # because each instance has it's own ...
   my $ua            = $t->ua ; # the user agent , aka http client
   my $objTimer      = {} ;

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

   #$tm = 'the first item BY DEFINITION always knows that it has an id of 0 and seq of 1' ;
   #$url = '/' . $db . '/hcreate/test_hcreate_table' ; 
   #ok ( $t->post_ok($url => json => {"id" =>0,"seq"=>1,"item"=>'test_hcreate_table'})->status_is(200) , $tm );

done_testing();
