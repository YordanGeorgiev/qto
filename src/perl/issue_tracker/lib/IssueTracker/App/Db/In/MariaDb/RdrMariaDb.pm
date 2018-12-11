package IssueTracker::App::Db::In::MariaDb::RdrMariaDb ; 

   use strict ; use warnings ; use utf8 ; 

   require Exporter; 
   use AutoLoader ; 
	use Encode qw( encode_utf8 is_utf8 );
   use POSIX qw(strftime);
   use DBI ; 
	use Data::Printer ; 
	use Carp ; 

   use IssueTracker::App::Utils::Logger ; 
   use IssueTracker::App::Mdl::Model ; 

   our $module_trace                            = 0 ; 
   our $IsUnitTest                              = 0 ; 
	our $appConfig 										= {} ; 
	our $objLogger 										= {} ; 
	our $objModel                                = {} ; 

	our $mysql_db_name                                 = q{} ; 
	our $mysql_host 										   = q{} ; 
	our $mysql_port 										   = q{} ;
	our $mysql_user 											= q{} ; 
	our $mysql_user_pw	 									= q{} ; 
	our $web_host 											= q{} ; 

   
   
   sub doSelectTablesList {

      my $self             = shift ; 

      my $msg              = q{} ;         
      my $ret              = 1 ;          # this is the return value from this method 
      my $debug_msg        = q{} ; 
      my $hsr              = {} ;         # this is meta hash describing the data hash ^^
      my $sth              = {} ;         # this is the statement handle
      my $dbh              = {} ;         # this is the database handle
      my $str_sql          = q{} ;        # this is the sql string to use for the query
      
      $str_sql = " 
      SELECT  
           table_catalog 
         , table_schema 
         , table_name 
         , ROW_NUMBER () OVER (ORDER BY table_name) as row_id
      FROM information_schema.tables  
      WHERE 1=1 
      AND table_type = 'BASE TABLE' 
      AND table_schema = 'public' 
      ORDER BY table_type, table_name
      ;
      " ; 

      # authentication src: http://stackoverflow.com/a/19980156/65706
      $debug_msg .= "\n mysql_db_name: $mysql_db_name \n mysql_host: $mysql_host " ; 
      $debug_msg .= "\n mysql_user: $mysql_user \n mysql_user_pw $mysql_user_pw \n" ; 
      # $objLogger->doLogDebugMsg ( $debug_msg ) ; 
     
      $dbh = DBI->connect("dbi:mysql:database=$mysql_db_name;host=$mysql_host;port=$mysql_port", "$mysql_user", "$mysql_user_pw" , {
                 'RaiseError'          => 1
               , 'ShowErrorStatement'  => 1
               , 'PrintError'          => 1
               , 'AutoCommit'          => 1
      } ) or $msg = DBI->errstr;
      
      # src: http://www.easysoft.com/developer/languages/perl/dbd_odbc_tutorial_part_2.html
      $sth = $dbh->prepare($str_sql);  

      $sth->execute()
            or $objLogger->error ( "$DBI::errstr" ) ;

      $hsr = $sth->fetchall_hashref( 'row_id' ) ; 
      # p($hsr )  ; 
      binmode(STDOUT, ':utf8');

      $msg = DBI->errstr ; 

      unless ( defined ( $msg ) ) {
         $msg = 'SELECT meta OK ' ; 
         $ret = 0 ; 
      } else {
         $objLogger->doLogErrorMsg ( $msg ) ; 
      }

      $debug_msg        = 'doSelectTablesList ret ' . $ret ; 
      $objLogger->doLogDebugMsg ( $debug_msg ) ; 
      
      return ( $ret , $msg , $hsr ) ; 	
   }
   # eof sub doSelectTablesList



   #
   # -----------------------------------------------------------------------------
   # 
   # -----------------------------------------------------------------------------
   sub doSelectItemByGuid {

      my $self             = shift ; 
      my $db               = shift ; 
      my $table            = shift || 'daily_issues' ;  # the table to get the data from  
      my $guid             = shift ; 
      
      my $msg              = q{} ;         
      my $ret              = 1 ;          # this is the return value from this method 
      my $debug_msg        = q{} ; 
      my $hsr              = {} ;         # this is hash ref of hash refs to populate with
      my $sth              = {} ;         # this is the statement handle
      my $dbh              = {} ;         # this is the database handle
      my $str_sql          = q{} ;        # this is the sql string to use for the query

      $str_sql = 
         " SELECT 
         * FROM $table 
         WHERE 1=1
         AND guid = '" . $guid . "'
         ;
      " ; 

      # authentication src: http://stackoverflow.com/a/19980156/65706
      $debug_msg .= "\n mysql_db_name: $mysql_db_name \n mysql_host: $mysql_host " ; 
      $debug_msg .= "\n mysql_user: $mysql_user \n mysql_user_pw $mysql_user_pw \n" ; 
      $objLogger->doLogDebugMsg ( $debug_msg ) ; 
     
      $dbh = DBI->connect("dbi:mysql:database=$mysql_db_name;host=$mysql_host;port=$mysql_port", "$mysql_user", "$mysql_user_pw" , {
                 'RaiseError'          => 1
               , 'ShowErrorStatement'  => 1
               , 'PrintError'          => 1
               , 'AutoCommit'          => 1
      } ) or $msg = DBI->errstr;
      
      $sth = $dbh->prepare($str_sql);  

      $sth->execute()
            or $objLogger->error ( "$DBI::errstr" ) ;

      $hsr = $sth->fetchall_hashref( 'guid' ) ; 
      binmode(STDOUT, ':utf8');
      p( $hsr ) if $module_trace == 1 ; 

      $msg = DBI->errstr ; 

      unless ( defined ( $msg ) ) {
         $msg = 'SELECT OK for table: ' . "$table" ; 
         $ret = 0 ; 
      } else {
         $objLogger->doLogErrorMsg ( $msg ) ; 
      }

      $debug_msg        = ' ret ' . $ret ; 
      $objLogger->doLogDebugMsg ( $debug_msg ) ; 
      
      return ( $ret , $msg , $hsr ) ; 	
   }
   # eof sub doSelectItemByGuid



   sub doSelectTablesColumnList {

      my $self          = shift ; 
      my $objModel      = ${ shift @_ } ; 
      my $table         = shift || 'daily_issues' ; 


      my $msg              = q{} ;         
      my $ret              = 1 ;          # this is the return value from this method 
      my $debug_msg        = q{} ; 
      my $mhsr             = {} ;         # this is meta hash describing the data hash ^^
      my $sth              = {} ;         # this is the statement handle
      my $dbh              = {} ;         # this is the database handle
      my $str_sql          = q{} ;        # this is the sql string to use for the query
      
      $str_sql = " 
         SELECT 
         ORDINAL_POSITION,COLUMN_NAME,CHARACTER_MAXIMUM_LENGTH 
         FROM INFORMATION_SCHEMA.COLUMNS
         WHERE 1=1
         AND TABLE_SCHEMA='" . $mysql_db_name . "' 
         AND TABLE_NAME='" . $table . "' 
         ORDER  BY ORDINAL_POSITION ASC
      ;
      " ; 

      # authentication src: http://stackoverflow.com/a/19980156/65706
      $debug_msg .= "\n mysql_db_name: $mysql_db_name \n mysql_host: $mysql_host " ; 
      $debug_msg .= "\n mysql_user: $mysql_user \n mysql_user_pw $mysql_user_pw \n" ; 
      $objLogger->doLogDebugMsg ( $debug_msg ) ; 
     
      $dbh = DBI->connect("dbi:mysql:database=$mysql_db_name;host=$mysql_host;port=$mysql_port", "$mysql_user", "$mysql_user_pw" , {
                 'RaiseError'          => 1
               , 'ShowErrorStatement'  => 1
               , 'PrintError'          => 1
               , 'AutoCommit'          => 1
      } ) or $msg = DBI->errstr;
      
      # src: http://www.easysoft.com/developer/languages/perl/dbd_odbc_tutorial_part_2.html
      $sth = $dbh->prepare($str_sql);  

      $sth->execute()
            or $objLogger->error ( "$DBI::errstr" ) ;

      $mhsr = $sth->fetchall_hashref( 'ORDINAL_POSITION' ) ; 
      binmode(STDOUT, ':utf8');
      #p( $mhsr ) ; 

      $msg = DBI->errstr ; 

      carp "failed to load meta-data for the table : $table !!!" unless %$mhsr  ; 

      unless ( defined ( $msg ) ) {
         $msg = 'SELECT meta OK for table: ' . "$table" ; 
         $ret = 0 ; 
      } else {
         $objLogger->doLogErrorMsg ( $msg ) ; 
      }

      # src: http://search.cpan.org/~rudy/DBD-Pg/Pg.pm  , METHODS COMMON TO ALL HANDLES
      $debug_msg        = 'doSelectTablesColumnList ret ' . $ret ; 
      $objLogger->doLogDebugMsg ( $debug_msg ) ; 

      $objModel->set('hs_headers' , $mhsr ) ; 
      return ( $ret , $msg , $mhsr ) ; 	
   }
   # eof sub doSelectTablesColumnList



   #
   # -----------------------------------------------------------------------------
   # get ALL the table data into hash ref of hash refs 
   # -----------------------------------------------------------------------------
   sub doSearchConfigurationEntries {

      my $self             = shift ; 
      my $mysql_db_name          = shift || croak "mysql db name not defined !!!" ; 
      my $table            = shift || 'confs' ;  # the table to get the data from  
      my $query_str        = shift || '*' ;  # the table to get the data from  
   

      $objLogger->doLogDebugMsg ( "doSelect table: $table " ) ; 

      my $msg              = q{} ;         
      my $ret              = 1 ;          # this is the return value from this method 
      my $debug_msg        = q{} ; 
      my $hsr              = {} ;         # this is hash ref of hash refs to populate with
      my $sth              = {} ;         # this is the statement handle
      my $dbh              = {} ;         # this is the database handle
      my $str_sql          = q{} ;        # this is the sql string to use for the query


      $str_sql = 
         " SELECT 
         guid, value as name FROM $table 
         WHERE 1=1
         AND value like '%" . $query_str . "%'
         ;
      " ; 

     
      $dbh = DBI->connect("dbi:mysql:database=$mysql_db_name;host=$mysql_host;port=$mysql_port", "$mysql_user", "$mysql_user_pw" , {
                 'RaiseError'          => 1
               , 'ShowErrorStatement'  => 1
               , 'PrintError'          => 1
               , 'AutoCommit'          => 1
      } ) or $msg = DBI->errstr;
      
      $sth = $dbh->prepare($str_sql);  

      $sth->execute()
            or $objLogger->error ( "$DBI::errstr" ) ;



		my @query_output = () ; 
      # LOOP THROUGH RESULTS
      binmode(STDOUT, ':utf8');
      while ( my $row = $sth->fetchrow_hashref ){
          my %hash = %$row ;
          #say "UTF8 flag is turned on in the STRING $key" if is_utf8( $hash{$key} );
          push @query_output, $row
          #if is_utf8( $hash{$key} );
      } #eof while
      
		$msg = DBI->errstr ; 

      unless ( defined ( $msg ) ) {
         $msg = 'SELECT OK for table: ' . "$table" ; 
         $ret = 0 ; 
      } else {
         $objLogger->doLogErrorMsg ( $msg ) ; 
      }

      # CLOSE THE DATABASE CONNECTION
      $dbh->disconnect();
      
		# src: http://search.cpan.org/~rudy/DBD-Pg/Pg.pm  , METHODS COMMON TO ALL HANDLES
      $debug_msg        = 'doInsertSqlHashData ret ' . $ret ; 
      $objLogger->doLogDebugMsg ( $debug_msg ) ; 

      #debug p(@query_output);
      return ( $ret , $msg , \@query_output ) ; 	
   
	}
   # eof sub doSearchConfigurationEntries



	
   #
	# -----------------------------------------------------------------------------
	# the constructor 
	# -----------------------------------------------------------------------------
	sub new {

		my $invocant 			= shift ;    
		$appConfig     = ${ shift @_ } || { 'foo' => 'bar' ,} ; 
      $objModel      = ${ shift @_ } ; 	
      #p($appConfig ) ; 

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

		# print "PostgreReader::doInitialize appConfig : " . p($appConfig );
      # debug sleep 6 ; 
		
		$mysql_db_name 	   = $ENV{ 'mysql_db_name' } || $appConfig->{'mysql_db_name'}     || croak "mysql db name undef !!!" ; 
		$mysql_host 			= $ENV{ 'mysql_host' } || $appConfig->{'mysql_host'} 		|| 'localhost' ;
		$mysql_port 			= $ENV{ 'mysql_port' } || $appConfig->{'mysql_port'} 		|| '13306' ; 
		$mysql_user 			= $ENV{ 'mysql_user' } || $appConfig->{'mysql_user'} 		|| 'ysg' ; 
		$mysql_user_pw 		= $ENV{ 'mysql_user_pw' } || $appConfig->{'mysql_user_pw'} 	|| 'no_pass_provided!!!' ; 
      
	   $objLogger 			   = 'IssueTracker::App::Utils::Logger'->new( \$appConfig ) ;
      $objModel          = 'IssueTracker::App::Mdl::Model'->new ( \$appConfig ) ; 

      return $self ; 
	}	
	#eof sub doInitialize
   


1;


__END__
