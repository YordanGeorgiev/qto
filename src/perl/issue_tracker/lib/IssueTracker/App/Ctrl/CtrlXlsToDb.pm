package IssueTracker::App::Ctrl::CtrlXlsToDb ; 

	use strict; use warnings; use utf8 ; 

	my $VERSION = '1.0.0';    

	require Exporter;
	our @ISA = qw(Exporter  IssueTracker::App::Utils::OO::SetGetable);
	our $AUTOLOAD =();
	use AutoLoader;
   use Carp ;
   use Data::Printer ; 

   use parent 'IssueTracker::App::Utils::OO::SetGetable' ;
   use IssueTracker::App::Utils::Logger ; 
   use IssueTracker::App::Db::Out::WtrDbsFactory ; 
   use IssueTracker::App::IO::In::RdrXls ; 
   use IssueTracker::App::Mdl::Model ; 
   use IssueTracker::App::Cnvr::CnrXlsHsr3ToDbHsr3 ; 
	
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
	our $objLogger						   = {} ; 
   our $rdbms_type                  = $ENV{ 'rdbms_type' } || 'postgres' ; 


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
      
      my @tables              = ();
      my $tables              = $issue_tracker::appConfig->{ 'tables' } ;  
      my $xls_file            = $issue_tracker::appConfig->{ 'xls_file' } ; 
	   push ( @tables , split(',',$tables ) ) ; 

      my $objModel          = 'IssueTracker::App::Mdl::Model'->new ( \$issue_tracker::appConfig ) ; 
      my $objRdrXls           = 'IssueTracker::App::IO::In::RdrXls'->new ( \$issue_tracker::appConfig , \@tables ) ; 
      
      # read the xls into hash ref of hash ref
      ( $ret , $msg  ) = 
            $objRdrXls->doReadXlsFileToHsr3 ( $xls_file , \$objModel) ; 
      return ( $ret , $msg ) unless $ret == 0 ; 
      my $hsr3                = $objModel->get('hsr3' ); 

      $msg                 = 'unknown error while inserting db tables !!!' ; 

      my $objWtrDbsFactory = 'IssueTracker::App::Db::Out::WtrDbsFactory'->new( \$issue_tracker::appConfig  , \$self , $rdbms_type ) ; 
      my $objWtrDb 		   = $objWtrDbsFactory->doInstantiate ( "$rdbms_type" , \@tables );

      p($hsr3) if $module_trace == 1 ; 

      my $load_model = $ENV{ 'load_model' } || 'upsert' ; 
      # p ( $hsr3 ) ; 
      # print " STOP before \n" ; 

      if ( $load_model eq 'upsert' ) {
         ( $ret , $msg  )        = $objWtrDb->doUpsertTables( \$objModel , \@tables) ; 
         p ( $objModel->get('hsr3') ) ; 

      } 
      elsif ( $load_model eq 'nested-set' ) {
         foreach my $table ( keys %$hsr3 ) { 
            $msg = "START hierarchy conversion for table: $table " ; 
            $objLogger->doLogInfoMsg ( $msg ) ; 
            my $hsr2 = $hsr3->{ "$table" } ; 
            my $objCnrXlsHsr3ToDbHsr3 = 
                  'IssueTracker::App::Cnvr::CnrXlsHsr3ToDbHsr3'->new (\$issue_tracker::appConfig , $rdbms_type ) ; 
            # p ( $hsr2 ) ; 
            $hsr2 = $objCnrXlsHsr3ToDbHsr3->doConvert ( $hsr2 ) ; 
            $objModel->set('hsr2' , $hsr2 );
            ( $ret , $msg  )        = $objWtrDb->doUpsertTable( \$objModel , $table ) ; 
         }

      } 
      else {
         ( $ret , $msg  )        = $objWtrDb->doUpsertTables( $hsr3 , \@tables) ; 
      }
      return ( $ret , $msg ) ; 
   } 

	


=head1 SUBROUTINES/METHODS

	STOP  SUBS 
	# -----------------------------------------------------------------------------
=cut


=head2 new
	# -----------------------------------------------------------------------------
	# the constructor
=cut 

	# -----------------------------------------------------------------------------
	# the constructor 
	# -----------------------------------------------------------------------------
	sub new {

		my $class      = shift;    # Class name is in the first parameter
		my $self = {};        # Anonymous hash reference holds instance attributes
		bless( $self, $class );    # Say: $self is a $class
      $self = $self->doInitialize() ; 
		return $self;
	}  
	#eof const
	
   #
	# --------------------------------------------------------
	# intializes this object 
	# --------------------------------------------------------
   sub doInitialize {
      my $self = shift ; 

	   $objLogger 			= 'IssueTracker::App::Utils::Logger'->new( \$issue_tracker::appConfig ) ;


      return $self ; 
	}	
	#eof sub doInitialize

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
	# eof sub AUTOLOAD


	# -----------------------------------------------------------------------------
	# wrap any logic here on clean up for this class
	# -----------------------------------------------------------------------------
	sub RunBeforeExit {

		my $self = shift;

		#debug print "%$self RunBeforeExit ! \n";
	}
	#eof sub RunBeforeExit


	# -----------------------------------------------------------------------------
	# called automatically by perl's garbage collector use to know when
	# -----------------------------------------------------------------------------
	sub DESTROY {
		my $self = shift;

		#debug print "the DESTRUCTOR is called  \n" ;
		$self->RunBeforeExit();
		return;
	}   
	#eof sub DESTROY


	# STOP functions
	# =============================================================================

	


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

