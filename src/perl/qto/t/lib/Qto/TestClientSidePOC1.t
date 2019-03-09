use strict ; use warnings ; 
use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../../../../qto/lib" }

use Selenium::Remote::Driver;
 
my $driver = Selenium::Remote::Driver->new;
$driver->get('http://www.google.com');
print $driver->get_title();
$driver->quit();

done_testing();
