package Qto::App::Ctrl::CtrlHTableToHTable ; 

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
   use Qto::App::Cnvr::CnrHashesArrRefToHashesArrRef ; 
	
	our $module_trace                = 0 ; 
	our $RunDir 						   = '' ; 
	our $ProductBaseDir 				   = '' ; 
	our $ProductDir 					   = '' ; 
	our $ProductInstanceDir 			= ''; 
	our $ProductInstanceEnv          = '' ; 
	our $ProductName 					   = '' ; 
	our $EnvType 					      = '' ; 
	our $ProductVersion 				   = ''; 
	our $ProductOwner 				   = '' ; 
	our $HostName 						   = '' ; 
	our $ConfFile 						   = '' ; 
   our $config                      = {} ; 
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
      $objLogger->info ( $msg ) ; 

      my $objWtrDbsFcry = 'Qto::App::Db::Out::WtrDbsFcry'->new( \$config  , \$objModel , \$self , $rdbms_type ) ; 
      my $objWtrDb 		   = $objWtrDbsFcry->doSpawn ( "$rdbms_type" , \@tables );

      my $table = $tables[0] ; # one table for now ... 
      my $item = $tables[0] ; # one table for now ... 
      $msg = "START hierarchy conversion for table: $table " ; 
      $objLogger->info ( $msg ) ; 

      my $db            = $ENV{'postgres_app_db'} ; 
      my $objModel      = 'Qto::App::Mdl::Model'->new ( \$config , $db , $item ) ; 
      my $objRdrDbsFcry    = 'Qto::App::Db::In::RdrDbsFcry'->new(\$config, \$objModel );
      my $objRdrDb 			= $objRdrDbsFcry->doSpawn("$rdbms_type");

      (my $http_code, $msg, my $dat ) = $objRdrDb->doHiSelectBranch( $db , $item );
      my $objCnrHashesArrRefToHashesArrRef = 'Qto::App::Cnvr::CnrHashesArrRefToHashesArrRef'->new (\$config  ) ; 
      $dat = $objCnrHashesArrRefToHashesArrRef->doConvert ( $dat) ; 
      my $i = 0 ; 
      my $hsr2 = {} ; 
      foreach my $row ( @$dat) {
         if ( $i == 0 ){
            my $row0 = {} ; 
            foreach my $key ( keys %{$row}){
               $row0->{$key} = $key ; 
            }
            $hsr2->{0} = $row0 ; $i++ ; 
         }
         $hsr2->{$i} = $row ; $i++ ;
      }
      my $objCnrXlsHsr3ToDbHsr3 = 'Qto::App::Cnvr::CnrXlsHsr3ToDbHsr3'->new (\$config , $rdbms_type ) ; 
      $hsr2 = $objCnrXlsHsr3ToDbHsr3->doConvert ( $hsr2 , $table ) ; 
      p $hsr2 ; sleep 1 ; print "EOF p \$hsr2 in CtrlHTableToHTable.pm \n";
      $objModel->set('hsr2' , $hsr2 );
      $objModel->set('postgres_app_db',$ENV{'postgres_app_db'}) ;
      ( $ret , $msg  )        = $objWtrDb->doUpsertTable( \$objModel , $table ) ; 

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

CtrlHTableToHTable 

=head1 SYNOPSIS

use CtrlHTableToHTable  ; 


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

