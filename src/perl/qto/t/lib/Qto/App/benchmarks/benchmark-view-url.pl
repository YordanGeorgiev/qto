use strict ; use warnings ; 

use Test::Most ; 
use Test::Mojo;
use Data::Printer ; 
use FindBin;
use Mojo::UserAgent;
use Time::HiRes qw( time );
use Mojo::IOLoop ; 


die_on_fail ; 

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../../qto/lib" }

use Qto::App::Utils::Timer ; 

   my $url              = $ARGV[0] || die "Nothing to benchark , give an url as the first cmd arg !!!" ; 
   my $ua               = 'Mojo::UserAgent'->new;

	$ua->on( start => sub {
		 my ( $ua, $tx ) = @_;
		 $tx->req->headers->header('Accept-Encoding' => 'gzip');
		 $tx->on( finish => sub {
			  my $tx = shift;
			  $tx->res->body(Compress::Zlib::memGunzip($tx->res->body))
					if $tx->res->headers->header('Content-Encoding')
					&& $tx->res->headers->header('Content-Encoding') =~ /gzip/;
		 });
	});


   my $tm               = '' ; # the test message for each test 
   my $db_name          = 'dev_qto' ; 
   my $create_url = (split /\?/ , $url )[0] ; $create_url =~ s|view/[a-zA-Z_]+|create/benchmarks|g ; 
   print "create_url : $create_url \n" ; 
   my $update_url = (split /\?/ , $url )[0] ; $update_url =~ s|view/[a-zA-Z_]+|update/benchmarks|g ; 
   print "update_url : $update_url \n" ; 

   my $objTimerId       = {} ;
   $objTimerId          = 'Qto::App::Utils::Timer'->new( 'YYYYMMDDhhmmss' );
   my $id = $objTimerId->GetHumanReadableTime(); 
   $id = substr( $id , 2) ; 
   # create the new entry to get the id

   my $objTimer         = {} ;
   $objTimer            = 'Qto::App::Utils::Timer'->new( 'YYYY-MM-DD hh:mm:ss' );
   my $start_time       = $objTimer->GetHumanReadableTime();
   print "start_time: $start_time \n" ; 
   $ua->post($create_url => json => { "id" =>$id}) ; 
   $ua->post($update_url => json => { "attribute"=>"start_time", 'id' => $id , 'cnt'=> $start_time } => sub {
     my ($ua, $tx) = @_;
     print $tx->result->body . "\n" ; 
   });
   Mojo::IOLoop->start unless Mojo::IOLoop->is_running;
   $ua->post($update_url => json => { "attribute"=>"url", 'id' => $id , 'cnt'=> $url } => sub {
     my ($ua, $tx) = @_;
     print $tx->result->body . "\n" ; 
   });
   Mojo::IOLoop->start unless Mojo::IOLoop->is_running;
   my $count = $ARGV[1] || 1000 ; 
   my $name = $ARGV[2] || 'url average page load' ; 
   $ua->post($update_url => json => { "attribute"=>"name", 'id' => $id , 'cnt'=> "$name" } => sub {
     my ($ua, $tx) = @_;
     print $tx->result->body . "\n" ; 
   });
   Mojo::IOLoop->start unless Mojo::IOLoop->is_running;

   my $currentShortHash = `git rev-parse --short HEAD` ; chomp($currentShortHash);

   my $begin_time       = time();
   for my $i (1 .. $count ) { # because pg-nums are human and non-nerd / machine readables ...
      $url =~ s/pg-num=[0-9]/pg-num=$i/g ; # non-generic for now ...
      $ua->get($url) ; 
      # $ua->get($url)->result->dom->find('title')->each (sub { my ($e) = @_; print "title: " . $e->content . ": $i \n"; })  ; 
   }
   my $end_time = time();
   my $diff_time = $end_time - $begin_time ;
   my $avg_ua_load_time = sprintf("%0.6f" , $diff_time/$count ) ; 
   
   my $stop_time = $objTimer->GetHumanReadableTime();
   $ua->post($update_url => json => { "attribute"=>"stop_time", 'id' => $id , 'cnt'=> $stop_time } => sub {
     my ($ua, $tx) = @_;
     print $tx->result->body . "\n" ; 
   });
   Mojo::IOLoop->start unless Mojo::IOLoop->is_running;
   print "stop_time: $stop_time \n" ; 
   
   print "$start_time - $stop_time = $diff_time \n" ; 
   print "avg page load time : $avg_ua_load_time seconds \n" ; 
   $ua->post($update_url => json => { "attribute"=>'avg_ua_load_time', 'id' => $id , 'cnt'=> $avg_ua_load_time } => sub {
     my ($ua, $tx) = @_;
     print $tx->result->body . "\n" ; 
   });
   Mojo::IOLoop->start unless Mojo::IOLoop->is_running;
   $ua->post($update_url => json => { "attribute"=>'git_hash', 'id' => $id , 'cnt'=> $currentShortHash } => sub {
     my ($ua, $tx) = @_;
     print $tx->result->body . "\n" ; 
   });
   Mojo::IOLoop->start unless Mojo::IOLoop->is_running;

done_testing();
 
