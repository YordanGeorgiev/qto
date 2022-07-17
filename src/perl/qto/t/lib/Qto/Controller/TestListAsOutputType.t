use strict ; use warnings ; 

use Test::More;
use Test::Mojo;
use Data::Printer ; 
use FindBin;

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../qto/lib" }

   $ENV{'QTO_NO_AUTH'} = 1 ;
   my $tm         = '' ; # the test message for each test 
   my $t          = Test::Mojo->new('Qto');
   my $config     = $t->app->config ; 
   my $ua         = {} ;  # the mojo user agent 
   my $dom        = {} ;  # the mojo dom parser 
   my $url        = {} ;  # the url to build for each test 
   my $exp_txt    = {} ;  # the expected text to check 
   my $response   = {} ;  # the response obj after each request  
   my $db_name    = {} ;  # the proj name
   my $PRODUCT_DIR = $config->{'env'}->{'run'}->{'ProductInstanceDir'}; 

   $db_name= $config->{'env'}->{'db'}->{ 'postgres_app_db' } ; 
   $url = '/' . $db_name . '/select-tables' ; 

	$tm = "for list all the tables from the $db_name db" ; 
   $t->get_ok($url)
      ->status_is(200) 
      ->header_is('Accept-Charset' => 'UTF-8' , $tm ) 
   ;

   $ua  = $t->ua ; 
   $response = $ua->get('/' . $db_name . '/select-tables')->result->json ; 
   my $list = $response->{ 'dat' } ; 
   my $counter = 0 ; 

   # foreach table in the proj db in test call db/list/table
   for my $row ( @$list ) {
      $counter++ ; next if $counter % 2 != 0 ; # we have enough tables take each second one
      my $table_name = $row->{'table_name'} ; 
      next unless ( $table_name eq 'issues');
      my $url = '' ; 
      my $tm = '' ; # the test msg 

      $tm = 'for get the correct http status code - 200 , utf-8 and fi,en as langs' ; 
     
      my @output_types = ( 'grid' , 'print-table' ) ;   # only the table output type supports page sizing
      my @page_sizes = ( 5,10) ;  # only the table output type supports page sizing
      my @page_nums = ( 1,2 ) ;        # only the table output type supports page sizing
      foreach my $as ( @output_types ) {
         foreach my $page_size ( @page_sizes ) {
            foreach my $page_num ( @page_nums ) {
               $url = '/' . $db_name . '/list/' . $table_name . '?as=' . "$as" . '&pg-size=' . $page_size .'&pg-num=' . $page_num ; 
               $t->get_ok( $url )
                  ->status_isnt(400) 
                   ->header_is('Accept-Charset' => 'UTF-8')
               ;

               if ( $page_size == 5 && $as eq 'grid' && $page_num == 1 ){
                  my $port = $config->{'env'}->{'app'}->{'port'};
                  my $cmd = "lsof -i -P -n | grep LISTEN|grep -i $port|wc -l";
                  my $my_instance_proc_running_count = `$cmd` ; 
                  if ( $my_instance_proc_running_count > 0 ) {
                     my $http_protocol = $config->{'env'}->{'app'}->{'ht_protocol'};
                     my $web_host = $config->{'env'}->{'app'}->{'web_host'};
                     $url = "$http_protocol" . '://' . "$web_host" . ':' . "$port" . "$url";
                     my $cmd = "nodejs $PRODUCT_DIR/src/js/node/scrap-html.js \"$url\"";
                     my $s = `$cmd`; 
                     for my $e (Mojo::DOM->new($s)->find("table button")->each){
                        unless ( $e->all_text =~ /^$/g ) {
                           p $e->all_text ;
                           ok ( $e->all_text =~ /edit/g , 'client side js load works - the table button has the "edit"' );
                        }
                     }
                  }
               }
            }
         }
      }
   }


done_testing();

