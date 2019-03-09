use strict ; use warnings ; 
use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../../../../qto/lib" }

# all of the tests are slightly adapted versions of the 
# https://github.com/jberger/Mojo-Chrome proj
use Data::Printer ; 
use Mojo::Base -strict;
use Test::More;
use Test::Mojo ; 
use Mojo::IOLoop;
use Mojo::Base -strict;
use Test::More;

my $t = Test::Mojo->with_roles("+Selenium")->new("Qto")->setup_or_skip_all;

# All the standard Test::Mojo methods are available
ok $t->isa("Test::Mojo");
ok $t->does("Test::Mojo::Role::Selenium");

#my $url = 'http://192.168.56.120:3001/dev_qto/list/monthly_issues?as=grid&pick=id,category,prio,status,name,weight,update_time,description&oa=prio&od=id&pg-size=100&pg-num=1' ; 

#$t->navigate_ok('/dev_qto/list/monthly_issues')
#   ->status_is(200)
#  ->header_is("Server" => "Mojolicious (Perl)")
#  ->text_is("div#message" => "Hello!")
#  ->live_text_is("div#message" => "Hello!")
#  ->live_element_exists("nav")
#  ->element_is_displayed("nav")
#  ->active_element_is("input[name=q]")
#  ->send_keys_ok("input[name=q]", "Mojo")
#  ->capture_screenshot;
#
#$t->submit_ok("form")
#  ->status_is(200)
#  ->current_url_like(qr{q=Mojo})
#  ->live_element_exists("input[name=q][value=Mojo]");
#
#$t->click_ok("nav a.logo")->status_is(200);
;

done_testing; 
