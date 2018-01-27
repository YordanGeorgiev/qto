use strict ; use warnings ; 
package TestSetGetable ; 


use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../../../../../../lib" }
BEGIN { unshift @INC, "$FindBin::Bin/" }

use IssueTracker::App::Utils::Initiator ; 
use IssueTracker::App::Utils::OO::SetGetable ; 
use Test::More tests => 3 ; 
use Data::Printer ; 

use SetGetableChild ; 

my $m = () ;            # the msg for each test 
my $objSetGetableChild = 'SetGetableChild'->new();

$m = 'can create the SetGetableChild obj' ; 
ok ( defined ( $objSetGetableChild ) , "$m" );


$m = 'a child obj can set a value' ; 
my $val_to_set = 'foobar' ; 
$objSetGetableChild->set('val_to_set' , $val_to_set );
my $val_to_chk = $objSetGetableChild->get('val_to_set');
ok ( $val_to_chk eq $val_to_set , "$m" );

my @methods = ('get', 'set' , 'dumpFields' ); 
$m = 'a child obj can run the following methods ' . @methods ; 
can_ok($objSetGetableChild, @methods);

1;

