package IssueTracker::App::Ctrl::CtrlTxtToDb ; 

	use strict; use warnings; use utf8 ; 

	my $VERSION = '1.0.0';    

	require Exporter;
	our @ISA = qw(Exporter  IssueTracker::App::Utils::OO::SetGetable);
	our $AUTOLOAD =();
	use AutoLoader;
   use utf8 ;
   use Carp ;
   use Data::Printer ; 

   use parent 'IssueTracker::App::Utils::OO::SetGetable' ;
   use IssueTracker::App::Utils::Logger ; 
   use IssueTracker::App::Db::Out::DbWritersFactory ; 
   use IssueTracker::App::IO::In::RdrTextFactory ; 
	
	our $module_trace                = 0 ; 
	our $appConfig						   = {} ; 
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
   our $rdbms_type                  = 'postgre' ; 


=head1 SYNOPSIS
      my $objCtrlTxtToDb = 
         'IssueTracker::App::Ctrl::CtrlTxtToDb'->new ( \$appConfig ) ; 
      ( $ret , $msg ) = $objCtrlTxtToDb->doLoadIssuesFileToDb ( $issues_file ) ; 
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
   sub doLoad {

      my $self                   = shift ; 
      my $ret                    = 1 ; 
      my $msg                    = '' ; 
      my $period                 = $ENV{ 'period' } || 'daily' ;  
      
      
      my @tables              = ();
      my $tables              = $appConfig->{ 'tables' } ;  
	   push ( @tables , split(',',$tables ) ) ; 
   

      foreach my $table ( @tables ) {
         my $objRdrTextFactory    = 'IssueTracker::App::IO::In::RdrTextFactory'->new( \$appConfig , $self ) ; 
         my $objRdrText 			   = $objRdrTextFactory->doInstantiate ( $table ); 
         my ( $ret , $msg , $str_issues_file ) 
                                    = $objRdrText->doReadIssueFile ( $table ) ; 
         return ( $ret , $msg ) if $ret != 0 ;  


         my $hsr = {} ;          # a hash ref of hash refs 	
         ( $ret , $msg , $hsr ) 
                                    = $objRdrText->doConvertStrToHashRef ( $str_issues_file , $table ) ; 
         return ( $ret , $msg ) if $ret != 0 ;  


         p($hsr) if $module_trace == 1 ; 
         my $objDbWritersFactory    = 'IssueTracker::App::Db::Out::DbWritersFactory'->new( \$appConfig , $self ) ; 
         my $objDbWriter 			   = $objDbWritersFactory->doInstantiate ( "$rdbms_type" );
         ( $ret , $msg )            = $objDbWriter->doInsertSqlHashData ( $hsr , $table ) ; 

         return ( $ret , $msg ) unless $ret == 0 ; 

      }

      $ret = 0 ; 
      $msg = "all tables loaded" ; 
      return ( $ret , $msg ) ; 
   } 


=head1 WIP

	
=cut

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
		$appConfig     = ${ shift @_ } || { 'foo' => 'bar' ,} ; 

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

      %$self = (
           appConfig => $appConfig
      );

	   $objLogger 			= 'IssueTracker::App::Utils::Logger'->new( \$appConfig ) ;


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

