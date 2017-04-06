package IssueTracker::App::Model::PostGreDbHandler ; 

   use strict ; use warnings ; use utf8 ; 

   require Exporter; 
   use AutoLoader ; 
	use Encode qw( encode_utf8 is_utf8 );
   use POSIX qw(strftime);
   use DBI ; 
	use DBD::mysql;
	use Data::Printer ; 
	use Carp ; 

   use IssueTracker::App::Utils::Logger ; 

   our $ModuleDebug	                                    = 0 ; 
   our $IsUnitTest                                    	= 0 ; 
	our $appConfig 													= q{} ; 
	our $objLogger 													= q{} ; 
	our $objController 												= {} ; 

	our $db_host 														= q{} ; 
	our $db_port 														= q{} ;
	our $db_user 														= q{} ; 
	our $db_user_pw	 												= q{} ; 
	our $web_host 														= q{} ; 

	#
   # ------------------------------------------------------
	# 
   # ------------------------------------------------------
	sub doInsertSqlHashData {

		my $self 				= shift ; 
		my $sql_hash 			= shift ; 	
      
      my $ret              = 1 ; 
      my $msg              = 'unknown error while sql insert ' ; 		

      my $debug_msg        = 'START doInsertSqlHashData' ; 
      $objLogger->doLogDebugMsg ( $debug_msg ) ; 
	   
		foreach my $key ( sort(keys( %{$sql_hash} ) ) ) {

      }
      #eof foreach $key


      $debug_msg        = 'STOP  doInsertSqlHashData' ; 
      $objLogger->doLogDebugMsg ( $debug_msg ) ; 

      return ( $ret , $msg ) ; 	
	}
	#eof sub doInsertSqlHashData


   #
   # -----------------------------------------------------------------------------
   # doInitialize the object with the minimum dat it will need to operate 
   # -----------------------------------------------------------------------------
   sub doInitialize {

      my $self = shift ; 

		#debug print "PostGreDbHandler::doInitialize appConfig : " . p($appConfig );
		
		$db_host 			= $appConfig->{'db_host'} 		|| 'localhost' ;
		$db_port 			= $appConfig->{'db_port'} 		|| '13306' ; 
		$db_user 			= $appConfig->{'db_user'} 		|| 'doc_pub_app_user' ; 
		$db_user_pw 		= $appConfig->{'db_user_pw'} 	|| 'no_pass_provided!!!' ; 
      
	   $objLogger 			= 'IssueTracker::App::Utils::Logger'->new( \$appConfig ) ;
   }
   #eof sub doInitialize

	
   #
   # -----------------------------------------------------------------------------
   # the constructor 
   # source:http://www.netalive.org/tinkering/serious-perl/#oop_constructors
   # -----------------------------------------------------------------------------
   sub new {

      my $class            = shift ;    # Class name is in the first parameter
		$appConfig = ${ shift @_ } if ( @_ );

      # Anonymous hash reference holds instance attributes
      my $self = { }; 
      bless($self, $class);     # Say: $self is a $class

      $self->doInitialize() ; 
      return $self;
   } 
   #eof const 
   
   
   



1;


__END__
