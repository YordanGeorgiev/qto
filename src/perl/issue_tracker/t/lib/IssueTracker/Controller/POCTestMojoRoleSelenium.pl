use strict ; use warnings ; 

use Data::Printer ; 
use FindBin;

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../issue_tracker/lib" }

use Mojo::Base -strict;
use Test::Mojo ; 

$ENV{MOJO_SELENIUM_DRIVER} ||= 'Selenium::Chrome';


my $t = Test::Mojo->with_roles("+Selenium")->new("IssueTracker")->setup_or_skip_all;

# All the standard Test::Mojo methods are available
ok $t->isa("Test::Mojo");
ok $t->does("Test::Mojo::Role::Selenium");

my $url = '/dev_issue_tracker/list/monthly_issues?as=table&pick=id,status,prio,name,weight,start_time,stop_time&page-size=20&o=prio' ; 
$t->navigate_ok("$url")
#  ->status_is(200) 
; 

done_testing();
