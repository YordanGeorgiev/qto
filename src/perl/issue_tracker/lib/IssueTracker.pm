package IssueTracker;

our @ISA = qw(Exporter  IssueTracker::App::Utils::OO::SetGetable);
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

use base qw(IssueTracker::App::Utils::OO::SetGetable);

use Data::Printer;
use Cwd qw ( abs_path );
use Getopt::Long;
use File::Basename qw< basename >;
use Carp qw< carp croak confess cluck >;
use Encode qw< encode decode >;
use Unicode::Normalize qw< NFD NFC >;


# use own modules ...
use IssueTracker::App::Utils::Initiator;
use IssueTracker::App::Utils::Configurator;
use IssueTracker::App::Utils::Logger;
use IssueTracker::App::Utils::IO::FileHandler;


my $module_trace 					= 0;
our $objConfigurator				= {} ; 
our $objInitiator 				= {};
our $appConfig    				= {};
our $objLogger 					= {};


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
	
   # http://host-name:3000/prd_ysg_issues/srch/confs/con
	$r->get('/:db/srch/:item/:srch')->to(
	  controller   => 'Srch'
	, action       => 'doSrchItem'
	);

   # http://host-name:3000/prd_ysg_issues/srch/confs/con
	$r->options('/:db/srch/:item/:srch')->to(
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

	$objConfigurator
		= 'IssueTracker::App::Utils::Configurator'->new($objInitiator->{'ConfFile'},
		\$appConfig);
	$objLogger = 'IssueTracker::App::Utils::Logger'->new(\$appConfig);

	p($appConfig) ; 
  	$self->set('AppConfig' , $appConfig );
   $self->set('ObjLogger', $objLogger );

	my $m = "START MAIN";
	$objLogger->doLogInfoMsg($m);

	$ret = 0;
	return ($ret, $msg);
}
# eof sub doInialize


1 ;
