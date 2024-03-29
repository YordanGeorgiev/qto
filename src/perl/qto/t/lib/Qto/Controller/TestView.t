use strict ; use warnings ; 

use Test::Most ; 
use Test::Mojo;
use Data::Printer ; 
use FindBin;

die_on_fail ; 
   $ENV{'QTO_NO_AUTH'} = 1;

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../qto/lib" }

   my $tm         = '' ;                   # the test message for each test 
   my $ua         = {} ;                   # the mojo user agent 
   my $dom        = {} ;                   # the mojo dom parser 
   my $url        = {} ;                   # the url to build for each test 
   my $exp_msg    = {} ;                   # the expected text to check 
   my $response   = {} ; 
   my $t          = Test::Mojo->new('Qto');
   my $config     = $t->app->config ; 
   my $db         = $config->{'env'}->{'db'}->{ 'postgres_app_db' } ; 

	$t->get_ok('/' . $db . '/select-databases')->status_is(200) ; 
   $ua  = $t->ua ; 
   $response = $ua->get('/' . $db . '/select-tables')->result->json ; 
   my $list = $response->{ 'dat' } ; 
   my @tables_to_check = ( 'devops_guide' , 'userstories' ) ; 

   for my $row ( @$list ) {
      
      my $table_name = $row->{'table_name'} ; 
      next if $table_name =~ m/test_/g ; # skipping the testing tables
      next unless ( grep( /^$table_name$/, @tables_to_check ) ) ;

      $tm = 'the return code for the ' . $table_name . ' is 200 ' ; 
      $url = '/' . $db . '/view/' . $table_name  ; 
      ok ($t->get_ok($url)
         ->status_is(200, $tm)
         ->header_is('Accept-Charset' => 'UTF-8')
         ->header_is('Accept-Language' => 'fi, en'), $tm );

      $dom = Mojo::DOM->new($t->ua->get($url)->result->body) ; 
      #p $dom->find('div')->join("\nSTOP  div \n\nSTART div \n")->say ;

      $tm = 'the view->' . $table_name . ' page should containt 4 scripts elements' ; 
      ok ( @{$dom->find('script')->to_array} == 4 , $tm );

      $tm = 'the view->' . $table_name . ' page should have more than 0 h3 titles' ; 
      ok ( @{$dom->find('h3')->to_array} > 0 , $tm );

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
