#!/usr/bin/env perl

use strict;
use warnings;

   $|++;


require Exporter ;
our @ISA = qw(Exporter);
our %EXPORT_TAGS = ( 'all' => [ qw() ] );
our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );
our @EXPORT = qw() ;
our $AUTOLOAD =();

use utf8 ;
use Data::Printer ; 
use Carp ;
use Cwd qw ( abs_path ) ;
use Getopt::Long;


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

# use own modules ...
use IssueTracker::App::Utils::Initiator ; 
use IssueTracker::App::Utils::Configurator ; 
use IssueTracker::App::Utils::Logger ; 
use IssueTracker::App::Controller::FileIOController ; 
use IssueTracker::App::Controller::DbIOController ; 
use IssueTracker::App::Utils::ETL::IssueTracker ; 
use IssueTracker::App::Utils::IO::FileHandler ; 
use IssueTracker::App::Model::DbHandlerFactory ; 
use IssueTracker::App::Model::PostGreDbHandler ; 
use IssueTracker::App::Utils::Timer ; 


my $module_trace                 = 0 ; 
my $md_file 							= '' ; 
my $rdbms_type 						= 'postgre' ; #todo: parametrize to 
my $issues_file                  = '' ; 
my $objInitiator                 = {} ; 
my $appConfig                    = {} ; 
my $objLogger                    = {} ; 
my $objFileHandler               = {} ; 
my $msg                          = q{} ; 
my $objConfigurator              = {} ; 
my $actions                      = q{} ; 
my $xls_dir                      = q{} ; 
my $issue_tracker_project        = q{} ; 


   #
   # the main shell entry point of the application
   #
   sub main {
      
      my $msg     = 'error during initialization of the tool !!! ' ; 
      my $ret     = 1 ; 
    
      print " issue_tracker.pl START  \n " ; 
      ( $ret , $msg ) = doInitialize();	
      doExit ( $ret , $msg ) if ( $ret == 1 ) ; 

      my @actions = split /,/ , $actions ; 
     
      foreach my $action ( @actions ) { 
         $msg = "running the $action action " ; 
         $objLogger->doLogInfoMsg ( $msg ) ; 

         if ( $action eq 'file-to-db' ) {

            $msg = 'issues_file to parse : ' . "\n" . $issues_file ; 
            $objLogger->doLogInfoMsg ( "$msg" ) ; 
            

            unless ( -f $issues_file ) {
               $msg = "the issues_file: $issues_file does not exist !!!. Nothing to do !!!" ; 
               $objLogger->doLogFatalMsg ( $msg ) ;
               doExit ( $ret , $msg ) ; 
            }
            my $objFileIOController = 
               'IssueTracker::App::Controller::FileIOController'->new ( \$appConfig ) ; 
            ( $ret , $msg ) = $objFileIOController->doLoadIssuesFileToDb ( $issues_file ) ; 
         } 
         elsif ( $action eq 'db-to-xls' ) {
            $msg = 'issues_file to parse : ' . "\n" . $issues_file ; 
            $objLogger->doLogInfoMsg ( "$msg" ) ; 

            my $objDbIOController = 
               'IssueTracker::App::Controller::DbIOController'->new ( \$appConfig ) ; 
            ( $ret , $msg ) = $objDbIOController->doLoadDbIssuesToXls ( $issues_file ) ; 
         } 
         elsif ( $action eq 'db-to-txt' ) {
            $msg = 'issues_file to produce : ' . "\n" . $issues_file ; 
            $objLogger->doLogInfoMsg ( "$msg" ) ; 

            my $objDbIOController = 
               'IssueTracker::App::Controller::DbIOController'->new ( \$appConfig ) ; 
            ( $ret , $msg ) = $objDbIOController->doLoadDbToTxtFile ( $issues_file ) ; 
         } 
         else {
            $msg = "unknown $action action !!!" ; 
            $objLogger->doLogErrorMsg ( $msg ) ; 
         }
         

      } 
      #eof foreach action 

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
         
      $objLogger->doLogInfoMsg ( "START MAIN") ; 
     
      # get the cmd args  
      GetOptions(	
           'issues_file=s' => \$issues_file
         , 'do=s'          => \$actions
         , 'xls_dir=s'     => \$xls_dir
      );
      
      $issue_tracker_project = $ENV{ "issue_tracker_project" } ; 
      $appConfig->{ 'issue_tracker_project' } = $ENV{ "issue_tracker_project" } ; 
     
      # if the issues_file is not specified via the cmd arg 
      unless ( $issues_file ) {
         my $objTimer   = 'IssueTracker::App::Utils::Timer'->new() ; 
	      my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = $objTimer->GetTimeUnits();
         my $nice_month  = "$year" . '-' . "$mon" ; 
         my $nice_date  = "$year" . '-' . "$mon" . '-' . $mday ; 

         $objLogger->doLogDebugMsg ( 'proj_txt_dir' . $ENV{'proj_txt_dir'} ); 
         $issues_file   = $ENV{'proj_txt_dir'} . '/issues' . 
            "/$year/$nice_month/$nice_date/$issue_tracker_project" . '-issues.' . "$nice_date" . ".daily.txt" ;

         # and the issues file does not comply with the project's dir structure and naming
         # convetions exit with error. Note this is valid for all actions !!!
         unless ( -f $issues_file ) {
            $msg .= 'the issues_file: ' . "\n" . $issues_file . "\n" ; 
            $msg .= 'does not exist !!!' ; 
            $objLogger->doLogErrorMsg ( $msg ) ; 
            return ( $ret , $msg ) ; 
         }
      }
      $appConfig->{ 'issues_file' } = $issues_file ; 
      $appConfig->{ 'xls_dir' }     = $xls_dir ; 
      $actions = 'file-to-db' unless ( $actions )  ; 

      $objLogger->doLogInfoMsg ( "START LOGGING SETTINGS ") ; 
      p ( $appConfig  ) ; 
      $objLogger->doLogInfoMsg ( "STOP  LOGGING SETTINGS ") ; 
     
      $ret = 0 ;  
      return ( $ret , $msg ) ; 
   }
   # eof sub doInialize

   sub doExit {
      my $exit_code  = shift ; 
      my $exit_msg   = shift ; 


      if ( $exit_code == 0 ) {
         $objLogger->doLogInfoMsg ( $msg ) ;       
      } else {

         $objLogger->doLogErrorMsg ( $msg ) ;       
         $objLogger->doLogFatalMsg ( $msg ) ;       
      }

      $objLogger->doLogInfoMsg ( "STOP  MAIN") ; 
      sleep 1 ; 
      exit ( $exit_code ) ; 
   }


# Action !!!
main () ; 

