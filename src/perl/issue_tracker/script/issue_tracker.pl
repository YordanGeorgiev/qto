#!/usr/bin/env perl

use strict;
use warnings;

   $|++;

use Data::Printer ; 

require Exporter ;
our @ISA = qw(Exporter);
our %EXPORT_TAGS = ( 'all' => [ qw() ] );
our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );
our @EXPORT = qw() ;
our $AUTOLOAD =();

use utf8 ;
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



#
# the main entry point of the application
#
sub main {

	print " issue_tracker.pl START MAIN \n " ; 
   doInitialize();	

   GetOptions(	
      'issue_file=s' => \$issue_file
   );
   
   $msg = 'issue_file to parse : ' ; 
   $objLogger->doLogInfoMsg ( "$msg" ) ; 
   $msg = $issue_file ; 
   $objLogger->doLogInfoMsg ( "$msg" ) ; 

	my $objIssueTracker 	   = 'IssueTracker::App::Utils::ETL::IssueTracker'->new ( \$appConfig ) ; 
	my ( $ret , $msg , $str_issue_file ) 
                     	   = $objIssueTracker->doReadIssueFile ( $issue_file ) ; 
   doExit ( $ret , $msg ) if $ret != 0 ;  

   my $hsr = {} ;          # a hash ref of hash refs 	
   ( $ret , $msg , $hsr ) 
                     	   = $objIssueTracker->doConvertStrToHashRef ( $str_issue_file ) ; 

   p($hsr) if $module_trace == 1 ; 

   doExit ( $ret , $msg ) if $ret != 0 ;  


	my $objDbHandlerFactory = 'IssueTracker::App::Model::DbHandlerFactory'->new( \$appConfig );
	my $objDbHandler 			= $objDbHandlerFactory->doInstantiate ( "$rdbms_type" );
   ( $ret , $msg )         = $objDbHandler->doInsertSqlHashData ( $hsr ) ; 
   doExit ( $ret , $msg ) if $ret != 0 ;  

	$objLogger->doLogInfoMsg ( "$msg") ; 
	$objLogger->doLogInfoMsg ( "STOP  MAIN") ; 

   exit ( $ret );
}
#eof sub main


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

   exit ( $exit_code ) ; 
}

# Action !!!
main () ; 

