use strict ; use warnings ; 

use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../../../../../lib" }
BEGIN { unshift @INC, "$FindBin::Bin/../lib" }

use Test::More tests => 4 ; 

use Getopt::Long;
use Data::Printer ; 
use Test::Trap;

use IssueTracker::App::Utils::Initiator ; 
use IssueTracker::App::Utils::Logger ; 
use IssueTracker::App::Utils::Configurator ; 
use IssueTracker::App::Cnvr::CnrXlsHsr3ToDbHsr3 ; 
# chdir

my $objInitiator 				= 'IssueTracker::App::Utils::Initiator'->new(4);	
my $appConfig					= {} ;
$appConfig                 = $objInitiator->get('AppConfig');
my $objConfigurator
   = 'IssueTracker::App::Utils::Configurator'->new($objInitiator->{'ConfFile'},
    \$appConfig);
$appConfig           = $objConfigurator->getConfHolder()  ;

my $objCnrXlsHsr3ToDbHsr3 = 
   'IssueTracker::App::Cnvr::CnrXlsHsr3ToDbHsr3'->new ( \$appConfig ) ; 

my $hsr_in     = {} ; 
my $hsr_out    = {} ; 
my $msg        = '' ; 
my $ret        = 1 ; 
my $hsr2_in    = {} ; 
my $hsr2_out    = {} ; 
my $hsr2_exp = {} ; 
my $m = {} ; 


$msg = ' ensure that the converter should exit if the level column is not available' ; 
$hsr2_in = { 
0 => {
   'id' => 'id' , 
   'name' => "name"
   },
1 => {
   'id' => '1' , 
   'name' => "the name"
   }
};
# src: http://search.cpan.org/~ebhanssen/Test-Trap-v0.3.3/lib/Test/Trap.pm
my @trap = trap {
   ( $ret , $m , $hsr2_out ) = $objCnrXlsHsr3ToDbHsr3->doConvert ( $hsr2_in ) ; 
   print $m ; exit $ret  ; 
   };

# 1.
# -----
is( $trap->exit, 1, 'Expecting &some_code to exit with 1' );


# 2.
# -----
is( $trap->stdout, 'the root element should have always level = 0', 'Expect the proper error msg' );

$hsr2_in = { 
0 => {
   'id' => 'id' , 
   'name' => "name" ,
   'level' => "level"
   },
1 => {
   'id' => '1' , 
   'name' => "the name",
   }
};


$hsr2_exp = { 
0 => {
   'id'     => 'id' , 
   'lft'    => 'lft' , 
   'rgt'    => 'rgt' ,
   'level' => "level",
   'name'   => "name" 
   },
1 => {
   'id'     => '1' , 
   'lft'    => '1' , 
   'rgt'    => '2' ,
   'name'   => "the name" ,
   'level' => 1 
   }
};

( $ret , $msg , $hsr2_out ) = $objCnrXlsHsr3ToDbHsr3->doConvert ( $hsr2_in ) ; 
@trap = trap {
   ( $ret , $m , $hsr2_out ) = $objCnrXlsHsr3ToDbHsr3->doConvert ( $hsr2_in ) ; 
   print $m ; exit $ret  ; 
   };

# 3.
# -----
is( $trap->exit, 1, 'Expecting &some_code to exit with 1' );


$msg = ' if the first row level is not 0 it should exit ' ; 
$hsr2_in = { 
0 => {
   'id'     => 'id' , 
   'name'   => "name",
   'level'  => "level"
   },
1 => {
   'id'     => 1 , 
   'name'   => "the name",
   'level'  => 0
   }
};

( $ret , $msg , $hsr2_out ) = $objCnrXlsHsr3ToDbHsr3->doConvert ( $hsr2_in ) ; 

$hsr2_exp = { 
0 => {
   'id'     => 'id' , 
   'lft'    => 'lft' , 
   'name'   => "name",
   'level'  => "level",
   'rgt'    => 'rgt' 
   },
1 => {
   'id'     => 1 , 
   'lft'    => 1 , 
   'name'   => "the name",
   'level'  => 0 ,
   'rgt'    => 2 
   }
};

# 4.
# -----
is_deeply( $hsr2_out , $hsr2_exp , $msg ) ;






















