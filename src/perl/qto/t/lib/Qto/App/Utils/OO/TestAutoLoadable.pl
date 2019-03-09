use strict ; use warnings ; 
package TestAutoLoadable ; 


use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../../../../../../lib" }
BEGIN { unshift @INC, "$FindBin::Bin/" }

use Qto::App::Utils::Initiator ; 
use Qto::App::Utils::OO::AutoLoadable ; 
use Test::More tests => 2 ; 
use Data::Printer ; 

use AutoLoadableChild ; 

my $m = () ;            # the msg for each test 
my $objAutoLoadableChild = 'AutoLoadableChild'->new();

$m = 'can create the AutoLoadableChild obj' ; 
ok ( defined ( $objAutoLoadableChild ) , "$m" );


my @methods = ('AUTOLOAD');
$m = 'a child obj can run the following methods ' . @methods ; 
can_ok($objAutoLoadableChild, @methods);

1;

