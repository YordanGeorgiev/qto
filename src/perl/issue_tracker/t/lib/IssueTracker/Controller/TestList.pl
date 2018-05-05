use strict ; use warnings ; 
use Test::More;
use Test::Mojo;
use Data::Printer ; 
use FindBin;

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../issue_tracker/lib" }

   my $tm = q{} ; # the test msg for each test
   my $t = Test::Mojo->new('IssueTracker');
   $t->get_ok('/')->status_is(200) ; 

   my $appConfig = $t->app->get('AppConfig') ; 

   # if the product instance id dev -> dev_issue_tracker
   # if the product instance id tst -> tst_issue_tracker
   my $db_name= $appConfig->{ 'postgres_db_name' } ; 
   # JSON

   $t->get_ok('/' . $db_name . '/list-tables')
      ->status_is(200) 
      ->header_is('Accept-Charset' => 'UTF-8')
      ->header_is('Accept-Language' => 'fi, en')
      ->content_like(qr/daily_issues/);
   ;

   my $ua  = $t->ua ; 
   my $response = $ua->get('/' . $db_name . '/list-tables')->result->json ; 
   my $hsr2 = $response->{ 'dat' } ; 

# foreach table in the app db in test call db/list/table
for my $key ( keys %$hsr2 ) {
	my $table_name = $hsr2->{ $key }->{'table_name'} ; 
   
   # feature-guid: 1d270227-0959-488f-83d3-0397221385a0
	$t->get_ok('/' . $db_name . '/list/' . $table_name)
		->status_is(200) 
		->header_is('Accept-Charset' => 'UTF-8')
		->header_is('Accept-Language' => 'fi, en')
	;

   # feature-guid: ac8a79af-9114-42e6-86eb-9bc29f7c0190
   my $res = $ua->get('/' . $db_name . '/list/' . $table_name )->result->json ; 
   my $tm = 'the response msg for the ' . $table_name . ' is correct' ; 
   ok ( $res->{'msg'} eq "SELECT OK for table: $table_name" , $tm) ; 
   $tm = 'the return code for the ' . $table_name . ' is correct' ; 
   ok ( $res->{'ret'} == 200 , $tm) ; 
}

   # feature-guid: dfc1216d-5a16-40eb-849a-2785264aa5bd
	my $table_name = 'non_existtent_table' ; 
	$t->get_ok('/' . $db_name . '/list/' . $table_name)
		->status_is(400) 
		->header_is('Accept-Charset' => 'UTF-8')
		->header_is('Accept-Language' => 'fi, en')
	;

   # feature-guid: 8d750499-4911-416c-ae81-b3415d13b5ef
   my $res = $ua->get('/' . $db_name . '/list/' . $table_name )->result->json ; 
   $tm = 'the response msg for the ' . $table_name . ' is correct' ; 
   ok ( $res->{'msg'} eq " the table $table_name does not exist in the $db_name database " , $tm ) ; 

   $tm = 'the return code for the ' . $table_name . ' is correct' ; 
   ok ( $res->{'ret'} == 400 , $tm) ; 
   
   $res = $ua->get('/non_existent_db/list/some_table'  )->result->json ; 
   $tm = 'shoud return error for cannot connect to db' ; 
   my $exp_err_msg = 'cannot connect to the non_existent_db database: FATAL:  database "non_existent_db" does not exist' ; 
   ok ( $res->{'msg'} eq $exp_err_msg , $tm ) ; 


# fetch all the tables 
done_testing();

# feature-guid: ecd424d7-e5bd-45f1-90c8-10fae1316bf9
