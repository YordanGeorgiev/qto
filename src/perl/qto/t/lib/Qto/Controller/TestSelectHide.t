use strict ; use warnings ; 

use Test::Most ; 
use Test::Mojo;
use Data::Printer ; 
use FindBin;

die_on_fail ; 

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../qto/lib" }
   $ENV{'QTO_NO_AUTH'} = 1;

my $t = Test::Mojo->new('Qto');

my $config = $t->app->config ; 

# if the product instance id dev -> dev_qto
# if the product instance id tst -> tst_qto
my $db       = $config->{'env'}->{'db'}->{ 'postgres_db_name' } ; 
use Qto::App::Utils::Timer ; 
my $objTimer = 'Qto::App::Utils::Timer'->new;
my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = $objTimer->GetTimeUnits(); 
my @tables  = ("monthly_issues_$year$mon" , "yearly_issues_$year" );
my $ua            = $t->ua ; 
my $res           = {} ; #a tmp result json string
my $tm            = '' ; 
my $url_params    = '' ; 
my $url           = '' ; 

$res = $ua->get('/' . $db . '/select-tables')->result->json ; 

for my $table ( @tables ) {

   # feature-guid: 2be978a7-1228-4502-9c5e-1c0bee8d2548
   $url_params = "?pick=name&hide=guid" ; 
   $url = "/$db" . '/select/' . $table . $url_params ; 
   $tm = "start test a response with only a single column hide for : $url" ; 
   $res = $ua->get($url )->result->json ; 
   # debug r $res ; 
   ok ( $res->{'ret'} == 200 , $tm ) ; 	
  
   # feature-guid: 83fa6b81-544a-4d1c-b62b-c2628fbcc172
   $url_params = "?pick=name,description,prio&hide=guid,prio" ; 
   $url = "/$db" . '/select/' . $table . $url_params ; 
   $tm = "hide multiple columns as well for : $url" ; 
   $res = $ua->get($url )->result->json ; 
   ok ( $res->{'ret'} == 200 , $tm ) ; 	
 
   # feature-guid: be1b150f-c5c7-45a4-9160-a50242ebbc51
   $tm = "test a non_existent_column - "; 
   $url_params = "?pick=name,description,prio&hide=guid,prio,non_existent_column" ; 
   $url = "/$db" . '/select/' . $table . $url_params ; 
   $tm .= "url : $url" ; 
   $res = $ua->get($url )->result->json ; 
   # debug r $ua->get($url )->result->json ;
   ok ( $res->{'ret'} == 400 , $tm ) ; 	
   $tm = "no data is retrieved for non-existent column to hide - url: $url" ; 
   ok ( scalar(@{$res->{'dat'}}) == 0 , $tm ) ; 	
   $tm = "the client is informed for the non-existent column - url: $url" ; 
   ok ( $res->{'msg'} eq 'the non_existent_column column does not exist' , $tm ) ; 	

} 
#eof foreach table


# fetch all the tables 
done_testing();
