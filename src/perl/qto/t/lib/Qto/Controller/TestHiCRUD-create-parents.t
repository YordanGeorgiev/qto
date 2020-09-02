use strict ; use warnings ; 

use Test::Most ; 
use Test::Mojo;
use Data::Printer ; 
use FindBin;
use Mojo::UserAgent;
use JSON ;
use Data::Printer;
use Test::Deep; 
die_on_fail ; 

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../qto/lib" }
   $ENV{'QTO_NO_AUTH'} = 1;

# ALL THE TestHiCRUD-nn test scripts MUST PASS to have a fully working hierarchichal CRUD !!!
# 1. open your browser at http://host-name:3001/qto/view/test_hierarchy_doc?&pg-size=100&pick=seq,level,lft,rgt,name,description&oa=seq
# 2. open your browser at http://host-name:3001/qto/list/test_hierarchy_doc?&pg-size=100&pick=seq,level,lft,rgt,name,description&oa=seq
# when ran those will show the final state , but to see the initial state chk bellow which line to disable 

sub main {


   my $tm            = '' ; # the test message for each test 
   my $res           = {} ; 
   my $url           = {} ; 
   my $exp_err_msg   = '' ; 
   my $t             = Test::Mojo->new('Qto');
   my $config        = $t->app->config ; 
   my $db            = $config->{'env'}->{'db'}->{'postgres_db_name'} ; # because each instance has it's own ...
   my $ua            = $t->ua ; # the user agent , aka http client
   my $objTimer      = {} ;
   my $cnt           = 'the content of a cell' ; 


   my $inn_json = <<'EOF_INN_JSON_01';

[
    {
      "description": " ",
      "guid": "0a48d2f0-3baa-473e-bf04-955228e78b3f",
      "id": 0,
      "level": 0,
      "name": "0",
      "lft": 1,
      "rgt": 10,
      "seq": 1
    },
    {
      "description": " ",
      "guid": "787b280a-0c2b-4cc8-a189-3ae5748ddf53",
      "id": 200726094848,
      "level": 1,
      "name": "1.0",
      "lft": 2,
      "rgt": 7,
      "seq": 2
    },
    {
      "description": " ",
      "guid": "f3bad87a-8e7f-4842-9458-7b4aad29b4e0",
      "id": 200726101948,
      "level": 2,
      "name": "1.1",
      "lft": 3,
      "rgt": 4,
      "seq": 3
    },
    {
      "description": " ",
      "guid": "0d42a4d9-81de-4e47-a540-46928e2ee042",
      "id": 200726102001,
      "level": 2,
      "name": "1.2",
      "lft": 5,
      "rgt": 6,
      "seq": 4
    },
    {
      "description": " ",
      "guid": "0e96db6e-2935-4b01-9ccd-c9b478119077",
      "id": 200726101411,
      "level": 1,
      "name": "2.0",
      "lft": 8,
      "rgt": 9,
      "seq": 5
    }
  ]
EOF_INN_JSON_01

my $exp_json = << 'EOF_EXP_JSON_01';

[
    {
      "description": " ",
      "guid": "0a48d2f0-3baa-473e-bf04-955228e78b3f",
      "id": 0,
      "level": 0,
      "lft": 1,
      "name": "0",
      "rgt": 12,
      "seq": 1
    },
    {
      "description": " ",
      "guid": "787b280a-0c2b-4cc8-a189-3ae5748ddf53",
      "id": 200726094848,
      "level": 1,
      "lft": 2,
      "name": "1.0",
      "rgt": 7,
      "seq": 2
    },
    {
      "description": " ",
      "guid": "0e96db6e-2935-4b01-9ccd-c9b478119077",
      "id": 200726101411,
      "level": 1,
      "lft": 10,
      "name": "2.0",
      "rgt": 11,
      "seq": 6 
    },
    {
      "description": " ",
      "guid": "f3bad87a-8e7f-4842-9458-7b4aad29b4e0",
      "id": 200726101948,
      "level": 2,
      "lft": 3,
      "name": "1.1",
      "rgt": 4,
      "seq": 3
    },
    {
      "description": " ",
      "guid": "0d42a4d9-81de-4e47-a540-46928e2ee042",
      "id": 200726102001,
      "level": 2,
      "lft": 5,
      "name": "1.2",
      "rgt": 6,
      "seq": 4
    },
    {
      "description": null,
      "guid": "%guid%",
      "id": %id%,
      "level": 1,
      "lft": 8,
      "name": "name...",
      "rgt": 9,
      "seq": 5
    }

]

EOF_EXP_JSON_01

   $url = '/' . $db . '/truncate/test_hierarchy_doc' ; 
   ok ( $t->get_ok($url )->status_is(200) , $tm ) ;
   
   $url = '/' . $db . '/multi-create/test_hierarchy_doc' ; 
   my $obj_inn_json = JSON->new->utf8->decode($inn_json);
   my $json = JSON->new->utf8->encode($obj_inn_json);
   # p $json ; 
   ok ( $t->post_ok($url => json => $obj_inn_json)->status_is(200) , $tm );

   $url = '/' . $db . '/hicreate/test_hierarchy_doc' ; 
   my $oid = '200726102001' ;  # right click on the 1.2
   my $lvlalpha = "-1" ; # level alpha of -1 means "add a parent node"

	# !!! disable this row to see in the UI what was the initial starting point before the addition !!!
   ok ( $t->post_ok($url => json => {'oid' => "$oid", 'lvlalpha' => $lvlalpha})->status_is(200) , $tm );

	$url = '/' . $db . '/select/test_hierarchy_doc?&pg-size=100&pick=seq,level,lft,rgt,name,description&oa=seq';
   my $result = $ua->get($url)->result->json->{'dat'}; 

	my $tms = "for adding parent element from the last subnode element having siblings ( 1.2)";

	my $fake_guid = '' ; my $fake_id = ''; 
	foreach my $el ( @$result ){ 
		$fake_guid = $el->{'guid'} if $el->{'name'} eq 'name...';
		$fake_id = $el->{'id'} if $el->{'name'} eq 'name...';
	}
	$exp_json =~ s/%guid%/$fake_guid/g;
	$exp_json =~ s/%id%/$fake_id/g;
   my $obj_exp_json = JSON->new->utf8->decode($exp_json);
	cmp_deeply( $result , $obj_exp_json, $tms );
	#p $obj_exp_json; 
	#print "obj_exp_json \n\n";
   

   #test-02
	$inn_json = $exp_json;
   $exp_json = <<EOF_EXP_JSON_02
	[
    {
      "description": " ",
      "guid": "0a48d2f0-3baa-473e-bf04-955228e78b3f",
      "id": 0,
      "level": 0,
      "lft": 1,
      "name": "0",
      "rgt": 10,
      "seq": 1
    },
    {
      "description": " ",
      "guid": "787b280a-0c2b-4cc8-a189-3ae5748ddf53",
      "id": 200726094848,
      "level": 1,
      "lft": 2,
      "name": "1.0",
      "rgt": 7,
      "seq": 2
    },
    {
      "description": " ",
      "guid": "f3bad87a-8e7f-4842-9458-7b4aad29b4e0",
      "id": 200726101948,
      "level": 2,
      "lft": 3,
      "name": "1.1",
      "rgt": 4,
      "seq": 3
    },
    {
      "description": " ",
      "guid": "0d42a4d9-81de-4e47-a540-46928e2ee042",
      "id": 200726102001,
      "level": 2,
      "lft": 5,
      "name": "1.2",
      "rgt": 6,
      "seq": 4
    },
    {
      "description": null,
      "guid": "%guid%",
      "id": %id%,
      "level": 1,
      "lft": 8,
      "name": "name...",
      "rgt": 9,
      "seq": 5
    }
	]
EOF_EXP_JSON_02
;
   $tm = 'can delete the last node 2.0 ';
	my $id_to_delete = '200726101411' ;
   $url = '/' . $db . '/hidelete/test_hierarchy_doc' ; 
   ok ( $t->delete_ok($url => json => {'oid' => "$id_to_delete" })->status_is(200) , $tm );
	$url = '/' . $db . '/select/test_hierarchy_doc?&pg-size=100&pick=seq,level,lft,rgt,name,description&oa=seq';
   $result = $ua->get($url)->result->json->{'dat'}; 

	$tms = "for adding parent element from the last subnode element having siblings ( 1.2)";

	$fake_guid = '' ; $fake_id = ''; 
	foreach my $el ( @$result ){ 
		$fake_guid = $el->{'guid'} if $el->{'name'} eq 'name...';
		$fake_id = $el->{'id'} if $el->{'name'} eq 'name...';
	}
	$exp_json =~ s/%guid%/$fake_guid/g;
	$exp_json =~ s/%id%/$fake_id/g;
   $obj_exp_json = JSON->new->utf8->decode($exp_json);
	cmp_deeply( $result , $obj_exp_json, $tms );
done_testing();
}

main();

1;

__END__
