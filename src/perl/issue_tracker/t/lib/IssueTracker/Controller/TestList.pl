use Test::More;
use Test::Mojo;

use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../../../../../issue_tracker/lib" }
my $t = Test::Mojo->new('IssueTracker');

# HTML/XML
$t->get_ok('/')->status_is(200) ; 

# JSON
$t->get_ok('/dev_issue_tracker/list/monthly_issues')
  ->status_is(200) 
  ->header_is('Accept-Charset' => 'UTF-8')
  ->header_is('Accept-Language' => 'fi, en')
;

done_testing();
