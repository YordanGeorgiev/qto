package IssueTracker::App::IO::Out::WtrExporterXls ; 

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
   use IssueTracker::App::IO::Out::WtrXls ; 

   our $module_trace      = 1 ; 
   our $objModel          = {} ; 
   our $appConfig         = {} ; 
   our $rdbms_type        = 'postgres' ; 


   sub doExport {
      my $self             = shift ; 
      my $db               = shift ; 
      my $table            = shift ; 

      my $ret              = 1 ; 
      my $msg              = '' ; 
      my $msr2             = {} ; 
      my $hsr2             = {} ; 
      my $rdbms_type       = 'postgres' ; 
      my $xls_file         = '' ; 

      my $objRdrDbsFactory = 'IssueTracker::App::Db::In::RdrDbsFactory'->new(\$appConfig, \$objModel ) ;
      my $objRdrDb = $objRdrDbsFactory->doSpawn ( $rdbms_type ) ; 
      
      ( $ret , $msg , $msr2 ) = $objModel->doGetTableMeta ( $appConfig , $db , $table ) ;
      return ( $ret , $msg ) unless $ret == 0 ; 


      ( $ret , $msg , $hsr2)  = $objRdrDb->doSelect( $db , $table ) ; 
      return ( $ret , $msg ) unless $ret == 0 ; 

      my $objWtrXls    = 'IssueTracker::App::IO::Out::WtrXls'->new( \$appConfig ) ;
      return  $objWtrXls->doBuildXlsFromHashRef ( \$objModel , $table , $hsr2 , $msr2) ;
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
