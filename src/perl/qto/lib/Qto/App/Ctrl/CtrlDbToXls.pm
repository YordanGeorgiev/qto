package Qto::App::Ctrl::CtrlDbToXls ; 

	use strict; use warnings;

	my $VERSION = '1.0.0';    

	require Exporter;
	our @ISA = qw(Exporter  Qto::App::Utils::OO::SetGetable);
	our $AUTOLOAD =();
	use AutoLoader;
   use utf8 ;
   use Carp ;
   use Data::Printer ; 

   use parent 'Qto::App::Utils::OO::SetGetable' ;
   use Qto::App::Utils::Logger ; 
   use Qto::App::Db::In::RdrDbsFactory ; 
   use Qto::App::IO::Out::WtrXls ; 
   use Qto::App::Mdl::Model ; 

	our $module_trace                = 0 ; 
	our $appConfig						   = {} ; 
	our $objLogger						   = {} ; 
   our $rdbms_type                  = 'postgres' ; 
	our $objModel						   = {} ; 

=head1 SYNOPSIS
      my $objCtrlDbToXls = 
         'Qto::App::Ctrl::CtrlDbToXls'->new ( \$appConfig , \$objModel ) ; 
      my ( $ret , $msg ) = $objCtrlDbToXls->doReadAndLoad ( ); 
=cut 

=head1 EXPORT

	A list of functions that can be exported.  You can delete this section
	if you don't export anything, such as for a purely object-oriented module.
=cut 

=head1 SUBROUTINES/METHODS
=cut


   # 
	# -----------------------------------------------------------------------------
   # read the passed issue file , convert it to hash ref of hash refs 
   # and insert the hsr into a db
	# -----------------------------------------------------------------------------
   sub doReadAndLoad {

      my $self                = shift ; 
      my $issues_file         = shift ; 	

      my $ret                 = 1 ; 
      my $msg                 = 'unknown error while loading db issues to xls file' ; 
      my @tables              = ();
      my $tables              = $objModel->get( 'ctrl.tables' ) || 'daily_issues' ; 
      my $hsr2                = {} ;      # this is the data hash ref of hash reffs 
      my $msr2                = {} ;      # this is the meta hash describing the data hash ^^
      my $amsr2               = {} ;      # this is the meta hash describing the data hash ^^
      my $xls_file            = '' ;  

      my $db                     = $objModel->get( 'env.postgres_db_name' );
	   push ( @tables , split(',',$tables ) ) ; 

      my $objRdrDbsFactory       = 'Qto::App::Db::In::RdrDbsFactory'->new( \$appConfig , \$objModel  ) ; 
      my $objRdrDb         = $objRdrDbsFactory->doSpawn("$rdbms_type");

      ($ret, $msg , $amsr2 )     = $objRdrDb->doLoadProjDbMetaData( $db );
      return ( $ret , $msg ) unless $ret == 0 ; 
      $appConfig->{ "$db" . '.meta' } = $amsr2 ;

      $objModel->set('select.web-action.pg-size' , 1000000000) ; #set the maximum size

      for my $table ( @tables ) { 
         ( $ret , $msg , $msr2 ) = $objModel->doGetTableMeta ( $appConfig , $db , $table ) ;
         return ( $ret , $msg ) unless $ret == 0 ; 
         ( $ret , $msg , $hsr2)  = $objRdrDb->doSelect( $db , $table ) ; 
         return ( $ret , $msg ) unless $ret == 0 ; 
         my $objWtrXls    = 'Qto::App::IO::Out::WtrXls'->new( \$appConfig ) ;
         ($ret , $msg , $xls_file ) = $objWtrXls->doBuildXlsFromHashRef ( \$objModel , $table , $hsr2 , $msr2) ;
         return ( $ret , $msg ) unless $ret == 0 ; 
      }

      return ( $ret , $msg  ) ; 
   } 
   


=head1 SUBROUTINES/METHODS

=cut


=head2 new
=cut 

	sub new {
		my $class   = shift;    
		$appConfig  = ${ shift @_ } || { 'foo' => 'bar' ,} ; 
		$objModel   = ${ shift @_ } || croak 'objModel not passed !!!' ; 
		my $self = {}; bless( $self, $class );    # Say: $self is a $class
      $self = $self->doInitialize( ) ; 
		return $self;
	}  


   sub doInitialize {
      my $self          = shift ; 

      %$self = (
           appConfig => $appConfig
       );
	   $objLogger 			= 'Qto::App::Utils::Logger'->new( \$appConfig ) ;

      return $self ; 
	}	


=head2
	# -----------------------------------------------------------------------------
	# overrided autoloader prints - a run-time error - perldoc AutoLoader
	# -----------------------------------------------------------------------------
=cut
	sub AUTOLOAD {

		my $self = shift;
		no strict 'refs';
		my $name = our $AUTOLOAD;
		*$AUTOLOAD = sub {
			my $msg =
			  "BOOM! BOOM! BOOM! \n RunTime Error !!! \n Undefined Function $name(@_) \n ";
			croak "$self , $msg $!";
		};
		goto &$AUTOLOAD;    # Restart the new routine.
	}   


	sub RunBeforeExit {
		my $self = shift;
		#debug rint "%$self RunBeforeExit ! \n";
	}


	sub DESTROY {
		my $self = shift;
		#debug rint "the DESTRUCTOR is called  \n" ;
		$self->RunBeforeExit();
		return;
	}   



1;

__END__

=head1 NAME

UrlSniper 

=head1 SYNOPSIS

use UrlSniper  ; 


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

