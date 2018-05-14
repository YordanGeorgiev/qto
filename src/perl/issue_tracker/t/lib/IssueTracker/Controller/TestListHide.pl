use strict ; use warnings ; 

use Test::More;
use Test::Mojo;
use Data::Printer ; 
use FindBin;

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../issue_tracker/lib" }

   my $tm = '' ; # the test message for each test 
   my $t = Test::Mojo->new('IssueTracker');
   my $appConfig = $t->app->get('AppConfig') ; 
   
   my $db_name= $appConfig->{ 'postgres_db_name' } ; 
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

	$tm = 'for the hide the id attribute , no id: should be present' ; 
	$t->get_ok($url)->content_unlike('/id:/' , $tm ) ; 

#   feature-id: ?!
#   $url = '/' . $db_name . '/select/' . $table_name ; 
#   my $res = $ua->get('/' . $db_name . '/select/' . $table_name )->result->json ; 
#   $tm .= 'the response msg for the ' . $table_name . "is correct for the url: $url" ; 
#   ok ( $res->{'msg'} eq "SELECT OK for table: $table_name" , $tm) ; 
#
#   $tm = 'the return code for the ' . $table_name . ' is correct' ; 
#   ok ( $res->{'ret'} == 200 , $tm) ; 
}


done_testing();

