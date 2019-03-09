use strict ; use warnings ; 

use Test::More;
use Test::Mojo;
use Data::Printer ; 
use FindBin;

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../qto/lib" }


use Data::Dumper;
use Test::More ; 

use_ok 'Selenium::Remote::Driver';
foreach (qw( chrome)){
  note $_;

  my $driver = new_ok('Selenium::Remote::Driver' => [ 
      'browser_name' => $_, 
      'platform' => 'linux',
      'proxy' =>{ 'proxyType' => 'direct'}]);

  my $url = 'http://localhost:3000/dev_qto/select-tables' ; 
  ok $driver->get($url);
  is $driver->get_title(), 'select-tables';
  $driver->quit();
}

done_testing();
