use strict ; use warnings ; 
use Test::Most ; 
use Test::Mojo;
use Data::Printer ; 
use FindBin;

die_on_fail ; 

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../qto/lib" }

my $t = Test::Mojo->new('Qto');
#$t->get_ok('/')->status_is(200) ; 

my $config = $t->app->get('AppConfig') ; 

# if the product instance id dev -> dev_qto
# if the product instance id tst -> tst_qto
my $db = $config->{'env'}->{'db'}->{'postgres_db_name'} ; 
my @tables = ( 'daily_issues' , 'weekly_issues' , 'monthly_issues' , 'yearly_issues' ) ; 
my $ua  = $t->ua ; 
my $res = {} ; #a tmp result json string
my $tm = '' ; 
my $url_params = '' ; 
my $url = '' ; 

$res = $ua->get('/' . $db . '/select-tables')->result->json ; 
my $hsr2 = $res->{ 'dat' } ; 

# foreach table in the app db in test call db/select/table
for my $table ( @tables ) {

   
   # feature-guid: 95cdac3a-4a41-4c5b-9ba8-6f8134b0edc9
   $tm = "single column pick - " ; 
   $url_params = "?pick=name&o=name" ; 
   $url = '/' . $db . '/select/' . $table . $url_params ; 
   $tm .= "url: $url " ; 
   $res = $ua->get( $url )->result->json ; 
   ok ( $res->{'ret'} == 200 , $tm ) ; 	
  
   # feature-guid: 95cdac3a-4a41-4c5b-9ba8-6f8134b0edc9 
   $tm = "single column order by - " ; 
   $url_params = "?pick=name,prio,update_time&o=prio" ; 
   $url = '/' . $db . '/select/' . $table . $url_params ; 
   $tm .= "url: $url " ; 
   $res = $ua->get($url)->result->json ; 
   ok ( $res->{'ret'} == 200 , $tm ) ; 	
  
   # feature-guid: fd3e2d4e-99a1-4cd8-8ebe-bb47f9de9caf
   $tm = "unexisting column pick - " ; 
   $url_params = "?pick=non_existing_column" ; 
   $url = '/' . $db . '/select/' . $table . $url_params ; 
   $tm .= "url: $url" ; 
   $res = $ua->get($url)->result->json ; 
   ok ( $res->{'msg'} eq "the non_existing_column column does not exist" , $tm ) ; 
   $tm = "and the response code is 400. \nstop table $table" ; 
   ok ( $res->{'ret'} == 400 , $tm ) ; 	
} 
#eof foreach table


# fetch all the tables 
done_testing();
