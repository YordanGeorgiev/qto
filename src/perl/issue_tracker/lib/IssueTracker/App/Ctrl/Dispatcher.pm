package IssueTracker::App::Ctrl::Dispatcher ; 

	use strict; use warnings; use utf8 ; 

	my $VERSION = '1.0.0';    

	require Exporter;
	our @ISA = qw(Exporter);
	our $AUTOLOAD =();
	use AutoLoader;
   use Carp ;
   use Data::Printer ; 

   use IssueTracker::App::Utils::Logger ; 

   use IssueTracker::App::Ctrl::CtrlTxtToDb ; 
   use IssueTracker::App::Ctrl::CtrlXlsToDb ; 	
   use IssueTracker::App::Ctrl::CtrlDbToTxt ; 
   use IssueTracker::App::Ctrl::CtrlDbToXls ; 
   use IssueTracker::App::Ctrl::CtrlDbToGSheet ; 
   use IssueTracker::App::Ctrl::CtrlDbToConflu ; 
   use IssueTracker::App::Ctrl::CtrlMetaToJson ; 

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
      my $objDispatcher = 
         'IssueTracker::App::Ctrl::Dispatcher'->new ( \$appConfig ) ; 
      ( $ret , $msg ) = $objDispatcher->doRun ( $actions ) ; 
=cut 

=head1 EXPORT

	A list of functions that can be exported.  You can delete this section
	if you don't export anything, such as for a purely object-oriented module.
=cut 

=head1 SUBROUTINES/METHODS

	# -----------------------------------------------------------------------------
	START SUBS 
=cut

   sub doTxtToDb {
      my $self = shift ; 
      use strict 'refs'; 

      my $objCtrlTxtToDb = 
         'IssueTracker::App::Ctrl::CtrlTxtToDb'->new ( \$appConfig ) ; 
      my ( $ret , $msg ) = $objCtrlTxtToDb->doLoad () ; 
      return ( $ret , $msg ) unless $ret == 0 ; 
   }

   sub doDbToXls {
      my $self = shift ; 
      use strict 'refs'; 

      my $objCtrlDbToXls = 
         'IssueTracker::App::Ctrl::CtrlDbToXls'->new ( \$appConfig ) ; 
      my ( $ret , $msg ) = $objCtrlDbToXls->doReadAndLoad ( ); 
      return ( $ret , $msg ) unless $ret == 0 ; 

   }
   
   sub doDbToGsheet {
      my $self = shift ; 
      use strict 'refs'; 
      my $self = shift ;  
      my $objCtrlDbToGsheet = 
         'IssueTracker::App::Ctrl::CtrlDbToGSheet'->new ( \$appConfig ) ; 
      my ( $ret , $msg ) = $objCtrlDbToGsheet->doReadAndLoad ( ); 
      return ( $ret , $msg ) unless $ret == 0 ; 

   }

   sub doDbToConlfu {
      my $self = shift ; 
      use strict 'refs'; 

      my $objCtrlDbToConflu = 
         'IssueTracker::App::Ctrl::CtrlDbToConflu'->new ( \$appConfig ) ; 
      my ( $ret , $msg ) = $objCtrlDbToConflu->doReadAndLoad ( ); 
      return ( $ret , $msg ) unless $ret == 0 ; 
   }

   sub doXlsToDb {
      my $self = shift ; 
      use strict 'refs'; 

      my $objCtrlXlsToDb = 
         'IssueTracker::App::Ctrl::CtrlXlsToDb'->new ( \$appConfig ) ; 
      my ( $ret , $msg ) = $objCtrlXlsToDb->doReadAndLoad ( ) ; 
      return ( $ret , $msg ) ; 
   }
   
   sub doLoadMetaToJson {
      my $self = shift ; 
      use strict 'refs'; 

      my $objCtrlMetaToJson = 
         'IssueTracker::App::Ctrl::CtrlMetaToJson'->new ( \$appConfig ) ; 
      my ( $ret , $msg ) = $objCtrlMetaToJson->doRun () ; 
      return ( $ret , $msg ) ; 
   }

   sub doDbToTxt {

      my $self = shift ; 
      use strict 'refs'; 
      my $objCtrlDbToTxt = 
         'IssueTracker::App::Ctrl::CtrlDbToTxt'->new ( \$appConfig ) ; 
      my ( $ret , $msg ) = $objCtrlDbToTxt->doReadAndWrite ( ) ; 
      return ( $ret , $msg ) unless $ret == 0 ; 

   }


   sub doRun {

      my $self          = shift ; 
      my $actions       = shift ; 

      my @actions = split /,/ , $actions ; 
      my $msg = 'error in Dispatcher' ; 
      my $ret = 0 ; 

     
      foreach my $action ( @actions ) { 

         $ret = 0 ; 
         $action = 'undefined action ' unless $action ; 
         $msg = "START RUN the $action action " ; 
         $objLogger->doLogInfoMsg ( $msg ) ; 
           

         my $func = $action ; 
         $func =~ s/(\w+)/($a=lc $1)=~s<(^[a-z]|-[a-z])><($b=uc$1);$b;>eg;$a;/eg ; 
         $func =~ s|-||g;
         $func = "do" . $func ; 
         no strict 'refs' ; 
         $self->$func ; 
         return ( $ret , $msg ) if $@ ; 
         # return ( $ret , $msg ) unless $ret == 0 ; 

         $msg = "unknown $action action !!!" ; 
         $objLogger->doLogErrorMsg ( $msg ) ; 
         # return ( $ret , $msg ) unless $ret == 0 ; 
         
         $msg = "STOP  RUN the $action action " ; 
         $objLogger->doLogInfoMsg ( $msg ) ; 

      } 
      #eof foreach action 

      $msg = "OK for all action runs" ; 
      $ret = 0 ; 
      return ( $ret , $msg ) ; 
   }
   # eof sub doRun

	

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
	# return a field's value
	# -----------------------------------------------------------------------------
	sub get {

		my $self = shift;
		my $name = shift;
		croak "\@TRYING to get an undef name" unless $name ;  
		croak "\@TRYING to get an undefined value" unless ( $self->{"$name"} ) ; 

		return $self->{ $name };
	}    #eof sub get


	# -----------------------------------------------------------------------------
	# set a field's value
	# -----------------------------------------------------------------------------
	sub set {

		my $self  = shift;
		my $name  = shift;
		my $value = shift;
		$self->{ "$name" } = $value;
	}
	# eof sub set


	# -----------------------------------------------------------------------------
	# return the fields of this obj instance
	# -----------------------------------------------------------------------------
	sub dumpFields {
		my $self      = shift;
		my $strFields = ();
		foreach my $key ( keys %$self ) {
			$strFields .= " $key = $self->{$key} \n ";
		}

		return $strFields;
	}    
	# eof sub dumpFields
		

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

