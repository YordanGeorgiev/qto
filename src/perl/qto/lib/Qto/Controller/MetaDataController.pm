package Qto::Controller::MetaDataController ; 
use strict ; use warnings ; 

my $VERSION = '1.0.0';    
require Exporter;
use AutoLoader  ;
our @ISA    = qw(Exporter);
use Carp qw(cluck croak);
our @EXPORT_OK = qw(setData);

use Data::Printer ; 
use Qto::App::Db::In::RdrDbsFcry ; 
use Qto::App::Cnvr::CnrHsr2ToHsr2 ; 
use Qto::App::Cnvr::CnrDbName qw(toPlainName toEnvName);
use Qto::App::Db::Out::WtrRedis ; 
use Qto::App::Db::In::RdrRedis ; 

our $module_trace    = 0 ; 
our $config          = {};
our $objLogger       = {} ;
our $rdbms_type      = 'postgres' ; 
our $objModel        = '' ; 

# use Qto::Controller::MetaDataController;
# my $objMetaDataController = 'Qto::Controller::MetaDataController'->new(\$config);
sub new {
   my $class = shift; 
   $config = ${ shift @_ } || croak 'no config provided !!!' ; 
	$objModel = ${ shift @_ } || croak 'objModel not passed !!!' ; 
   my $self = {}; 
   bless( $self, $class );    
   return $self;
}  


# use Qto::Controller::MetaDataController;
# my $objMetaDataController = 'Qto::Controller::MetaDataController'->new(\$config);
# $objMetaDataController->doReloadProjDbMeta($db,$item);
sub doReloadProjDbMetaData {

   my $self          = shift ;
   my $db            = shift ;
   my $item          = shift || '' ; 
   $db               = toEnvName ( $db , $config ) ;
   $objModel->set('postgres_db_name' , $db ) ; 
   # reload the columns meta data ONLY after the meta_columns has been requested
   # each one of those requested by the UI triggers meta data reload to redis !!!
   if ( $item eq 'app-startup' or $item eq 'meta_columns' or $item eq 'meta_tables' or $item eq 'items_doc') {

      my $objWtrRedis = 'Qto::App::Db::Out::WtrRedis'->new(\$config);
      $self->doReloadProjDbMetaColumns($db,$item,\$objWtrRedis);
      $self->doReloadProjDbMetaTables($db,$item,\$objWtrRedis);
      $self->doReloadProjDbRBACList($db,$item,\$objWtrRedis);
      $self->doReloadMetaRoutes($db,\$objWtrRedis);

   } else {
      my $objRdrRedis   = 'Qto::App::Db::In::RdrRedis'->new(\$config);
      my $meta_tables   = $objRdrRedis->getData(\$config,"$db" . '.meta-tables');
      my $meta_columns  = $objRdrRedis->getData(\$config,"$db" . '.meta-columns');
      my $tables_list   = $objRdrRedis->getData(\$config,"$db" . '.tables-list');
      my $rbac_list     = $objRdrRedis->getData(\$config,"$db" . '.rbac-list');
      
      $objModel->set($db . '.meta-columns',  $meta_columns);
      $objModel->set($db . '.meta-tables',   $meta_tables);
      $objModel->set($db . '.tables-list',   $tables_list);
      $objModel->set($db . '.rbac-list',     $rbac_list);
   }
}


sub doReloadProjDbMetaColumns {

   my $self                = shift ;
   my $db                  = shift ;
   my $item                = shift || '' ; 
	my $objWtrRedis         = ${ shift @_ } || croak 'objWtrRedis not passed !!!' ; 
   my $objRdrDbsFcry       = {} ; 
   my $objRdrDb            = {} ; 
   my $msr2                = {} ; 
   my $ret                 = 1 ; 
   my $msg                 = "fatal error while reloading project database meta data " ; 

    
   $objRdrDbsFcry          = 'Qto::App::Db::In::RdrDbsFcry'->new( \$config, \$objModel );
   $objRdrDb               = $objRdrDbsFcry->doSpawn( $rdbms_type );
   ($ret, $msg , $msr2 )   = $objRdrDb->doLoadProjDbMetaCols( $db ) ; 

   $objWtrRedis->setData(\$config, $db . '.meta-columns', $msr2);
   $objModel->set($db . '.meta-columns',$msr2);
}


sub doReloadProjDbMetaTables {

   my $self                = shift ;
   my $db                  = shift ;
   my $item                = shift || '' ; 
	my $objWtrRedis         = ${ shift @_ } || croak 'objWtrRedis not passed !!!' ; 
   my $objRdrDbsFcry       = {} ; 
   my $objRdrDb            = {} ; 
   my $msr2                = {} ; 
   my $hsr                 = {} ; 
   my $ret                 = 1 ; 
   my $msg                 = "fatal error while reloading project database meta data " ; 

   $objRdrDbsFcry          = 'Qto::App::Db::In::RdrDbsFcry'->new( \$config, \$objModel );
   $objRdrDb               = $objRdrDbsFcry->doSpawn( $rdbms_type );
   ($ret, $msg , $msr2 )   = $objRdrDb->doLoadProjDbMetaTables( $db ) ; 

   $objWtrRedis->setData(\$config, $db . '.meta-tables', $msr2);
   $objModel->set($db . '.meta-tables',$msr2);

   ($ret, $msg, $hsr)      = $objRdrDb->doSelectTablesList($db);
   my @tables_lst          = ();
   foreach my $rowid ( sort keys %$hsr ){
      push (@tables_lst, $hsr->{$rowid}->{'table_name'});
   }
   $objWtrRedis->setData(\$config, "$db" . '.tables-list', \@tables_lst);
   $objModel->set("$db" . '.tables-list',\@tables_lst);

}


# reload the project db Roles Based Access Control List
sub doReloadProjDbRBACList {

   my $self                = shift ;
   my $db                  = shift ;
   my $item                = shift || '' ; 
	my $objWtrRedis         = ${ shift @_ } || croak 'objWtrRedis not passed !!!' ; 
   my $objRdrDbsFcry       = {} ; 
   my $objRdrDb            = {} ; 
   my $arr                 = () ; 
   my $ret                 = 1 ; 
   my $msg                 = "fatal error while reloading project database meta data " ; 

   $objRdrDbsFcry          = 'Qto::App::Db::In::RdrDbsFcry'->new( \$config, \$objModel );
   $objRdrDb               = $objRdrDbsFcry->doSpawn( $rdbms_type );
   ($ret, $msg , $arr )    = $objRdrDb->doLoadProjDbRBACList( $db ) ; 

   $objWtrRedis->setData(\$config, $db . '.rbac-list', $arr);
   $objModel->set($db . '.rbac-list',$arr);

}

# reload the project db Roles Based Access Control List
sub doReloadMetaRoutes {

   my $self                = shift ;
   my $db                  = shift ;
   $db                     = toEnvName ( $db , $config ) ;
	my $objWtrRedis         = ${ shift @_ } || croak 'objWtrRedis not passed !!!' ; 
   my $objRdrDbsFcry       = {} ; 
   my $objRdrDb            = {} ; 
   my $hsr                 = {} ;
   my $ret                 = 1 ; 
   my $msg                 = "fatal error while reloading project database meta data " ; 

   $objModel->set('postgres_db_name' , $db ) ; 
   $objRdrDbsFcry          = 'Qto::App::Db::In::RdrDbsFcry'->new( \$config, \$objModel );
   $objRdrDb               = $objRdrDbsFcry->doSpawn( $rdbms_type , $db);
   ($ret, $msg , $hsr )    = $objRdrDb->doCallFuncGetHashRef('func_get_meta_routes','id'); # by convention ?!
   
   $objWtrRedis->setData(\$config, $db . '.meta-routes', $hsr);

}

1;

__END__

=head1 NAME

MetaDataController

=head1 SYNOPSIS

require Exporter;
our @ISA = qw(Exporter Mojo::Base Qto::Controller::MetaDataController);
our $AUTOLOAD =();
our $ModuleDebug = 0 ; 
use AutoLoader;

use parent qw(Qto::Controller::MetaDataController);


=head1 DESCRIPTION
the parent for all Qto application controllers

=head2 EXPORT


=head1 SEE ALSO


Qto::Controller::MetaDataController ; 


=head1 AUTHOR

yordan.georgiev@gmail.com

=head1 




=cut 

