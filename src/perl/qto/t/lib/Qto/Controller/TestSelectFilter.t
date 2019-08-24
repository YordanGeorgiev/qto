use strict ; use warnings ; 
use Test::Most ; 
use Test::Mojo;
use Data::Printer ; 
use FindBin;

die_on_fail ; 

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../qto/lib" }

my $t       = Test::Mojo->new('Qto') ;
my $config  = $t->app->get('AppConfig') ; 
my $db      = $config->{'env'}->{'db'}->{ 'postgres_db_name' } ; 
my @tables  = ( 'daily_issues' , 'weekly_issues' , 'monthly_issues' , 'yearly_issues' ) ; 
my $ua      = $t->ua ; 
my $res     = {} ; #a tmp result json string
my $tm      = '' ; 

$res        = $ua->get('/' . $db . '/select-tables')->result->json ; 
my $list    = $res->{'dat'} ; 
my @tables_to_check = ( 'monthly_issues' , 'yearly_issues' ) ; 

   
# foreach table in the app db in test call db/select/table
for my $row ( @$list ) {

   my $table = $row->{'table_name'} ; 
   next unless ( grep( /^$table$/, @tables_to_check ) ) ;
	my $url_params = '' ; # 
	my $url = '' ; 

   # debug print "\n running url: /$db" . '/select/' . $table . $url_params . "\n" ; 	
   my $meta_res = $ua->get('/' . $db . '/select-meta/' . $table  )->result->json ; 
   my $list_meta = $meta_res->{'dat'} ; 
   
   # not all tables contain the prio attribute to test by , thus run only for those having it
   foreach my $prio_have_row ( @$list_meta )  {
         next unless $prio_have_row->{'attribute_name'} eq 'prio'  ;
         # test a filter by Select of integers	
         $url_params = '?fltr-by=prio&fltr-val=1,2,3' ; 
         $url = '/' . $db . '/select/' . $table . $url_params ; 
         $t->get_ok($url )
            ->status_is(200) 
            ->header_is('Accept-Charset' => 'UTF-8')
            ->header_is('Accept-Language' => 'fi, en')
         ;
         # debug print "\n running url: /$db" . '/select/' . $table . $url_params . "\n" ; 	
         $res = $ua->get('/' . $db . '/select/' . $table . $url_params )->result->json ; 
         my $list = $res->{'dat'} ; 

         foreach my $row ( @$list) {
            # not all the tables have the prio attribute
               $tm = "only prio smaller or equal than 3 are selected for $table: " . substr ( $row->{'name'} , 0, 30 ) . ' ...' ; 	
               ok ( $row->{'prio'} <= 3, $tm ) ; 
               $tm = "only prio greater or equal to 1  are selected for $table: " . substr ( $row->{'name'} , 0, 30 ) . ' ...' ; 	
               ok ( $row->{'prio'} >= 1, $tm ) ; 
         }

   if ( defined ( $row->{'status'} ) ) {
      print "test a string filter \n" ; 
      $url_params = '?fltr-by=status&fltr-val=02-todo' ; 
      $url = "/$db" . '/select/' . $table . $url_params ; 
      print "\n running url: $url"   ; 
      $res = $ua->get('/' . $db . '/select/' . $table . $url_params )->result->json ; 
      my $list = $res->{'dat'} ; 

      # feature-guid: 1f89454a-1801-423d-9784-9477973d05fc
      foreach my $row ( @$list) {
         $tm = "all the retrieved statuses should be 02-todo for the table: $table: " . substr ( $row->{'name'} , 0, 30 ) . ' ...' ;
         ok ( $row->{'status'} eq '02-todo', $tm ) ; 
      }

      # feature-guid: c71d93de-f178-485a-844f-fe8d226628a4
      print 'test a response with invalid syntax - provide fltr-by only' . "\n" ; 
      $url_params = '?fltr-by=status' ; 
      $url = "/$db" . '/select/' . $table . $url_params ; 
      print "running url: $url " ; 
      $res = $ua->get('/' . $db . '/select/' . $table . $url_params )->result->json ; 
      ok ( $res->{'msg'} 
         eq 'mall-formed url params for filtering - valid syntax is ?fltr-by=<<attribute>>&fltr-val=<<filter-value>>' ) ; 
      ok ( $res->{'ret'} == 400 ) ; 	
   }

   # feature-guid: c71d93de-f178-485a-844f-fe8d226628a4
   $tm = 'test a response with invalid syntax - provide fltr-val only ' ; 
	$url_params = '?fltr-val=wrong' ; 
   $url = "/$db" . '/select/' . $table . $url_params ; 
	print "running url: $url" ; 
   $res = $ua->get('/' . $db . '/select/' . $table . $url_params )->result->json ; 
	ok ( $res->{'msg'} 
		eq 'mall-formed url params for filtering - valid syntax is ?fltr-by=<<attribute>>&fltr-val=<<filter-value>>' ) ; 
	ok ( $res->{'ret'} == 400 , $tm) ; 	

   # feature-guid: d6561095-c965-4658-a5dc-0350093e75ab
   $tm = "test a response with valid syntax, but use unexisting columns "; 
   $url_params = '?fltr-by=non_existing_column&fltr-val=foo-bar' ; 
   $url = "/$db" . '/select/' . $table . $url_params ; 
   $tm .= "running url: $url \n" ; 
   $res = $ua->get('/' . $db . '/select/' . $table . $url_params )->result->json ; 
   ok ( $res->{'msg'} eq "the non_existing_column column does not exist" ) ; 
   ok ( $res->{'ret'} == 400 , $tm) ; 	
   print "stop  test a response with valid syntax, but use unexisting columns \n" ; 

   } 
} 


done_testing();
