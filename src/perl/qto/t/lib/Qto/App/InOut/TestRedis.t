package Qto::App::Utils::InOut::TestRedis ; 
use strict ; use warnings ; 

BEGIN { 
   use FindBin ; 
   unshift @INC, "$FindBin::Bin/../../../../../lib";
   unshift @INC, "$FindBin::Bin/../../../../../t/lib"; 
}

use Test::Most ; 
use Test::More ;
use Data::Printer ; 
use Test::Mojo ; 
use Qto::App::Db::Out::WtrRedis ; 
use Qto::App::Db::In::RdrRedis ; 

die_on_fail;

my $m = () ;            # the msg for each test 
my $t = Test::Mojo->new('Qto');
$t->ua->max_redirects(10);
my $config  = $t->app->config ; 

my $objRdrRedis = 'Qto::App::Db::In::RdrRedis'->new(\$config);
my $objWtrRedis = 'Qto::App::Db::Out::WtrRedis'->new(\$config);
$objWtrRedis->setData(\$config, 'config', $config);

my $expected_config = $objRdrRedis->getData(\$config,'config');

#$m = 'the saved config is the same as the initial config' ; 
is_deeply ($config,$expected_config);

done_testing();

1;

__END__
