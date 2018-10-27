package IssueTracker::App::Db::Out::MariaDb::WtrMariaDb ; 

   use strict ; use warnings ; use utf8 ; 

   require Exporter; 
   use AutoLoader ; 
	use Encode qw( encode_utf8 is_utf8 );
   use POSIX qw(strftime);
   use DBI ; 
	use Data::Printer ; 
	use Carp ; 

   use IssueTracker::App::Utils::Logger ; 
   use IssueTracker::App::Db::In::RdrDbsFactory ; 
   use IssueTracker::App::Utils::Timer ; 
   use IssueTracker::App::Mdl::Model ; 

   
   our $rdbms_type                              = 'mysql' ; 
   our $module_trace                            = 1 ; 
   our $IsUnitTest                              = 0 ; 
	our $appConfig 										= {} ; 
	our $objLogger 										= {} ; 

	our $mysql_db_name                           = q{} ; 
	our $mysql_host 										= q{} ; 
	our $mysql_port 										= q{} ;
	our $mysql_user 							         = q{} ; 
	our $mysql_user_pw	 					         = q{} ; 
	our $web_host 											= q{} ; 
   our @tables                                  = ( 'daily_issues' );
   our $objController                           = () ; 



	#
   # ------------------------------------------------------
	#  input: hash ref of hash refs containing the issues 
	#  file data  and meta data 
   # ------------------------------------------------------
	sub doHsr2ToDb {

		my $self 				= shift ; 
		my $hsr2 			   = shift ; 	# the hash ref of hash refs  aka hs r on power 2
      my $objModel         = shift ; 
      my $table            = shift ; 
      my $term             = shift || 'daily' ; 

      my $ret              = 1 ; 
      my $dbh              = {} ; 
      my $msg              = 'unknown error while sql insert ' ; 		
      my $str_sql_insert   = q{} ; 
      my $str_col_list     = q{} ; 
      my $str_val_list     = q{} ; 
      my $error_msg        = q{} ; 

      my $objRdrDbsFactory = 'IssueTracker::App::Db::In::RdrDbsFactory'->new( \$appConfig , \$objModel) ; 
      my $objRdrDb 		= $objRdrDbsFactory->doInstantiate ( $rdbms_type );
		
      my $objTimer         = 'IssueTracker::App::Utils::Timer'->new( $appConfig->{ 'TimeFormat' } );
		my $UpdateTime      = $objTimer->GetHumanReadableTime();
      
      my $dmhsr            = {} ; 

      ( $ret , $msg , $dmhsr ) = $objRdrDb->doSelectTablesColumnList ( $table ) ; 
      return  ( $ret , $msg , undef ) unless $ret == 0 ; 

      # debug p($dmhsr); 
      # sleep 6 ; 
      
      my $do_trucate_tables = $ENV{ 'do_truncate_tables' } || 0 ; 
      if ( $do_trucate_tables == 1 ) { 
         $str_sql_insert .= "TRUNCATE TABLE $table ;" ; 
      }

	 
      p ( $hsr2 ) ; 
      
      my $debug_msg        = 'START doInsertSqlHashData' ; 
      $objLogger->doLogDebugMsg ( $debug_msg ) ; 
 
		foreach my $key ( sort(keys( %{$hsr2} ) ) ) {
         my $row_hash = $hsr2->{ $key } ; 

		   foreach my $key ( sort(keys( %{$dmhsr} ) ) ) {
            next if $key eq 'guid' ; 
            $str_col_list .= ' , ' . $key ; 

            my $value = 'null' ; 
            unless ( $key eq 'UpdateTime' ) {
               $value     = $row_hash->{ $key } || 'null' ; 
               # $value =~ s|\\|\\\\|g ;
               $value       =~ s|\'|\\\'|g ;
            } else {
               $value     = $UpdateTime ; 
            }
            $str_val_list .= ' , \'' . $value . '\''; 
         }
          
         $str_col_list = substr ( $str_col_list , 3 ) ; 
         $str_val_list = substr ( $str_val_list , 3 ) ; 

         $str_sql_insert .= 'INSERT INTO ' . "$table" ; 
         $str_sql_insert .= '( ' . $str_col_list . ') VALUES (' . $str_val_list . ');' . "\n" ; 

         $str_col_list = '' ; 
         $str_val_list = '' ; 
      }
      
      p ( $str_sql_insert ) ; 

      # proper authentication implementation src:
      # http://stackoverflow.com/a/19980156/65706
      $objLogger->doLogDebugMsg ( $debug_msg ) ; 
     
      $dbh = DBI->connect("dbi:mysql:database=$mysql_db_name;host=$mysql_host;port=$mysql_port", "$mysql_user", "$mysql_user_pw" , {
                 'RaiseError'          => 1
               , 'ShowErrorStatement'  => 1
               , 'PrintError'          => 1
               , 'AutoCommit'          => 1
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
	#eof sub doHsr2ToDb


	#
   # ------------------------------------------------------
	#  input: hash ref of hash refs containing the issues 
	#  output: the data in the issue table
   # ------------------------------------------------------
	sub doInsertSqlHashData {

		my $self 				= shift ; 
		my $sql_hash 			= shift ; 	
		my $table				= shift || 'daily_issues' ; 
      my $objModel         = shift ;  

      my $ret              = 1 ; 
      my $msg              = 'unknown error while sql insert ' ; 		
      my $str_sql_insert   = q{} ; 
      my $str_col_list     = q{} ; 
      my $str_val_list     = q{} ; 
      my $error_msg        = q{} ; 
		my $dbh					= {} ; 
		my $rv					= 0 ; 
      
      unless ( $sql_hash ) {
         $msg = 'no data in sql hash - probably an error' ; 
         $objLogger->doLogErrorMsg ( $msg ) ; 
         return ( $ret , $msg ) ; 
      }

      binmode(STDIN,  ':utf8');
      binmode(STDOUT, ':utf8');
      binmode(STDERR, ':utf8');

      my $debug_msg        = 'START doInsertSqlHashData' ; 
      $objLogger->doLogDebugMsg ( $debug_msg ) ; 
	  
      my $do_trucate_tables = $ENV{ 'do_truncate_tables' } || 0 ; 
      if ( $do_trucate_tables == 1 ) { 
         $str_sql_insert .= "TRUNCATE TABLE $table ;" ; 
      }
      
      my $dmhsr            = {} ; 
      my $UpdateTime      = q{} ; 

      my $objRdrDbsFactory = 'IssueTracker::App::Db::In::RdrDbsFactory'->new( \$appConfig , \$objModel ) ; 
      my $objRdrDb 		= $objRdrDbsFactory->doInstantiate ( $rdbms_type );
      ( $ret , $msg , $dmhsr ) = $objRdrDb->doSelectTablesColumnList ( $table ) ; 
      return  ( $ret , $msg , undef ) unless $ret == 0 ; 

		foreach my $key ( sort(keys( %{$sql_hash} ) ) ) {

         my $row_hash = $sql_hash->{ $key } ; 
		   foreach my $k ( sort(keys( %{$dmhsr} ) ) ) {

            my $col = $dmhsr->{ $k }->{ 'COLUMN_NAME' } ; 
            next if $col eq 'guid' ; 
            next if $col eq 'UpdateTime' ; 

            $str_col_list .= ' , ' . $col ; 
            my $value = 'null' ; 
            unless ( $key eq 'UpdateTime' ) {
               $value     = $row_hash->{ $col } ; 

               unless ( defined $value ) { 
                  $str_val_list .= ' , NULL' ; 
                  next ; 
               }
               # $value     =~ s|\\|\\\\|g ;
               $value     =~ s|\'|\\\'|g ;
               $value     =~ s/'/''/g if ( $value ) ; 
            } else {
               $value     = $UpdateTime ; 
            }
            $str_val_list .= ' , \'' . $value . '\''  ; 
         }

         p ( $str_col_list ) ; 
         p ( $str_val_list ) ; 
         next unless ( $str_col_list ) ; 
         next unless ( $str_val_list ) ; 
 
         $str_col_list = substr ( $str_col_list , 3 ) ; 
         $str_val_list = substr ( $str_val_list , 3 ) ; 

         $str_sql_insert .= 'INSERT INTO ' . "$table" . ' '  ; 
         $str_sql_insert .= '( ' . $str_col_list . ') VALUES (' . $str_val_list . ');' . "\n" ; 



         $str_col_list = '' ; 
         $str_val_list = '' ; 
      }
      
      p ( $str_sql_insert ) ; 

      # proper authentication implementation src:
      # http://stackoverflow.com/a/19980156/65706
      $debug_msg .= "\n mysql_db_name: $mysql_db_name \n mysql_host: $mysql_host " ; 
      $debug_msg .= "\n mysql_user: $mysql_user \n mysql_user_pw $mysql_user_pw \n" ; 
      $objLogger->doLogDebugMsg ( $debug_msg ) if $module_trace == 1 ; 


      eval {
            $dbh = DBI->connect("dbi:mysql:database=$mysql_db_name;host=$mysql_host;port=$mysql_port", "$mysql_user", "$mysql_user_pw" , {
                 'RaiseError'          => 1
               , 'ShowErrorStatement'  => 1
               , 'PrintError'          => 1
               , 'AutoCommit'          => 1
         } );
      } or $ret = 2  ;

      if ( $ret == 2 ) {
         $msg = DBI->errstr || 'null dbi-errstr on dbi connect' ;
         $objLogger->doLogErrorMsg ( $msg ) ;
         print "SHOULD RETURN WITH ERROR !!!" ;
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
	# runs the insert sql by passed data part 
	# by convention is assumed that the first column is unique and update could 
	# be performed on it ... should there be duplicates the update should fail
	# -----------------------------------------------------------------------------
	sub doUpsertTable {

		my $self 			   = shift ; 
      my $objModel         = ${ shift @_ } ; 
      my $table            = shift ;
		my $hsr2 		      = $objModel->get( 'hsr2' ) ; 

      binmode(STDIN,  ':utf8');
      binmode(STDOUT, ':utf8');
      binmode(STDERR, ':utf8');
		my $ret 				   = 1 ; 
		my $msg 				   = ' failed to connect during insert to db !!! ' ; 
		my $debug_msg 		   = ' failed to connect during insert to db !!! ' ; 

      return ( $ret , $msg , undef ) unless $hsr2 ; 
      return ( $ret , $msg , undef ) unless $table ; 

      my $sth              = {} ;    # this is the statement handle
      my $dbh              = {} ;    # this is the database handle
      my $str_sql          = q{} ;   # this is the sql string to use for the query
      my $rv               = 0 ;     # apperantly insert ok returns rv = 1 !!! 
      
      my $UpdateTime      = q{} ; # must have the default value now() in db
      
      my $dmhsr            = {} ; 

      my $objRdrDbsFactory = 'IssueTracker::App::Db::In::RdrDbsFactory'->new( \$appConfig , \$objModel ) ; 
      my $objRdrDb 		= $objRdrDbsFactory->doInstantiate ( $rdbms_type );

      $objLogger->doLogDebugMsg ( "MariaDb doUpsertTable table: $table" );

      # load ONLY the tables defined to load

      ( $ret , $msg ) = $objRdrDb->doSelectTablesColumnList ( \$objModel , $table ) ; 
      my $hs_headers       = $objModel->get('hs_headers' ); 
      return  ( $ret , $msg , undef ) unless $ret == 0 ; 

      # p($hs_headers )  ; 
  
      eval { 
         $dbh = DBI->connect("dbi:mysql:database=$mysql_db_name;host=$mysql_host;port=$mysql_port", "$mysql_user", "$mysql_user_pw" , {
              'RaiseError'          => 1
            , 'ShowErrorStatement'  => 1
            , 'PrintError'          => 1
            , 'AutoCommit'          => 1
         } ); 
      } or $ret = 2  ;
         
      if ( $ret == 2 ) {
         $msg = 'connect NOK' ; 
         print $msg . "\n" ; 
         $msg .= DBI->errstr;
         $objLogger->doLogErrorMsg ( $msg ) ; 
         return ( $ret , $msg ) ; 
      } else {
         $msg = 'connect OK' ; 
         print $msg . "\n" ; 
         $objLogger->doLogDebugMsg ( $msg ) ; 
      }

      my $sql_str          = '' ; 
      my $do_trucate_tables = $ENV{ 'do_truncate_tables' } || 0 ; 
      if ( $do_trucate_tables == 1 ) { 
         $sql_str = "TRUNCATE TABLE $table ;" ; 
         $rv = $dbh->do($sql_str) or croak DBI->errstr ; 
         $sql_str = '' ; 
      }

      my $sql_str_insrt    = "INSERT INTO $table " ; 
      $sql_str_insrt      .= '(' ; 


      foreach my $col_num ( sort ( keys %{$hs_headers} )) {
         my $column_name = $hs_headers->{ $col_num }->{ 'COLUMN_NAME' }; 
         # next if $column_name eq 'UpdateTime' ; 
            # if the xls does not contain the guid's do just insert
         $sql_str_insrt .= " $column_name " . ' , ' 
            if exists $hsr2->{ 0 }->{ $column_name } ; 
      } 
   
      #print "$sql_str_insrt" ; 
      #sleep 10 ; 

      for (1..3) { chop ( $sql_str_insrt) } ; 
      $sql_str_insrt	.= ')' ; 

      #p $hsr2 ; 
      # p $sql_str_insrt ; 

      my $objTimer         = 'IssueTracker::App::Utils::Timer'->new( $appConfig->{ 'TimeFormat' } );
      $UpdateTime      = $objTimer->GetHumanReadableTime();
      foreach my $row_num ( sort ( keys %$hsr2) ) { 

         next if $row_num == 0 ; 
         
         my $hs_row = $hsr2->{ $row_num } ; 
         my $data_str = q{} ; 

         # because obviously postgre prefers lc in col names by default on Ubuntu
         my %row_h = %$hs_row ; 
         # %row_h = map { lc $_ => $row_h{$_} } keys %row_h;
         $hs_row = \%row_h ; 
         # p($hs_row) ; 
         

         foreach my $col_num ( sort ( keys ( %$hs_headers ) ) ) {

            my $column_name = $hs_headers->{ $col_num }->{ 'COLUMN_NAME' }; 

            # if the xls does not have the table column ( ie guid )
            next unless exists $hsr2->{ 0 }->{ $column_name } ; 

            my $cell_value = $hs_row ->{ $column_name } ; 
            $cell_value = $UpdateTime if $column_name eq 'UpdateTime' ; 
            
            # if the xls does not contain the guid's do just insert
            # note that even cells with 1 space are considered for nulls !!!
            # this is simply because of Shift + arrow works on 1 space
            if ( !defined ( $cell_value ) or $cell_value eq 'NULL' 
                  or $cell_value eq 'null' or $cell_value eq "'NULL'" 
                  or $cell_value eq ' ' ) {  

               $cell_value = 'NULL'   ; 
               $data_str .= "$cell_value" . " , " ; 

            } else { 
               $cell_value =~ s|\\|\\\\|g ; 
               # replace the ' chars with \'
               $cell_value 		=~ s|\'|\\\'|g ; 
               $data_str .= "'" . "$cell_value" . "' , " ; 
            }
         }
         #eof foreach col_num
         
         # remove the " , " at the end 
         for (1..3) { chop ( $data_str ) } ; 
         
         $sql_str .= $sql_str_insrt ;  
         $sql_str	.=  " VALUES (" . "$data_str" . ') ' ; 

         # if the xls has guid column do upsert
         if ( $hsr2->{ 'guid' } ) {

            $sql_str	.=  "\n ON CONFLICT ( guid ) \n" ; 
            $sql_str	.=  " DO UPDATE SET \n" ; 
         
            foreach my $col_num ( sort ( keys %{$hs_headers} )) {
               my $column_name = $hs_headers->{ $col_num }->{ 'COLUMN_NAME' }; 
               next if $column_name eq 'UpdateTime' ; 
               # next if $column_name eq 'id' ; # id's are unique !!!
               $sql_str .= " $column_name " . '= EXCLUDED.' . $column_name . ' , ' ; 
            } 
            # remove the " , " at the end 
            for (1..3) { chop ( $sql_str ) } ; 
         }
         $sql_str .= ';' . "\n" ; 

         $objLogger->doLogDebugMsg ( "sql_str : $sql_str" ) ; 
         # id-180201 - why cannot run the whole sql string at once !?
         $rv = $dbh->do($sql_str) or croak DBI->errstr ; 
         $sql_str = "" ; 
      } 
      #eof foreach row
          


      # Action !!! 
      $msg = " DBI upsert error on table: $table: " . $msg  ; $ret = 1 ; 

      if ( $rv == 1 ) { 
         $msg = "upsert OK for table $table" ;          
         $objLogger->doLogInfoMsg ( $msg ) ; 
         $ret = 0 ; 
      }

      $msg = 'upsert OK for all table' ; 
		return ( $ret , $msg ) ; 
	}
	#eof sub doUpsertTable


   #
	# -----------------------------------------------------------------------------
	# the constructor 
	# -----------------------------------------------------------------------------
	sub new {

		my $invocant 			= shift ;    
		$appConfig     = ${ shift @_ } || { 'foo' => 'bar' ,} ; 
      $objController = shift ;  
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

		# print "PostgreWriter::doInitialize appConfig : " . p($appConfig );
      # sleep 6 ; 
		
		$mysql_db_name 			= $ENV{ 'mysql_db_name' } || $appConfig->{'mysql_db_name'}  || croak "mysql_db_name not defined !!!" ; 
		$mysql_host 			   = $ENV{ 'mysql_host' } || $$appConfig->{'mysql_host'} 		|| 'localhost' ;
		$mysql_port 			   = $ENV{ 'mysql_port' } || $$appConfig->{'mysql_port'} 		|| '13306' ; 
		$mysql_user 	      = $ENV{ 'mysql_user' } || $$appConfig->{'mysql_user'} 		|| 'ysg' ; 
		$mysql_user_pw       = $ENV{ 'mysql_user_pw' } || $appConfig->{'mysql_user_pw'} 	|| 'no_pass_provided!!!' ; 
      
	   $objLogger 			= 'IssueTracker::App::Utils::Logger'->new( \$appConfig ) ;

      return $self ; 
	}	
	#eof sub doInitialize
   


1;


__END__
