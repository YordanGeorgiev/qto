use strict ; use warnings ; 
use Test::Most ; 
use Test::Mojo;
use Data::Printer ; 
use FindBin;

die_on_fail;

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../issue_tracker/lib" }

   my $tm            = '' ; # the test message for each test 
   my $t             = Test::Mojo->new('IssueTracker');
   my $appConfig     = $t->app->get('AppConfig') ; 
   my $db            = $appConfig->{ 'postgres_db_name' } ; 

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


   my $ua  = $t->ua ; 
   my $response = $ua->get('/' . $db . '/select-tables')->result->json ; 
   my $list = $response->{ 'dat' } ; 
   my @tables_to_check = ( 'devops_guide' , 'userstories' ) ; 

   for my $row ( @$list ) {
      
      my $table_name = $row->{'table_name'} ; 
      next if $table_name =~ m/test_/g ; # skipping the testing tables
      next unless ( grep( /^$table_name$/, @tables_to_check ) ) ;

      $tm = 'the return code for the ' . $table_name . ' is correct' ; 
      $url = '/' . $db . '/hselect/' . $table_name  . '?bid=0&with=description-like-name' ; 
      
      ok ($t->get_ok($url)
         ->status_is(200) 
         ->header_is('Accept-Charset' => 'UTF-8')
         ->header_is('Accept-Language' => 'fi, en'), $tm );

      my $res = $ua->get($url)->result->json ; 

      my $http_code = 200 ; 
      $tm = "the http_code: $http_code is returned" ;  
      ok ( $res->{'ret'} == $http_code , $tm) ; 
      foreach my $row ( @{$res->{'dat'}} ) {
         my $desc = $row->{ 'description' } ; 
         if ( defined $desc ) {
            my $tm = 'if a description is filtered it contains the "name" string' ; 
            ok ( $desc =~ m/name/g , $tm );
         }
      }



      $url = '/' . $db . '/hselect/' . $table_name  . '?bid=0&with=level-in-1,2' ; 
      
      ok ($t->get_ok($url)
         ->status_is(200) 
         ->header_is('Accept-Charset' => 'UTF-8')
         ->header_is('Accept-Language' => 'fi, en'), $tm );

      $res = $ua->get($url)->result->json ; 

      $http_code = 200 ; 
      $tm = "the http_code: $http_code is returned" ;  
      ok ( $res->{'ret'} == $http_code , $tm) ; 
      foreach my $row ( @{$res->{'dat'}} ) {
         my $level = $row->{ 'level' } ; 
         if ( defined $level ) {
            my $tm = 'ensure the level is smaller than 3' ; 
            ok ( $level < 3 , $tm );
         }
      }


   }

# start the hierarchy testing table 
$tm = 'the status code from the test_hierarchy_table is 200' ; 
$url = '/' . $db . '/hselect/test_hierarchy_table?bid=0' ; 
ok ($t->get_ok($url)
   ->status_is(200) 
   ->header_is('Accept-Charset' => 'UTF-8')
   ->header_is('Accept-Language' => 'fi, en'), $tm );

my $res = $ua->get($url)->result->json ; 

my $http_code = 200 ; 
$tm = "the http_code: $http_code is returned" ;  
ok ( $res->{'ret'} == $http_code , $tm) ; 
# stop  the hierarchy testing table 

done_testing();

