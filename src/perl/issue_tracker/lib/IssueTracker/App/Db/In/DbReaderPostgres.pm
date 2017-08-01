package IssueTracker::App::Db::In::DbReaderPostgres ; 

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
      $debug_msg .= "\n db_name: $db_name \n db_host: $db_host " ; 
      $debug_msg .= "\n db_user: $db_user \n db_user_pw $db_user_pw \n" ; 
      $objLogger->doLogDebugMsg ( $debug_msg ) ; 
     
      $dbh = DBI->connect("dbi:Pg:dbname=$db", "", "" , {
                 'RaiseError'          => 1
               , 'ShowErrorStatement'  => 1
               , 'PrintError'          => 1
               , 'AutoCommit'          => 1
               , 'pg_utf8_strings'     => 1
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
      my $table         = shift || 'daily_issues' ; 


      my $msg              = q{} ;         
      my $ret              = 1 ;          # this is the return value from this method 
      my $debug_msg        = q{} ; 
      my $mhsr             = {} ;         # this is meta hash describing the data hash ^^
      my $sth              = {} ;         # this is the statement handle
      my $dbh              = {} ;         # this is the database handle
      my $str_sql          = q{} ;        # this is the sql string to use for the query
      
      $str_sql = " 
         SELECT attnum, attname
         FROM   pg_attribute
         WHERE  attrelid = '" . $table . "'::regclass
         AND    attnum > 0
         AND    NOT attisdropped
         ORDER  BY attnum
      ;
      " ; 

      # authentication src: http://stackoverflow.com/a/19980156/65706
      $debug_msg .= "\n db_name: $db_name \n db_host: $db_host " ; 
      $debug_msg .= "\n db_user: $db_user \n db_user_pw $db_user_pw \n" ; 
      $objLogger->doLogDebugMsg ( $debug_msg ) ; 
     
      $dbh = DBI->connect("dbi:Pg:dbname=$db_name", "", "" , {
                 'RaiseError'          => 1
               , 'ShowErrorStatement'  => 1
               , 'PrintError'          => 1
               , 'AutoCommit'          => 1
               , 'pg_utf8_strings'     => 1
      } ) or $msg = DBI->errstr;
      
      # src: http://www.easysoft.com/developer/languages/perl/dbd_odbc_tutorial_part_2.html
      $sth = $dbh->prepare($str_sql);  

      $sth->execute()
            or $objLogger->error ( "$DBI::errstr" ) ;

      $mhsr = $sth->fetchall_hashref( 'attnum' ) ; 
      binmode(STDOUT, ':utf8');
      p( $mhsr ) if $module_trace == 1 ; 

      $msg = DBI->errstr ; 

      unless ( defined ( $msg ) ) {
         $msg = 'SELECT meta OK for table: ' . "$table" ; 
         $ret = 0 ; 
      } else {
         $objLogger->doLogErrorMsg ( $msg ) ; 
      }

      # src: http://search.cpan.org/~rudy/DBD-Pg/Pg.pm  , METHODS COMMON TO ALL HANDLES
      $debug_msg        = 'doInsertSqlHashData ret ' . $ret ; 
      $objLogger->doLogDebugMsg ( $debug_msg ) ; 
      
      return ( $ret , $msg , $mhsr ) ; 	
   }
   # eof sub doSelectTablesColumnList



   #
   # -----------------------------------------------------------------------------
   # get ALL the table data into hash ref of hash refs 
   # -----------------------------------------------------------------------------
   sub doSearchConfigurationEntries {

      my $self             = shift ; 
      my $db_name          = shift || 'ysg_issues' ; # the default db
      my $table            = shift || 'confs' ;  # the table to get the data from  
      my $query_str        = shift || '*' ;  # the table to get the data from  
   

      $objLogger->doLogDebugMsg ( "doSelectTableIntoHashRef table: $table " ) ; 

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

     
      $dbh = DBI->connect("dbi:Pg:dbname=$db_name", "", "" , {
                 'RaiseError'          => 1
               , 'ShowErrorStatement'  => 1
               , 'PrintError'          => 1
               , 'AutoCommit'          => 1
               , 'pg_utf8_strings'     => 1
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
   # get ALL the table data into hash ref of hash refs 
   # -----------------------------------------------------------------------------
   sub doSelectTableIntoHashRef {

      my $self             = shift ; 
      my $table            = shift || 'daily_issues' ;  # the table to get the data from  
   

      $objLogger->doLogDebugMsg ( "doSelectTableIntoHashRef table: $table " ) ; 

      my $msg              = q{} ;         
      my $ret              = 1 ;          # this is the return value from this method 
      my $debug_msg        = q{} ; 
      my $hsr              = {} ;         # this is hash ref of hash refs to populate with
      my $mhsr             = {} ;         # this is meta hash describing the data hash ^^
      my $dmhsr             = {} ;        # this is meta hash describing the data hash ^^
      my $sth              = {} ;         # this is the statement handle
      my $dbh              = {} ;         # this is the database handle
      my $str_sql          = q{} ;        # this is the sql string to use for the query


      ( $ret , $msg , $dmhsr ) = $self->doSelectTablesColumnList ( $table ) ; 
      return  ( $ret , $msg , undef ) unless $ret == 0 ; 

      foreach my $key ( sort ( keys %$dmhsr ) ) {
         $mhsr->{'ColumnNames'}-> { $key } = $dmhsr->{ $key } ; 
      }


      $str_sql = 
         " SELECT 
         * FROM $table 
         order by prio asc
         ;
      " ; 

      # authentication src: http://stackoverflow.com/a/19980156/65706
      $debug_msg .= "\n db_name: $db_name \n db_host: $db_host " ; 
      $debug_msg .= "\n db_user: $db_user \n db_user_pw $db_user_pw \n" ; 
      $objLogger->doLogDebugMsg ( $debug_msg ) ; 
     
      $dbh = DBI->connect("dbi:Pg:dbname=$db_name", "", "" , {
                 'RaiseError'          => 1
               , 'ShowErrorStatement'  => 1
               , 'PrintError'          => 1
               , 'AutoCommit'          => 1
               , 'pg_utf8_strings'     => 1
      } ) or $msg = DBI->errstr;
      
      # src: http://www.easysoft.com/developer/languages/perl/dbd_odbc_tutorial_part_2.html
      $sth = $dbh->prepare($str_sql);  

      $sth->execute()
            or $objLogger->error ( "$DBI::errstr" ) ;

      $hsr = $sth->fetchall_hashref( 'guid' ) ; 
      binmode(STDOUT, ':utf8');
      p( $hsr ) ; 

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
	
      p($appConfig ) ; 

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
      # sleep 6 ; 
		
		$db_name 			= $ENV{ 'db_name' } || $appConfig->{'db_name'}     || 'prd_ysg_issues' ; 
		$db_host 			= $ENV{ 'db_host' } || $appConfig->{'db_host'} 		|| 'localhost' ;
		$db_port 			= $ENV{ 'db_port' } || $appConfig->{'db_port'} 		|| '13306' ; 
		$db_user 			= $ENV{ 'db_user' } || $appConfig->{'db_user'} 		|| 'ysg' ; 
		$db_user_pw 		= $ENV{ 'db_user_pw' } || $appConfig->{'db_user_pw'} 	|| 'no_pass_provided!!!' ; 
      
	   $objLogger 			= 'IssueTracker::App::Utils::Logger'->new( \$appConfig ) ;

      return $self ; 
	}	
	#eof sub doInitialize
   


1;


__END__
