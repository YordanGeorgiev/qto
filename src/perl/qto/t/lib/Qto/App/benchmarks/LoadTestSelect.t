use strict ; use warnings ; 
use Test::Most; 
use Test::Mojo;
use Data::Printer ; 
use FindBin;

die_on_fail ; 

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../../qto/lib" }

   my $tm = '' ; # the test message for each test 
   my $t = Test::Mojo->new('Qto');
   my $config = $t->app->get('AppConfig') ; 
   # if the product instance id tst -> tst_qto
   my $db_name= $config->{ 'postgres_db_name' } ; 
   my $url = '/' . $db_name . '/select-tables' ; 

   $t->get_ok($url)
      ->status_is(200) 
      ->header_is('Accept-Charset' => 'UTF-8')
      ->header_is('Accept-Language' => 'fi, en')
      ->content_like(qr/daily_issues/);
   ;

   my $ua  = $t->ua ; 

use Mojo::IOLoop;

my $d = Mojo::IOLoop->delay(sub {  print 'finish' });

my @uas;

print "perform 500 asyncronous $url GET requests \n" ; 
# for 550 the following error occurs:
# Mojo::Reactor::EV: Timer failed: Handle is closed at /usr/local/share/perl/5.26.0/Mojo/IOLoop/Client.pm line 180.
for (0 .. 500) {
  # debug print "get $url run-". "$_" . "\n" ; 
  push @uas, my $ua = $t->ua ;
  $ua->get($url => $d->begin);
  $ua->get('/' . $db_name . '/select-tables' => $d->begin );
}

$d->wait;


# fetch all the tables 
done_testing();

# feature-guid: ecd424d7-e5bd-45f1-90c8-10fae1316bf9
