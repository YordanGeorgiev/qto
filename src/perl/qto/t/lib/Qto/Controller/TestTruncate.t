use strict ; use warnings ; 

use Test::Most ; 
use Test::Mojo;
use Data::Printer ; 
use FindBin;
use Mojo::UserAgent;

die_on_fail ; 

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../qto/lib" }

   my $res           = {} ; # the result set for a call
   my $url           = {} ; 
   my $tm            = '' ; # the test message for each test 
   my $t             = Test::Mojo->new('Qto');
   my $config        = $t->app->config ; 
   my $exp_err_msg   = '' ; 
   my $db            = $config->{'env'}->{'db'}->{'postgres_db_name'} ; # OBS instance specific !!!
   my $ua            = $t->ua ; 
   my $objTimer      = {} ;
   my $env           = $config->{'env'}->{'run'}->{'ENV_TYPE' };
   
   $tm = 'the table is truncated' ; 
   $url = '/' . $db . '/truncate/test_truncate_table' ; 
   ok ( $t->get_ok($url )->status_is(200) , $tm ) ;

   # load some data first
   for ( my $id=1; $id <= 3; $id++ ){
      $url = '/' . $db . '/create/test_truncate_table' ; 
      ok ( $t->post_ok($url => json => {"id" =>$id})->status_is(200) , $tm );
      $url = '/' . $db . '/select/test_truncate_table?with=id-eq-' . $id ; 
      $tm = "the item with id: $id is in the table" ; 
      ok ( $t->get_ok($url )->status_is(200) , $tm ) ;
   }

   $tm = 'the table is truncated' ; 
   $url = '/' . $db . '/truncate/test_truncate_table' ; 
   ok ( $t->get_ok($url )->status_is(200) , $tm ) ;
   
   $tm = 'the table should be empty' ; 
   $url = '/' . $db . '/select/test_truncate_table';
   ok ( $t->get_ok($url )->status_is(204) , $tm ) ; # 204 - empty table
   
	my $table_name = 'non_existent_table' ; 
	$t->get_ok('/' . $db . '/truncate/' . $table_name)
		->status_is(400) 
	;
	$db = 'non_existent_db' ; 
	$t->get_ok('/' . $db . '/truncate/test_truncate_table')
		->status_is(400) 
	;
   
done_testing();
