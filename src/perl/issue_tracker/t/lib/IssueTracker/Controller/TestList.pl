use strict ; use warnings ; 

use Test::More;
use Test::Mojo;
use Data::Printer ; 
use FindBin;

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../issue_tracker/lib" }

   my $tm = '' ; # the test message for each test 
   my $t = Test::Mojo->new('IssueTracker');
   my $appConfig = $t->app->get('AppConfig') ; 
  
   $tm = ' when providing a non-existing db the http response code should be 400 ' ; 
   my $db_name = 'non_existent_db' ; 
   my $url = '/' . $db_name . '/list/some-table' ; 
   $t->get_ok($url)
      ->status_is(400 , $tm )
   ;

   $tm = ' the error msg should be diplayed in the err_msg label of the page ' ; 
   my $dom = Mojo::DOM->new($t->ua->get($url)->result->body); 
   my $exp_txt = 'cannot connect to the "non_existent_db" database: FATAL:  database "non_existent_db" does not exist' ; 
   ok ( $dom->at('#spn_err_msg')->text eq $exp_txt , $tm ) ; 
   ; 

   $db_name= $appConfig->{ 'postgres_db_name' } ; 
   $url = '/' . $db_name . '/select-tables' ; 

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
	$url = '/' . $db_name . '/list/' . $table_name ; 
	$t->get_ok( $url )
		->status_is(200) 
		 ->header_is('Accept-Charset' => 'UTF-8')
		 ->header_is('Accept-Language' => 'fi, en' , $tm)
	;
	$tm = 'for get the correct title <<table_name>> in <<db_name>>' ; 
	$t->get_ok($url)->text_is('html head title'
    	=> " list $table_name in $db_name " , $tm );
   
   $tm = ' no text should be displayed in the spn_msg label as the user sees the result' ; 
   my $dom = Mojo::DOM->new($t->ua->get($url)->result->body); 
   my $exp_txt = '' ; 
   ok ( $dom->at('#spn_msg')->text eq $exp_txt , $tm ) ; 
   ; 

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

