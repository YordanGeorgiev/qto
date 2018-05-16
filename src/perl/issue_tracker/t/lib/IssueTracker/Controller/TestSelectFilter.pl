use strict ; use warnings ; 
use Test::More;
use Test::Mojo;
use Data::Printer ; 
use FindBin;

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../issue_tracker/lib" }

my $t = Test::Mojo->new('IssueTracker');
#$t->get_ok('/')->status_is(200) ; #chk:it-18050601

my $appConfig = $t->app->get('AppConfig') ; 

# if the product instance id dev -> dev_issue_tracker
# if the product instance id tst -> tst_issue_tracker
my $db_name= $appConfig->{ 'postgres_db_name' } ; 
my @tables = ( 'daily_issues' , 'weekly_issues' , 'monthly_issues' , 'yearly_issues' ) ; 
my $ua  = $t->ua ; 
my $res = {} ; #a tmp result json string
my $tm = '' ; 

$res = $ua->get('/' . $db_name . '/select-tables')->result->json ; 
my $list = $res->{'dat'} ; 

# foreach table in the app db in test call db/select/table
for my $row ( @$list ) {

   my $table = $row->{'table_name'} ; 
	my $url_params = '' ; # 
	my $url = '' ; 

         # test a filter by Select of integers	
         $url_params = '?fltr-by=prio&fltr-val=1,2,3' ; 
         $url = '/' . $db_name . '/select/' . $table . $url_params ; 
         $t->get_ok($url )
            ->status_is(200) 
            ->header_is('Accept-Charset' => 'UTF-8')
            ->header_is('Accept-Language' => 'fi, en')
         ;

         print "\n running url: /$db_name" . '/select/' . $table . $url_params . "\n" ; 	
         $res = $ua->get('/' . $db_name . '/select/' . $table . $url_params )->result->json ; 
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
      print "\n running url: /$db_name" . '/select/' . $table . $url_params . "\n" ; 	
      $res = $ua->get('/' . $db_name . '/select/' . $table . $url_params )->result->json ; 
      my $list = $res->{'dat'} ; 

      # feature-guid: 1f89454a-1801-423d-9784-9477973d05fc
      foreach my $row ( @$list) {
         $tm = "all the retrieved statuses should be 02-todo for the table: $table: " . substr ( $row->{'name'} , 0, 30 ) . ' ...' ;
         ok ( $row->{'status'} eq '02-todo', $tm ) ; 
      }

      # feature-guid: c71d93de-f178-485a-844f-fe8d226628a4
      print 'test a response with invalid syntax - provide fltr-by only' . "\n" ; 
      $url_params = '?fltr-by=status' ; 
      print "\n running url: /$db_name" . '/select/' . $table . $url_params . "\n" ; 	
      $res = $ua->get('/' . $db_name . '/select/' . $table . $url_params )->result->json ; 
      ok ( $res->{'msg'} 
         eq 'mall-formed url params for filtering - valid syntax is ?fltr-by=<<attribute>>&fltr-val=<<filter-value>>' ) ; 
      ok ( $res->{'ret'} == 400 ) ; 	
   }

   # feature-guid: c71d93de-f178-485a-844f-fe8d226628a4
   print 'test a response with invalid syntax - provide fltr-val only ' . "\n" ; 
	$url_params = '?fltr-val=wrong' ; 
	print "\n running url: /$db_name" . '/select/' . $table . $url_params . "\n" ; 	
   $res = $ua->get('/' . $db_name . '/select/' . $table . $url_params )->result->json ; 
	ok ( $res->{'msg'} 
		eq 'mall-formed url params for filtering - valid syntax is ?fltr-by=<<attribute>>&fltr-val=<<filter-value>>' ) ; 
	ok ( $res->{'ret'} == 400 ) ; 	

   # feature-guid: d6561095-c965-4658-a5dc-0350093e75ab
   $tm = "test a response with valid syntax, but use unexisting columns \n" ; 
   $url_params = '?fltr-by=non_existing_column&fltr-val=foo-bar' ; 
   $tm .= "\n running url: /$db_name" . '/select/' . $table . $url_params . "\n" ; 	
   $res = $ua->get('/' . $db_name . '/select/' . $table . $url_params )->result->json ; 
   ok ( $res->{'msg'} eq "the non_existing_column column does not exist" ) ; 
   ok ( $res->{'ret'} == 400 , $tm) ; 	
   print "stop  test a response with valid syntax, but use unexisting columns \n" ; 
   
} 
#eof foreach table


# fetch all the tables 
done_testing();
