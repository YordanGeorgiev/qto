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


# This method will run once at server start
sub startup {

   my $self = shift;
   my $ret = 1 ; 
   my $msg = '' ; 

  # Documentation browser under "/perldoc"
  $self->plugin('PODRenderer');

  ($ret, $msg) = $self->doInitialize();
  
   # Router
  my $r = $self->routes;

  $r->get('/')->to('example#welcome');

   # http://host-name:3000/dev_stockit/get/company_eps/727cf807-c9f1-446b-a7fc-65f9dc53ed2d
   $r->get('/:db/get/:item/:guid')->to(
     controller   => 'Get'
   , action       => 'doGetItem'
   );
   
   # http://host-name:3000/dev_issue_tracker/list/monthly_issues
   $r->get('/:db/list/:item')->to(
     controller   => 'List'
   , action       => 'doListItems'
   );
   
   # http://host-name:3000/prd_ysg_issues/srch/confs/con
   $r->get('/:db/srch/:item/:srch')->to(
     controller   => 'Srch'
   , action       => 'doSrchItem'
   );

}


sub doInitialize {

   my $self = shift ; 
   my $msg = 'error during initialization !!!';
   my $ret = 1;

   $objInitiator = 'IssueTracker::App::Utils::Initiator'->new();
   $appConfig    = $objInitiator->get('AppConfig');

   $objConfigurator  = 'IssueTracker::App::Utils::Configurator'->new( 
         $objInitiator->{'ConfFile'}, \$appConfig);
   $objLogger        = 'IssueTracker::App::Utils::Logger'->new(\$appConfig);
   $objModel         = 'IssueTracker::App::Mdl::Model'->new ( \$appConfig ) ; 

   p($appConfig) ; 
   $self->set('AppConfig' , $appConfig );
   $self->set('ObjLogger', $objLogger );
   $self->set('ObjModel', \$objModel );

   $msg = "START MAIN";
   $objLogger->doLogInfoMsg($msg);

   $ret = 0;
   return ($ret, $msg);
}
# eof sub doInialize


# -----------------------------------------------------------------------------
# return a field's value - aka the "getter"
# chk: http://perldoc.perl.org/Carp.html
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
# eof sub set

# -----------------------------------------------------------------------------
# return the fields of this obj instance
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
