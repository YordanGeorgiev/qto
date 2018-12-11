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
  
   # p $t->ua->get($url)->result->body ; 
   # this needs to be asyncrounous with using client code as well ...
   my $ProductType = $appConfig->{ 'ProductType' } ; 
   my $db_name= $appConfig->{ 'postgres_db_name' } ; 
   $tm = "the app label contains the product_type of this product instance: $ProductType " ; 
   $url = '/' . $db_name . '/list/monthly_issues?as=cloud' ; 
   $dom = Mojo::DOM->new($t->ua->get($url)->result->body) ; 
   ok ( $dom->find('div')->[1] =~ m/$ProductType/ , $tm ) ;


   my $GitShortHash = $appConfig->{ 'GitShortHash' } ; 
   $tm = "the app label contains the short git hash of this product instance: $GitShortHash" ; 
   ok ( $dom->find('div')->[1] =~ m/$GitShortHash/ , $tm ) ;
   
   my $ProductVersion = $appConfig->{ 'ProductVersion' } ; 
   $tm = "the app label contains the product version of this product instance: $ProductVersion " ; 
   ok ( $dom->find('div')->[1] =~ m/$ProductVersion/ , $tm ) ;
   #my $id = $dom->find('span')->[0] ; 
   #ok ( $dom->at('html body div span#spn_err_msg')->text eq $exp_txt , $tm ) ; 


done_testing();

