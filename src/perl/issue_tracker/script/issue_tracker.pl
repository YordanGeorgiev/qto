#!/usr/bin/env perl
package issue_tracker ; 

use strict;
use warnings;
use utf8;
use strict;
use autodie;
use warnings; 
use warnings    qw< FATAL  utf8     >;
use open        qw< :std  :utf8     >;
use charnames   qw< :full >;
use feature     qw< unicode_strings >;



require Exporter ;
our @ISA = qw(Exporter);
our %EXPORT_TAGS = ( 'all' => [ qw() ] );
our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );
our @EXPORT = qw() ;
our $AUTOLOAD =();

use Data::Printer ; 
use Cwd qw ( abs_path ) ;
use Getopt::Long;
use File::Basename      qw< basename >;
use Carp                qw< carp croak confess cluck >;
use Encode              qw< encode decode >;
use Unicode::Normalize  qw< NFD NFC >;

$| = 1;


   BEGIN {
      use Cwd qw (abs_path) ;
      my $my_inc_path = Cwd::abs_path( $0 );

      $my_inc_path =~ m/^(.*)(\\|\/)(.*?)(\\|\/)(.*)/;
      $my_inc_path = $1;
      
      # debug ok print "\$my_inc_path $my_inc_path \n" ; 

      unless (grep {$_ eq "$my_inc_path"} @INC) {
         push ( @INC , "$my_inc_path" );
         $ENV{'PERL5LIB'} .= "$my_inc_path" ;
      }

      unless (grep {$_ eq "$my_inc_path/lib" } @INC) {
         push ( @INC , "$my_inc_path/lib" );
         $ENV{'PERL5LIB'} .= ":$my_inc_path/lib" ;
      }
   }

END { close STDOUT }


# use own modules ...
use IssueTracker::App::Utils::Initiator ; 
use IssueTracker::App::Utils::Configurator ; 
use IssueTracker::App::Utils::Logger ; 
use IssueTracker::App::Utils::IO::FileHandler ; 
use IssueTracker::App::Utils::Timer ; 
use IssueTracker::App::Ctrl::Dispatcher ; 

# give a full stack dump on any untrapped exceptions
local $SIG{__DIE__} = sub {
   $0 = basename($0);  # shorter messages
    confess "Uncaught exception: @_" unless $^S;
};

# now promote run-time warnings into stackdumped exceptions
#   *unless* we're in an try block, in which 
#   case just generate a clucking stackdump instead
local $SIG{__WARN__} = sub {
   $0 = basename($0);  # shorter messages
    if ($^S) { cluck   "Trapped warning: @_" } 
    else     { confess "Deadly warning: @_"  }
};


my $module_trace                 = 0 ; 
my $md_file 							= '' ; 
my $rdbms_type 						= 'postgre' ; #todo: parametrize to 
my $issues_file                  = 'undefined-issues-file' ; 
my $objInitiator                 = {} ; 
my $appConfig                    = {} ; 
our $objLogger                   = {} ; 
my $objFileHandler               = {} ; 
my $objConfigurator              = {} ; 
my $actions                      = q{} ; 
my $xls_dir                      = q{} ; 
my $xls_file                     = q{} ; 
my $issue_tracker_project        = q{} ; 
my $period                       = q{} ;  



   #
   # the main shell entry point of the application
   #
   sub main {
      
      my $msg     = 'error during initialization of the tool !!! ' ; 
      my $ret     = 1 ; 
    
      print " issue_tracker.pl START  \n " ; 
      ( $ret , $msg ) = doInitialize();	
      doExit ( $ret , $msg ) unless ( $ret == 0 ) ; 

      my $objDispatcher = 
         'IssueTracker::App::Ctrl::Dispatcher'->new ( \$appConfig ) ; 
      ( $ret , $msg ) = $objDispatcher->doRun ( $actions , $issues_file , $xls_file) ; 
   
      doExit ( $ret , $msg ) ; 

   }
   #eof sub mainthe issues_file: ' . "\n" . $issues_file . "\n" ; 


   sub doInitialize {
      
      my $msg           = 'error during initialization !!!' ; 
      my $ret           = 1 ; 
      $objInitiator 		= 'IssueTracker::App::Utils::Initiator'->new();
      $appConfig 			= $objInitiator->get('AppConfig') ; 
      p ( $appConfig  ) if $module_trace == 1 ; 

      $objConfigurator 	= 
         'IssueTracker::App::Utils::Configurator'->new( $objInitiator->{'ConfFile'} , \$appConfig ) ; 
      $objLogger 			= 'IssueTracker::App::Utils::Logger'->new( \$appConfig ) ;
       
      my $m = "START MAIN" ; $objLogger->doLogInfoMsg ( $m ) ; 
     
      # get the cmd args  
      GetOptions(	
           'issues_file=s' => \$issues_file
         , 'do=s'          => \$actions
         , 'xls_dir=s'     => \$xls_dir
         , 'xls-file=s'    => \$xls_file
         , 'period=s'      => \$period
      );
      
      $issue_tracker_project = $ENV{ "issue_tracker_project" } ; 
      $period = $ENV{ "period" } unless $period ; 
      $period = 'daily' unless $period ; 

      unless ( $issue_tracker_project ) {
         $msg = "set you current project by: \n" ; 
         $msg .= "doParseCnfEnvVars <<path-to-issue-tracker-project-configuration-file>>" ; 
         $objLogger->doLogErrorMsg ( $msg ) ; 
         $objLogger->doLogFatalMsg ( $msg ) ; 
         return ( $ret , $msg ) ; 
      }
      
      $appConfig->{ 'issue_tracker_project' } = $issue_tracker_project ; 
       
      # if the issues_file is not specified via the cmd arg 
      if ( $issues_file eq 'undefined-issues-file' ) {
         my $objTimer   = 'IssueTracker::App::Utils::Timer'->new() ; 
	      my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = $objTimer->GetTimeUnits();
         my $nice_month  = "$year" . '-' . "$mon" ; 
         my $nice_date  = "$year" . '-' . "$mon" . '-' . $mday ; 

         $msg = 'proj_txt_dir: ' . $ENV{'proj_txt_dir'} ; 
         $objLogger->doLogDebugMsg ( $msg ) ; 
         $issues_file   = $ENV{'proj_txt_dir'} . '/issues' . 
            "/$year/$nice_month/$nice_date/$issue_tracker_project" . '-issues.'
          . "$nice_date" . '.' . "$period" . '.txt' ;

         $msg = 'issues_file: ' . $issues_file ; 
         $objLogger->doLogDebugMsg ( $msg ) ; 

         # and the issues file does not comply with the project's dir structure and naming
         # convetions exit with error. Note this is valid for all actions !!!
         unless ( -f $issues_file ) {
            $msg = 'the issues_file: ' . "\n" . $issues_file . "\n" ; 
            $msg .= 'does not exist !!!' ; 
            $objLogger->doLogErrorMsg ( $msg ) ; 
            return ( $ret , $msg ) ; 
         }

      }
      $appConfig->{ 'issues_file' } = $issues_file ; 
      $appConfig->{ 'xls_dir' }     = $xls_dir ; 
      $actions = 'txt-to-db' unless ( $actions )  ; 


      if ( $module_trace == 1 ) {
         $msg="START LOGGING SETINGS" ; $objLogger->doLogInfoMsg ( $msg ) ; 
         p ( $appConfig  ) ; 
         $msg="STOP  LOGGING SETINGS" ; $objLogger->doLogInfoMsg ( $msg ) ; 
      }
     
      $ret = 0 ;  
      return ( $ret , $msg ) ; 
   }
   # eof sub doInialize


   #
   # pass the exit msg and the exit to the calling process
   #
   sub doExit {

      my $exit_code  = shift ; 
      my $exit_msg   = shift || 'exit issue_tracker.pl' ; 

      if ( $exit_code == 0 ) {
         $objLogger->doLogInfoMsg ( $exit_msg ) ;       
      } else {
         $objLogger->doLogErrorMsg ( $exit_msg ) ;       
         $objLogger->doLogFatalMsg ( $exit_msg ) ;       
      }

      my $msg = "STOP MAIN" ; 
		$objLogger->doLogInfoMsg ( $msg ) ; 
     	$msg = "19d94b2c-096c-4bf9-b6ba-780c3f90bf70" ; 
		$objLogger->doRunLogMsg ( $msg ) ; 
      exit ( $exit_code ) ; 
   }


# Action !!!
main () ; 

