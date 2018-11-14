use strict ; use warnings ; 
use Test::Most ; 
use Test::Mojo;
use Data::Printer ; 
use FindBin;

die_on_fail ; 

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../issue_tracker/lib" }

my $t = Test::Mojo->new('IssueTracker');

my $appConfig = $t->app->get('AppConfig') ; 

my $db_name= $appConfig->{ 'postgres_db_name' } ; 
my $ua  = $t->ua ; 
my $res = {} ; #a tmp result json string
my $tm = '' ; 

$res = $ua->get('/' . $db_name . '/select-tables')->result->json ; 
my $tables = $res->{'dat'} ; 
my @tables_to_check = ( 'monthly_issues' , 'yearly_issues' ) ; 

# foreach table in the app db in test call db/select/table
for my $row ( @$tables ) {

   my $table      = $row->{'table_name'} ; 
   next unless ( grep( /^$table$/, @tables_to_check ) ) ; 
	my $url_params = '' ; # 
	my $url        = '' ; 

   $url = '/' . $db_name . '/select-meta/' . $table ; 
   my $meta_res = $ua->get($url)->result->json ; 
   my $list_meta = $meta_res->{'dat'} ; 
   my @with_or_where = ( 'with' , 'where' ); 
   # not all tables contain the prio attribute to test by , thus run only for those having it
   foreach my $with_where ( @with_or_where )  {
      foreach my $prio_have_row ( @$list_meta )  {
         next unless $prio_have_row->{'attribute_name'} eq 'prio'  ;
         # test a filter by Select of integers	
         $url = '/' . $db_name . '/select/' . $table . '?pick=name,prio&' . "$with_where" . '=prio-le-3&' . "$with_where" . '=prio-ge-1' ; 
         print "url: $url \n" ; 
         $t->get_ok($url )
            ->status_is(200) 
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
         
         $url = '/' . $db_name . '/select/' . $table . '?pick=name,prio&' . "$with_where" . '=prio-WRONG_OPERATOR-3';
         $t->get_ok($url )
            ->status_is(400) 
         ;
      } 
   }
   #eof for each prio
   
   
   # not all tables contain the prio attribute to test by , thus run only for those having it
   foreach my $status_have_row ( @$list_meta )  {
      next unless $status_have_row->{'attribute_name'} eq 'status'  ;
      $url = '/' . $db_name . '/select/' . $table . '?pick=name,prio,status&with=status-eq-02-todo' ; 
      $t->get_ok($url )->status_is(200) ; 

      $res = $ua->get($url)->result->json ; 
      my $list = $res->{'dat'} ; 

      if ( $list ) {
         foreach my $row ( @$list) {
            # not all the tables have the prio attribute
            $tm = "only status=02-todo  are selected for $url: " . substr ( $row->{'name'} , 0, 30 ) . ' ...' ; 	
            ok ( $row->{'status'} eq '02-todo', $tm ) ; 
         }
      }
      
      $url = '/' . $db_name . '/select/' . $table . '?pick=name,prio,status&with=status-like-0%25' ; 
      $t->get_ok($url )->status_is(200) ;

      $res = $ua->get($url)->result->json ; 
      $list = $res->{'dat'} ; 

      foreach my $row ( @$list) {
         # not all the tables have the prio attribute
         $tm = "test for like - only status starting with 0  are selected for $url: " . substr ( $row->{'name'} , 0, 30 ) . ' ...' ; 	
         ok ( $row->{'status'} =~ '0', $tm ) ; 
      }
      
      $url = '/' . $db_name . '/select/' . $table . '?pick=name,prio,status&with=status-eq-1000' ; 
      $tm = "if no data is received the 204 http code 'No Content' is returned" ;
      ok ( $t->get_ok($url )->status_is(204) , $tm )
   } 
   #eof for each status
} 
#eof foreach table


# fetch all the tables 
done_testing();
