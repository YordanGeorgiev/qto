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

# use Qto::Controller::MetaDataController;
# my $objMetaDataController = 'Qto::Controller::MetaDataController'->new(\$config);
sub new {
   my $class = shift; 
   $config = ${ shift @_ } || croak 'no config provided !!!' ; 
   my $self = {}; 
   bless( $self, $class );    
   return $self;
}  


# use Qto::Controller::MetaDataController;
# my $objMetaDataController = 'Qto::Controller::MetaDataController'->new(\$config);
# $objMetaDataController->doReloadProjDbMeta($db,$item);
sub doReloadProjDbMeta {

   my $self                = shift ;
   my $db                  = shift ;
   my $item                = shift || '' ; 

   $db                     = toEnvName ( $db , $config ) ;
   $self->doReloadProjDbMetaColumns($db,$item);
   $self->doReloadProjDbMetaTables($db,$item);
}


sub doReloadProjDbMetaColumns {

   my $self                = shift ;
   my $db                  = shift ;
   my $item                = shift || '' ; 

   $db                     = toEnvName ( $db , $config ) ;

   # reload the columns meta data ONLY after the meta_columns has been requested
   # each one of those requested by the UI triggers meta data reload to redis !!!
   return if ( $item ne 'app-startup' && $item ne 'meta_columns' && $item ne 'meta_tables' && $item ne 'items_doc');

   my $objRdrDbsFcry       = {} ; 
   my $objRdrDb            = {} ; 
   my $msr2                = {} ; 
   my $ret                 = 1 ; 
   my $msg                 = "fatal error while reloading project database meta data " ; 
   my $objModel            = {} ; 

   $objModel               = 'Qto::App::Mdl::Model'->new ( \$config ) ;
   $objModel->set('postgres_db_name' , $db ) ; 
    
   $objRdrDbsFcry          = 'Qto::App::Db::In::RdrDbsFcry'->new( \$config, \$objModel );
   $objRdrDb               = $objRdrDbsFcry->doSpawn( $rdbms_type );
   ($ret, $msg , $msr2 )   = $objRdrDb->doLoadProjDbMetaCols( $db ) ; 

   #$config->{ "$db" . '.meta-columns' } = $msr2 ; # chk: it-181101180808
	#$self->app->config($config);
   #$self->render('text' => $msg ) unless $ret == 0 ; 
   my $objWtrRedis = 'Qto::App::Db::Out::WtrRedis'->new(\$config);
   $objWtrRedis->setData(\$config, $db . '.meta-columns', $msr2);
}


sub doReloadProjDbMetaTables {

   my $self                = shift ;
   my $db                  = shift ;
   my $item                = shift || '' ; 

   $db                     = toEnvName ( $db , $config ) ;

   # reload the columns meta data ONLY after the meta_columns has been requested
   return if ( $item ne 'meta_columns' && $item ne 'meta_tables' && $item ne 'items_doc');

   my $objRdrDbsFcry       = {} ; 
   my $objRdrDb            = {} ; 
   my $msr2                = {} ; 
   my $hsr                 = {} ; 
   my $ret                 = 1 ; 
   my $msg                 = "fatal error while reloading project database meta data " ; 
   my $objModel            = {} ; 

   $objModel               = 'Qto::App::Mdl::Model'->new ( \$config ) ;
   $objModel->set('postgres_db_name' , $db ) ; 
    
   $objRdrDbsFcry          = 'Qto::App::Db::In::RdrDbsFcry'->new( \$config, \$objModel );
   $objRdrDb               = $objRdrDbsFcry->doSpawn( $rdbms_type );
   ($ret, $msg , $msr2 )   = $objRdrDb->doLoadProjDbMetaTables( $db ) ; 

   #$config->{ "$db" . '.meta-tables' } = $msr2 ; # chk: it-181101180808
   my $objWtrRedis = 'Qto::App::Db::Out::WtrRedis'->new(\$config);
   $objWtrRedis->setData(\$config, $db . '.meta-tables', $msr2);


   ($ret, $msg, $hsr) = $objRdrDb->doSelectTablesList($db);
   my @tables_lst          = ();
   foreach my $rowid ( sort keys %$hsr ){
      push (@tables_lst, $hsr->{$rowid}->{'table_name'});
   }
   #$config->{ "$db" . '.tables-list' } = \@tables_lst ; 
   $objWtrRedis->setData(\$config, "$db" . '.tables-list', \@tables_lst);

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

