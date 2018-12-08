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

   $url = '/' . $db . '/view/monthly_issues' ; 

   $tm = ' the content type is text/html and the charset is utf-8' ; 
   ok ( $t->get_ok($url)->content_type_is('text/html;charset=UTF-8') , $tm ) ; 

done_testing();
