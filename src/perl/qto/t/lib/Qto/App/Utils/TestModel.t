use strict ; use warnings ; 

use FindBin; BEGIN { unshift @INC, "$FindBin::Bin/../../../../../lib" }
use Data::Printer ; 
use Test::More ;
use Test::Mojo ;

use Qto::App::Utils::Initiator ; 
use Qto::App::Utils::Logger ; 
use Qto::App::Ctrl::Dispatcher ; 
use Qto::App::Mdl::Model ; 

use Carp ; 

my $m          = 'the m' ; 
my $t          = Test::Mojo->new('Qto');
$t->ua->max_redirects(10);
my $config  = $t->app->config ; 
my $objModel               = 'Qto::App::Mdl::Model'->new ( \$config ) ; 

# 1.
# -----
$m = 'test that the objModel is created' ; 
ok ( ref($objModel) eq 'Qto::App::Mdl::Model' , $m ) ;

# 2.
# -----
$m = 'check that the config is passed correctly' ; 
my $chkAppConfig  = $objModel->get('config' ) ; 
ok ( $chkAppConfig == $config , $m ) ;

done_testing() ; 

1;
