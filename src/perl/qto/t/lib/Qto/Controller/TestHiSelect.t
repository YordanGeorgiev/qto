use strict ; use warnings ; 
use Test::Most ; 
use Test::Mojo;
use Data::Printer ; 
use FindBin;

die_on_fail;

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../qto/lib" }

   my $tm            = '' ; # the test message for each test 
   my $t             = Test::Mojo->new('Qto');
   my $config        = $t->app->get('AppConfig') ; 
   # if the product instance id tst -> tst_qto
   my $db            = $config->{'env'}->{'db'}->{ 'postgres_db_name' } ; 

   $tm = '01. the select-databases route returns the list of the dbs in this server' ; 
	ok ( $t->get_ok('/' . $db . '/select-databases')->status_is(200) , $tm ) ; 
   
   $tm = '02. the select-tables route returns the list of the tables in the default app db' ; 
   my $url = '/' . $db . '/select-tables' ; 

   ok ( $t->get_ok($url)
      ->status_is(200) 
      ->header_is('Accept-Charset' => 'UTF-8')
      ->header_is('Accept-Language' => 'fi, en')
      , $tm )
   ;

   $tm = 'status 404 is returned  when the database provided does not exist' ; 
   $url = '/non_existent_db/hiselect/daily_issues/0' ; 
	#ok ( $t->get_ok($url)->status_is(404)  , $tm ) ; 
   
   #$tm = 'status 404 is returned  when the table  provided does not exist' ; 
   #$url = '/non_existent_db/hiselect/daily_issues/0' ; 
	#ok ( $t->get_ok($url)->status_is(404)  , $tm ) ; 

   

   my $ua  = $t->ua ; 
   my $response = $ua->get('/' . $db . '/select-tables')->result->json ; 
   my $list = $response->{ 'dat' } ; 
   my @tables_to_check = ( 'devops_guide_doc' , 'userstories_doc' ) ; 

   for my $row ( @$list ) {
      
      my $table_name = $row->{'table_name'} ; 
      next if $table_name =~ m/test_/g ; # skipping the testing tables
      next unless ( grep( /^$table_name$/, @tables_to_check ) ) ;

      $tm = 'the return code for the ' . $table_name . ' is correct' ; 
      $url = '/' . $db . '/hiselect/' . $table_name  ; 
      ok ($t->get_ok($url)
         ->status_is(200) 
         ->header_is('Accept-Charset' => 'UTF-8')
         ->header_is('Accept-Language' => 'fi, en'), $tm );

      my $res = $ua->get($url)->result->json ; 

      my $http_code = 200 ; 
      $tm = "the http_code: $http_code is returned" ;  
      ok ( $res->{'ret'} == $http_code , $tm) ; 
      
      $tm = "an empty msg is returned if all ok" ; 
      ok ( $res->{'msg'} eq "" , $tm) ; 

      $tm = 'return 400 if non-integer is passed for the seq url parameter' ; 
      $url = '/' . $db . '/hiselect/' . $table_name . '?bid=non_integer' ; 
      ok ($t->get_ok($url)->status_is(400) , $tm );

      $res = $ua->get($url)->result->json ; 
      my $emsg = "the branch-id bid url parameter should be a whole number" ; 
      ok ( $res->{'msg'} eq $emsg , $emsg) ;
   }


done_testing();

