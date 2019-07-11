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
use Qto::App::Utils::Configurator;
use Qto::App::Utils::Logger;
use Qto::App::Mdl::Model ; 

my $module_trace 					= 0;
our $objConfigurator				= {} ; 
our $objInitiator 				= {};
our $appConfig    				= {};
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

   $objInitiator = 'Qto::App::Utils::Initiator'->new();
   $appConfig    = $objInitiator->get('AppConfig');


   my $ConfFile = q{} ; 
   if ( defined $ENV->{ 'conf_file' } ) {
      $ConfFile = $ENV->{ 'conf_file' } ; 
   } else {
      $ConfFile = $objInitiator->{'ConfFile'} ; 
   }

   $objConfigurator  = 'Qto::App::Utils::Configurator'->new( 
         $ConfFile, \$appConfig);
   $appConfig       = $objConfigurator->getConfHolder()  ;
   $objLogger        = 'Qto::App::Utils::Logger'->new(\$appConfig);

	$appConfig->{'proj_instance_dir'} = $appConfig->{'ProductInstanceDir'} 
      unless ( exists $appConfig->{'proj_instance_dir'} );
   my $currentShortHash = `git rev-parse --short HEAD` ; chomp($currentShortHash);
   $appConfig->{ 'GitShortHash' } = $currentShortHash || "" ; 

   p($appConfig) ; 
   $self->set('AppConfig' , $appConfig );
   $self->set('ObjLogger', $objLogger );

   $msg = "START MAIN";
   $objLogger->doLogInfoMsg($msg);

}



# -----------------------------------------------------------------------------
# src: https://mojolicious.org/perldoc/Mojolicious/Plugins
# -----------------------------------------------------------------------------
sub doRegisterPlugins {
   
   my $self = shift ; 
   
   $self->plugin('BasicAuthPlus');
   $self->plugin('RenderFile');
}

#
# -----------------------------------------------------------------------------
# src: https://mojolicious.org/perldoc/Mojolicious/Guides/Routing#Hooks
# -----------------------------------------------------------------------------
sub doSetHooks {
  
   my $self = shift ; 

#  # comment out to debug 
#	my $before_render_debug = 0 ; 
#   if ( $before_render_debug == 1 ) {
#      $self->hook ( 'before_render' => sub {
#         my ($c, $args) = @_;
#         # debug r $c ; 
#         # debug r ( $c->req->url->to_abs . '?' . $c->req->url->query ) ; 
#      });
#   }


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

	  # Check if "gzip => 1" has been set in the stash
	  # return unless $c->stash->{gzip};

	  # Check if user agent accepts gzip compression
	  return unless ($c->req->headers->accept_encoding // '') =~ /gzip/i;
	  $c->res->headers->append( 'Vary' => 'Accept-Encoding');

	  # Compress content with gzip
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
   $self->secrets(['Mojolicious rocks!!!' . randomStr()]);

}


# -----------------------------------------------------------------------------
# src: https://mojolicious.org/perldoc/Mojolicious/Guides/Routing
# -----------------------------------------------------------------------------
sub doSetRoutes {
   
   my $self = shift ; 
   my $r = $self->routes;
   
   $r->get('/:db/home')->to(
     controller   => 'Home'
   , action       => 'doLanding'
   );
   
   $r->get('/:db/login')->to(
     controller   => 'Login'
   , action       => 'doShowLoginForm'
   );
   
   $r->post('/:db/login')->to(
     controller   => 'Login'
   , action       => 'doLoginUser'
   );
   
   $r->get('/:db/search')->to(
     controller   => 'Search'
   , action       => 'doSearchItems'
   );
   
   $r->get('/:db/query')->to(
     controller   => 'Query'
   , action       => 'doQueryItems'
   );
	
   $r->get('/:db/select-databases')->to(
     controller   => 'Select'
   , action       => 'doSelectDatabases'
   );

   $r->get('/:db/select-tables')->to(
     controller   => 'Select'
   , action       => 'doSelectTables'
   );
   
   
   $r->get('/:db/hselect/:item')->to(
     controller   => 'HSelect'
   , action       => 'doHSelectItems'
   );
   
   $r->get('/:db/hlselect/:item')->to(
     controller   => 'HLSelect'
   , action       => 'doHLSelectItems'
   );
   
   $r->post('/:db/create/:item')->to(
     controller   => 'Create'
   , action       => 'doCreateById'
   );
   
   $r->post('/:db/hcreate/:item')->to(
     controller   => 'HCreate'
   , action       => 'doHCreateById'
   );
   
   $r->post('/:db/delete/:item')->to(
     controller   => 'Delete'
   , action       => 'doDeleteById'
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

   $r->websocket('/websocketecho')->to('WebSocketPoc#doTestWebSocket');
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

sub randomStr {
   my @chars   = ("A".."Z", "a".."z");
   my $string  = '' ; 
   $string    .= $chars[rand @chars] for 1..3;
   return $string 
}

1;
