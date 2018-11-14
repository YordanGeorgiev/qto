use strict ; use warnings ; 

use Test::Most ; 
use Test::Mojo;
use Data::Printer ; 
use FindBin;

die_on_fail ; 

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

   # feature-guid: 2be978a7-1228-4502-9c5e-1c0bee8d2548
   $url_params = "?pick=name&hide=guid" ; 
   $url = "/$db_name" . '/select/' . $table . $url_params ; 
   $tm = "start test a response with only a single column hide for : $url" ; 
   $res = $ua->get($url )->result->json ; 
   ok ( $res->{'ret'} == 200 , $tm ) ; 	
  
   # feature-guid: 83fa6b81-544a-4d1c-b62b-c2628fbcc172
   $url_params = "?pick=name,description,prio&hide=guid,prio" ; 
   $url = "/$db_name" . '/select/' . $table . $url_params ; 
   $tm = "hide multiple columns as well for : $url" ; 
   $res = $ua->get($url )->result->json ; 
   ok ( $res->{'ret'} == 200 , $tm ) ; 	
 
   # feature-guid: be1b150f-c5c7-45a4-9160-a50242ebbc51
   $tm = "test a non_existent_column - "; 
   $url_params = "?pick=name,description,prio&hide=guid,prio,non_existent_column" ; 
   $url = "/$db_name" . '/select/' . $table . $url_params ; 
   $tm .= "url : $url" ; 
   $res = $ua->get($url )->result->json ; 
   #p $ua->get($url )->result->json ;
   #p $res ; 
   ok ( $res->{'ret'} == 404 , $tm ) ; 	
   $tm = "no data is retrieved for non-existent column to hide - url: $url" ; 
   ok ( $res->{'dat'} == undef , $tm ) ; 	
   $tm = "the client is informed for the non-existent column - url: $url" ; 
   ok ( $res->{'msg'} eq 'the non_existent_column column does not exist' , $tm ) ; 	

} 
#eof foreach table


# fetch all the tables 
done_testing();
