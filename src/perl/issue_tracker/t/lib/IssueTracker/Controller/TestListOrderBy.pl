use strict ; use warnings ; 

use Test::More;
use Test::Mojo;
use Data::Printer ; 
use FindBin;

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../issue_tracker/lib" }

   my $tm = '' ; # the test message for each test 
   my $t = Test::Mojo->new('IssueTracker');
   my $appConfig = $t->app->get('AppConfig') ; 
   my $db_name= $appConfig->{ 'postgres_db_name' } ; 
  
   $tm = ' the error msg should be diplayed in the err_msg label of the page ' ; 
   my $url = '/' . $db_name . '/list/monthly_issues?as=lbs&pick=id&o=id' ; 
   my $dom = Mojo::DOM->new($t->ua->get($url)->result->body); 
   my $exp_txt = 'cannot connect to the "non_existent_db" database: FATAL:  database "non_existent_db" does not exist' ; 
   # p $dom->find('div.rgt_lbl') ; 

   # to use mojo::chrome
   # https://github.com/jberger/Mojo-Chrome
#   my $url = '/' . $db_name . '/list/monthly_issues?as=lbs&pick=id,status&o=non_existing_column' ; 
#   $tm = ' on wrong col to order by the error msg should be diplayed in the err_msg label msg ' ; 
#   my $dom = Mojo::DOM->new($t->ua->get($url)->result->body); 
#   my $exp_txt = 'the non_existing_column column does not exist'; 
#   ok ( $dom->at('#spn_err_msg')->text eq $exp_txt , $tm ) ; 
#   ; 



done_testing();

