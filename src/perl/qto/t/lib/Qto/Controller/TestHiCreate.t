use strict ; use warnings ; 

use Test::Most ; 
use Test::Mojo;
use Data::Printer ; 
use FindBin;
use Mojo::UserAgent;


die_on_fail ; 

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../qto/lib" }
# relies on the following table:
# psql -d dev_qto < src/sql/pgsql/qto/tables/95.create-table-test_hi_create_table_doc.sql ;
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
   my $config        = $t->app->get('AppConfig') ; 
   my $db            = $config->{'env'}->{'db'}->{'postgres_db_name'} ; # because each instance has it's own ...
   my $ua            = $t->ua ; # the user agent , aka http client
   my $objTimer      = {} ;
   my $level         = 1 ; 
   
   $tm = 'the test_hi_create_table_doc table is truncated' ; 
   $url = '/' . $db . '/truncate/test_hi_create_table_doc' ; 
   ok ( $t->get_ok($url )->status_is(200) , $tm ) ;

   $url = '/' . $db . '/create/test_hi_create_table_doc' ; 
   ok ( $t->post_ok($url => json => {"id" => "0" })->status_is(200) , $tm );
   
   $tm = 'can create the root element - id=0,level=0,seq=1,name=document-title';
   $url = '/' . $db . '/update/test_hi_create_table_doc' ; 
   ok ( $t->post_ok($url => json => {"attribute"=>"level", "id" =>"0", "cnt"=>"0"})->status_is(200), $tm);

   $tm = 'can create 1.0.0 name - level-1,seq-2 no siblings' ;
   $url = '/' . $db . '/hicreate/test_hi_create_table_doc' ; 
   my $seq           = 1 ; # this is the ORIGIN seq  !!!
   ok ( $t->post_ok($url => json => {'seq' => "$seq" })->status_is(200) , $tm );

   sleep 1 ; 
   $tm = 'can create 2.0.0 name - level-1,seq-2 no siblings' ;
   $seq              = 2 ; # this is the ORIGIN seq  !!!
   $level            = 1 ; 
   ok ( $t->post_ok($url => json => {'level' => "$level", 'seq' => "$seq" })->status_is(200) , $tm );
   
   sleep 1 ; 
   $tm = 'can create 2.1.0 name - level-1,seq-3 with siblings' ;
   $seq              = 3 ; # this is the ORIGIN seq  !!!
   $level            = 2 ; 
   ok ( $t->post_ok($url => json => {'level' => $level, 'seq' => "$seq" })->status_is(200) , $tm );
   
   sleep 1 ; 
   $tm = 'can create 2.2.0 name - level-2,seq-4 no siblings' ;
   $seq              = 4 ; # this is the ORIGIN seq  !!!
   $level            = 2 ; 
   ok ( $t->post_ok($url => json => {'level' => $level, 'seq' => "$seq" })->status_is(200) , $tm );
   
   sleep 1 ; 
   $tm = 'can create 3.0.0 name - level-2,seq-6 with siblings' ;
   $seq              = 5 ; # this is the ORIGIN seq  !!!
   $level            = 1 ; 
   ok ( $t->post_ok($url => json => {'level' => $level, 'seq' => "$seq" })->status_is(200) , $tm );
   
   sleep 1 ; 
   $tm = 'can create 3.1.0 name - level-2,seq-7 with siblings' ;
   $seq              = 6 ; # this is the ORIGIN seq  !!!
   $level            = 2 ; 
   ok ( $t->post_ok($url => json => {'level' => $level, 'seq' => "$seq" })->status_is(200) , $tm );

   sleep 1 ; 
   $tm = 'can create 4.0.0 - can go up 1 level and create element with siblings'; 
   $seq              = 7 ; # this is the ORIGIN seq  !!!
   $level            = 1 ; 
   ok ( $t->post_ok($url => json => {'level' => $level, 'seq' => "$seq" })->status_is(200) , $tm );
   
   sleep 1 ; 
   $tm = 'can create 3.2.0 - with siblings';
   $seq              = 6 ; # this is the ORIGIN seq  !!!
   $level            = 2 ; 
   ok ( $t->post_ok($url => json => {'level' => $level, 'seq' => "$seq" })->status_is(200) , $tm );
   
   sleep 1 ; 
   $tm = 'can create 3.1.1 - with siblings';
   $seq              = 7 ; # this is the ORIGIN seq  !!!
   $level            = 3 ; 
   ok ( $t->post_ok($url => json => {'level' => $level, 'seq' => "$seq" })->status_is(200) , $tm );
   
   sleep 1 ; 
   $tm = 'can create new 3.0.0 and increase 1-st level by 1';
   $seq              = 5 ; # this is the ORIGIN seq  !!!
   $level            = 1 ; 
   ok ( $t->post_ok($url => json => {'level' => $level, 'seq' => "$seq" })->status_is(200) , $tm );


done_testing();
































