package Qto::App::Ctrl::CtrlXlsToDb ; 

	use strict; use warnings; use utf8 ; 

	my $VERSION = '1.0.0';    

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
   use Qto::App::Db::Out::WtrDbsFactory ; 
   use Qto::App::IO::In::RdrDirs ; 
   use Qto::App::IO::In::RdrXls ; 
   use Qto::App::Mdl::Model ; 
   use Qto::App::Cnvr::CnrXlsHsr3ToDbHsr3 ; 
	
	our $module_trace                = 0 ; 
	our $RunDir 						   = '' ; 
	our $ProductBaseDir 				   = '' ; 
	our $ProductDir 					   = '' ; 
	our $ProductInstanceDir 			= ''; 
	our $ProductInstanceEnvironment  = '' ; 
	our $ProductName 					   = '' ; 
	our $ProductType 					   = '' ; 
	our $ProductVersion 				   = ''; 
	our $ProductOwner 				   = '' ; 
	our $HostName 						   = '' ; 
	our $ConfFile 						   = '' ; 
   our $appConfig                   = {} ; 
   our $rdbms_type                  = {} ; 
	our $objLogger						   = {} ; 
   our $objRdrDirs                  = {} ;
	our $objModel                    = {} ; 


=head1 SYNOPSIS
=cut 

=head1 EXPORT

	A list of functions that can be exported.  You can delete this section
	if you don't export anything, such as for a purely object-oriented module.
=cut 

=head1 SUBROUTINES/METHODS

	# -----------------------------------------------------------------------------
	START SUBS 
=cut


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
      if ( $objModel->get( 'io.xls-file' ) eq 'undefined' ) {
         my $xls_dir          = $ENV{'mix_data_dir' } ;  ; 
         my $arrRefXlsFiles   = $objRdrDirs->doReadDirGetFilesByExtension ( $xls_dir , 'xlsx')  ; 
         # ignore tilde containing files - todo: fix regex for file names starting with ~
         $xls_file            = (reverse sort (grep { $_ !~ m/~/g } @$arrRefXlsFiles))[0] ; 
         $objModel->set( 'io.xls-file' , $xls_file ) ; 
         confess ( "xls file not defined !!! Nothing to do !!!" ) unless $objModel->get( 'io.xls-file' ) ; 
      } 
      $xls_file               = $objModel->get( 'io.xls-file' ) ; 
     
      my $objRdrXls           = 'Qto::App::IO::In::RdrXls'->new ( 
            \$qto::appConfig , \@tables ) ; 
      
      # read the xls into hash ref of hash ref
      ( $ret , $msg  ) = 
            $objRdrXls->doReadXlsFileToHsr3 ( $xls_file , \$objModel) ; 
      return ( $ret , $msg ) unless $ret == 0 ; 
      my $hsr3             = $objModel->get('hsr3' ); 

      $msg                 = 'unknown error while inserting db tables !!!' ; 

      my $objWtrDbsFactory = 'Qto::App::Db::Out::WtrDbsFactory'->new( 
            \$qto::appConfig  , \$objModel , \$self , $rdbms_type ) ; 
      my $objWtrDb 		   = $objWtrDbsFactory->doSpawn ( "$rdbms_type" , \@tables );

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
                  'Qto::App::Cnvr::CnrXlsHsr3ToDbHsr3'->new (\$qto::appConfig , $rdbms_type ) ; 
            p ( $hsr2 ) ; 
            # todo:ysg
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

	


=head1 SUBROUTINES/METHODS
=cut


=head2 new
	# -----------------------------------------------------------------------------
	# the constructor 
	# -----------------------------------------------------------------------------
=cut 

	sub new {
		my $class      = shift;    # Class name is in the first parameter
		$appConfig     = ${ shift @_ } || { 'foo' => 'bar' ,} ; 
		$objModel      = ${ shift @_ } || croak 'objModel not passed !!!' ; 
		my $self       = {};        # Anonymous hash reference holds instance attributes
		bless( $self, $class );    # Say: $self is a $class
      $self->doInitialize() ; 
		return $self;
	}  


   sub doInitialize {
      my $self = shift ; 
	   $objLogger 	= 'Qto::App::Utils::Logger'->new( \$qto::appConfig ) ;
      $rdbms_type = $ENV{ 'rdbms_type' } || $objModel->get( 'ctrl.rdbms-type' ) || 'postgres' ; 
      $objRdrDirs = 'Qto::App::IO::In::RdrDirs'->new ( \$qto::appConfig , \$objModel ); 
	}	

=head2
	# -----------------------------------------------------------------------------
	# overrided autoloader prints - a run-time error - perldoc AutoLoader
	# -----------------------------------------------------------------------------
=cut

	


1;

__END__

=head1 NAME

CtrlXlsToDb 

=head1 SYNOPSIS

use CtrlXlsToDb  ; 


=head1 DESCRIPTION
the main purpose is to initiate minimum needed environment for the operation 
of the whole application - man app cnfig hash 

=head2 EXPORT


=head1 SEE ALSO

perldoc perlvars

No mailing list for this module


=head1 AUTHOR

yordan.georgiev@gmail.com

=head1 



=cut 

