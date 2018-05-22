package IssueTracker::Controller::Select;
use strict ; use warnings ; 
use Mojo::Base 'Mojolicious::Controller';

use Data::Printer ; 
use Data::Dumper; 
use Scalar::Util qw /looks_like_number/;

use IssueTracker::App::Db::In::RdrDbsFactory;
use IssueTracker::App::Utils::Logger;
use IssueTracker::App::Cnvr::CnrHsr2ToArray ; 

our $module_trace   = 0 ;
our $appConfig      = {};
our $objLogger      = {} ;
our $rdbms_type     = 'postgre';


#
# --------------------------------------------------------
# Select all the rows from db by passed db and table name
# --------------------------------------------------------
sub doSelectMeta {

   my $self        = shift;
   my $item        = $self->stash('item');
   my $db          = $self->stash('db');
   my $rdbms_type  = 'postgres';

	print "Select.pm ::: url: " . $self->req->url->to_abs . "\n\n" if $module_trace == 1 ; 

   $appConfig		= $self->app->get('AppConfig');
   my $objModel         = 'IssueTracker::App::Mdl::Model'->new ( \$appConfig ) ;
   $objModel->set('postgres_db_name' , $db ) ; 
 
   my $ret = 0;
   my $msg = 'unknown error during Select item';

   my $objRdrDbsFactory
      = 'IssueTracker::App::Db::In::RdrDbsFactory'->new(\$appConfig, \$objModel );
   my $objRdrDb = $objRdrDbsFactory->doInstantiate("$rdbms_type");
   ($ret, $msg) = $objRdrDb->doSelectTablesColumnList($item);

   $self->res->headers->accept_charset('UTF-8');
   $self->res->headers->accept_language('fi, en');
   $self->res->headers->content_type('application/json; charset=utf-8');


   if ( $ret == 0 ) {
      my $list = () ; # an array ref holding the converted hash ref of hash refs 
      my $http_code = 200 ; 
      $msg = "SELECT meta OK for table: $item" ; 
      my $objCnrHsr2ToArray = 
         'IssueTracker::App::Cnvr::CnrHsr2ToArray'->new ( \$appConfig , \$objModel ) ; 
      ( $ret , $msg , $list ) = $objCnrHsr2ToArray->doConvert($objModel->get('hs_headers'));

      unless ( $ret == 0 ) {
         $http_code = 400 ; 
         $list = '' ;
      }
      
      $self->res->code($http_code);
      $self->render( 'json' =>  { 
           'msg'   => $msg
         , 'dat'   => $list
         , 'ret'   => $http_code
         , 'req'   => "GET " . $self->req->url->to_abs
      });
   } elsif ( $ret == 400 ) {

      $self->res->code(400);
      $self->render( 'json' =>  { 
         'msg'   => $msg,
         'ret'   => 400, 
         'req'   => "GET " . $self->req->url->to_abs
      });
   } elsif ( $ret == 2 ) {

      $self->res->code(400);
      $self->render( 'json' =>  { 
         'msg'   => $msg,
         'ret'   => 400, 
         'req'   => "GET " . $self->req->url->to_abs
      });
   } elsif ( $ret == 1 ) {
      $msg = " the table $item does not exist " ; 
      $self->res->code(400);
      $self->render( 'json' =>  { 
         'msg'   => $msg,
         'ret'   => 400, 
         'req'   => "GET " . $self->req->url->to_abs
      });
   } else {

      $msg = 'unknown error has occurred' ; 
      $self->res->code(400);
      $self->render( 'json' => { 
         'msg'   => $msg,
         'ret' => 404, 
         'req'   => "GET " . $self->req->url->to_abs
      })
      ;
   }
}

sub doSetUrlParams {
   my $self = shift ; 
   my $objModel = ${ shift @_ } ; 

   my $query_params = $self->req->query_params ; 

   $objModel->set('select.web-action.fltr-by' , $query_params->every_param('fltr-by') ) ; 
   $query_params->remove('fltr-by') ; 
   $objModel->set('select.web-action.fltr-val' , $query_params->every_param('fltr-val') ) ; 
   $query_params->remove('fltr-val') ; 
   $objModel->set('select.web-action.like-by' , $query_params->every_param('like-by') ) ; 
   $query_params->remove('like-by') ; 
   $objModel->set('select.web-action.like-val' , $query_params->every_param('like-val') ) ; 
   $query_params->remove('like-val') ; 
   $objModel->set('select.web-action.pick' , $query_params->param('pick') );
   $query_params->remove('pick') ; 
   $objModel->set('select.web-action.hide' , $query_params->param('hide') );
   $query_params->remove('hide') ; 
   $objModel->set('select.web-action.o' , $query_params->param('o') );
   $query_params->remove('o') ; 
   
 
   my ( @with_cols , @with_ops , @with_vals ) = () ; 
   my $found = 0 ; 
   foreach my $qp ( @{$query_params->pairs} ) {
      if ( $qp =~ m/with[-](.*?)/g ) {
        my $with_col = $qp ; 
        $with_col =~ s/(with[-])(.*)/$2/g ; 
        print "with_col: $with_col \n" ; 
        if ( $with_col =~ m/(.*?)([<>])(.*)/g ) {
            print "$1 , $2 , $3 \n" ; 
            push @with_cols , $1 ; 
            push @with_ops , $2 ; 
            push @with_vals , $3 ; 
            $found = 0 ; 
            next ; 
        }

        $found = 1 ; 
        push @with_cols , $with_col ; 
        next ; 
      } 
      
      if ( $found == 1 ) {
         $found = 0 ; 
         push @with_ops , '=' ; 
         push @with_vals , $qp ; 
         next ; 
      }
   }

   $objModel->set('select.web-action.with-by' , \@with_cols ) ; 
   $objModel->set('select.web-action.with-op' , \@with_ops ) ; 
   $objModel->set('select.web-action.with-val' , \@with_vals ) ; 
   # p $objModel ; 
}


#
# --------------------------------------------------------
# Select all the rows from db by passed db and table name
# --------------------------------------------------------
sub doSelectItems {

   my $self        = shift;
   my $item        = $self->stash('item');
   my $db          = $self->stash('db');
   my $rdbms_type  = 'postgres';

	print "Select.pm ::: url: " . $self->req->url->to_abs . "\n\n" if $module_trace == 1 ; 

   $appConfig		= $self->app->get('AppConfig');
   my $objModel         = 'IssueTracker::App::Mdl::Model'->new ( \$appConfig ) ;
   $objModel->set('postgres_db_name' , $db ) ; 
 
   my $ret = 0;
   my $msg = 'unknown error during Select item';

   $self->doSetUrlParams ( \$objModel ) ; 

   my $hsr2 = {};
   my $objRdrDbsFactory
      = 'IssueTracker::App::Db::In::RdrDbsFactory'->new(\$appConfig, \$objModel );
   my $objRdrDb = $objRdrDbsFactory->doInstantiate("$rdbms_type");
   ($ret, $msg) = $objRdrDb->doSelectTableIntoHashRef(\$objModel, $item);

   $self->res->headers->accept_charset('UTF-8');
   $self->res->headers->accept_language('fi, en');
   $self->res->headers->content_type('application/json; charset=utf-8');


   if ( $ret == 0 ) {
      my $list = () ; # an array ref holding the converted hash ref of hash refs 
      my $http_code = 200 ; 
      $msg = "SELECT OK for table: $item" ; 
      my $objCnrHsr2ToArray = 
         'IssueTracker::App::Cnvr::CnrHsr2ToArray'->new ( \$appConfig , \$objModel ) ; 
      ( $ret , $msg , $list ) = $objCnrHsr2ToArray->doConvert ($objModel->get('hsr2'));

      unless ( $ret == 0 ) {
         $http_code = 400 ; 
         $list = '' ;
      }
      
      $self->res->code($http_code);
      $self->render( 'json' =>  { 
           'msg'   => $msg
         , 'dat'   => $list
         , 'ret'   => $http_code
         , 'req'   => "GET " . $self->req->url->to_abs
      });
   } elsif ( $ret == 400 ) {

      $self->res->code(400);
      $self->render( 'json' =>  { 
         'msg'   => $msg,
         'ret'   => 400, 
         'req'   => "GET " . $self->req->url->to_abs
      });
   } elsif ( $ret == 2 ) {

      $self->res->code(400);
      $self->render( 'json' =>  { 
         'msg'   => $msg,
         'ret'   => 400, 
         'req'   => "GET " . $self->req->url->to_abs
      });
   } else {

      $msg = 'unknown error has occurred' ; 
      $self->res->code(400);
      $self->render( 'json' => { 
         'msg'   => $msg,
         'ret' => 404, 
         'req'   => "GET " . $self->req->url->to_abs
      })
      ;
   }
}


#
# --------------------------------------------------------
# provide the following json response of the tables Select in the db
# {
#  "1": {
#    "row_id": "1",
#    "table_catalog": "dev_issue_tracker",
#    "table_name": "confs",
#    "table_schema": "public"
#  }, ...
# }
# --------------------------------------------------------
sub doSelectTables {

	my $self       = shift;
	my $db         = $self->stash('db');
	my $rdbms_type = 'postgres';
   my $msg = 'unknown error during select-tables';

	$appConfig	   = $self->app->get('AppConfig');
   my $objModel   = 'IssueTracker::App::Mdl::Model'->new ( \$appConfig ) ;

	$objModel->set('postgres_db_name' , $db ) ; 

	my $ret = 0;
	my $hsr2 = {};

	my $objRdrDbsFactory
			= 'IssueTracker::App::Db::In::RdrDbsFactory'->new(\$appConfig, \$objModel );

	my $objRdrDb = $objRdrDbsFactory->doInstantiate("$rdbms_type");
	($ret, $msg) = $objRdrDb->doSelectTablesList(\$objModel);

	$self->res->headers->accept_charset('UTF-8');
	$self->res->headers->accept_language('fi, en');
	$self->res->headers->content_type('application/json; charset=utf-8');

   if ( $ret == 0 ) {

      my $list = () ; # an array ref holding the converted hash ref of hash refs 
      my $objCnrHsr2ToArray = 
         'IssueTracker::App::Cnvr::CnrHsr2ToArray'->new ( \$appConfig , \$objModel ) ; 
      ( $ret , $msg , $list ) = $objCnrHsr2ToArray->doConvert($objModel->get('hsr2'));

      $self->res->headers->content_type('application/json; charset=utf-8');
      $self->res->code(200);
      $self->render( 'json' =>  { 
           'msg'   => $msg
         , 'dat'   => $list
         , 'ret'   => 200
         , 'req'   => "GET " . $self->req->url->to_abs
      });

   } elsif ( $ret == 400 ) {

      $self->res->code(404);
      $self->render( 'json' =>  { 
         'msg'   => $msg,
         'ret'   => 404, 
         'req'   => "GET " . $self->req->url->to_abs
      })
      ;
   } elsif ( $ret == 2 ) {

      $self->res->code(400);
      $self->render( 'json' =>  { 
         'msg'   => $msg,
         'ret'   => 400, 
         'req'   => "GET " . $self->req->url->to_abs
      });
   } else {

      $self->res->code(404);
      $msg = 'unknown error has occurred' ; 
      $self->render( 'json' => { 
         'msg'   => $msg,
         'ret'   => 404, 
      })
      ;
   }

}


1;

__END__

# feature-guid: ecd424d7-e5bd-45f1-90c8-10fae1316bf9
