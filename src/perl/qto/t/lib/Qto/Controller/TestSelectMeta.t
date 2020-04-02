use strict ; use warnings ; 
use Test::Most ; 
use Test::Mojo;
use Data::Printer ; 
use FindBin;

die_on_fail;
   $ENV{'QTO_NO_AUTH'} = 1 ;

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../qto/lib" }

   my $tm = '' ; # the test message for each test 
   my $t = Test::Mojo->new('Qto');
   my $config = $t->app->config ; 
   # if the product instance id tst -> tst_qto
   my $db = $config->{'env'}->{'db'}->{ 'postgres_db_name' } ; 
	$t->get_ok('/' . $db . '/select-databases')->status_is(200) ; 

   my $url = '/' . $db . '/select-item-meta-for' ; 
   my $env = $config->{'env'}->{'ENV_TYPE'};


   $t->get_ok($url)
      ->status_is(200) 
      ->header_is('Accept-Charset' => 'UTF-8')
      ->header_is('Accept-Language' => 'fi, en')
   ;


done_testing();

# feature-guid: ecd424d7-e5bd-45f1-90c8-10fae1316bf9
