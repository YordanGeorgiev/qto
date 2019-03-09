#!/usr/bin/env perl
use strict ;
use warnings ; 
use Carp ; 
use Data::Printer ;
use Selenium::Remote::Driver;

my $host="127.0.0.1";
my $driver = Selenium::Remote::Driver->new( 
		  "browser_name" =>"chrome"
		, "error_handler" => sub { print $_[1]; croak 'goodbye' ; }
		, "remote_server_addr" => "$host"
		, "port"=> "4444") ;
$driver->debug_on() ;
$driver->get("http://www.google.com");
print $driver->get_title();
$driver->quit();
