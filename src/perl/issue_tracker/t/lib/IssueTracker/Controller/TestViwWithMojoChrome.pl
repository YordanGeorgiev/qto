use strict ; use warnings ; 

# all of the tests are slightly adapted versions of the 
# https://github.com/jberger/Mojo-Chrome proj
use Data::Printer ; 
use FindBin;
use Mojo::Base -strict;
use Test::More;
use Test::Mojo ; 
use Mojo::IOLoop;

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../issue_tracker/lib" }
use Mojo::Chrome;

binmode(STDOUT, ":utf8");
$|++;

no warnings 'redefine';

my $url = 'http://127.0.0.1:3001/dev_issue_tracker/view/test_hierarchy_table' ; 
my $chrome = Mojo::Chrome->new("$url");
is $chrome->target->scheme, 'http', 'correct scheme';
is $chrome->target->host, '127.0.0.1', 'correct host';
is $chrome->target->port, '3001', 'correct port';
is $chrome->target->to_string, 'http://127.0.0.1:3001', 'correct overall target';

unless ( $ENV{'MOJO_CHROME_EXECUTABLE'} ) {
   print "you have to set the MOJO_CHROME_EXECUTABLE env var !!! \n" ; 
   print "export MOJO_CHROME_EXECUTABLE=/usr/bin/chromium-browser \n" ; 
   done_testing(); exit 1 ; 
}


is $chrome->executable, $ENV{'MOJO_CHROME_EXECUTABLE'}, 'executable not set';
is_deeply $chrome->arguments, ['--headless'], 'default arguments as expected';

$chrome = Mojo::Chrome->new('http://127.0.0.0/?headless&disable-gpu');
is_deeply $chrome->arguments, ['--headless', '--disable-gpu'], 'explicit headless with options';
is $chrome->executable, $ENV{'MOJO_CHROME_EXECUTABLE'} , 'executable not set';

$chrome = Mojo::Chrome->new('http://127.0.0.0/?disable-gpu');
is_deeply $chrome->arguments, ['--disable-gpu', '--headless'], 'implicit headless with options';

$chrome = Mojo::Chrome->new('http://127.0.0.0/?disable-gpu&no-headless');
is_deeply $chrome->arguments, ['--disable-gpu'], 'explicit no-headless with options';

$chrome = Mojo::Chrome->new('http://127.0.0.0/?no-headless');
is_deeply $chrome->arguments, [], 'explicit no-headless with no options';

$chrome = Mojo::Chrome->new('http://127.0.0.0/?executable=mychrome');
is_deeply $chrome->arguments, ['--headless'], 'no explicit headless with executable';

$chrome = Mojo::Chrome->new->catch(sub{ warn pop });
#$chrome = Mojo::Chrome->new("$url");
$url = 'http://127.0.0.1:3001/dev_issue_tracker/view/userstories' ; 
p $chrome->detect_chrome_executable ; 
#$chrome = Mojo::Chrome->new("$url");
Mojo::IOLoop->delay(
 sub { $chrome->load_page($url, shift->begin) },
 sub {
	my ($delay, $err) = @_;
	die $err if $err ;
	my $str_js = '
      var sel = \'h3\';
      var headings = document.querySelectorAll(sel);
      [].slice.call(headings).map((link)=>{return link.innerText});
' ; 
	my $res = $chrome->evaluate($str_js , $delay->begin);
   #my $dom = Mojo::DOM->new($t->ua->get($url)->result->body) ; 
	#p $res ; 
 },
 sub {
	my ($delay, $err, $result) = @_;
	die Mojo::Util::dumper $err if $err;
	#say for @$result;
   p $result ; 
 }
)->catch(sub{ warn pop })->wait;


#	my $str_js = "document.getElementsByTagName('span')[0].innerHTML" ; 

done_testing;
