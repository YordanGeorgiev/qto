package IssueTracker::App::Model::PostGreDbHandler ; 

   use strict ; use warnings ; use utf8 ; 

   require Exporter; 
   use AutoLoader ; 
	use Encode qw( encode_utf8 is_utf8 );
   use POSIX qw(strftime);
   use DBI ; 
	use Data::Printer ; 
	use Carp ; 

   use IssueTracker::App::Utils::Logger ; 

   our $module_trace                            = 1 ;
   our $IsUnitTest                              = 0 ; 
	our $appConfig 										= q{} ; 
	our $objLogger 										= q{} ; 

	our $db_name                                 = q{} ; 
	our $db_host 										   = q{} ; 
	our $db_port 										   = q{} ;
	our $db_user 											= q{} ; 
	our $db_user_pw	 									= q{} ; 
	our $web_host 											= q{} ; 


	#
   # ------------------------------------------------------
	#  input: hash ref of hash refs containing the issues 
	#  file data  and meta data 
   # ------------------------------------------------------
	sub doInsertSqlHashData {

		my $self 				= shift ; 
		my $sql_hash 			= shift ; 	
      
      my $ret              = 1 ; 
      my $msg              = 'unknown error while sql insert ' ; 		
      my $str_sql_insert   = q{} ; 
      my $str_col_list     = q{} ; 
      my $str_val_list     = q{} ; 
      my $error_msg        = q{} ; 


      my $debug_msg        = 'START doInsertSqlHashData' ; 
      $objLogger->doLogDebugMsg ( $debug_msg ) ; 
	  
 
		foreach my $key ( sort(keys( %{$sql_hash} ) ) ) {
         my $row_hash = $sql_hash->{ $key } ; 

		   foreach my $key ( sort(keys( %{$row_hash} ) ) ) {
            $str_col_list .= ' , ' . $key ; 
            my $value     = $row_hash->{ $key } ; 
            $value        =~ s/'/''/g ; 
            $str_val_list .= ' , \'' . $value . '\''; 
         }
         
         $str_col_list = substr ( $str_col_list , 3 ) ; 
         $str_val_list = substr ( $str_val_list , 3 ) ; 

         $str_sql_insert .= 'INSERT INTO issue ' ; 
         $str_sql_insert .= '( ' . $str_col_list . ') VALUES (' . $str_val_list . ');' . "\n" ; 

         $str_col_list = '' ; 
         $str_val_list = '' ; 
      }
      
      # p ( $str_sql_insert ) if $module_trace == 1 ; 

      # proper authentication implementation src:
      # http://stackoverflow.com/a/19980156/65706
      #
      $debug_msg .= "\n db_name: $db_name \n db_host: $db_host " ; 
      $debug_msg .= "\n db_user: $db_user \n db_user_pw $db_user_pw \n" ; 
      $objLogger->doLogDebugMsg ( $debug_msg ) ; 
     
      # my $dbh = DBI->connect("DBI:Pg:dbname=$db_name;host=$db_host", $db_user, $db_user_pw )
      my $dbh = DBI->connect("dbi:Pg:dbname=$db_name", "", "" , {
           'RaiseError' => 1
         , 'ShowErrorStatement' => 1
         , 'AutoCommit' => 1
      } ) or $msg = DBI->errstr;
      
      
      $ret = $dbh->do( $str_sql_insert ) ; 
      $msg = DBI->errstr ; 

      unless ( defined ( $msg ) ) {
         $msg = 'INSERT OK' ; 
         $ret = 0 ; 
      } else {
         $objLogger->doLogErrorMsg ( $msg ) ; 
      }

      # src: http://search.cpan.org/~rudy/DBD-Pg/Pg.pm  , METHODS COMMON TO ALL HANDLES

      $debug_msg        = 'doInsertSqlHashData ret ' . $ret ; 
      $objLogger->doLogDebugMsg ( $debug_msg ) ; 
      
      return ( $ret , $msg ) ; 	
	}
	#eof sub doInsertSqlHashData


   #
   # -----------------------------------------------------------------------------
   # get ALL the table data into hash ref of hash refs 
   # -----------------------------------------------------------------------------
   sub doSelectTableIntoHashRef {
      my $self             = shift ; 
      my $table            = shift ;      # the table to get the data from  
      
      my $msg           = q{} ;         
      my $ret           = 1 ;          # this is the return value from this method 
      my $debug_msg     = q{} ; 
      my $hsr           = {} ;         # this is hash ref of hash refs to populate with
      my $mhsr           = {} ;         # this is meta hash describing the data hash ^^
      my $sth           = {} ;         # this is the statement handle
      my $dbh           = {} ;         # this is the database handle
      my $str_sql       = q{} ;        # this is the sql string to use for the query


#         Column    |          Type           | Modifiers | Storage  | Stats target | Description
#      -------------+-------------------------+-----------+----------+--------------+-------------
#       issue_id    | integer                 | not null  | plain    |              |
#       prio        | integer                 |           | plain    |              |
#       name        | character varying(100)  | not null  | extended |              |
#       description | character varying(1000) |           | extended |              |
#       status      | character varying(50)   | not null  | extended |              |
#       category    | character varying(100)  | not null  | extended |              |
#       actual      | integer                 |           | plain    |              |
#       daily_date  | character varying(50)   | not null  | extended |              |


      $mhsr->{'ColumnNames'}-> { 0 } = 'issue_id' ;
      $mhsr->{'ColumnNames'}-> { 1 } = 'prio' ;
      $mhsr->{'ColumnNames'}-> { 2 } = 'name' ;
      $mhsr->{'ColumnNames'}-> { 3 } = 'description' ;
      $mhsr->{'ColumnNames'}-> { 4 } = 'status' ;
      $mhsr->{'ColumnNames'}-> { 5 } = 'category' ;
      $mhsr->{'ColumnNames'}-> { 6 } = 'actual' ;
      $mhsr->{'ColumnNames'}-> { 7 } = 'daily_date' ;

      $str_sql = 
         " SELECT 
              issue_id
            , prio
            , name
            , description
            , status
            , category
            , actual
            , daily_date
         FROM $table ;
      " ; 

      # authentication src: http://stackoverflow.com/a/19980156/65706
      $debug_msg .= "\n db_name: $db_name \n db_host: $db_host " ; 
      $debug_msg .= "\n db_user: $db_user \n db_user_pw $db_user_pw \n" ; 
      $objLogger->doLogDebugMsg ( $debug_msg ) ; 
     
      $dbh = DBI->connect("dbi:Pg:dbname=$db_name", "", "" , {
           'RaiseError' => 1
         , 'ShowErrorStatement' => 1
         , 'AutoCommit' => 1
      } ) or $msg = DBI->errstr;
      
      # src: http://www.easysoft.com/developer/languages/perl/dbd_odbc_tutorial_part_2.html
      $sth = $dbh->prepare($str_sql);  

      $sth->execute()
            or $objLogger->error ( "$DBI::errstr" ) ;

      $hsr = $sth->fetchall_hashref( 'issue_id' ) ; 
      p( $hsr ) if $module_trace == 1 ; 

      $msg = DBI->errstr ; 

      unless ( defined ( $msg ) ) {
         $msg = 'SELECT OK for table: ' . "$table" ; 
         $ret = 0 ; 
      } else {
         $objLogger->doLogErrorMsg ( $msg ) ; 
      }

      # src: http://search.cpan.org/~rudy/DBD-Pg/Pg.pm  , METHODS COMMON TO ALL HANDLES
      $debug_msg        = 'doInsertSqlHashData ret ' . $ret ; 
      $objLogger->doLogDebugMsg ( $debug_msg ) ; 
      
      return ( $ret , $msg , $hsr , $mhsr ) ; 	
   }
   # eof sub doSelectTableIntoHashRef



   #
   # -----------------------------------------------------------------------------
   # doInitialize the object with the minimum dat it will need to operate 
   # -----------------------------------------------------------------------------
   sub doInitialize {
      
      my $self          = shift ; 
		my $appConfig     = ${ shift @_ } if ( @_ );

		#debug print "PostGreDbHandler::doInitialize appConfig : " . p($appConfig );
		
		$db_name 			= $appConfig->{'db_name'} 		|| 'prd_pgsql_runner' ; 
		$db_host 			= $appConfig->{'db_host'} 		|| 'localhost' ;
		$db_port 			= $appConfig->{'db_port'} 		|| '13306' ; 
		$db_user 			= $appConfig->{'db_user'} 		|| 'ysg' ; 
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
		$appConfig           = ${ shift @_ } if ( @_ );

      # Anonymous hash reference holds instance attributes
      my $self = { }; 
      bless($self, $class);     # Say: $self is a $class

      $self->doInitialize( \$appConfig ) ; 
      return $self;
   } 
   #eof const 
   


1;


__END__
