use strict ; use warnings ; 
package Qto::App::Utils::OO::TestSetGetable ; 

BEGIN { 
   use FindBin ; 
   unshift @INC, "$FindBin::Bin/../../../../../../lib";
   unshift @INC, "$FindBin::Bin/../../../../../../t/lib"; 
}

use Test::Most ; 
use Test::Mojo;
use Test::More ;
use Data::Printer ; 

use Qto::App::Utils::OO::SetGetableChild ; 
use Qto::App::Utils::OO::SetGetable ; 

die_on_fail;

my $m = () ;            # the msg for each test 
my $objSetGetableChild = 'Qto::App::Utils::OO::SetGetableChild'->new();

$m = 'can create the SetGetableChild obj' ; 
ok ( defined ( $objSetGetableChild ) , "$m" );


$m = 'a child obj can set a value' ; 
my $val_to_set = 'something' ; 
$objSetGetableChild->set('val_to_set' , $val_to_set );
my $val_to_chk = $objSetGetableChild->get('val_to_set');
p $objSetGetableChild ; 
ok ( $val_to_chk eq $val_to_set , "$m" );

my @methods = ('get', 'set' , 'dumpFields' ); 
$m = 'a child obj can run the following methods ' . @methods ; 
can_ok($objSetGetableChild, @methods);


done_testing();

1;

__END__
