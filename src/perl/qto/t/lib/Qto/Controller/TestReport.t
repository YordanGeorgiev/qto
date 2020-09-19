use strict ; use warnings ; 

use FindBin;
use Data::Printer ; 
use Test::Most ; 
use Test::Mojo;
use Test::More;
use Test::Mojo::WithRoles qw/Phantom/;

die_on_fail;
   $ENV{'QTO_NO_AUTH'} = 1;

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../qto/lib" }

   my $tm      = '' ; # the test message for each test 
   my $t       = Test::Mojo->new('Qto');
   my $ua      = $t->ua ; # the user agent , aka http client
   my $config  = $t->app->config ; 
   my $db      = $config->{'env'}->{'db'}->{ 'postgres_app_db' } ; 
   my $url     = '/' . $db . '/Report?for=' ; 

   $tm = "not at all for Report param specified, presents blank Report" ; 
   ok ( $t->get_ok($url)->status_is(200) , $tm ) ;
  
   $tm = 'not at all for Report param specified - a blank Report page is presented' ; 
   $url = '/' . $db . '/Report' ; 
   ok ( $t->get_ok($url)->status_is(200) , $tm ) ;

   $tm = 'some foo Report param is specified ' ; 
   $url = '/' . $db . '/Report?for=meta-data' ; 
   ok ( $t->get_ok($url)->status_is(200) , $tm ) ;
   
  
   # this requires client side testing capability
   #$tm = 'the query text is added to the Report box' ; 
   #my $dom = Mojo::DOM->new($t->ua->get($url)->result->body) ; 
   #ok ( $dom->at('#inp_srch_box')->text == 'meta-data' );

 
 
# but 
# Can't call method "server" on an undefined value at
# /home/ysg/perl5/lib/perl5/Mojo/Server/Daemon.pm line 55
# error is issues ?!
#my $ti = Test::Mojo::WithRoles->new;
#$ti->phantom_ok($url => <<'JS');
#	  var text = page.evaluate(function(){
#		 return document.getElementById('inp_srch_box').innerHTML;
#	  });
#	  perl.is(text, 'meta-data', 'the srch box exists and it is populated');
#JS


   $tm = 'can find the Report-box ' ; 
   $url = '/' . $db . '/Report' ; 
   ok ( $t->get_ok($url)->status_is(200) , $tm ) ;


done_testing();
