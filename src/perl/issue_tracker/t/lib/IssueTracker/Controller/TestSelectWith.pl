use strict ; use warnings ; 
use Test::More;
use Test::Mojo;
use Data::Printer ; 
use FindBin;

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../issue_tracker/lib" }

my $t = Test::Mojo->new('IssueTracker');

my $appConfig = $t->app->get('AppConfig') ; 

my $db_name= $appConfig->{ 'postgres_db_name' } ; 
my $ua  = $t->ua ; 
my $res = {} ; #a tmp result json string
my $tm = '' ; 

$res = $ua->get('/' . $db_name . '/select-tables')->result->json ; 
my $tables = $res->{'dat'} ; 

# foreach table in the app db in test call db/select/table
for my $row ( @$tables ) {

   my $table      = $row->{'table_name'} ; 
	my $url_params = '' ; # 
	my $url        = '' ; 

   $url = '/' . $db_name . '/select-meta/' . $table ; 
   my $meta_res = $ua->get($url)->result->json ; 
   my $list_meta = $meta_res->{'dat'} ; 
   
   # not all tables contain the prio attribute to test by , thus run only for those having it
   foreach my $prio_have_row ( @$list_meta )  {
      next unless $prio_have_row->{'attname'} eq 'prio'  ;
      # test a filter by Select of integers	
      $url = '/' . $db_name . '/select/' . $table . '?pick=name,prio&with=prio-le-3&with=prio-ge-1' ; 
      $t->get_ok($url )
         ->status_is(200) 
         ->header_is('Accept-Charset' => 'UTF-8')
         ->header_is('Accept-Language' => 'fi, en')
      ;

      $res = $ua->get($url)->result->json ; 
      my $list = $res->{'dat'} ; 

      foreach my $row ( @$list) {
         # not all the tables have the prio attribute
         $tm = "only prio <= 3 are selected for $url: " . substr ( $row->{'name'} , 0, 30 ) . ' ...' ; 	
         ok ( $row->{'prio'} <= 3, $tm ) ; 
         $tm = "only prio >= 1  are selected for $url: " . substr ( $row->{'name'} , 0, 30 ) . ' ...' ; 	
         ok ( $row->{'prio'} >= 1, $tm ) ; 
      }
   } 
   #eof for each prio
   
   
   # not all tables contain the prio attribute to test by , thus run only for those having it
   foreach my $status_have_row ( @$list_meta )  {
      next unless $status_have_row->{'attname'} eq 'status'  ;
      $url = '/' . $db_name . '/select/' . $table . '?pick=name,prio,status&with=status-eq-02-todo' ; 
      $t->get_ok($url )->status_is(200)->header_is('Accept-Charset' => 'UTF-8')
      ->header_is('Accept-Language' => 'fi, en')
      ;

      $res = $ua->get($url)->result->json ; 
      my $list = $res->{'dat'} ; 

      foreach my $row ( @$list) {
         # not all the tables have the prio attribute
         $tm = "only status=02-todo  are selected for $url: " . substr ( $row->{'name'} , 0, 30 ) . ' ...' ; 	
         ok ( $row->{'status'} eq '02-todo', $tm ) ; 
      }
      
      $url = '/' . $db_name . '/select/' . $table . '?pick=name,prio,status&with=status-like-03-%25' ; 
      $t->get_ok($url )->status_is(200)->header_is('Accept-Charset' => 'UTF-8')
      ->header_is('Accept-Language' => 'fi, en')
      ;

      $res = $ua->get($url)->result->json ; 
      $list = $res->{'dat'} ; 

      foreach my $row ( @$list) {
         # not all the tables have the prio attribute
         $tm = "test for like - only status starting with 03  are selected for $url: " . substr ( $row->{'name'} , 0, 30 ) . ' ...' ; 	
         ok ( $row->{'status'} =~ '03', $tm ) ; 
      }
   } #eof for each status
} 
#eof foreach table


# fetch all the tables 
done_testing();
