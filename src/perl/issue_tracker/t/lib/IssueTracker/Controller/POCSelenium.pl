use strict ; use warnings ; 

use Data::Printer ; 
use FindBin;

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../issue_tracker/lib" }


    use Selenium::Remote::Driver;

my $driver = new Selenium::Remote::Driver('browser_name' => 'firefox',
                                              'platform' => 'ANY');
    $driver->get('http://www.google.com');
    print $driver->get_title();
    $driver->quit();

#$t->navigate_ok('/perldoc')
#  ->live_text_is('a[href="#GUIDES"]' => 'GUIDES');

#    use Test::WWW::Selenium;
#
#    # Parameters are passed through to WWW::Selenium
#    my $sel = Test::WWW::Selenium->new( host => "localhost",
#                                        port => 4444,
#                                        browser => "/usr/bin/firefox",
#                                        browser_url => "http://www.google.com",
#                                        default_names => 1,
#                                        error_callback => sub { print "AN ERROR OCCURED !!!" },
#                                      );
#
#    # use special test wrappers around WWW::Selenium commands:
#    $sel->open_ok("http://www.google.com", undef, "fetched G's site alright");
#    $sel->type_ok( "q", "hello world");
#    $sel->click_ok("btnG");
#    $sel->wait_for_page_to_load_ok(5000);
#    $sel->title_like(qr/Google Search/);
#    $sel->error_callback(sub {...});
