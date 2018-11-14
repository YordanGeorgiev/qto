use strict ; use warnings ; 

use Test::Most ; 
use Test::Mojo;
use Data::Printer ; 
use FindBin;

die_on_fail ; 

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../issue_tracker/lib" }

   my $tm = '' ; # the test message for each test 
   my $t = Test::Mojo->new('IssueTracker');
   my $appConfig = $t->app->get('AppConfig') ; 
   my $ua = {} ;                                # the mojo user agent 
   my $dom = {} ;                                # the mojo dom parser 
   my $url = {} ;                                # the url to build for each test 
   my $exp_txt = {} ;                            # the expected text to check 
   my $response = {} ; 
  
   $tm = ' when providing a non-existing db the http response code should be 400 ' ; 
   my $db_name = 'non_existent_db' ; 
   $url = '/' . $db_name . '/list/some-table' ; 
   $t->get_ok($url)
      ->status_is(400 , $tm )
   ;

   $url = '/non_existent_db/list/monthly_issues' ; 
   $tm = ' the error msg should be diplayed in the err_msg label of the page ' ; 
   ok ( $t->get_ok($url)->content_type_is('text/html;charset=UTF-8') , $tm ) ; 
   # $dom = Mojo::DOM->new($t->ua->get($url)->result->body); 
   # $exp_txt = 'cannot connect to the "non_existent_db" database: FATAL:  database "non_existent_db" does not exist' ; 
   # ok ( $t->ua->get($url)->result->body eq $exp_txt , $tm ) ; 
   ; 

   $db_name= $appConfig->{ 'postgres_db_name' } ; 
   $url = '/' . $db_name . '/select-tables' ; 

	$tm = "for list all the tables from the $db_name db" ; 
   $t->get_ok($url)
      ->status_is(200) 
      ->header_is('Accept-Charset' => 'UTF-8' , $tm ) 
   ;

   $ua  = $t->ua ; 
   $response = $ua->get('/' . $db_name . '/select-tables')->result->json ; 
   my @list = ('monthly_issues' , 'yearly_issues');

# foreach table in the app db in test call db/list/table
for my $table_name ( @list ) {

   my $url = '' ; 
   my $tm = '' ; # the test msg 

	$tm = 'for get the correct http status code - 200 , utf-8 and fi,en as langs' ; 
  
   my @output_types = ( 'cloud' ) ;  
   foreach my $as ( @output_types ) {
      $url = '/' . $db_name . '/list/' . $table_name . '?as=' . "$as" ; 
      $t->get_ok( $url )
         ->status_is(200) 
          ->header_is('Accept-Charset' => 'UTF-8')
          ->content_like(qr{id="div_cloud_items"})
      ;
      $tm = 'for get the correct title <<table_name>> in <<db_name>>' ; 
      $t->get_ok($url)->text_is('html head title'
         => " list $table_name as $as in $db_name " , $tm );
    
      $tm = ' no text should be displayed in the spn_msg label as the user sees the result' ; 
      $dom = Mojo::DOM->new($t->ua->get($url)->result->body); 
      $exp_txt = '' ; 
      ok ( $dom->at('#spn_msg')->text eq $exp_txt , $tm ) ; 
      ; 
   }
}

   $tm = 'handle error on non-existent db ' ; 
	$url = '/non_existent_db/list/some_table&as=lbls' ; 
   $dom = Mojo::DOM->new($t->ua->get($url)->result->body); 

   $exp_txt = 'cannot connect to the "non_existent_db" database: FATAL:  database "non_existent_db" does not exist' ; 
   $tm = " a text content type response is expected " ; 
   ok ( $t->get_ok($url)->content_type_is('text/html;charset=UTF-8') , $tm ) ; 
   # ok ( $dom->at('#spn_err_msg')->text eq $exp_txt , $tm ) ; 

   $db_name= $appConfig->{ 'postgres_db_name' } ; 
   $tm = 'handle error on non-existent table' ; 
	$url = '/' . $db_name . '/list/non_existent_table?as=lbls' ; 
   $dom = Mojo::DOM->new($t->ua->get($url)->result->body); 

   # p $t->ua->get($url)->result->body ; 
   # this needs to be asyncrounous with using client code as well ...
   # $exp_txt = "the table non_existent_table does not exist in the " . $db_name . " database" ; 
   # ok ( $dom->at('#spn_err_msg')->text eq $exp_txt , $tm ) ; 




done_testing();

