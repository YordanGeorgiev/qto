package Qto;

use Mojo::Base 'Mojolicious';

use strict ; use warnings ; 
use utf8;
use strict;
use autodie;
use warnings;
use warnings qw< FATAL  utf8     >;
use open qw< :std  :utf8     >;
use charnames qw< :full >;
use feature qw< unicode_strings >;

use Data::Printer ; 
use Cwd qw ( abs_path );
use File::Basename qw< basename >;
use Carp qw< carp croak confess cluck >;
use Encode qw< encode decode >;
use Unicode::Normalize qw< NFD NFC >;
use IO::Compress::Gzip 'gzip' ;

use Mojolicious::Plugin::RenderFile ; 

use Qto::App::Utils::Initiator;
use Qto::App::Utils::Logger;
use Qto::App::Mdl::Model ; 
use JSON::Parse 'json_file_to_perl';
use Qto::App::Cnvr::CnrDbName qw(toPlainName toEnvName);
use Qto::Controller::MetaDataController ; 
use Qto::App::Sec::Guardian ;

my $module_trace 					= 0;
our $objInitiator 				= {};
our $objGuardian              = {};
our $config    				   = {};
our $objLogger 					= {};
our $objModel                 = {};


#
# -----------------------------------------------------------------------------
# This method will run once at server starts
# -----------------------------------------------------------------------------
sub startup {

   my $self = shift;

   $self->doRegisterPlugins() ; 

   $self->doSessions() ; 
   
   $self->doLoadAppConfig();

   $self->doReloadProjectsDbMeta();
   
   $self->doSetHooks() ; 

   $self->doSetRoutes();


}


#
# -----------------------------------------------------------------------------
# Qto specific configuration files confs loading
# -----------------------------------------------------------------------------
sub doLoadAppConfig {

   my $self = shift ; 
   my $msg = 'error during initialization !!!';
   my $ret = 1;

   $objInitiator  = 'Qto::App::Utils::Initiator'->new();
   $config        = json_file_to_perl ($objInitiator->doResolveConfFile());
   $config->{'env'}->{'run'}->{'ProductInstanceDir'} = $objInitiator->doResolveProductInstanceDir(-1);
   $config->{'env'}->{'run'}->{'ProductName'} = $objInitiator->doResolveProductName();
   $config->{'env'}->{'run'}->{'VERSION'} = $objInitiator->doResolveVersion();
   $config->{'env'}->{'run'}->{'ENV_TYPE'} = $objInitiator->doResolveEnvType();
   $objLogger     = 'Qto::App::Utils::Logger'->new(\$config);

   my $currentShortHash = `git rev-parse --short HEAD` ; chomp($currentShortHash);
   $config->{'env'}->{'run'}->{ 'GitShortHash' } = $currentShortHash || "" ; 
   my $port = $config->{'env'}->{'app'}->{ 'port' };
   my $protocol = $config->{'env'}->{'app'}->{ 'ht_protocol' };
   my $num_of_workers = $config->{'env'}->{'app'}->{ 'num_of_workers' } || 5 ; 
   my $listen = 'http://*:'.$port;

   $self->set('ObjLogger', $objLogger );

   $config->{'hypnotoad'} = {
      listen  => [$listen],
      workers => $num_of_workers
      } ;

   $objGuardian      = 'Qto::App::Sec::Guardian'->new ( \$config ) ;
   $config->{'env'}->{'run'}->{ 'PublicRSAKey' } = $objGuardian->doGetPublicKeySecret();
   $self->set('ObjGuardian', $objGuardian );
   p $config;
   $self = $self->config( $config );
   # 
   $self->renderer->cache->max_keys(0);

   $msg = "START MAIN";
   $objLogger->doLogInfoMsg($msg);
}


# initial load into redis the metadata of all databases 
sub doReloadProjectsDbMeta {

   my $self                = shift ;
   my $config              = $self->config ; # the global config
   my $cnf                 = $self->config->{'env'}->{'db'}; # the db section only ...
   #my $proj_dbs_str       =~ s/\s+/$config->{'postgres_db_name'} . ' , ' . $config->{'project_databases'}/g;
   my $proj_dbs_str        = $cnf->{'postgres_db_name'} . ' , ' . $cnf->{'project_databases'};
   $proj_dbs_str           =~ s/\s+//g;
   my @dbs                 = split (',',$proj_dbs_str);

   foreach my $db ( @dbs ) {
      print "loading meta for db : \"" . "$db" . '"' . " \n" ; 
      my $item             = 'app-startup';
      my $objModel         = 'Qto::App::Mdl::Model'->new ( \$config , $db , $item) ; 
      $db                  = toEnvName ( $db , $config ) ;
      my $objMetaDataController = 'Qto::Controller::MetaDataController'->new(\$config, \$objModel);
      $objMetaDataController->doReloadProjDbMetaData($db,$item);
   }

   my $redis_server        = $config->{'env'}->{'redis'}->{'server'};
   my $redis_port          = $config->{'env'}->{'redis'}->{'port'};
   print "START printing the meta-data keys in redis : \n";
   print `echo 'KEYS * ' | redis-cli -h $redis_server -p $redis_port| sort`;
   print "STOP  printing the meta-data keys in redis : \n";
}


# -----------------------------------------------------------------------------
# src: https://mojolicious.org/perldoc/Mojolicious/Plugins
# -----------------------------------------------------------------------------
sub doRegisterPlugins {
   
   my $self = shift ; 
   
   $self->plugin('BasicAuthPlus');
   $self->plugin('RenderFile');
   # $self->plugin('Config');
}

#
# -----------------------------------------------------------------------------
# src: https://mojolicious.org/perldoc/Mojolicious/Guides/Routing#Hooks
# -----------------------------------------------------------------------------
sub doSetHooks {
  
   my $self = shift ; 

   $self->hook(after_dispatch => sub {
       my $c = shift;

       # was the response dynamic?
       return if $c->res->headers->header('Expires');

       # if so, try to prevent caching
       $c->res->headers->header(
           "Expires" => Mojo::Date->new(time-365*86400)
       );
       $c->res->headers->header(
           "Cache-Control" => "max-age=1, no-cache"
       );
   });


   $self->hook( 'before_dispatch' => sub {
      my $c = shift;
      $c->res->headers->cache_control('max-age=604800, no-cache');
      $c->res->headers->accept_charset('UTF-8');
      $c->res->headers->accept_language('fi, en');

      # qto-200302161711
      # get the app config
      # get the guardian $objGuardian
      # get the RBAC list from the Redis
      # get the jwt from the session 
      # get the public key from the session
      #

   });


   $self->hook( 'after_static' => sub {
       my $c = shift;
       my $code = $c->res->code;
       my $type = $c->res->headers->content_type;

       $c->res->headers->remove('Cache-Control');
       $c->res->headers->remove('Set-Cookie');

       # resolve an expiry date
       my $e = Mojo::Date->new(time+600);
       if ($type) {
           if ($type =~ /javascript/) {
               $e = Mojo::Date->new(time+300);
           }
           elsif ($type =~ /^text\/css/ || $type =~ /^image\//) {
               $e = Mojo::Date->new(time+3600);
               $c->res->headers->cache_control('max-age=604800, only-if-cached'); 
           }
       }
       $c->res->headers->header(Expires => $e);
   });


	$self->hook( 'after_render' => sub {
	  my ($c, $output, $format) = @_;

	  # check if user agent accepts gzip compression
	  return unless ($c->req->headers->accept_encoding // '') =~ /gzip/i;
	  $c->res->headers->append( 'Vary' => 'Accept-Encoding');

	  # compress content with gzip
	  $c->res->headers->content_encoding('gzip');
	  gzip $output, \my $compressed;
	  $$output = $compressed;
	});


}

 
# -----------------------------------------------------------------------------
# src: https://mojolicious.org/perldoc/Mojolicious/Sessions
# -----------------------------------------------------------------------------
sub doSessions {
   
   my $self = shift ; 
   $self->sessions->default_expiration(86400); # set expiry to 1 day
   $self->secrets(['Mojolicious rocks!!!' . rndStr(12, 'A'..'Z', 0..9, 'a'..'z')]);

}


# -----------------------------------------------------------------------------
# src: https://mojolicious.org/perldoc/Mojolicious/Guides/Routing
# -----------------------------------------------------------------------------
sub doSetRoutes {
   
   my $self = shift ; 
   my $r = $self->routes;
   
   $r->get('/')->to(
     controller   => 'Index'
   , action       => 'doServeIndex'
   );
   
   $r->get('/:db/home')->to(
     controller   => 'Search'
   , action       => 'doSearchItems'
   );
   
   $r->get('/:db/login')->to(
     controller   => 'Login'
   , action       => 'doInitShowLoginUI'
   );
   
   $r->get('/:db/logon')->to(
     controller   => 'Logon'
   , action       => 'doInitShowLogonUI'
   );
   
   $r->post('/:db/login')->to(
     controller   => 'Login'
   , action       => 'doLoginUser'
   );
   
   $r->post('/:db/logon')->to(
     controller   => 'Logon'
   , action       => 'doLogonUser'
   );
   
   $r->get('/:db/search')->to(
     controller   => 'Search'
   , action       => 'doSearchItems'
   );
   
   $r->get('/:db/report/:report_name')->to(
     controller   => 'Report'
   , action       => 'doListReportResultItems'
   );
   
   $r->get('/:db/query')->to(
     controller   => 'Query'
   , action       => 'doQueryItems'
   );
	
   $r->get('/:db/call-func/:func')->to(
     controller   => 'CallFunc'
   , action       => 'doCallFunc'
   );


   $r->get('/:db/select-databases')->to(
     controller   => 'Select'
   , action       => 'doSelectDatabases'
   );

   $r->get('/:db/select-tables')->to(
     controller   => 'Select'
   , action       => 'doSelectTables'
   );
   
   
   $r->get('/:db/hiselect/:item')->to(
     controller   => 'HiSelect'
   , action       => 'doHiSelectItems'
   );
  
    
   $r->post('/:db/create/:item')->to(
     controller   => 'Create'
   , action       => 'doCreateById'
   );
   
   $r->post('/:db/hicreate/:item')->to(
     controller   => 'HiCreate'
   , action       => 'doHiCreate'
   );
   
   $r->delete('/:db/delete/:item')->to(
     controller   => 'Delete'
   , action       => 'doRemoveById'
   );
   
   $r->delete('/:db/hidelete/:item')->to(
     controller   => 'HiDelete'
   , action       => 'doHiDelete'
   );
   
   $r->get('/:db/truncate/:item')->to(
     controller   => 'Truncate'
   , action       => 'doTruncateItem'
   );
   
   $r->post('/:db/update/:item')->to(
     controller   => 'Update'
   , action       => 'doUpdateById'
   );
   
   $r->get('/:db/select/:item')->to(
     controller   => 'Select'
   , action       => 'doSelectItems'
   );

   $r->get('/:db/select-meta')->to(
     controller   => 'Select'
   , action       => 'doSelectMeta'
   );

   $r->get('/:db/select-meta/:item')->to(
     controller   => 'Select'
   , action       => 'doSelectMeta'
   );
   
   $r->get('/:db/list/:item')->to(
     controller   => 'List'
   , action       => 'doListItems'
   );

   $r->get('/:db/export/:item')->to(
     controller   => 'Export'
   , action       => 'doExportItems'
   );
   
   $r->get('/:db/view/:item')->to(
     controller   => 'View'
   , action       => 'doViewItems'
   );

   $r->any('/:db/*')->to(
     controller   => 'Search'
   , action       => 'doSearchItems'
   );
   
   $r->post('/upload-files/')->to(
     controller   => 'Upload'
   , action       => 'doUploadFiles'
   );

   $r->websocket('/ws-select-items')->to('WsSelect#doWsSelectTables');
   $r->websocket('/wsecho')->to('WSSelect#wsecho');
}


# -----------------------------------------------------------------------------
# return a field's value - aka the "getter"
# -----------------------------------------------------------------------------
sub get {

   my $self = shift;
   my $name = shift;
   croak "\@TRYING to get an undef name" unless $name ;  
   croak "\@TRYING to get an undefined value" unless ( $self->{"$name"} ) ; 

   return $self->{ $name };
}    

# -----------------------------------------------------------------------------
# set a field's value - aka the "setter"
# -----------------------------------------------------------------------------
sub set {

   my $self  = shift;
   my $name  = shift;
   my $value = shift;
   $self->{ "$name" } = $value;
}

# -----------------------------------------------------------------------------
# return the fields of this obj instance. Perl vs. Java - checkmate !!!
# -----------------------------------------------------------------------------
sub dumpFields {
   my $self      = shift;
   my $strFields = ();
   foreach my $key ( keys %$self ) {
      $strFields .= " $key = $self->{$key} \n ";
   }

   return $strFields;
}    

sub rndStr{ join'', @_[ map{ rand @_ } 1 .. shift ] }


1;
