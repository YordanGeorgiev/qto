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
use URL::Encode qw(url_encode url_decode);

use Mojolicious::Plugin::RenderFile ; 

use Qto::App::Utils::Initiator;
use Qto::App::Utils::Logger;
use Qto::App::Mdl::Model ; 
use JSON::Parse 'json_file_to_perl';
use Qto::App::Cnvr::CnrDbName qw(toPlainName toEnvName);
use Qto::Controller::MetaDataController ; 
use Qto::App::IO::In::RdrDirs ; 
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

   $self->doSetSessions() ; 
   
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
	my $ProductInstanceDir = $objInitiator->doResolveProductInstanceDir(-1); 
   $config->{'env'}->{'run'}->{'ProductInstanceDir'} = $ProductInstanceDir ; 
   $config->{'env'}->{'run'}->{'ProductName'} = $objInitiator->doResolveProductName();
   $config->{'env'}->{'run'}->{'VERSION'} = $objInitiator->doResolveVersion();
   $config->{'env'}->{'run'}->{'ENV_TYPE'} = $objInitiator->doResolveEnvType();
   $objLogger     = 'Qto::App::Utils::Logger'->new(\$config);

   my $currentShortHash = `git rev-parse --short HEAD` ; chomp($currentShortHash);
   $config->{'env'}->{'run'}->{ 'GitShortHash' } = $currentShortHash || "" ; 
   my $port = $config->{'env'}->{'app'}->{ 'port' };
   my $protocol = $config->{'env'}->{'app'}->{ 'ht_protocol' };
   my $num_of_workers = $config->{'env'}->{'app'}->{ 'num_of_workers' } || 5 ; 
   my $inactivity_timeout = $config->{'env'}->{'app'}->{ 'inactivity_timeout' } || 60 ;
   my $listen = 'http://*:'.$port;

   $self->set('ObjLogger', $objLogger );

	# qto-200326084258
   $config->{'hypnotoad'} = {
        listen  => [$listen]
      , workers => $num_of_workers
      , inactivity_timeout => $inactivity_timeout
      } ;


   $objGuardian      = 'Qto::App::Sec::Guardian'->new ( \$config ) ;
   $config->{'env'}->{'run'}->{ 'PublicRSAKey' } = $objGuardian->doGetPublicKeySecret();
   $self->set('ObjGuardian', $objGuardian );

   my $objRdrDirs = 'Qto::App::IO::In::RdrDirs'->new (); 
	my $arrDirs = $objRdrDirs->doFindMaxDepth( "$ProductInstanceDir/src/perl/qto/public", 1) ; 
   foreach my $dir (@{$arrDirs}) {
      $dir =~ s/(.*)[\\|\/](.*?)/$2/g;
   }

   $config->{'env'}->{'run'}->{ 'PublicLevel1Dirs' } = $arrDirs;
   # debug rint $config;
   $self = $self->config( $config );
    
   $self->renderer->cache->max_keys(0);

   $msg = "START MAIN";
   $objLogger->doLogInfoMsg($msg);
}


# -----------------------------------------------------------------------------
# initial load into redis the metadata of ALL databases 
# -----------------------------------------------------------------------------
sub doReloadProjectsDbMeta {
   my $self                = shift ;
   my $start_time          = Time::HiRes::gettimeofday();
   my $msg                 = '' ; 
   my $config              = $self->config ; # the global config
   my $cnf                 = $self->config->{'env'}->{'db'}; # the db section only ...

   my $proj_dbs_str        = $cnf->{'project_databases'};
   $proj_dbs_str .= ' , '. $cnf->{'postgres_db_name'} unless ( $cnf->{'project_databases'} eq $cnf->{'postgres_db_name'});
   $proj_dbs_str           =~ s/\s+//g;
   my @dbs                 = split (',',$proj_dbs_str);

   foreach my $db ( @dbs ) {
      #print "start loading meta for db : \"" . "$db" . '"' . " \n" ; 
      my $item             = 'app-startup';
      my $objModel         = 'Qto::App::Mdl::Model'->new ( \$config , $db , $item) ; 
      $db                  = toEnvName ( $db , $config ) ;
      my $objMetaDataController = 'Qto::Controller::MetaDataController'->new(\$config, \$objModel);
      $objMetaDataController->doReloadProjDbMetaData($db,$item);
   }

   my $redis_server        = $config->{'env'}->{'redis'}->{'server'};
   my $redis_port          = $config->{'env'}->{'redis'}->{'port'};

   #print "START printing the meta-data keys for ALL dbs in redis : \n";
   #print `echo 'KEYS * ' | redis-cli -h $redis_server -p $redis_port| sort`;
   #print "STOP  printing the meta-data keys in redis : \n";

   my $stop_time = Time::HiRes::gettimeofday();
   $msg  = "the meta-data load to Redis for the CONFIGURED project_databases: \"$proj_dbs_str\" took ";
   $msg .= sprintf("%.3f seconds\n", $stop_time - $start_time); # takes about 0.065s on a dev-box for one db ~ 300kB
   chomp($msg);
   $objLogger->doLogInfoMsg($msg);
   $self->config($config);
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

	$self->hook(before_render => sub {
	  my ($c, $args) = @_;

	  # Make sure we are rendering the exception template
	  return unless my $template = $args->{template};
	  return unless $template eq 'exception';

	  # Switch to JSON rendering if content negotiation allows it
	  return unless $c->accepts('json');
	  $args->{'json'} = {'exception'=> $c->stash('exception')};
});


	# chk: https://mojolicious.org/perldoc/Mojolicious#before_routes
	$self->hook('before_routes'=> sub {
		my $c = shift;
		my $code = $c->res->code;
		my $type = $c->res->headers->content_type;

		# Was the response static?
		return unless $code && ($code == 304 || $type);

		# If so, remove cookies and/or caching instructions
		$c->res->headers->remove('Cache-Control');
		$c->res->headers->remove('Set-Cookie');

		 # Decide on an expiry date
		my $e = Mojo::Date->new(time+600);
		if ($type) {
			  if ($type =~ /javascript/) {
					$e = Mojo::Date->new(time+300);
			  }
			  elsif ($type =~ /^text\/css/ || $type =~ /^image\//) {
					$e = Mojo::Date->new(time+3600);
					$c->res->headers->header("Cache-Control" => "public");
			  }
			  # …other conditions…
		}
		$c->res->headers->header(Expires => $e);
	});


   $self->hook( 'before_dispatch' => sub {
      my $c = shift;
      $c->res->headers->cache_control('max-age=604800, no-cache');
      $c->res->headers->accept_charset('UTF-8');
      $c->res->headers->accept_language('fi, en');
   });
  
   # chk: https://toroid.org/mojolicious-static-resources, 
   # obs: after_static_dispatch deprecated
   $self->hook( 'after_dispatch' => sub {
      my $c       = shift;
      my $url     = (split('#',$c->req->url->path))[0];
      my $msg     = '' ; 
	
		# If so, try to prevent caching
		$c->res->headers->header(
			Expires => Mojo::Date->new(time-365*86400)
		);
		$c->res->headers->header(
			"Cache-Control" => "max-age=1, no-cache"
		);
		
      my $type = $c->res->headers->content_type;

      # only auth#entiation for dynamic resources and json
      # return unless ( defined $type || $type =~ /text\/html/g || $type =~ /application\/json/g);
		# obs no authentication for static resources ... qto-200314095059
      return unless $type ; 
		return if ($type =~ /^text\/css/g || $type =~ /javascript/g || $type =~ /image/g);

      my $route   = (split('/',$url))[2]; #this will fail on new static resource types ...
	   my $db      = (split('/',$url))[1]; $db = toEnvName($db,$c->app->config);
      my @open_routes = (); 
   
      my $lvl_1_public_dirs = $config->{'env'}->{'run'}->{ 'PublicLevel1Dirs' } ;

      # basically a static resource fetch ...
      # do not check src/perl/qto/public/poc like locations / routes
      my $pdb = toPlainName($db);
      return if grep ( /^$pdb$/, @$lvl_1_public_dirs);
      
      # but if the :db is not configured nor static root => something fishy !!!
      unless ( defined ($config->{'env'}->{'app'}->{$db . '.meta-routes'} )) {
         my $redirect_db = $config->{'env'}->{'db'}->{'postgres_db_name'};
         my $msg = " the project db you requested : $db does not exist !!!" ;
         my $backend_error_url  = '/' . toPlainName($redirect_db) . '/serve/forbidden?&msg=' . url_encode($msg);
         $msg .= ' unauthorized attempt to access ' . $route . ' backend route ';
         $objLogger->doLogErrorMsg($msg);
         $c->redirect_to($backend_error_url);
         return;
      }
         
      # chk if it is a publicall opened route ( login , error , etc. ) 
      foreach my $k(keys %{$config->{'env'}->{'app'}->{$db . '.meta-routes'}}){
         my $r = $config->{'env'}->{'app'}->{$db . '.meta-routes'}->{$k};
         push @open_routes, $r->{'name'} if $r->{'is_open'} == 1 ; 
      }

      my $flag_found_open_route = grep ( /^$route$/, @open_routes);
      if ( $flag_found_open_route == 1 ){
         return ; # not authorization checks for open routes
		} else {
         $db         = 'qto' unless $db ;
			$db         = toEnvName ($db,$c->app->config);
			my $objGuardian = $self->get('ObjGuardian');
         my $objRdrRedis   = 'Qto::App::Db::In::RdrRedis'->new(\$config);
         my $rbac_list     = $objRdrRedis->getData(\$config,"$db" . '.rbac-list');

			unless ( $objGuardian->isAuthenticated($c->app->config, $db, $c, \$msg)){
				my $login_url = '/' . toPlainName($db) . '/logon' ;
            $objLogger->doLogErrorMsg($msg);
				$c->redirect_to($login_url);
            return ;
			}
         unless ( $objGuardian->isAuthorized($c->app->config, $rbac_list, $db, $c, \$msg)){
            foreach my $k(keys %{$config->{'env'}->{'app'}->{$db . '.meta-routes'}}){
               my $r = $config->{'env'}->{'app'}->{$db . '.meta-routes'}->{$k};
               next unless $r->{'name'} eq $route ;

               if ( $r->{'is_backend'} == 1) {
                  my $backend_error_url  = '/' . toPlainName($db) . '/serve/forbidden?&msg=' . url_encode($msg);
                  $msg .= ' unauthorized attempt to access ' . $route . ' backend route ';
                  $objLogger->doLogErrorMsg($msg);
                  $c->redirect_to($backend_error_url);
                  return;
               } else {
                  $msg .= ' unauthorized attempt to access ' . $route . ' ui route ';
                  $objLogger->doLogErrorMsg($msg);
                  my $home_url = '/' . toPlainName($db) . '/search' ;
                  $c->redirect_to($home_url);
                  return ;
               }
            }
         }
      }

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
sub doSetSessions {
   
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
   
   $r->get('/:db/serve/:item')->to(
     controller   => 'Serve'
   , action       => 'doServe'
   );
   
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

   $r->get('/:db/select-item-meta-for/:item')->to(
     controller   => 'Select'
   , action       => 'doSelectItemMetaFor'
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
