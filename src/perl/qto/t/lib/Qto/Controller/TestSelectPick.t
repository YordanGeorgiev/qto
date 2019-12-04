use strict ; use warnings ; 

use Test::Most ; 
use Test::Mojo;
use Data::Printer ; 
use FindBin;

die_on_fail ; 

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../qto/lib" }
   $ENV{'QTO_ONGOING_TEST'} = 1;

my $t = Test::Mojo->new('Qto');
#$t->get_ok('/')->status_is(200) ; 

my $config = $t->app->config ; 

# if the product instance id dev -> dev_qto
# if the product instance id tst -> tst_qto
my $db = $config->{'env'}->{'db'}->{'postgres_db_name'} ; 
my @tables = ( 'installations_doc' , 'requirements_doc' , 'devops_guide_doc' , 'userstories_doc' ) ; 
my @web_actions = ( 'select' , 'hiselect' ) ; 
my $ua = $t->ua ; 
my $res = {} ; #a tmp result json string
my $tm = '' ; 
my $url = '' ; 
my $url_params = '' ; 

$res = $ua->get('/' . $db . '/select-tables')->result->json ; 

for my $web_action ( @web_actions ) {
   # foreach table in the app db in test call db/select/table
   for my $table ( @tables ) {

      # feature-guid: 95cdac3a-4a41-4c5b-9ba8-6f8134b0edc9
      $tm = "start test a response with only a single column pick" ; 
      $url_params = "?pick=name" ; 
      $url ="/$db/$web_action/$table" . "$url_params"; 
      print "url: $url \n" ; 
      $res = $ua->get($url )->result->json ; 
      ok ( $res->{'ret'} == 200 , $tm ) ; 	
     
      # feature-guid: 95cdac3a-4a41-4c5b-9ba8-6f8134b0edc9 
      $tm = "start test a response with a select column pick" ; 
      $url_params = "?pick=name,update_time" ; 
      $url = '/' . $db . '/select/' . $table . $url_params ; 
      $res = $ua->get( $url )->result->json ; 
      ok ( $res->{'ret'} == 200 , $tm ) ; 	
     
      # feature-guid: fd3e2d4e-99a1-4cd8-8ebe-bb47f9de9caf
      $tm = "start test a response with an inexisting column pick" ; 
      $url_params = "?pick=non_existing_column" ; 
      $url ="/$db/$web_action/$table/$url_params"; 
      $res = $ua->get( $url )->result->json ; 
      ok ( $res->{'msg'} eq "the non_existing_column column does not exist" , $tm ) ; 

      $tm = "and the 400 http code is returned " ; 
      ok ( $res->{'ret'} == 400 , $tm ) ; 	
   } 
#eof foreach table
} 
#eof web_action


# fetch all the tables 
done_testing();
