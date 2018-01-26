package IssueTracker::App::IO::Out::WtrURL;

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
   use IssueTracker::App::Utils::IO::FileHandler ; 
   use IssueTracker::App::Utils::Logger ;
   use WWW::Curl::Easy ; 
	use Data::Printer ; 
   use HTTP::Response ; 
   use URL::Encode qw /url_encode/ ; 
	
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

      my $objWtrURL = 'IssueTracker::App::IO::Out::WtrURL'->new ( \$appConfig ) ; 
      my ( $ret , $response_code , $response_body , $response_content )  = () ; 
      ( $ret , $response_code , $response_body , $response_content ) 
            = $objWtrURL->doRunURL( 'PUT' , $headers , $cookies , $url , $str_page );

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
sub doRunURL {

   my $self               = shift ; 
   my $http_method_type   = shift || 'GET' ; 
   my $headers            = shift ; 
   my $cookies		        = shift ; 
   my $url                = shift ;   
   my $content            = shift ; 

   my $curl = WWW::Curl::Easy->new();
   $curl->setopt(WWW::Curl::Easy::CURLOPT_URL, "$url" );
   # cheat the server who we are ...
   #$curl->setopt(WWW::Curl::Easy::CURLOPT_USERAGENT, 
   #'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36');

   #$curl->setopt(WWW::Curl::Easy::CURLOPT_HTTP_VERSION , WWW::Curl::Easy::CURL_HTTP_VERSION_1_1 ) ; 
   # We don't care about what version the library uses. libcurl will use whatever it thinks fit.
   $curl->setopt(WWW::Curl::Easy::CURLOPT_HTTP_VERSION , WWW::Curl::Easy::CURL_HTTP_VERSION_NONE ) ; 
   $curl->setopt(WWW::Curl::Easy::CURLOPT_MAXREDIRS , 3);
   $curl->setopt(WWW::Curl::Easy::CURLOPT_TIMEOUT,10);
   $curl->setopt(WWW::Curl::Easy::CURLOPT_VERBOSE, 1);                  # tweak verbosity
   $curl->setopt(WWW::Curl::Easy::CURLOPT_HEADER, 1);                   # Don't include header in body 
   $curl->setopt(WWW::Curl::Easy::CURLOPT_NOPROGRESS, 0);               # Disable internal progress meter
   $curl->setopt(WWW::Curl::Easy::CURLOPT_FOLLOWLOCATION, 0);           # Disable automatic location redirects
   $curl->setopt(WWW::Curl::Easy::CURLOPT_FAILONERROR, 0);              # Setting this to true fails on HTTP error

   $curl->setopt(WWW::Curl::Easy::CURLOPT_SSLVERSION, 
                    WWW::Curl::Easy::CURL_SSLVERSION_DEFAULT); # any ssl would do it
   $curl->setopt(WWW::Curl::Easy::CURLOPT_SSL_VERIFYPEER, 1);           # do not ignore bad SSL
   $curl->setopt(WWW::Curl::Easy::CURLOPT_SSL_VERIFYHOST, 0);           # 1 not supported anymmore !


#   if ( $cookies ) {
#      $curl->setopt(WWW::Curl::Easy::CURLOPT_COOKIE, $cookies);         # set the stolen cookies
#   }

   # $curl->setopt(WWW::Curl::Easy::CURLOPT_NOSIGNAL, 1);                 # To make thread safe, disable signals
   # $curl->setopt(WWW::Curl::Easy::CURLOPT_ENCODING, 'gzip');            # Allow gzip compressed pages

   if ( $headers ) { 
      for my $key ( sort ( keys %$headers )) {
         my $header_name = $key ; 
         my $header_val = $headers->{ "$key" } ; 
         $curl->setopt(WWW::Curl::Easy::CURLOPT_HTTPHEADER  , [ $header_name . $header_val ]  );
      }
   }

   p ( $content ) ; 

   my $enc_content = url_encode ( $content ) ; 
   p ( $enc_content) ; 

   if ( $http_method_type eq 'POST' ) {
      $curl->setopt(WWW::Curl::Easy::CURLOPT_POST, 1);
      $curl->setopt(WWW::Curl::Easy::CURLOPT_POSTFIELDS, $enc_content);
   }



   if ( $http_method_type eq 'PUT' ) {
      $curl->setopt(WWW::Curl::Easy::CURLOPT_PUT, 1);
      $curl->setopt(WWW::Curl::Easy::CURLOPT_POSTFIELDS, $enc_content  );
   }

   # A filehandle, reference to a scalar or reference to a typeglob can be used here.
   my $response_body       = q{} ; 
   my $response_code       = q{} ; 
   my $response_content    = q{} ; 
   # print $str_dump ; 

   $curl->setopt(WWW::Curl::Easy::CURLOPT_WRITEDATA,\$response_body);


   # Starts the actual request
   my $ret = $curl->perform;


   if ($ret == 0) {
      my $msg = "OK for the curl transfer for the url: $url " ; 
      $objLogger->doLogInfoMsg ( $msg ) ; 
      
      $response_code = $curl->getinfo(WWW::Curl::Easy::CURLINFO_HTTP_CODE);
      $response_content = HTTP::Response->parse( "$response_body" ) ; 
      $response_content = $response_content->content;
      print "start printing response" ; 
      p ( $response_content ) ; 
      print "stop  printing response" ; 
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

