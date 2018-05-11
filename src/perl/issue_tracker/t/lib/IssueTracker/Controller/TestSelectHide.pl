use strict ; use warnings ; 

use Test::More;
use Test::Mojo;
use Data::Printer ; 
use FindBin;

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../issue_tracker/lib" }

my $t = Test::Mojo->new('IssueTracker');

my $appConfig = $t->app->get('AppConfig') ; 

# if the product instance id dev -> dev_issue_tracker
# if the product instance id tst -> tst_issue_tracker
my $db_name       = $appConfig->{ 'postgres_db_name' } ; 
my @tables        = ( 'daily_issues' , 'weekly_issues' , 'monthly_issues' , 'yearly_issues' ) ; 
my $ua            = $t->ua ; 
my $res           = {} ; #a tmp result json string
my $tm            = '' ; 
my $url_params    = '' ; 
my $url           = '' ; 

$res = $ua->get('/' . $db_name . '/select-tables')->result->json ; 

# foreach table in the app db in test call db/select/table
for my $table ( @tables ) {

   # feature-guid: 95cdac3a-4a41-4c5b-9ba8-6f8134b0edc9
   $url_params = "?pick=name&hide=guid" ; 
   $url = "/$db_name" . '/select/' . $table . $url_params ; 
   $tm = "start test a response with only a single column pick for : $url" ; 
   $res = $ua->get($url )->result->json ; 
   ok ( $res->{'ret'} == 200 , $tm ) ; 	
  
#   # feature-guid: 95cdac3a-4a41-4c5b-9ba8-6f8134b0edc9 
#   print "\n start test a response with a select column pick" ; 
#   $url_params = "?pick=name,update_time" ; 
#   print "\n running url: /$db_name" . '/select/' . $table . $url_params . "\n" ; 	
#   $res = $ua->get('/' . $db_name . '/select/' . $table . $url_params )->result->json ; 
#   ok ( $res->{'ret'} == 200 ) ; 	
#   print "stop  test a response with a Select column pick" ; 
#  
#   # feature-guid: fd3e2d4e-99a1-4cd8-8ebe-bb47f9de9caf
#   print "\n start test a response with an inexisting column pick" ; 
#   $url_params = "?pick=non_existing_column" ; 
#   print "\n running url: /$db_name" . '/select/' . $table . $url_params . "\n" ; 	
#   $res = $ua->get('/' . $db_name . '/select/' . $table . $url_params )->result->json ; 
#   ok ( $res->{'msg'} eq "the non_existing_column column does not exist" ) ; 
#   ok ( $res->{'ret'} == 400 ) ; 	
#   print "\n start test a response with an inexisting column pick" ; 
} 
#eof foreach table


# fetch all the tables 
done_testing();
