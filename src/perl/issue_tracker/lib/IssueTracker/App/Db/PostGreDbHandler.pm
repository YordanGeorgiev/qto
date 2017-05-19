package IssueTracker::App::Db::PostGreDbHandler ; 

   use strict ; use warnings ; use utf8 ; 

   require Exporter; 
   use AutoLoader ; 
	use Encode qw( encode_utf8 is_utf8 );
   use POSIX qw(strftime);
   use DBI ; 
	use Data::Printer ; 
	use Carp ; 

   use IssueTracker::App::Utils::Logger ; 

   our $module_trace                            = 0 ; 
   our $IsUnitTest                              = 0 ; 
	our $appConfig 										= {} ; 
	our $objLogger 										= {} ; 

	our $db_name                                 = q{} ; 
	our $db_host 										   = q{} ; 
	our $db_port 										   = q{} ;
	our $db_user 											= q{} ; 
	our $db_user_pw	 									= q{} ; 
	our $web_host 											= q{} ; 


	#
   # ------------------------------------------------------
	#  input: hash ref of hash refs containing the issues 
	#  output: the data in the issue table
   # ------------------------------------------------------
	sub doInsertSqlHashData {

		my $self 				= shift ; 
		my $sql_hash 			= shift ; 	
   

      p ( $sql_hash ) if $module_trace == 1  ;
      $objLogger->doLogDebugMsg ( "STOP print sql_hash " ) ;    
      my $ret              = 1 ; 
      my $msg              = 'unknown error while sql insert ' ; 		
      my $str_sql_insert   = q{} ; 
      my $str_col_list     = q{} ; 
      my $str_val_list     = q{} ; 
      my $error_msg        = q{} ; 
		my $dbh					= {} ; 
		my $rv					= 0 ; 

      binmode(STDIN,  ':utf8');
      binmode(STDOUT, ':utf8');
      binmode(STDERR, ':utf8');

      my $debug_msg        = 'START doInsertSqlHashData' ; 
      $objLogger->doLogDebugMsg ( $debug_msg ) ; 
	  
      $str_sql_insert .= ' TRUNCATE TABLE issue ; ' ; 
 
		foreach my $key ( sort(keys( %{$sql_hash} ) ) ) {
         my $row_hash = $sql_hash->{ $key } ; 
         
         p ( $row_hash ) if $module_trace > 1 ; 
         my $debug_msg        = 'STOP print row_hash ' ; 
         $objLogger->doLogDebugMsg ( $debug_msg ) ; 

		   foreach my $key ( sort(keys( %{$row_hash} ) ) ) {
            $str_col_list .= ' , ' . $key ; 
            my $value     = $row_hash->{ $key } ; 
            $value        =~ s/'/''/g if ( $value ) ; 
            $str_val_list .= ' , \'' . $value . '\'' if defined $value ; 
            $str_val_list .= ' , NULL' unless defined $value ; 
         }
         
         $str_col_list = substr ( $str_col_list , 3 ) ; 
         $str_val_list = substr ( $str_val_list , 3 ) ; 

         $str_sql_insert .= 'INSERT INTO issue ' ; 
         $str_sql_insert .= '( ' . $str_col_list . ') VALUES (' . $str_val_list . ');' . "\n" ; 

         $str_col_list = '' ; 
         $str_val_list = '' ; 
      }
      
      p ( $str_sql_insert ) if $module_trace == 1 ; 

      # proper authentication implementation src:
      # http://stackoverflow.com/a/19980156/65706
      $debug_msg .= "\n db_name: $db_name \n db_host: $db_host " ; 
      $debug_msg .= "\n db_user: $db_user \n db_user_pw $db_user_pw \n" ; 
      $objLogger->doLogDebugMsg ( $debug_msg ) if $module_trace == 1 ; 


      eval {
         $dbh = DBI->connect("dbi:Pg:dbname=$db_name", "", "" , {
              'RaiseError'          => 1
            , 'ShowErrorStatement'  => 1
            , 'AutoCommit'          => 1
         } );
      } or $ret = 2  ;

      if ( $ret == 2 ) {
         $msg = DBI->errstr;
         $objLogger->doLogErrorMsg ( $msg ) ;
         return ( $ret , $msg ) ;
      } else {
         $msg = 'OK for connect ' ;
         $objLogger->doLogDebugMsg ( $msg ) ;
      }

      p ( $str_sql_insert ) if $module_trace == 1 ; 
 

		# Action !!!
		eval {
			$rv = $dbh->do($str_sql_insert) ;
		} or $msg = $@ ;

		unless ( $rv == 1 ) {
			$msg .= " DBI upsert error :" . $msg  ;
			$objLogger->doLogFatalMsg ( $msg ) ;   ;
			return ( $ret , $msg ) ; # all or nothing ok
		}
		else {
			$msg = "OK for insert " ;
			$objLogger->doLogInfoMsg ( $msg ) ;
			$ret = 0 ;
		}

      $msg = 'OK for insert for all tables' ;
      return ( $ret , $msg ) ;

      # src: http://search.cpan.org/~rudy/DBD-Pg/Pg.pm  , METHODS COMMON TO ALL HANDLES
      $debug_msg        = 'STOP  doInsertSqlHashData ret ' . $ret ; 
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
      
      my $msg              = q{} ;         
      my $ret              = 1 ;          # this is the return value from this method 
      my $debug_msg        = q{} ; 
      my $hsr              = {} ;         # this is hash ref of hash refs to populate with
      my $mhsr             = {} ;         # this is meta hash describing the data hash ^^
      my $sth              = {} ;         # this is the statement handle
      my $dbh              = {} ;         # this is the database handle
      my $str_sql          = q{} ;        # this is the sql string to use for the query

#         Column    |          Type           | Modifiers | Storage  | Stats target | Description
#      -------------+-------------------------+-----------+----------+--------------+-------------
#       issue_id    | integer                 | not null  | plain    |              |
#       prio        | integer                 |           | plain    |              |
#       name        | character varying(100)  | not null  | extended |              |
#       description | character varying(1000) |           | extended |              |
#       status      | character varying(50)   | not null  | extended |              |
#       category    | character varying(100)  | not null  | extended |              |


      $mhsr->{'ColumnNames'}-> { 0 } = 'issue_id' ;
      $mhsr->{'ColumnNames'}-> { 1 } = 'level' ;
      $mhsr->{'ColumnNames'}-> { 2 } = 'prio' ;
      $mhsr->{'ColumnNames'}-> { 3 } = 'status' ;
      $mhsr->{'ColumnNames'}-> { 4 } = 'category' ;
      $mhsr->{'ColumnNames'}-> { 5 } = 'name' ;
      $mhsr->{'ColumnNames'}-> { 6 } = 'description' ;
      $mhsr->{'ColumnNames'}-> { 7 } = 'start_time' ;
      $mhsr->{'ColumnNames'}-> { 8 } = 'stop_time' ;
      $mhsr->{'ColumnNames'}-> { 9 } = 'run_date' ;

      $str_sql = 
         " SELECT 
              issue_id
            , level 
            , prio
            , status
            , category
            , name
            , description
            , start_time
            , stop_time
            , run_date
         FROM $table 
         order by prio asc
         ;
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
      binmode(STDOUT, ':utf8');
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
	# the constructor 
	# -----------------------------------------------------------------------------
	sub new {

		my $invocant 			= shift ;    
		$appConfig     = ${ shift @_ } || { 'foo' => 'bar' ,} ; 
		
      # might be class or object, but in both cases invocant
		my $class = ref ( $invocant ) || $invocant ; 

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

		# print "PostGreDbHandler::doInitialize appConfig : " . p($appConfig );
      # sleep 6 ; 
		
		$db_name 			= $ENV{ 'db_name' } || $appConfig->{'db_name'}        || 'prd_pgsql_runner' ; 
		$db_host 			= $ENV{ 'db_host' } || $$appConfig->{'db_host'} 		|| 'localhost' ;
		$db_port 			= $ENV{ 'db_port' } || $$appConfig->{'db_port'} 		|| '13306' ; 
		$db_user 			= $ENV{ 'db_user' } || $$appConfig->{'db_user'} 		|| 'ysg' ; 
		$db_user_pw 		= $ENV{ 'db_user_pw' } || $appConfig->{'db_user_pw'} 	|| 'no_pass_provided!!!' ; 
      
	   $objLogger 			= 'IssueTracker::App::Utils::Logger'->new( \$appConfig ) ;

      return $self ; 
	}	
	#eof sub doInitialize
   


1;


__END__
