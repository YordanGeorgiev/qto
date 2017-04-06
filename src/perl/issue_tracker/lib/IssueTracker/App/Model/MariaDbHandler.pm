package IssueTracker::App::Model::MariaDbHandler ; 

   use strict ; use warnings ; use utf8 ; 

   require Exporter; 
   use AutoLoader ; 
	use Encode qw( encode_utf8 is_utf8 );
   use POSIX qw(strftime);
   use DBI ; 
	use DBD::mysql;
	use Data::Printer ; 
	use Carp ; 


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
		my $met_hash 			= shift ; 
		my $sql_hash 			= shift ; 	
		
		print "BOOOOOO !!!! doInsertSqlHashData \n " ; 
	}
	#eof sub doInsertSqlHashData


   #
   # -----------------------------------------------------------------------------
   # doInitialize the object with the minimum dat it will need to operate 
   # -----------------------------------------------------------------------------
   sub doInitialize {

      my $self = shift ; 

		#debug print "MariaDbHandler::doInitialize appConfig : " . p($appConfig );
		
		$db_host 			= $appConfig->{'db_host'} 		|| 'localhost' ;
		$db_port 			= $appConfig->{'db_port'} 		|| '13306' ; 
		$db_user 			= $appConfig->{'db_user'} 		|| 'doc_pub_app_user' ; 
		$db_user_pw 		= $appConfig->{'db_user_pw'} 	|| 'no_pass_provided!!!' ; 

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
