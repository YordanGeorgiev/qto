use strict ; use warnings ; 

use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../lib" }
use Data::Printer ; 

use Test::More tests => 6 ; 
use Qto::App::Utils::Initiator ; 
use Qto::App::Utils::Logger ; 
use Qto::App::Utils::Configurator ; 
use Qto::App::Ctrl::Dispatcher ; 
use Qto::App::Mdl::Model ; 

use Carp ; 
my $m = 'the qto calling shell needs always a set of pre-defined env vars,
thus you need to define your issue tracker project by :
doParseCnfEnvVars <<path-to-your-qto-projects-cnf-files>>/<<qto-cnf-file>>
for example:
doParseCnfEnvVars /vagrant/var/csitea/cnf/projects/qto/ysg-issues.dev.host-name.cnf'  ; 
croak $m unless ( defined ( $ENV{ "qto_project" } )) ; 

my $msg = ();
my $objInitiator 				= 'Qto::App::Utils::Initiator'->new();	
my $appConfig					= {} ;

$appConfig                 = $objInitiator->get('AppConfig');

my  $objConfigurator
    = 'Qto::App::Utils::Configurator'->new($objInitiator->{'ConfFile'},
    \$appConfig);

$appConfig                 = $objConfigurator->getConfHolder()  ;

my $objModel             = 'Qto::App::Mdl::Model'->new ( \$appConfig ) ; 

# 1.
# -----
$msg = 'test that the objModel is created' ; 
ok ( ref($objModel) eq 'Qto::App::Mdl::Model' , $msg ) ;

# 2.
# -----
$msg = 'check that the appConfig is passed correctly' ; 
my $chkAppConfig  = $objModel->get('appConfig' ) ; 
ok ( $chkAppConfig == $appConfig , $msg ) ;


