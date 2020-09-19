use strict ; use warnings ; 

use Test::Most ; 
use Test::Mojo;
use Data::Printer ; 
use FindBin;
use Mojo::UserAgent;


die_on_fail ; 

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../qto/lib" }
   $ENV{'QTO_NO_AUTH'} = 1;
# relies on the following table:
# psql -d dev_qto < src/sql/pgsql/qto/tables/95.create-table-test_hi_delete_table_doc.sql ;
# clear ; perl -MCarp=verbose src/perl/qto/t/lib/Qto/Controller/TestCreate.t
# use File::Basename qw< basename >;
# use Carp qw< carp croak confess cluck >;
# local $SIG{__DIE__} = sub {
#   $0 = basename($0); confess "\n\n\n FATAL Uncaught exception: @_" unless $^S;
# };
# local $SIG{__WARN__} = sub {
#   $0 = basename($0);    # shorter messages
#   if   ($^S) { cluck "\n\n WARN Trapped warning: @_" }
#   else       { cluck "\n\n WARN Deadly ?! warning: @_" }
# };

   my $tm            = '' ; # the test message for each test 
   my $res           = {} ; 
   my $url           = {} ; 
   my $exp_err_msg   = '' ; 
   my $t             = Test::Mojo->new('Qto');
   my $config        = $t->app->config ; 
   my $db            = $config->{'env'}->{'db'}->{'postgres_app_db'} ; # because each instance has it's own ...
   my $ua            = $t->ua ; # the user agent , aka http client
   my $objTimer      = {} ;
   my $lvlalpha         = 1 ; 
   
   $tm = 'the test_hi_delete_table_doc table is truncated' ; 
   $url = '/' . $db . '/truncate/test_hi_delete_table_doc' ; 
   ok ( $t->get_ok($url )->status_is(200) , $tm ) ;

   $url = '/' . $db . '/create/test_hi_delete_table_doc' ; 
   ok ( $t->post_ok($url => json => {"id" => "0" })->status_is(200) , $tm );

   
   $tm = 'can create the root element - id=0,lvlalpha=0,seq=1,name=document-title';
   $url = '/' . $db . '/update/test_hi_delete_table_doc' ; 
   # by definition the root element has ALWAYS id = 0 !!!
   ok ( $t->post_ok($url => json => {"attribute"=>"level", "id" =>"0", "cnt"=>"0"})->status_is(200), $tm);
   ok ( $t->post_ok($url => json => {"attribute"=>"seq", "id" =>"0", "cnt"=>"1"})->status_is(200), $tm);

   $tm = 'can create 1.0.0 name - lvlalpha-1,seq-2 no siblings' ;
   my $oid = 0 ;
   $lvlalpha = 1 ; 
   $url = '/' . $db . '/hicreate/test_hi_delete_table_doc' ; 
   ok ( $t->post_ok($url => json => {'id' => "$oid",'lvlalpha' => $lvlalpha})->status_is(200) , $tm );
   $tm = 'can set the 1.0.0 element ' ; 
   $url              = '/' . $db . '/update/test_hi_delete_table_doc' ; 
   ok ( $t->post_ok($url => json => {"attribute"=>"name", "id" =>$oid, "cnt"=>"00 - the root el"})->status_is(200), $tm);

   $oid = undef; # the ORIGIN id - aka the id where the add action originated ...
   $tm = 'can fetch the origin id for the 1.0.0 name' ;
   $url = '/' . $db . '/select/test_hi_delete_table_doc?pick=id&with=seq-eq-2';
   ok($t->get_ok($url )->status_is(200),$tm) ; $res = $ua->get($url)->result->json ; 
   foreach my $row (@{$res->{'dat'}}){ $oid = $row->{'id'} };
   
   $tm = 'can set the 1.0.0 element ' ; 
   $url              = '/' . $db . '/update/test_hi_delete_table_doc' ; 
   ok ( $t->post_ok($url => json => {"attribute"=>"name", "id" =>$oid, "cnt"=>"1.0.0 ::: title ::: "})->status_is(200), $tm);

   $tm = 'can create 2.0.0 name - lvlalpha-1,seq-2 no siblings' ;
   $lvlalpha = 0;
   $url = '/' . $db . '/hicreate/test_hi_delete_table_doc' ; 
   ok ( $t->post_ok($url => json => {'oid' => $oid,'lvlalpha' => $lvlalpha})->status_is(200) , $tm );
   
   $tm = 'can fetch the origin id for the 2.0.0 name' ;
   $url = '/' . $db . '/select/test_hi_delete_table_doc?pick=id&with=seq-eq-3';
   ok($t->get_ok($url )->status_is(200),$tm) ; $res = $ua->get($url)->result->json ; 
   foreach my $row (@{$res->{'dat'}}){ $oid = $row->{'id'} };
   my $oid_200 = $oid ; 
   
   $tm = 'can set the 2.0.0 element ' ; 
   $url              = '/' . $db . '/update/test_hi_delete_table_doc' ; 
   ok ( $t->post_ok($url => json => {"attribute"=>"name", "id" =>$oid, "cnt"=>"2.0.0 ::: title ::: "})->status_is(200), $tm);
   
   $tm = 'can create 2.1.0 name - lvlalpha-1,seq-3 with siblings' ;
   $lvlalpha = 1;
   $url = '/' . $db . '/hicreate/test_hi_delete_table_doc' ; 
   ok ( $t->post_ok($url => json => {'lvlalpha' => $lvlalpha, 'oid' => "$oid" })->status_is(200) , $tm );
   
   $oid = undef; # the ORIGIN id - aka the id where the add action originated ...
   $tm = 'can fetch the origin id for the 1.0.0 name' ;
   $url = '/' . $db . '/select/test_hi_delete_table_doc?pick=id&with=seq-eq-4';
   ok($t->get_ok($url )->status_is(200),$tm) ; $res = $ua->get($url)->result->json ; 
   foreach my $row (@{$res->{'dat'}}){ $oid = $row->{'id'} };
   my $oid_220 = $oid ;
   
   $tm = 'can set the 2.1.0 element ' ; 
   $url              = '/' . $db . '/update/test_hi_delete_table_doc' ; 
   ok ( $t->post_ok($url => json => {"attribute"=>"name", "id" =>$oid, "cnt"=>"2.1.0 ::: title ::: "})->status_is(200), $tm);
   
   my $oid_210 = undef; # the ORIGIN id - aka the id where the add action originated ...
   $tm = 'can fetch the origin id for the 3.0.0 name' ;
   $url = '/' . $db . '/select/test_hi_delete_table_doc?pick=id&with=seq-eq-4';
   ok($t->get_ok($url )->status_is(200),$tm) ; $res = $ua->get($url)->result->json ; 
   foreach my $row (@{$res->{'dat'}}){ $oid_210 = $row->{'id'} };
   $oid_210 = $res->{'dat'}->[0]->{'id'};
   
   $tm = 'can create 2.2.0 name - lvlalpha-0,seq-4 no siblings' ;
   $lvlalpha = 0 ; 
   $url = '/' . $db . '/hicreate/test_hi_delete_table_doc' ; 
   ok ( $t->post_ok($url => json => {'lvlalpha' => $lvlalpha, 'oid' => "$oid" })->status_is(200) , $tm );
  
   $oid = undef; # the ORIGIN id - aka the id where the add action originated ...
   $tm = 'can fetch the origin id for the 2.2.0 name' ;
   $url = '/' . $db . '/select/test_hi_delete_table_doc?pick=id&with=seq-eq-5';
   ok($t->get_ok($url )->status_is(200),$tm) ; $res = $ua->get($url)->result->json ; 
   foreach my $row (@{$res->{'dat'}}){ $oid = $row->{'id'} };
   $oid_220 = $oid ; 
   
   $tm = 'can set the 2.2.0 element ' ; 
   $url              = '/' . $db . '/update/test_hi_delete_table_doc' ; 
   ok ( $t->post_ok($url => json => {"attribute"=>"name", "id" =>$oid, "cnt"=>"2.2.0 ::: title ::: "})->status_is(200), $tm);
   
   $oid_220 = undef; # the ORIGIN id - aka the id where the add action originated ...
   $tm = 'can fetch the origin id for the 3.0.0 name' ;
   $url = '/' . $db . '/select/test_hi_delete_table_doc?pick=id&with=seq-eq-5';
   ok($t->get_ok($url )->status_is(200),$tm) ; $res = $ua->get($url)->result->json ; 
   foreach my $row (@{$res->{'dat'}}){ $oid_220 = $row->{'id'} };
   $oid_220 = $res->{'dat'}->[0]->{'id'};

   $tm = 'can create 3.0.0 name - lvlalpha-2,seq-6 with siblings' ;
   $lvlalpha            = -1 ; 
   $url = '/' . $db . '/hicreate/test_hi_delete_table_doc' ; 
   ok ( $t->post_ok($url => json => {'lvlalpha' => $lvlalpha, 'oid' => "$oid" })->status_is(200) , $tm );
   
   $oid = undef; # the ORIGIN id - aka the id where the add action originated ...
   $tm = 'can fetch the origin id for the 3.0.0 name' ;
   $url = '/' . $db . '/select/test_hi_delete_table_doc?pick=id&with=seq-eq-6';
   ok($t->get_ok($url )->status_is(200),$tm) ; $res = $ua->get($url)->result->json ; 
   foreach my $row (@{$res->{'dat'}}){ $oid = $row->{'id'} };
   $oid = $res->{'dat'}->[0]->{'id'};
   
   $tm = 'can set the 3.0.0 element ' ; 
   $url              = '/' . $db . '/update/test_hi_delete_table_doc' ; 
   ok ( $t->post_ok($url => json => {"attribute"=>"name", "id" =>$oid, "cnt"=>"3.0.0 ::: title ::: "})->status_is(200), $tm);
   
   

   $tm = 'can delete the 2.2.0 ';
   $url = '/' . $db . '/hidelete/test_hi_delete_table_doc' ; 
   ok ( $t->delete_ok($url => json => {'oid' => "$oid_220" })->status_is(200) , $tm );
   
   $tm = 'can delete the 2.1.0 ';
   $url = '/' . $db . '/hidelete/test_hi_delete_table_doc' ; 
   ok ( $t->delete_ok($url => json => {'oid' => "$oid_210" })->status_is(200) , $tm );
   
   $tm = 'can delete new 3.0.0 ';
   $url = '/' . $db . '/hidelete/test_hi_delete_table_doc' ; 
   ok ( $t->delete_ok($url => json => {'oid' => "$oid" })->status_is(200) , $tm );


done_testing();










