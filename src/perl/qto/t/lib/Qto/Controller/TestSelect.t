use strict ; use warnings ; 
use Test::Most ; 
use Test::Mojo;
use Data::Printer ; 
use FindBin;

die_on_fail;
   $ENV{'QTO_NO_AUTH'} = 1 ;

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../qto/lib" }

   my $tm = '' ; # the test message for each test 
   my $t = Test::Mojo->new('Qto');
   my $config = $t->app->config ; 
   # if the product instance id tst -> tst_qto
   my $db = $config->{'env'}->{'db'}->{ 'postgres_db_name' } ; 
	$t->get_ok('/' . $db . '/select-databases')->status_is(200) ; 

   my $url = '/' . $db . '/select-tables' ; 
   my $env = $config->{'env'}->{'ENV_TYPE'};


   $t->get_ok($url)
      ->status_is(200) 
      ->header_is('Accept-Charset' => 'UTF-8')
      ->header_is('Accept-Language' => 'fi, en')
      ->content_like(qr/daily_issues/);
   ;

   my $ua  = $t->ua ; 
   my $response = $ua->get('/' . $db . '/select-tables')->result->json ; 
   my $list = $response->{ 'dat' } ; 
   use Qto::App::Utils::Timer ; 
   my $objTimer = 'Qto::App::Utils::Timer'->new;
   my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = $objTimer->GetTimeUnits(); 
   my @tables_to_check = ("monthly_issues_$year$mon" , "yearly_issues_$year" );

# foreach table in the app db in test call db/select/table
for my $row ( @$list ) {

   my $table_name = $row->{'table_name'} ; 
   next if $table_name =~ m/test_/g ; # skipping the testing tables
   next unless ( grep( /^$table_name$/, @tables_to_check ) ) ;

   my $url = '' ; 
   my $tm = '' ; # the test msg 

   # feature-guid: 1d270227-0959-488f-83d3-0397221385a0
	$t->get_ok('/' . $db . '/select/' . $table_name)
		->status_is(200) 
		->header_is('Accept-Charset' => 'UTF-8')
		->header_is('Accept-Language' => 'fi, en')
	;

   # feature-guid: ac8a79af-9114-42e6-86eb-9bc29f7c0190

   $url = '/' . $db . '/select/' . $table_name ; 
   my $res = $ua->get('/' . $db . '/select/' . $table_name )->result->json ; 
   $tm .= 'the response msg for the ' . $table_name . " for the url: $url is empty" ; 
   ok ( $res->{'msg'} eq "" , $tm) ; 

   $tm = 'the return code for the ' . $table_name . ' is correct' ; 
   ok ( $res->{'ret'} == 200 , $tm) ; 
}

   # feature-guid: dfc1216d-5a16-40eb-849a-2785264aa5bd
	my $table_name = 'non_existent_table' ; 
	$t->get_ok('/' . $db . '/select/' . $table_name)
		->status_is(200) 
		->header_is('Accept-Charset' => 'UTF-8')
		->header_is('Accept-Language' => 'fi, en')
	;

   my $res = $ua->get('/' . $db . '/select/' . $table_name )->result->json ; 
   $tm = '2: the response msg for the ' . $table_name . ' is correct' ; 
   ok ( $res->{'msg'} eq " the table $table_name does not exist in the $db database " , $tm ) ; 

   $tm = 'the return code for the ' . $table_name . ' is correct' ; 
   ok ( $res->{'ret'} == 400 , $tm) ; 
   
   $res = $ua->get('/non_existent_db/select/monthly_issues'  )->result->json ; 
   $tm = 'shoud return error for cannot connect to db' ; 
   my $exp_err_msg = "cannot connect to the \"" . $env . "_non_existent_db\" database: FATAL:  database \"" . 
                              $env . "_non_existent_db\" does not exist";
                     
   ok ( $res->{'msg'} eq $exp_err_msg , $tm ) ; 

	$tm = 'if the page size is not a positive whole number return http 400 ' ; 
   my $page_size = 'not_even_a_number' ; 
   my $page_num = 1 ; 
   $url = '/' . $db . '/select/tst_paging?as=table&pg-size=' . $page_size .'&pg-num=' . $page_num ; 
   $t->get_ok( $url )->status_is(400 , $tm ) ; 
	
   $tm = 'if the page num is not a positive whole number return http 400 ' ; 
   $page_size = 15 ; 
   $page_num = 'not_even_a_number' ; 
   $url = '/' . $db . '/select/tst_paging?as=table&pg-size=' . $page_size .'&pg-num=' . $page_num ; 
   $t->get_ok( $url )->status_is(400 , $tm ) ; 

   $tm = 'if there is no data http code 200 should be returned, but 204 ret to UI should be passed' ; 
   $url = '/' . $db . '/select/monthly_issues?with=prio-eq-1000000' ; 
   $t->get_ok( $url )->status_is(200 , $tm ) ; 
   $res = $ua->get($url )->result->json ; 
   ok ( $res->{'ret'} == 204 , $tm);

done_testing();

# feature-guid: ecd424d7-e5bd-45f1-90c8-10fae1316bf9
