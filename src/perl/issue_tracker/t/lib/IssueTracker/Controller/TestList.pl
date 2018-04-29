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


# src: https://restfulapi.net/http-status-codes/
#400 (Bad Request)
#400 is the generic client-side error status, used when no other 4xx error code is appropriate. Errors can be like malformed request syntax, invalid request message parameters, or deceptive request routing etc.
#
#The client SHOULD NOT repeat the request without modifications.


# fetch all the tables 
done_testing();
