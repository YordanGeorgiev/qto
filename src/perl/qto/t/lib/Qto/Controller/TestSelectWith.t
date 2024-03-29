use strict ; use warnings ; 
use Test::Most ; 
use Test::Mojo;
use Data::Printer ; 
use FindBin;

die_on_fail ; 
   $ENV{'QTO_NO_AUTH'} = 1 ;

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../qto/lib" }

my $t       = Test::Mojo->new('Qto');
my $config  = $t->app->config ; 
my $db      = $config->{'env'}->{'db'}->{ 'postgres_app_db' } ; 
my $ua      = $t->ua ; 
my $res     = {} ; #a tmp result json string
my $tm      = '' ; 

$res = $ua->get('/' . $db . '/select-tables')->result->json ; 
my $tables = $res->{'dat'} ; 
use Qto::App::Utils::Timer ; 
my $objTimer = 'Qto::App::Utils::Timer'->new;
my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = $objTimer->GetTimeUnits(); 
my $prev_year_month = "$year" . "$mon" - 1;
my @tables_to_check = ("issues_$year$mon" , "issues_" . "$prev_year_month" );

# foreach table in the app db in test call db/select/table
for my $row ( @$tables ) {

   my $table      = $row->{'table_name'} ; 
   next unless ( grep( /^$table$/, @tables_to_check ) ) ; 
	my $url_params = '' ; # 
	my $url        = '' ; 

   $url = '/' . $db . '/select-item-meta-for/' . $table ; 
   my $meta_res = $ua->get($url)->result->json ; 
   my $list_meta = $meta_res->{'dat'} ; 
   my @with_or_where = ( 'with' , 'where' ); 
   # not all tables contain the prio attribute to test by , thus run only for those having it
   foreach my $with_where ( @with_or_where )  {
      foreach my $prio_have_row ( @$list_meta )  {
         next unless $prio_have_row->{'attribute_name'} eq 'prio'  ;
         # test a filter by Select of integers	
         $url = '/' . $db . '/select/' . $table . '?pick=name,prio&' . "$with_where" . '=prio-le-3&' . "$with_where" . '=prio-ge-1' ; 
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
         
         $url = '/' . $db . '/select/' . $table . '?pick=name,prio&' . "$with_where" . '=prio-WRONG_OPERATOR-3';
         $t->get_ok($url )
            ->status_is(400) 
         ;
      } 
   }
   #eof for each prio
   
   
   # not all tables contain the prio attribute to test by , thus run only for those having it
   foreach my $status_have_row ( @$list_meta )  {
      next unless $status_have_row->{'attribute_name'} eq 'status'  ;
      $url = '/' . $db . '/select/' . $table . '?pick=name,prio,status&with=status-eq-02-todo' ; 
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
      
      $url = '/' . $db . '/select/' . $table . '?pick=name,prio,status&with=status-like-0%25' ; 
      $t->get_ok($url )->status_is(200) ;

      $res = $ua->get($url)->result->json ; 
      $list = $res->{'dat'} ; 

      foreach my $row ( @$list) {
         # not all the tables have the prio attribute
         $tm = "test for like - only status starting with 0  are selected for $url: " . substr ( $row->{'name'} , 0, 30 ) . ' ...' ; 	
         ok ( $row->{'status'} =~ '0', $tm ) ; 
      }
      
      $url = '/' . $db . '/select/' . $table . '?pick=name,prio&with=prio-eq-1000' ; 
      $tm = "if no data is received the 204 http code 'No Content' is returned" ;
      ok ( $t->get_ok($url )->status_is(200) , $tm );
      $res = $ua->get($url)->result->json ; 
      ok ( $res->{'ret'} == 204 , $tm )
   } 
   #eof for each status
} 
#eof foreach table


# fetch all the tables 
done_testing();
