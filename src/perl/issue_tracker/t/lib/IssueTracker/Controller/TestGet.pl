use Test::More;
use Test::Mojo;

my $t = Test::Mojo->new('IssueTracker');

# HTML/XML
$t->get_ok('/')->status_is(200)->text_is('div#message' => 'Hello!');


done_testing();
