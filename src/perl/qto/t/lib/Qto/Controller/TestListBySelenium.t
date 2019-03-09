use strict ; use warnings ; 

use Data::Printer ; 
use FindBin;

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../qto/lib" }

use Selenium::Remote::Driver;
use Test::Mojo ; 
use Test::More ; 

my $tm = '' ; # the test message for each test 
my $t = Test::Mojo->new('Qto');


my $appConfig = $t->app->get('AppConfig') ; 
my $db_name= $appConfig->{ 'postgres_db_name' } or die 'cannot find db name !!!' ; 
my $ua = {} ;                                # the mojo user agent 
my $dom = {} ;                                # the mojo dom parser 
my $url = {} ;                                # the url to build for each test 
my $exp_txt = {} ;                            # the expected text to check 
my $response = {} ; 

my $driver = new Selenium::Remote::Driver('browser_name' => 'chrome',
                                              'platform' => 'Linux');

$ua  = $t->ua ; 
$response = $ua->get('/' . $db_name . '/select-tables')->result->json ; 
my $tables_list = $response->{ 'dat' } ; 

$tm = 'foreach table in the app db in test call <<db>>/list/<<table>>' ; 
for my $row ( @$tables_list ) {

   my $table_name = $row->{'table_name'} ; 
   my $url = '/' . $db_name . '/list/' . $table_name ; 
   $t->get_ok($url);   
   my $local_address = $appConfig->{'web_host'} ; 
   my $remote_port = $appConfig->{'mojo_morbo_port'} ; 
   $url = 'http://' . $local_address . ':' . $remote_port . $url ; 
   # print "url: $url \n" ;
   # ??? $url = 'http://' . $t->tx->remote_address . ':' . $t->tx->remote_port . '/' . $db_name . '/list/' . $table_name ; 
   $driver->navigate($url);

   # example: list tst_paging as grid in dev_qto
   $tm = 'page title is like: list <<item>> as grid in <<db-name>>: ' . $driver->get_title() ; 
   ok ($driver->get_title() eq 'list ' . $table_name . ' as grid in ' . $db_name , $tm );
} 
# eof foreach table

p $driver->get_sessions(); 

$driver->quit();

done_testing() ; 
