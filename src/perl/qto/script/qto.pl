
package qto;

use strict;
use warnings qw< FATAL  utf8     >;
use autodie qw(:all);
use utf8;
use open qw< :std  :utf8     >;
use charnames qw< :full >;
use feature qw< unicode_strings >;
use 5.12.0;

require Exporter;
our @ISA         = qw(Exporter);
our %EXPORT_TAGS = ('all' => [qw()]);
our @EXPORT_OK   = (@{$EXPORT_TAGS{'all'}});
our @EXPORT      = qw($config);
our $AUTOLOAD    = ();

use Cwd qw ( abs_path );
use File::Basename qw< basename >;
use Carp qw< carp croak confess cluck >;
use Encode qw< encode decode >;
use Unicode::Normalize qw< NFD NFC >;
use Data::Printer;
use JSON::Parse 'json_file_to_perl';

$| = 1;


BEGIN {
  use Cwd qw (abs_path);
  my $my_inc_path = Cwd::abs_path($0);

  $my_inc_path =~ m/^(.*)(\\|\/)(.*?)(\\|\/)(.*)/;
  $my_inc_path = $1;

  # debug ok print "\$my_inc_path $my_inc_path \n" ;

  unless (grep { $_ eq "$my_inc_path" } @INC) {
    push(@INC, "$my_inc_path");
    $ENV{'PERL5LIB'} .= "$my_inc_path";
  }

  unless (grep { $_ eq "$my_inc_path/lib" } @INC) {
    push(@INC, "$my_inc_path/lib");
    $ENV{'PERL5LIB'} .= ":$my_inc_path/lib";
  }
}

END { close STDOUT }


# use own modules ...
use Qto::App::Utils::Initiator;
use Qto::App::Utils::Logger;
use Qto::App::Utils::Timer;
use Qto::App::Ctrl::Dispatcher;
use Qto::App::Mdl::Model ; 
use Qto::App::IO::In::RdrCmdArgs ; 
use Qto::App::IO::In::RdrEnv ; 

# give a full stack dump on any untrapped exceptions
local $SIG{__DIE__} = sub {
  $0 = basename($0);    # shorter messages
  confess "\n\n\n FATAL Uncaught exception: @_" unless $^S;
};

# now promote run-time warnings into stackdumped exceptions
#   *unless* we're in an try block, in which
#   case just generate a clucking stackdump instead
local $SIG{__WARN__} = sub {
  $0 = basename($0);    # shorter messages
  if   ($^S) { cluck "\n\n WARN Trapped warning: @_" }
  else       { cluck "\n\n WARN Deadly ?! warning: @_" }
};


our $config             = {};
our $objModel           = {};
our $objLogger          = {};
my $module_trace        = 0;
my $md_file             = '';
my $objInitiator        = {};
my $objConfigurator     = {};
my $xls_dir             = q{};
my $xls_file            = q{};
my $qto_project         = q{};
my $period              = q{};
my $tables              = 'daily' ;
my $rdbms_type          = 'postgre';                 #todo: parametrize to


#
# the main shell entry point of the application
sub main {

  my $msg = 'error during initialization of the tool !!! ';
  my $ret = 1;

  print " qto.pl START  \n ";
  ($ret, $msg) = doInit();
  doExit($ret, $msg) unless ($ret == 0);

  my $objDispatcher = 'Qto::App::Ctrl::Dispatcher'->new(\$config , \$objModel);

  ($ret, $msg) = $objDispatcher->doRunActions($objModel->get('ctrl.actions'));

  doExit($ret, $msg);

}



sub doInit {

   my $msg          = 'error during initialization !!!';
   my $ret          = 1;
   $objInitiator    = 'Qto::App::Utils::Initiator'->new();
   $config       = $objInitiator->get('AppConfig');

   $config = json_file_to_perl ($objInitiator->doResolveConfFile());
   $config->{'env'}->{'run'}->{'ProductInstanceDir'} = $objInitiator->doResolveProductInstanceDir(-1);
   $config->{'env'}->{'run'}->{'ProductName'} = $objInitiator->doResolveProductName();
   $config->{'env'}->{'run'}->{'VERSION'} = $objInitiator->doResolveVersion();
   $config->{'env'}->{'run'}->{'ENV_TYPE'} = $objInitiator->doResolveEnvType();

   if ( defined $ENV{'PROJ_CONF_FILE'} ) {
      my $projConfig = json_file_to_perl ($ENV{'PROJ_CONF_FILE'} );
      $config->{'env'}->{'db'} = $projConfig->{'env'}->{'db'} ; 
   }

   p $config ; 

   $objLogger = 'Qto::App::Utils::Logger'->new(\$config);
   my $m = "START MAIN";
   $objLogger->doLogInfoMsg($m);

   $objModel               = 'Qto::App::Mdl::Model'->new ( \$config ) ; 
   my $objRdrCmdArgs 	   = 'Qto::App::IO::In::RdrCmdArgs'->new(\$config , \$objModel ) ; 
   $objRdrCmdArgs->doRead();
   my $objRdrEnv 	         = 'Qto::App::IO::In::RdrEnv'->new(\$config, \$objModel ) ; 
   $objRdrEnv->doRead();

   $ret = 0;
   return ($ret, $msg);
}



#
# pass the exit msg and the exit to the calling process
#
sub doExit {

  my $exit_code = shift;
  my $exit_msg = shift || 'exit qto.pl';

  if ($exit_code == 0) {
    $objLogger->doLogInfoMsg($exit_msg);
  }
  else {
    $objLogger->doLogErrorMsg($exit_msg);
    $objLogger->doLogFatalMsg($exit_msg);
  }

  my $msg = "STOP MAIN";
  $objLogger->doLogInfoMsg($msg);
  $msg = "19d94b2c-096c-4bf9-b6ba-780c3f90bf70";
  $objLogger->doRunLogMsg($msg);
  exit($exit_code);
}


# Action !!!
main();

