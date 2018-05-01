use strict ; use warnings ; 
use Test::More;
use Test::Mojo;
use Data::Printer ; 
use FindBin;

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../issue_tracker/lib" }

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
	$t->get_ok('/' . $db_name . '/list/' . $table_name)
		->status_is(200) 
		->header_is('Accept-Charset' => 'UTF-8')
		->header_is('Accept-Language' => 'fi, en')
	;

   my $res = $ua->get('/' . $db_name . '/list/' . $table_name )->result->json ; 
   my $tm = 'the response msg for the ' . $table_name . ' is correct' ; 
   ok ( $res->{'msg'} eq "SELECT OK for table: $table_name" , $tm) ; 
   $tm = 'the return code for the ' . $table_name . ' is correct' ; 
   ok ( $res->{'ret'} == 200 , $tm) ; 
}

	my $table_name = 'non_existtent_table' ; 
	$t->get_ok('/' . $db_name . '/list/' . $table_name)
		->status_is(400) 
		->header_is('Accept-Charset' => 'UTF-8')
		->header_is('Accept-Language' => 'fi, en')
	;

   my $res = $ua->get('/' . $db_name . '/list/' . $table_name )->result->json ; 
   my $tm = 'the response msg for the ' . $table_name . ' is correct' ; 
   ok ( $res->{'msg'} eq " the table $table_name does not exist in the $db_name database " , $tm ) ; 
   $tm = 'the return code for the ' . $table_name . ' is correct' ; 
   ok ( $res->{'ret'} == 400 , $tm) ; 

# src: https://restfulapi.net/http-status-codes/
#400 (Bad Request)
#400 is the generic client-side error status, used when no other 4xx error code is appropriate. Errors can be like malformed request syntax, invalid request message parameters, or deceptive request routing etc.
#
#The client SHOULD NOT repeat the request without modifications.


# fetch all the tables 
done_testing();
