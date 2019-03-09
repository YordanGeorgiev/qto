use strict ; use warnings ; 

use Data::Printer ; 
use FindBin;

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../qto/lib" }

use Mojo::Base -strict;
use Test::Mojo ; 
use Test::More ; 
use Mojo::Base -strict;

my $tm = '' ; # the test msg
$ENV{MOJO_SELENIUM_BASE_URL} ||= 'http://192.168.56.120:3001';
$ENV{'TEST_SELENIUM'} = 1 ;
#$ENV{MOJO_SELENIUM_DRIVER}   ||= 'Selenium::Chrome';
#$ENV{MOJO_SELENIUM_DRIVER} ||= 'Selenium::Remote::Driver' ; 
  
my $t = Test::Mojo->with_roles("+Selenium")->new("Qto")->setup_or_skip_all ; 

$ENV{MOJO_SELENIUM_DRIVER} ||= 'Selenium::Remote::Driver&browser_name=chromium&port=4444' ; 
#$ENV{MOJO_SELENIUM_BASE_URL} ||= 'http://192.168.56.120:3001';
#my $t = Test::Mojo->with_roles("+Selenium")->new->setup_or_skip_all;

# All the standard Test::Mojo methods are available
$tm = "A Test::Mojo instance can be created " ; 
ok ($t->isa("Test::Mojo"), $tm );

$tm = "A Test::Mojo::Role::Selenium role can be executed" ; 
ok ($t->does("Test::Mojo::Role::Selenium"),$tm );

my $url = 'http://192.168.56.120:3001/dev_qto/list/monthly_issues?as=grid' ; 
$t->navigate_ok("$url"); 

$tm = "The '☰' char is used for the open right menu " ; 
$url = 'http://192.168.56.120:3001/dev_qto/view/test_hierarchy_table'  ; 
ok (
   $t->navigate_ok("$url")
      ->live_text_is('div#div_open_rgt_menu' => '☰') , $tm );


ok (
   $t->navigate_ok("$url")
      ->live_text_is('div#lft_body' => '☰') , $tm );
$t->element_is_displayed("div");

my $dom = Mojo::DOM->new($t->ua->get($url)->wait_for(1)->result->body) ; 
#p $dom->find('div')->join("\nSTOP  div \n\nSTART div \n")->say ;

my $tm = 'the view->test_hierarchy_table page should containt 4 scripts elements' ; 
ok ( @{$dom->find('script')->to_array} == 4 , $tm );

foreach my $e ( @{$dom->find('h3')} ) { p $e->to_string ; p $e->content ; p $e->text ;} ; 

$tm = 'the view->test_hierarchy_table page should have more than 0 h3 titles' ; 
ok ( @{$dom->find('h3')->to_array} > 0 , $tm );


done_testing();
      
