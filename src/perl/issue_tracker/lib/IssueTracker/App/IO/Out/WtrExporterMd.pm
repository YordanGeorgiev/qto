package IssueTracker::App::IO::Out::WtrExporterMd ; 

use strict ; use warnings ; use utf8 ; 

require Exporter; 
use AutoLoader ; 
use Encode qw( encode_utf8 is_utf8 );
use POSIX qw(strftime);
use DBI ; 
use Data::Printer ; 
use Carp ; 
use Data::Printer ; 
use List::Util 1.33 'any';

use IssueTracker::App::Utils::Logger ; 
use IssueTracker::App::Utils::Timer ; 
use IssueTracker::App::Db::In::RdrDbsFactory ; 
use IssueTracker::App::Cnvr::CnrHashesArrRefToHashesArrRef ; 
use IssueTracker::App::IO::Out::WtrMd ; 

our $module_trace      = 1 ; 
our $objModel          = {} ; 
our $appConfig         = {} ; 
our $rdbms_type        = 'postgres' ; 


sub doExport {
   my $self = shift ; 
   my $db               = shift ; 
   my $table            = shift ; 
   my $rv               = 1 ; 
   my $msg              = '' ; 
   my $http_code        = 400 ; 
   my $http_method      = 'GET' ; 
   my $met              = {} ; 
   my $ret              = 1 ; 
   my $cnt              = 0 ; 
   my $objRdrDbsFactory = {} ; 
   my $objRdrDb         = {} ; 
   my $rdbms_type       = 'postgres' ; 
   my $dat              = {} ; 
 
   $objRdrDbsFactory 	= 'IssueTracker::App::Db::In::RdrDbsFactory'->new(\$appConfig, \$objModel );
   $objRdrDb            = $objRdrDbsFactory->doSpawn("$rdbms_type");

   ($rv, $msg, $dat) 	= $objRdrDb->doHSelectBranch($db , $table, $objModel->get('view.web-action.bid'));
   $http_code 				= $rv ;  
   my $objCnrHashesArrRefToHashesArrRef = 'IssueTracker::App::Cnvr::CnrHashesArrRefToHashesArrRef'->new (\$appConfig  ) ; 
   # p ( $dat ) ; 
   $dat = $objCnrHashesArrRefToHashesArrRef->doConvert ( $dat) ; 

   my $objWtrMd    = 'IssueTracker::App::IO::Out::WtrMd'->new( \$appConfig , \$objModel) ;
   return $objWtrMd->doWrite ( $table , $dat );
}


	sub new {
		my $invocant   = shift ;    
		$appConfig     = ${ shift @_ } || croak 'missing appConfig !!!' ; 
		$objModel      = ${ shift @_ } || croak 'missing objModel !!!' ; 
		$rdbms_type    = shift         || $rdbms_type ; 
		my $class      = ref ( $invocant ) || $invocant ; 
		my $self       = {}; bless( $self, $class );    # Say: $self is a $class
      $self = $self->doInit() ; 
		return $self;
	}  


   sub doInit {
      my $self = shift ; 

      %$self = (
           appConfig => $appConfig
      );
      return $self ; 
	}	
   


1;


__END__
