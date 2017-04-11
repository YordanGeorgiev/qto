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
use IssueTracker::App::Utils::ETL::IssueTracker ; 
use IssueTracker::App::Utils::IO::FileHandler ; 
use IssueTracker::App::Utils::ETL::IssueTracker ; 
use IssueTracker::App::Model::DbHandlerFactory ; 
use IssueTracker::App::Model::PostGreDbHandler ; 


my $module_trace                 = 1 ; 
my $md_file 							= '' ; 
my $rdbms_type 						= 'postgre' ; #todo: parametrize to 
my $issue_file                   = '' ; 
my $objInitiator                 = {} ; 
my $appConfig                    = {} ; 
my $objLogger                    = {} ; 
my $objFileHandler               = {} ; 
my $msg                          = q{} ; 
my $objConfigurator              = {} ; 
my $actions                      = q{} ; 


   #
   # the main shell entry point of the application
   #
   sub main {
      
      my $msg     = '' ; 
      my $ret     = 1 ; 
    
      print " issue_tracker.pl START  \n " ; 
      doInitialize();	

      GetOptions(	
         'issue_file=s' => \$issue_file
         , 'do=s'       => \$actions
      );
     
      $actions = 'file-to-db' unless ( $actions )  ; 

      my @actions = split /,/ , $actions ; 
     
      foreach my $action ( @actions ) { 
         $msg = "running the $action action " ; 
         $objLogger->doLogInfoMsg ( $msg ) ; 

         if ( $action eq 'file-to-db' ) {

            $msg = 'issue_file to parse : ' . "\n" . $issue_file ; 
            $objLogger->doLogInfoMsg ( "$msg" ) ; 

            my $objFileIOController = 
               'IssueTracker::App::Controller::FileIOController'->new ( \$appConfig ) ; 
            ( $ret , $msg ) = $objFileIOController->doLoadIssuesFileToDb ( $issue_file ) ; 
         } elsif ( $action eq 'db-to-file' ) {
             
            $msg = 'issue_file to parse : ' . "\n" . $issue_file ; 
            $objLogger->doLogInfoMsg ( "$msg" ) ; 

            my $objFileIOController = 
               'IssueTracker::App::Controller::FileIOController'->new ( \$appConfig ) ; 
            ( $ret , $msg ) = $objFileIOController->doLoadDbIssuesToXls ( $issue_file ) ; 
         } else {
            
            $msg = "unknown $action action !!!" ; 
            $objLogger->doLogErrorMsg ( $msg ) ; 
         }
         

      } 
      #eof foreach action 
      #

      doExit ( $ret , $msg ) ; 

   }



   sub doInitialize {

      $objInitiator 		= 'IssueTracker::App::Utils::Initiator'->new();
      $appConfig 			= $objInitiator->get('AppConfig') ; 
      p ( $appConfig  ) if $module_trace == 1 ; 

      $objConfigurator 	= 
         'IssueTracker::App::Utils::Configurator'->new( $objInitiator->{'ConfFile'} , \$appConfig ) ; 
      $objLogger 			= 'IssueTracker::App::Utils::Logger'->new( \$appConfig ) ;
         
      $objLogger->doLogInfoMsg ( "START MAIN") ; 
      $objLogger->doLogInfoMsg ( "START LOGGING SETTINGS ") ; 
      p ( $appConfig  ) ; 
      $objLogger->doLogInfoMsg ( "STOP  LOGGING SETTINGS ") ; 

   }


   sub doExit {

      my $exit_code = shift ; 
      my $exit_msg  = shift ; 


      if ( $exit_code == 0 ) {
         $objLogger->doLogInfoMsg ( $msg ) ;       
      } else {

         $objLogger->doLogErrorMsg ( $msg ) ;       
         $objLogger->doLogFatalMsg ( $msg ) ;       
      }

      $objLogger->doLogInfoMsg ( "STOP  MAIN") ; 
      exit ( $exit_code ) ; 
   }


# Action !!!
main () ; 

