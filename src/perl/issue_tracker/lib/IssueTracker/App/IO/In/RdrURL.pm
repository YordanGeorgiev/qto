package IssueTracker::App::IO::In::RdrURL;

	use strict; use warnings;

	my $VERSION = '1.0.0';    #doc at the end

	require Exporter;
	our @ISA = qw(Exporter  IssueTracker::App::Utils::OO::SetGetable);
	our $AUTOLOAD =();
	our $ModuleDebug = 0 ; 
	use AutoLoader;

	use Cwd qw/abs_path/;
	use File::Path qw(make_path) ;
	use File::Find ; 
	use Sys::Hostname;
	use Carp qw /cluck confess shortmess croak carp/ ; 
   
   use base qw(IssueTracker::App::Utils::OO::SetGetable);
   use IssueTracker::App::Utils::Logger ;
   use WWW::Curl::Easy ; 
	use Data::Printer ; 
   use HTTP::Response ; 
	
	our $appConfig						= {} ; 
	our $RunDir 						= '' ; 
	our $ProductBaseDir 				= '' ; 
	our $ProductDir 					= '' ; 
	our $ProductInstanceDir 			= ''; 
	our $EnvironmentName 			= '' ; 
	our $ProductName 					= '' ; 
	our $ProductType 					= '' ; 
	our $ProductVersion 				= ''; 
	our $ProductOwner 				= '' ; 
	our $HostName 						= '' ; 
	our $ConfFile 						= '' ; 
	our $objLogger						= {} ; 

=head1 SYNOPSIS

my ( $ret , $response_code , $response_body , $response_content )  = () ; 
( $ret , $response_code , $response_body , $response_content ) 
      = $objRdrURL->doRunURL( $http_method , $url );

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
# performs an http request 	
#
sub doReadURL {

   my $self               = shift ; 
   my $url                = shift ;   
   my $http_method_type   = shift || 'GET' ; 
   my $headers            = shift ; 

   my $curl = WWW::Curl::Easy->new();
   $curl->setopt(WWW::Curl::Easy::CURLOPT_HEADER(),1);
   $curl->setopt(WWW::Curl::Easy::CURLOPT_MAXREDIRS(),3);
   $curl->setopt(WWW::Curl::Easy::CURLOPT_URL(), "$url" );
   ## Set up the standard GET/POST request options
   $curl->setopt(WWW::Curl::Easy::CURLOPT_VERBOSE, 0);                  # Disable verbosity
   $curl->setopt(WWW::Curl::Easy::CURLOPT_HEADER, 0);                   # Don't include header in body 
   $curl->setopt(WWW::Curl::Easy::CURLOPT_NOPROGRESS, 1);               # Disable internal progress meter
   $curl->setopt(WWW::Curl::Easy::CURLOPT_FOLLOWLOCATION, 0);           # Disable automatic location redirects
   $curl->setopt(WWW::Curl::Easy::CURLOPT_FAILONERROR, 0);              # Setting this to true fails on HTTP error
   $curl->setopt(WWW::Curl::Easy::CURLOPT_SSL_VERIFYPEER, 0);           # Ignore bad SSL
   $curl->setopt(WWW::Curl::Easy::CURLOPT_SSL_VERIFYHOST, 0);           # Ignore bad SSL
   # $curl->setopt(WWW::Curl::Easy::CURLOPT_NOSIGNAL, 1);                 # To make thread safe, disable signals
   # $curl->setopt(WWW::Curl::Easy::CURLOPT_ENCODING, 'gzip');            # Allow gzip compressed pages

   if ( $headers ) { 
      for my $key ( sort ( keys %$headers )) {
         my $header_name = $key ; 
         my $header_val = $headers->{ "$key" } ; 
         $curl->setopt(WWW::Curl::Easy::CURLOPT_HTTPHEADER() , [ $header_name . $header_val ]  );
      }
   }

   if ( $http_method_type eq 'POST' ) {
      $curl->setopt(WWW::Curl::Easy::CURLOPT_POST(), 1);
   }

   # A filehandle, reference to a scalar or reference to a typeglob can be used here.
   my $response_body       = q{} ; 
   my $response_code       = q{} ; 
   my $response_content    = q{} ; 

   $curl->setopt(WWW::Curl::Easy::CURLOPT_WRITEDATA(),\$response_body);

   # Starts the actual request
   my $ret = $curl->perform;


   if ($ret == 0) {
      my $msg = "OK for the curl transfer for the url: $url " ; 
      $objLogger->doLogInfoMsg ( $msg ) ; 
      
      $response_code = $curl->getinfo(CURLINFO_HTTP_CODE);
      $response_content = HTTP::Response->parse( "$response_body" ) ; 
      $response_content = $response_content->content;
      print "start printing response" ; 
      p ( $response_content ) ; 
      print "stop  printing response" ; 
      sleep 3 ; 
      #my $json_str = HTTP::Response->parse($response_body);
      # print("Received response: $response_body\n");
      #p($response_body);
      #$json_str = $response_body->content ; 

      #my $json_dat = JSON->new->utf8->decode($json_str);
      #p($json_dat);
      #debug p ( $response_content ) ; 
      

   } else {
      my $msg = "An error happened: $ret ".$curl->strerror($ret)." ".$curl->errbuf."\n" ; 
      $objLogger->doLogErrorMsg ( $msg ) ; 
      #  Error code, type of error, error message
   }

   return ( $ret , $response_code , $response_body , $response_content ) ; 
}
#eof sub



	#
	# --------------------------------------------------------
	# intializes this object 
	# --------------------------------------------------------
	sub doInitialize {
	   my $self       = shift ; 	
		my $appConfig  = ${ shift @_ } if ( @_ );

		$objLogger 	= "IssueTracker::App::Utils::Logger"->new( \$appConfig ) ; 
	}	
	#eof sub doInitialize
	

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
      my $class            = shift ;    # Class name is in the first parameter
		$appConfig = ${ shift @_ } if ( @_ );

      # Anonymous hash reference holds instance attributes
      my $self = { }; 
      bless($self, $class);     # Say: $self is a $class

      $self->doInitialize( \$appConfig ) ; 
      return $self;
		
	}  
	#eof const

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




# ---------------------------------------------------------
# VersionHistory: 
# ---------------------------------------------------------
#
1.2.0 --- 2014-09-11 20:44:26 -- tests on Windows 
1.1.0 --- 2014-08-27 11:29:25 -- tests passed with Test::More
1.0.0 --- 2014-08-25 08:25:15 -- refactored away from main calling script

=cut 

