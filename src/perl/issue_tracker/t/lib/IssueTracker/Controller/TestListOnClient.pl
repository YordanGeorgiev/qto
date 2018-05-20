use strict ; use warnings ; 

# all of the tests are slightly adapted versions of the 
# https://github.com/jberger/Mojo-Chrome proj
use Data::Printer ; 


use Mojo::Base -strict;

use Mojo::Chrome;
use Test::More;

# quick mock default_chrome_executable
no warnings 'redefine';
*Mojo::Chrome::detect_chrome_executable = sub { 'default-chrome' };

my $chrome = Mojo::Chrome->new('https://127.0.0.1:3000');
is $chrome->target->scheme, 'https', 'correct scheme';
is $chrome->target->host, '127.0.0.1', 'correct host';
is $chrome->target->port, '3000', 'correct port';
is $chrome->target->to_string, 'https://127.0.0.1:3000', 'correct overall target';
is $chrome->executable, 'default-chrome', 'executable not set';
is_deeply $chrome->arguments, ['--headless'], 'default arguments as expected';

$chrome = Mojo::Chrome->new('http://127.0.0.1/?headless&disable-gpu');
is_deeply $chrome->arguments, ['--headless', '--disable-gpu'], 'explicit headless with options';
is $chrome->executable, 'default-chrome', 'executable not set';

$chrome = Mojo::Chrome->new('http://127.0.0.1/?disable-gpu');
is_deeply $chrome->arguments, ['--disable-gpu', '--headless'], 'implicit headless with options';
is $chrome->executable, 'default-chrome', 'executable not set';

$chrome = Mojo::Chrome->new('http://127.0.0.1/?disable-gpu&no-headless');
is_deeply $chrome->arguments, ['--disable-gpu'], 'explicit no-headless with options';
is $chrome->executable, 'default-chrome', 'executable not set';

$chrome = Mojo::Chrome->new('http://127.0.0.1/?no-headless');
is_deeply $chrome->arguments, [], 'explicit no-headless with no options';
is $chrome->executable, 'default-chrome', 'executable not set';

$chrome = Mojo::Chrome->new('http://127.0.0.1/?executable=mychrome');
is_deeply $chrome->arguments, ['--headless'], 'no explicit headless with executable';
is $chrome->executable, 'mychrome', 'executable set';

done_testing;
#
#
#
#use Test::More;
#use Test::Mojo;
#use Mojo::Chrome;
#use Mojo::IOLoop;
#
##BEGIN { unshift @INC, "$FindBin::Bin/../../../../../issue_tracker/lib" }
#
#my $t = Test::Mojo->new('IssueTracker');
#my $url = $t->ua->server->nb_url;
##my $url = '/non_existent_db/list/monthly_issues&as=labels' ;
#my $chrome = Mojo::Chrome->new;
#p $chrome ; 
#
#my $tm = '' ; 
#my $result;
#Mojo::IOLoop->delay(
#  sub { p $chrome ; $chrome->load_page($url, shift->begin) },
#  sub {
#    my ($delay, $err) = @_;
#    die $err if $err;
#    $chrome->evaluate(q!document.getElementsByTagName('span')[0].innerHTML!, $delay->begin);
#	 #p $chrome ; 
#  },
#  sub {
#    my ($delay, $err, $r) = @_;
#    die $err if $err;
#    $result = $r;
#  },
#)->catch(sub{ fail pop })->wait;
#
#$tm = "handle error for non-existent db properly" ; 
#is $result, 'cannot connect to the "non_existent_db" database: FATAL: database "non_existent_db" does not exist', $tm  ; 
#
#
#
#
#
#done_testing;
