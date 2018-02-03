use strict ; use warnings ; 

use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../../../../../lib" }
BEGIN { unshift @INC, "$FindBin::Bin/../lib" }

use Test::More tests => 7 ;

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

# test-01
# -----
$msg = ' test-01 :: if the level column is not available the converter should exit with 1' ; 
is( $trap->exit, 1, $msg );

# test-02
# -----
$msg = ' test-02 :: if exitting with error, the proper error msg should be issued' ; 
is( $trap->stdout, ' the level for row id 0 was not defined !!!', $msg ) ; 

# 3.
# -----
$msg = ' test-03 :: if the first row level is not 0 it should exit with ret 1' ; 

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

@trap = trap {
   ( $ret , $m , $hsr2_out ) = $objCnrXlsHsr3ToDbHsr3->doConvert ( $hsr2_in ) ; 
   print $m ; exit $ret  ; 
   };

is( $trap->exit, 1, $msg );


# test-04
# -----
$msg = ' test-04 :: if the root element level is 0 => lft should be 1 and rgt = 2 ' ; 
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

( $ret , $m , $hsr2_out ) = $objCnrXlsHsr3ToDbHsr3->doConvert ( $hsr2_in ) ; 

$hsr2_exp = { 
0 => {
   'id'     => 'id' , 
   'level'  => "level",
   'lft'    => 'lft' , 
   'rgt'    => 'rgt'  ,
   'name'   => "name"
   },
1 => {
   'id'     => 1 , 
   'level'  => 0 ,
   'lft'    => 1 , 
   'rgt'    => 2 ,
   'name'   => "the name"
   }
};

is_deeply( $hsr2_out , $hsr2_exp , $msg ) ;

# test-05
# -----
$msg = ' test-05 :: if the second element does not have a level of 1 should exit with 1' ; 

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
   },
2 => {
   'id'     => 1 , 
   'name'   => "the name",
   'level'  => 2
   }
};

@trap = trap {
   ( $ret , $m , $hsr2_out ) = $objCnrXlsHsr3ToDbHsr3->doConvert ( $hsr2_in ) ; 
   print $m ; exit $ret  ; 
   };
is( $trap->exit, 1, $msg );

# test-06
# -----
$msg = ' test-06 :: if the second element has a level of 1 lft => 3 , right = 4' ; 


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
   },
2 => {
   'id'     => 2 , 
   'name'   => "the name",
   'level'  => 1
   }
};


   ( $ret , $m , $hsr2_out ) = $objCnrXlsHsr3ToDbHsr3->doConvert ( $hsr2_in ) ; 

$hsr2_exp = { 
0 => {
   'id'     => 'id' , 
   'lft'    => 'lft' , 
   'rgt'    => 'rgt' ,
   'level'  => "level",
   'name'   => "name" 
   },
1 => {
   'id'     => 1 , 
   'level'  => 0 ,
   'lft'    => 1 , 
   'rgt'    => 4 ,
   'name'   => "the name" ,
   } ,
2 => {
   'id'     => 2 , 
   'level'  => 1 ,
   'lft'    => 2 , 
   'rgt'    => 3 ,
   'name'   => "the name" ,
   }
};

# ok (1==1, 'fake' )  ; 
is_deeply( $hsr2_out , $hsr2_exp , $msg ) ;


# test-07
# -----
$msg = ' test-07 :: add element on the same level having already sibling element' ; 

$hsr2_in = { 
0 => {
   'id'     => 'id' , 
   'name'   => "name",
   'level'  => "level"
   }
, 1 => {
   'id'     => 1 , 
   'name'   => "the name-01",
   'level'  => 0
   },
, 2 => {
   'id'     => 2 , 
   'name'   => "the name-02",
   'level'  => 1
   }
, 3 => {
   'id'     => 3 , 
   'name'   => "the name-03",
   'level'  => 1
   }
};


( $ret , $m , $hsr2_out ) = $objCnrXlsHsr3ToDbHsr3->doConvert ( $hsr2_in ) ; 

$hsr2_exp = { 
0 => {
   'id'     => 'id' , 
   'lft'    => 'lft' , 
   'rgt'    => 'rgt' ,
   'level'  => "level",
   'name'   => "name" 
   }
, 1 => {
   'id'     => 1 , 
   'level'  => 0 ,
   'lft'    => 1 , 
   'rgt'    => 6 ,
   'name'   => "the name-01" ,
   }
, 2 => {
   'id'     => 2 , 
   'level'  => 1 ,
   'lft'    => 2 , 
   'rgt'    => 3 ,
   'name'   => "the name-02" ,
   }
, 3 => {
   'id'     => 3 , 
   'level'  => 1 ,
   'lft'    => 4 , 
   'rgt'    => 5 ,
   'name'   => "the name-03" ,
   }
};

# ok (1==1, 'fake' )  ; 
is_deeply( $hsr2_out , $hsr2_exp , $msg ) ;












