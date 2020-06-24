package Qto::App::Ctrl::CtrlXlsToDb ; 

	use strict; use warnings; use utf8 ; 

	my $VERSION = '1.0.1';    

	require Exporter;
	our @ISA = qw(Exporter Qto::App::Utils::OO::SetGetable Qto::App::Utils::OO::AutoLoadable) ;
	our $AUTOLOAD =();
	use AutoLoader;
   use utf8 ;
   use Carp ;
   use Data::Printer ; 

   use parent 'Qto::App::Utils::OO::SetGetable' ;
   use parent 'Qto::App::Utils::OO::AutoLoadable' ;

   use Qto::App::Utils::Logger ; 
   use Qto::App::Db::Out::WtrDbsFcry ; 
   use Qto::App::IO::In::RdrDirs ; 
   use Qto::App::IO::In::RdrXls ; 
   use Qto::App::Mdl::Model ; 
   use Qto::App::Cnvr::CnrXlsHsr3ToDbHsr3 ; 
	
	our $module_trace                = 0 ; 
	our $RunDir 						   = '' ; 
	our $ProductBaseDir 				   = '' ; 
	our $ProductDir 					   = '' ; 
	our $ProductInstanceDir 			= ''; 
	our $ProductInstanceEnv  = '' ; 
	our $ProductName 					   = '' ; 
	our $EnvType 					   = '' ; 
	our $ProductVersion 				   = ''; 
	our $ProductOwner 				   = '' ; 
	our $HostName 						   = '' ; 
	our $ConfFile 						   = '' ; 
   our $config                   = {} ; 
   our $rdbms_type                  = {} ; 
	our $objLogger						   = {} ; 
   our $objRdrDirs                  = {} ;
	our $objModel                    = {} ; 


   # 
	# -----------------------------------------------------------------------------
   # read the passed issue file , convert it to hash ref of hash refs 
   # and insert the hsr into a db
	# -----------------------------------------------------------------------------
   sub doReadAndLoad {

      my $self                = shift ; 
      my $tables_list         = shift ; 

      my $ret                 = 1 ; 
      my $msg                 = 'file read' ; 
      
      my $tables              = $objModel->get( 'ctrl.tables' ) ; 
      my @tables              = ();
	   push ( @tables , split(',',$tables ) ) ; 
      my $xls_file            = '' ; 
     
      $msg = "using the following \@tables: " . join (",", @tables) . "\n" ; 
      $objLogger->doLogInfoMsg ( $msg ) ; 
      # if the xls_file is not defined take the latest one from the mix data dir
      $xls_file               = $objModel->get( 'io.xls-file' ) ; 
      print "$xls_file \n" ; sleep 10 ; 
      if ( $objModel->get( 'io.xls-file' ) eq 'undefined' ) {
         my $xls_dir          = $ENV{'PROJ_INSTANCE_DIR' } || $config->{'env'}->{'run'}->{'ProductInstanceDir'} ; 
         $xls_dir             = $xls_dir . "/dat/mix" ; 
         my $arrRefXlsFiles   = $objRdrDirs->doReadDirGetFilesByExtension ( $xls_dir , 'xlsx')  ; 
         # ignore tilde containing files - todo: fix regex for file names starting with ~
         $xls_file            = (reverse sort (grep { $_ !~ m/~/g } @$arrRefXlsFiles))[0] ; 
         $objModel->set( 'io.xls-file' , $xls_file ) ; 
         confess ( "cannot find an xls file to load !!! Nothing to do !!!" ) unless $objModel->get( 'io.xls-file' ) ; 
      } 
     
      my $objRdrXls           = 'Qto::App::IO::In::RdrXls'->new ( \$config , \@tables ) ; 
      
      # read the xls into hash ref of hash ref
      ( $ret , $msg  ) = $objRdrXls->doReadXlsFileToHsr3 ( $xls_file , \$objModel) ; 
      return ( $ret , $msg ) unless $ret == 0 ; 
      my $hsr3             = $objModel->get('hsr3' ); 

      $msg                 = 'unknown error while inserting db tables !!!' ; 

      my $objWtrDbsFcry = 'Qto::App::Db::Out::WtrDbsFcry'->new( \$config  , \$objModel , \$self , $rdbms_type ) ; 
      my $objWtrDb 		   = $objWtrDbsFcry->doSpawn ( "$rdbms_type" , \@tables );

      p($hsr3) if $module_trace == 1 ; 

      my $load_model = $ENV{ 'load_model' } || 'nested-set' ; 

      # p ( $hsr3 ) ; 
      # print " STOP before \n" ; 

      if ( $load_model eq 'upsert' ) {
         $objModel->set('postgres_db_name',$ENV{'postgres_db_name'}) ;
         ( $ret , $msg  )        = $objWtrDb->doUpsertTables( \$objModel , \@tables) ; 
         
         p ( $objModel->get('hsr3') ) if $module_trace == 1 ; 

      } 
      elsif ( $load_model eq 'nested-set' ) {
         foreach my $table ( keys %$hsr3 ) { 
            $msg = "START hierarchy conversion for table: $table " ; 
            $objLogger->doLogInfoMsg ( $msg ) ; 
            my $hsr2 = $hsr3->{ "$table" } ; 
            my $objCnrXlsHsr3ToDbHsr3 = 
                  'Qto::App::Cnvr::CnrXlsHsr3ToDbHsr3'->new (\$config , $rdbms_type ) ; 
            $hsr2 = $objCnrXlsHsr3ToDbHsr3->doConvert ( $hsr2 , $table ) ; 
            $objModel->set('hsr2' , $hsr2 );
            $objModel->set('postgres_db_name',$ENV{'postgres_db_name'}) ;
            ( $ret , $msg  )        = $objWtrDb->doUpsertTable( \$objModel , $table ) ; 
         }

      } 
      else {
         ( $ret , $msg  )        = $objWtrDb->doUpsertTables( $hsr3 , \@tables) ; 
      }
      return ( $ret , $msg ) ; 
   } 


	sub new {
		my $class      = shift;    
		$config        = ${ shift @_ } || croak 'no config passed !!!' ; 
		$objModel      = ${ shift @_ } || croak 'objModel not passed !!!' ; 
		my $self       = {}; bless( $self, $class );
      $self->doInit() ; 
		return $self;
	}  


   sub doInit {
      my $self = shift ; 
	   $objLogger 	= 'Qto::App::Utils::Logger'->new( \$config ) ;
      $rdbms_type = $ENV{ 'rdbms_type' } || $objModel->get( 'ctrl.rdbms-type' ) || 'postgres' ; 
      $objRdrDirs = 'Qto::App::IO::In::RdrDirs'->new (); 
	}	


	


1;

__END__

=head1 NAME

CtrlXlsToDb 

=head1 SYNOPSIS

use CtrlXlsToDb  ; 


=head1 DESCRIPTION
the main purpose is to initiate minimum needed environment for the operation 
of the whole application - man app config hash 

=head2 EXPORT


=head1 SEE ALSO

perldoc perlvars

No mailing list for this module


=head1 AUTHOR

yordan.georgiev@gmail.com

=head1 



=cut 

