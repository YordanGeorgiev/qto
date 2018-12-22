use strict ; use warnings ; 

use Test::Most ; 
use Test::Mojo;
use Data::Printer ; 
use FindBin;

die_on_fail ; 

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../issue_tracker/lib" }

   my $tm         = '' ;                                 # the test message for each test 
   my $ua         = {} ;                                 # the mojo user agent 
   my $dom        = {} ;                                 # the mojo dom parser 
   my $url        = {} ;                                 # the url to build for each test 
   my $exp_msg    = {} ;                                 # the expected text to check 
   my $response   = {} ; 
   my $t          = Test::Mojo->new('IssueTracker');
   my $appConfig  = $t->app->get('AppConfig') ; 
   my $db         = $appConfig->{ 'postgres_db_name' } ; 

	$t->get_ok('/' . $db . '/select-databases')->status_is(200) ; 
   $ua  = $t->ua ; 
   $response = $ua->get('/' . $db . '/select-tables')->result->json ; 
   my $list = $response->{ 'dat' } ; 
   my @tables_to_check = ( 'devops_guide' , 'userstories' ) ; 

   for my $row ( @$list ) {
      
      my $table_name = $row->{'table_name'} ; 
      next if $table_name =~ m/test_/g ; # skipping the testing tables
      next unless ( grep( /^$table_name$/, @tables_to_check ) ) ;

      $tm = 'the return code for the ' . $table_name . ' is correct' ; 
      $url = '/' . $db . '/view/' . $table_name  ; 
      ok ($t->get_ok($url)
         ->status_is(200), $tm);
#         ->header_is('Accept-Charset' => 'UTF-8')
#         ->header_is('Accept-Language' => 'fi, en'), $tm )

#      my $res = $ua->get($url)->result->json ; 
#
#      my $http_code = 200 ; 
#      $tm = "the http_code: $http_code is returned" ;  
#      ok ( $res->{'ret'} == $http_code , $tm) ; 
#      
#      my $cnt = 0 ; 
#      $tm = "the count: $cnt is returned" ;  
#      ok ( $res->{'cnt'} == $cnt , $tm) ; 
#
#      $tm = "an empty msg is returned if all ok" ; 
#      ok ( $res->{'msg'} eq "" , $tm) ; 
#
#      $tm = 'return 400 if non-integer is passed for the seq url parameter' ; 
#      $url = '/' . $db . '/view/' . $table_name . '?seq=non_integer' ; 
#      ok ($t->get_ok($url)->status_is(400) , $tm );
   }
done_testing();
