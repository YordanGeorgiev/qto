use strict ; use warnings ; 
use Test::Most ; 
use Test::Mojo;
use Data::Printer ; 
use FindBin;

die_on_fail;

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../qto/lib" }
   $ENV{'QTO_NO_AUTH'} = 1;

   my $tm            = '' ; # the test message for each test 
   my $t             = Test::Mojo->new('Qto');
   my $config        = $t->app->config ; 
   my $url           = '' ; 
   my $db            = $config->{'env'}->{'db'}->{'postgres_db_name'} ;  # obs instanced specific !!!
   my $dom           = {} ;
   my $ua            = $t->ua ; 
   my $response      = $ua->get('/' . $db . '/select-tables')->result->json ; 
   my $item          = 'test_hierarchy_doc' ; 

   $tm = 'the view-doc page for the ' . $item . ' returns http 200 ' ; 
   $url = "/$db/view/$item" ; 
   ok ($t->get_ok($url)
      ->status_is(200) 
      ->header_is('Accept-Charset' => 'UTF-8')
      ->header_is('Accept-Language' => 'fi, en'), $tm );

   $tm = 'the view page is presented by branch-id = 0 ' ; 
   $url = "/$db/view/$item?bid=0" ; 
   ok ($t->get_ok($url)
      ->status_is(200) 
      ->header_is('Accept-Charset' => 'UTF-8')
      ->header_is('Accept-Language' => 'fi, en'), $tm );

   $dom = Mojo::DOM->new($t->ua->get($url)->result->body) ; 
   ok ( $dom->find('div')->[1] =~ m/$config->{'env'}->{'run'}->{'ENV_TYPE'}/ , $tm ) ;

   #my @headers = $dom->find('div#lft_body')->map('all_text'); 
   #p @headers ; 


























   

done_testing();

