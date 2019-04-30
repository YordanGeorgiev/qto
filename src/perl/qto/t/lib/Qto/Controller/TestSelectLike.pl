use strict ; use warnings ; 
use Test::Most ; 
use Test::Mojo;
use Data::Printer ; 
use FindBin;

die_on_fail ; 

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../qto/lib" }

my $t = Test::Mojo->new('Qto');
#$t->get_ok('/')->status_is(200) ; 

my $appConfig = $t->app->get('AppConfig') ; 

# if the product instance id dev -> dev_qto
# if the product instance id tst -> tst_qto
my $db_name= $appConfig->{ 'postgres_db_name' } ; 
my @tables = ( 'monthly_issues' , 'yearly_issues' ) ; 
my $ua  = $t->ua ; 
my $res = {} ; #a tmp result json string
my $tm = '' ; 
my @tables_to_scan = ('monthly_issues' , 'yearly_issues' );

$res = $ua->get('/' . $db_name . '/select-tables')->result->json ; 

# foreach table in the app db in test call db/select/table
for my $table ( @tables ) {
   	
   next unless  grep ( /^$table$/, @tables_to_scan ) ;
	# test a like by select of integers	
	my $url_params = '?like-by=status&like-val=todo' ; 
	$t->get_ok('/' . $db_name . '/select/' . $table . $url_params )
		->status_is(200) 
		->header_is('Accept-Charset' => 'UTF-8')
		->header_is('Accept-Language' => 'fi, en')
	;

	print "\n running url: /$db_name" . '/select/' . $table . $url_params . "\n" ; 	
   $res = $ua->get('/' . $db_name . '/select/' . $table . $url_params )->result->json ; 
	my @list = @{$res->{'dat'}} ; 

   # feature-id: d4592c2e-60a4-4078-b499-743423d66d94
	foreach my $row ( @list ) {
		$tm = 'only rows with status containing the "todo" string are selected for ' ; 
      $tm .= "$table table: " . substr ( $row->{'name'} , 0, 30 ) . ' ...' ; 	
		ok ( $row->{'status'} =~ m/todo/g, $tm ) ; 
	}



	print "test a string like \n" ; 
	$url_params = '?like-by=category&like-val=feature' ; 
	print "\n running url: /$db_name" . '/select/' . $table . $url_params . "\n" ; 	
   $res = $ua->get('/' . $db_name . '/select/' . $table . $url_params )->result->json ; 
	@list = @{$res->{'dat'}} ; 

   # feature-guid: 3c43addf-bc2a-4eed-b4a5-040e9bd9dc75
	foreach my $row ( @list ) {
		$tm = "all the retrieved rows of the the table: $table: " . substr ( $row->{'name'} , 0, 30 ) . ' ...' ;
		ok ( $row->{'category'} =~ m/feature/g , $tm ) ; 
	}

   #
   # feature-guid: dfd70012-bc52-4c8a-860f-a760d77f50ad
	print 'test a response with invalid syntax - provide like-by only' . "\n" ; 
	$url_params = '?like-by=status' ; 
	print "\n running url: /$db_name" . '/select/' . $table . $url_params . "\n" ; 	
   $res = $ua->get('/' . $db_name . '/select/' . $table . $url_params )->result->json ; 
	ok ( $res->{'msg'} 
		eq 'mall-formed url params for the like operator - valid syntax is ?like-by=<<attribute>>&like-val=<<like-value>>' );
	ok ( $res->{'ret'} == 400 ) ; 	

   # feature-guid: c71d93de-f178-485a-844f-fe8d226628a4
   print 'test a response with invalid syntax - provide like-val only ' . "\n" ; 
	$url_params = '?like-val=wrong' ; 
	print "\n running url: /$db_name" . '/select/' . $table . $url_params . "\n" ; 	
   $res = $ua->get('/' . $db_name . '/select/' . $table . $url_params )->result->json ; 
	ok ( $res->{'msg'} 
		eq 'mall-formed url params for the like operator - valid syntax is ?like-by=<<attribute>>&like-val=<<like-value>>' ) ; 
	ok ( $res->{'ret'} == 400 ) ; 	

   # feature-guid: dbaeebbe-b827-4c0b-90b5-c63627c620b8
   print "\n start test a response with valid syntax, but use unexisting columns \n" ; 
   $url_params = '?like-by=non_existing_column&like-val=foo-bar' ; 
   print "running url: /$db_name" . '/select/' . $table . $url_params . "\n" ; 	
   $res = $ua->get('/' . $db_name . '/select/' . $table . $url_params )->result->json ; 
   ok ( $res->{'msg'} eq "the non_existing_column column does not exist" ) ; 
   ok ( $res->{'ret'} == 400 ) ; 	
   print "stop  test a response with valid syntax, but use unexisting columns \n" ; 
   
	$url_params = '?like-by=name,description&like-val=add' ; # choose a word which most probably WILL occur
	$t->get_ok('/' . $db_name . '/select/' . $table . $url_params )->status_is(200) ;

	print "\n running url: /$db_name" . '/select/' . $table . $url_params . "\n" ; 	
   $res = $ua->get('/' . $db_name . '/select/' . $table . $url_params )->result->json ; 
	@list = @{$res->{'dat'}} ; 

   # feature-id: d4592c2e-60a4-4078-b499-743423d66d94
	foreach my $row ( @list ) {
		$tm = "\n".'test-06 only rows having BOTH name and description containing the string "add" ' ; 
      $tm .= "in the \n $table table: " . substr ( $row->{'name'} , 0, 30 ) . ' ...' ; 	
		ok ( $row->{'name'} =~ m/add/g , $tm ) ; 
		ok ( $row->{'description'} =~ m/add/g, $tm ) ; 
	}
	
   $url_params = '?like-by=name&like-val=add&like-by=description&like-val=the' ; # choose a word which most probably WILL occur
	$t->get_ok('/' . $db_name . '/select/' . $table . $url_params )->status_is(200) ;

	print "\n running url: /$db_name" . '/select/' . $table . $url_params . "\n" ; 	
   $res = $ua->get('/' . $db_name . '/select/' . $table . $url_params )->result->json ; 
	@list = @{$res->{'dat'}} ; 

   # feature-id: d4592c2e-60a4-4078-b499-743423d66d94
	foreach my $row ( @list ) {
		$tm = "\n".'test-07 EITHER name has the "add" string OR the description has the "the" string' ; 
      $tm .= "in the \n $table table: " . substr ( $row->{'name'} , 0, 30 ) . ' ...' ; 	
		ok ( ( $row->{'name'} =~ m/add/g or $row->{'description'} =~ m/the/g), $tm ) ; 
	}
} 
#eof foreach table


# fetch all the tables 
done_testing();
