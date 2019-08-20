use strict ; use warnings ; 

use Test::Most ; 
use Test::Mojo;
use Data::Printer ; 
use FindBin;

die_on_fail;

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../qto/lib" }

   my $tm = '' ; # the test message for each test 
   my $t = Test::Mojo->new('Qto');
   my $config = $t->app->get('AppConfig') ; 
   
   my $db_name= $config->{ 'postgres_db_name' } ; 
   my $url = '/' . $db_name . '/select-tables' ; 

	$tm = "for list all the tables from the $db_name db" ; 
   $t->get_ok($url)
      ->status_is(200) 
      ->header_is('Accept-Charset' => 'UTF-8' , $tm ) 
   ;

   my $ua  = $t->ua ; 
   my $response = $ua->get('/' . $db_name . '/select-tables')->result->json ; 
   my $list = $response->{ 'dat' } ; 

# foreach table in the app db in test call db/list/table
for my $row ( @$list ) {

   my $table_name = $row->{'table_name'} ; 
   next unless exists $row->{ 'update_time' } ; 
   my $url = '' ; 
   my $tm = '' ; # the test msg 

	$tm = 'for get the correct http status code - 200 , utf-8 and fi,en as langs' ; 
	$url = '/' . $db_name . '/list/' . $table_name . '?hide=guid,id' ; 
	$t->get_ok( $url )
		->status_is(200) 
		 ->header_is('Accept-Charset' => 'UTF-8')
		 ->header_is('Accept-Language' => 'fi, en' , $tm)
	;
	$tm = 'for the hide the guid attribute , no guid: should be present' ; 
	$t->get_ok($url)->content_unlike('/guid:/' , $tm ) ; 

	$url = '/' . $db_name . '/list/' . $table_name . '?hide=update_time' ; 
	$t->get_ok( $url )
		->status_is(200) 
	;
	$tm = 'for the hide the update_time attribute , no update_time should be present' ; 
	$t->get_ok($url)->content_unlike('/update_time/' , $tm ) ; 

}


done_testing();

