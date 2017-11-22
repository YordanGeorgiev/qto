package IssueTracker::App::Ctrl::CtrlDbToGSheet ; 

	use strict; use warnings;

	my $VERSION = '1.2.0';    

	require Exporter;
	our @ISA = qw(Exporter);
	our $AUTOLOAD =();
	use AutoLoader;
   use utf8 ;
   use Carp ;
   use Data::Printer ; 
   no warnings 'deprecated';
   use Net::Google::DataAPI::Auth::OAuth2 ; 
   use warnings 'deprecated';

   use IssueTracker::App::Utils::Logger ; 
   use IssueTracker::App::Db::In::DbReadersFactory ; 
   use IssueTracker::App::IO::Out::GSheetWriter ; 
   use IssueTracker::App::IO::In::UrlReader ; 

	our $module_trace                = 0 ; 
	our $appConfig						   = {} ; 
	our $objLogger						   = {} ; 
	our $objFileHandler			      = {} ; 
   our $rdbms_type                  = 'postgre' ; 

=head1 SYNOPSIS
      my $objCtrlDbToFile = 
         'IssueTracker::App::Ctrl::CtrlDbToFile'->new ( \$appConfig ) ; 
      ( $ret , $msg ) = $objCtrlDbToFile->doLoadIssuesFileToDb ( $issues_file ) ; 
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
      my $issues_file         = shift ; 	

      my $ret                 = 1 ; 
      my $msg                 = 'unknown error while loading db issues to xls file' ; 
      my @tables              = ();
      my $tables              = $appConfig->{ 'tables' } || 'daily_issues' ; 
	   push ( @tables , split(',',$tables ) ) ; 

      my $oauth2 = Net::Google::DataAPI::Auth::OAuth2->new(
          client_id        => $ENV{CLIENT_ID},
          client_secret    => $ENV{CLIENT_SECRET},
          scope            => ['https://www.googleapis.com/auth/spreadsheets' 
                             , 'https://www.googleapis.com/auth/drive'
                             , 'https://spreadsheets.google.com/feeds'
                             ],
      # https://www.googleapis.com/auth/drive	
      # View and manage the files in your Google D# # i# rive
      # https://www.googleapis.com/auth/drive.file	
      # View and manage Google Drive files and folders that you have opened or created with this app
      # https://www.googleapis.com/auth/drive.readonly	
      # View the files in your Google Drive
      # https://www.googleapis.com/auth/spreadsheets	
      # View and manage your spreadsheets in Google Drive
      # https://www.googleapis.com/auth/spreadsheets.readonly	
      # View your Google Spreadsheets
      );

      my $url = $oauth2->authorize_url();
      # my $url = '' ; 
      # system("open '$url'");
      print "go to the following url with your browser \n" ; 
      print "$url\n" ; 
      my $issue_tracker_proj = $ENV{'issue_tracker_project'} ; 
      my $home_dir = $ENV{'HOME'} ; 
      print "copy the string from your browser \n" ; 
      print 'echo <<CODE>> > ' . "$home_dir/.google/.code." . $issue_tracker_proj . "\n" ; 
      sleep 6 ; # give time to the human to get it done ...

      my $code = $objFileHandler->doReadFileReturnString ( "$home_dir/.google/.code." . $issue_tracker_proj ) ; 
      print "\$code is $code" ; 
      sleep 3 ; # give time to the developer to verify it ...

      
      my $objToken = $oauth2->get_access_token($code);
      my $refresh_token = $objToken->refresh_token ; 


      my $client_id        = $ENV{ 'CLIENT_ID' } ; 
      my $client_secret    = $ENV{ 'CLIENT_SECRET' } ; 
      my $spread_sheet_id  = $ENV{ 'google_spread_sheet_id' }  ; 
     
      if ( $module_trace == 1 ) {
         p ( $objToken ) ; 
         print "start my refresh token is : \n" ; 
         p( $objToken ) if $module_trace == 1 ; 
         print "my client id is : $client_id \n" ; 
         print "my client secret is : $client_secret \n" ; 
         print "my google_spread_sheet_id is : $spread_sheet_id \n" ; 
         print "stop  my refresh token is : \n" ; 
         p($refresh_token ) ; 
      }

      my $objGoogleService = Net::Google::Spreadsheets::V4->new(
            client_id      => $client_id
          , client_secret  => $client_secret
          , refresh_token  => $refresh_token 
          , spreadsheet_id => $spread_sheet_id
      );

      if ( $module_trace == 1 ) {
         print "start debuggin the \$objGoogleService \n" ; 
         p ( $objGoogleService ) ; 
         print "stop  debuggin the \$objGoogleService \n" ; 
       }

      for my $table ( @tables ) { 

         my $hsr                 = {} ;      # this is the data hash ref of hash reffs 
         my $mhsr                = {} ;      # this is the meta hash describing the data hash ^^

         my $objDbReadersFactory = 'IssueTracker::App::Db::In::DbReadersFactory'->new( \$appConfig , $self ) ; 
         my $objDbReader 			= $objDbReadersFactory->doInstantiate ( "$rdbms_type" );
      
         ( $ret , $msg , $hsr , $mhsr )  = $objDbReader->doSelectTableIntoHashRef( $table ) ; 
         return ( $ret , $msg ) unless $ret == 0 ; 
    
         my $objGSheetWriter    = 'IssueTracker::App::IO::Out::GSheetWriter'->new( \$appConfig ) ;
         ( $ret , $msg )  = $objGSheetWriter->doWriteGSheetFromHashRef ( 
               $mhsr , $hsr , \$objGoogleService , $table , $refresh_token , $spread_sheet_id ) ; 

         return ( $ret , $msg ) unless $ret == 0 ; 
      }

      return ( $ret , $msg  ) ; 
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

		my $class = shift;    # Class name is in the first parameter
		$appConfig = ${ shift @_ } || { 'foo' => 'bar' ,} ; 
		my $self = {};        # Anonymous hash reference holds instance attributes
		bless( $self, $class );    # Say: $self is a $class
      $self = $self->doInitialize( ) ; 
		return $self;
	}  
	#eof const


   #
	# --------------------------------------------------------
	# intializes this object 
	# --------------------------------------------------------
   sub doInitialize {
      my $self          = shift ; 

      %$self = (
           appConfig => $appConfig
       );

	   $objLogger 			= 'IssueTracker::App::Utils::Logger'->new( \$appConfig ) ;
	   $objFileHandler   = 'IssueTracker::App::Utils::IO::FileHandler'->new ( \$appConfig ) ; 

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

