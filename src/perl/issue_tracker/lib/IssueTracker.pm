package IssueTracker;

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


# use own modules ...
use IssueTracker::App::Utils::Initiator;
use IssueTracker::App::Utils::Configurator;
use IssueTracker::App::Utils::Logger;
use IssueTracker::App::Mdl::Model ; 


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

   $self->doSetHooks() ; 

   $self->doLoadAppConfig();

   $self->doSetRoutes();

}


#
# -----------------------------------------------------------------------------
# IssueTracker specific configuration files confs loading
# -----------------------------------------------------------------------------
sub doLoadAppConfig {

   my $self = shift ; 
   my $msg = 'error during initialization !!!';
   my $ret = 1;

   $objInitiator = 'IssueTracker::App::Utils::Initiator'->new();
   $appConfig    = $objInitiator->get('AppConfig');


   my $ConfFile = q{} ; 
   if ( defined $ENV->{ 'conf_file' } ) {
      $ConfFile = $ENV->{ 'conf_file' } ; 
   } else {
      $ConfFile = $objInitiator->{'ConfFile'} ; 
   }

   $objConfigurator  = 'IssueTracker::App::Utils::Configurator'->new( 
         $ConfFile, \$appConfig);
   $objLogger        = 'IssueTracker::App::Utils::Logger'->new(\$appConfig);

	$appConfig->{'proj_instance_dir'} = $appConfig->{'ProductInstanceDir'} unless ( exists $appConfig->{'proj_instance_dir'} );
   my $currentShortHash = `git rev-parse --short HEAD` ; chomp($currentShortHash);
   $appConfig->{ 'ShortCommitHash' } = $currentShortHash || "" ; 

   p($appConfig) ; 
   $self->set('AppConfig' , $appConfig );
   $self->set('ObjLogger', $objLogger );

   $msg = "START MAIN";
   $objLogger->doLogInfoMsg($msg);

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
# src: https://mojolicious.org/perldoc/Mojolicious/Plugins
# -----------------------------------------------------------------------------
sub doRegisterPlugins {
   
   my $self = shift ; 
   
   $self->plugin('PODRenderer');
   $self->plugin('BasicAuthPlus');
}

#
# -----------------------------------------------------------------------------
# src: https://mojolicious.org/perldoc/Mojolicious/Guides/Routing#Hooks
# -----------------------------------------------------------------------------
sub doSetHooks {
  
   my $self = shift ; 
  
   # hook-01
   $self->hook( 'before_dispatch' => sub {
      my $c = shift;
      $c->res->headers->cache_control('max-age=604800, no-cache');
   });

   # hook-02 - conditional
	my $before_render_debug = 0 ; 
   if ( $before_render_debug == 1 ) {
      $self->hook ( 'before_render' => sub {
         my ($c, $args) = @_;
         p $c ; 
         p ( $c->req->url->to_abs . '?' . $c->req->url->query ) ; 
      });
   }
}

#
# -----------------------------------------------------------------------------
# src: 
# -----------------------------------------------------------------------------
sub doSessions {
   
   my $self = shift ; 
   $self->sessions->default_expiration(86400); # set expiry to 1 day

}

#
# -----------------------------------------------------------------------------
# src: https://mojolicious.org/perldoc/Mojolicious/Guides/Routing
# -----------------------------------------------------------------------------
sub doSetRoutes {
   
   my $self = shift ; 
   my $r = $self->routes;
	
   # http://host-name:3001/dev_issue_tracker/query?for=<<global-txt-srch>>
   $r->get('/:db/query')->to(
     controller   => 'Query'
   , action       => 'doGlobalTxtSrch'
   );
	
   # http://host-name:3001/dev_issue_tracker/select-databases
   $r->get('/:db/select-databases')->to(
     controller   => 'Select'
   , action       => 'doSelectDatabases'
   );

	# http://host-name:3001/dev_issue_tracker/select-tables
   $r->get('/:db/select-tables')->to(
     controller   => 'Select'
   , action       => 'doSelectTables'
   );
   
   # http://host-name:3001/dev_issue_tracker/select/monthly_issues
   $r->get('/:db/select/:item')->to(
     controller   => 'Select'
   , action       => 'doSelectItems'
   );
   
   # http://host-name:3001/dev_issue_tracker/create/monthly_issues?id=123
   $r->post('/:db/create/:item')->to(
     controller   => 'Create'
   , action       => 'doCreateBySoleId'
   );
   
   # http://host-name:3001/dev_issue_tracker/delete/monthly_issues?id=123
   $r->post('/:db/delete/:item')->to(
     controller   => 'Delete'
   , action       => 'doDeleteItemById'
   );
   
   # http://host-name:3001/dev_issue_tracker/update/monthly_issues
   $r->post('/:db/update/:item')->to(
     controller   => 'Update'
   , action       => 'doUpdateItemBySingleCol'
   );

   # http://host-name:3001/dev_issue_tracker/select/monthly_issues
   $r->get('/:db/select-meta/:item')->to(
     controller   => 'Select'
   , action       => 'doSelectMeta'
   );
   
   
   # http://host-name:3001/dev_issue_tracker/select/monthly_issues
   $r->get('/:db/list/:item')->to(
     controller   => 'List'
   , action       => 'doListItems'
   );

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
# eof sub set

#
# -----------------------------------------------------------------------------
# return the fields of this obj instance. Perl vs. Java - check mate !!!
# -----------------------------------------------------------------------------
sub dumpFields {
   my $self      = shift;
   my $strFields = ();
   foreach my $key ( keys %$self ) {
      $strFields .= " $key = $self->{$key} \n ";
   }

   return $strFields;
}    

1;
