package Qto::App::IO::Out::WtrExporterMd ; 

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

use Qto::App::Utils::Logger ; 
use Qto::App::Utils::Timer ; 
use Qto::App::Db::In::RdrDbsFactory ; 
use Qto::App::Cnvr::CnrHashesArrRefToHashesArrRef ; 
use Qto::App::IO::WtrMdFactory ; 

our $module_trace      = 1 ; 
our $objModel          = {} ; 
our $appConfig         = {} ; 
our $export_type       = 'md' ; 


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
   my $dat              = {} ; 
 
   $objRdrDbsFactory 	= 'Qto::App::Db::In::RdrDbsFactory'->new(\$appConfig, \$objModel );
   $objRdrDb            = $objRdrDbsFactory->doSpawn("$export_type");

   ($rv, $msg, $dat) 	= $objRdrDb->doHSelectBranch($db , $table, $objModel->get('hselect.web-action.bid'));
   $http_code 				= $rv ;  
   my $objCnrHashesArrRefToHashesArrRef = 'Qto::App::Cnvr::CnrHashesArrRefToHashesArrRef'->new (\$appConfig  ) ; 
   # p ( $dat ) ; 
   $dat = $objCnrHashesArrRefToHashesArrRef->doConvert ( $dat) ; 

   #my $objWtrGitHubMd    = 'Qto::App::IO::Out::WtrGitHubMd'->new( \$appConfig , \$objModel) ;
   my $objWtrMdFactory = 'Qto::App::IO::WtrMdFactory'->new( \$appConfig , \$objModel ) ;
   my $objWtrMd = $objWtrMdFactory->doSpawn("$export_type");
   return $objWtrMd->doWrite ( $table , $dat );
}


	sub new {
		my $invocant   = shift ;    
		$appConfig     = ${ shift @_ } || croak 'missing appConfig !!!' ; 
		$objModel      = ${ shift @_ } || croak 'missing objModel !!!' ; 
		$export_type   = shift         || $export_type ; 
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
