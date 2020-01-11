use strict ; use warnings ; 

use FindBin;
use Data::Printer ; 
use Test::Most ; 
use Test::Mojo;

die_on_fail;

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../qto/lib" }
   $ENV{'QTO_NO_AUTH'} = 1;

   my $tm         = '' ; # the test message for each test 
   my $emsg       = '' ; # the expected msg on the ui
   my $t          = Test::Mojo->new('Qto');
   $t->ua->max_redirects(10);
   my $config     = $t->app->config ; 
   my $db         = $config->{'env'}->{'db'}->{'postgres_db_name'} ; 
   my $tx         = {}  ; # the transaction object 
   my $url = '/' . $db . '/logon' ; 


   $t->get_ok($url)
      ->status_is(200) 
      ->header_is('Accept-Charset' => 'UTF-8')
      ->header_is('Accept-Language' => 'fi, en')
   ;
      #->content_like(qr/daily_issues/);

done_testing();
