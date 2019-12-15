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
use Qto::App::Db::In::RdrDbsFcry ; 
use Qto::App::Cnvr::CnrHashesArrRefToHashesArrRef ; 
use Qto::App::IO::WtrMdFactory ; 

our $module_trace      = 1 ; 
our $objModel          = {} ; 
our $config            = {} ; 
our $export_type       = 'md' ; 


sub doExport {
   my $self = shift ; 
   my $db               = shift ; 
   my $table            = shift ; 
   my $md_dialect       = shift || 'github' ;
   my $rv               = 1 ; 
   my $msg              = '' ; 
   my $http_code        = 400 ; 
   my $http_method      = 'GET' ; 
   my $met              = {} ; 
   my $ret              = 1 ; 
   my $cnt              = 0 ; 
   my $objRdrDbsFcry = {} ; 
   my $objRdrDb         = {} ; 
   my $dat              = {} ; 
 
   $objRdrDbsFcry 	= 'Qto::App::Db::In::RdrDbsFcry'->new(\$config, \$objModel );
   $objRdrDb            = $objRdrDbsFcry->doSpawn("$export_type");

   ($rv, $msg, $dat) 	= $objRdrDb->doHiSelectBranch($db , $table, $objModel->get('hiselect.web-action.bid'));
   $http_code 				= $rv ;  
   my $objCnrHashesArrRefToHashesArrRef = 'Qto::App::Cnvr::CnrHashesArrRefToHashesArrRef'->new (\$config  ) ; 
   # p ( $dat ) ; 
   $dat = $objCnrHashesArrRefToHashesArrRef->doConvert ( $dat) ; 

   #my $objWtrGitHubMd    = 'Qto::App::IO::Out::WtrGitHubMd'->new( \$config , \$objModel) ;
   my $objWtrMdFactory = 'Qto::App::IO::WtrMdFactory'->new( \$config , \$objModel ) ;
   my $objWtrMd = $objWtrMdFactory->doSpawn("$export_type");
   return $objWtrMd->doWrite ( $table , $dat , $md_dialect);
}


	sub new {
		my $invocant   = shift ;    
		$config     = ${ shift @_ } || croak 'missing config !!!' ; 
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
           config => $config
      );
      return $self ; 
	}	
   


1;


__END__
