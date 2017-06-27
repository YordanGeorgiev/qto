package IssueTracker::App::Db::Out::DbWriterPostgres ; 

   use strict ; use warnings ; use utf8 ; 

   require Exporter; 
   use AutoLoader ; 
	use Encode qw( encode_utf8 is_utf8 );
   use POSIX qw(strftime);
   use DBI ; 
	use Data::Printer ; 
	use Carp ; 

   use IssueTracker::App::Utils::Logger ; 
   use IssueTracker::App::Db::In::DbReadersFactory ; 
   use IssueTracker::App::Utils::Timer ; 


   our $module_trace                            = 1 ; 
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
	#  file data  and meta data 
   # ------------------------------------------------------
	sub doHsr2ToDb {

		my $self 				= shift ; 
		my $hsr2 			   = shift ; 	# the hash ref of hash refs  aka hs r on power 2
      my $term             = shift || 'daily' ; 
      my $table            = "$term" . '_issues' ; 

      my $ret              = 1 ; 
      my $msg              = 'unknown error while sql insert ' ; 		
      my $str_sql_insert   = q{} ; 
      my $str_col_list     = q{} ; 
      my $str_val_list     = q{} ; 
      my $error_msg        = q{} ; 

      my $objDbReadersFactory = 'IssueTracker::App::Db::In::DbReadersFactory'->new( \$appConfig , $self ) ; 
      my $objDbReader 		= $objDbReadersFactory->doInstantiate ( 'postgre' );
		
      my $objTimer         = 'IssueTracker::App::Utils::Timer'->new( $appConfig->{ 'TimeFormat' } );
		my $update_time      = $objTimer->GetHumanReadableTime();
      
      my $dmhsr            = {} ; 

      ( $ret , $msg , $dmhsr ) = $objDbReader->doSelectTablesColumnList ( $table ) ; 
      return  ( $ret , $msg , undef ) unless $ret == 0 ; 

      # debug p($dmhsr); 
      # sleep 6 ; 
      
      $str_sql_insert .= ' TRUNCATE TABLE issues ; ' ; 
      

      my $debug_msg        = 'START doInsertSqlHashData' ; 
      $objLogger->doLogDebugMsg ( $debug_msg ) ; 
	  
 
		foreach my $key ( sort(keys( %{$hsr2} ) ) ) {
         my $row_hash = $hsr2->{ $key } ; 

		   foreach my $key ( sort(keys( %{$dmhsr} ) ) ) {
            $str_col_list .= ' , ' . $key ; 

            my $value = 'null' ; 
            unless ( $key eq 'update_time' ) {
               $value     = $row_hash->{ $key } || 'null' ; 
               $value =~ s|\\|\\\\|g ;
               $value       =~ s|\'|\\\'|g ;
            } else {
               $value     = $update_time ; 
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
      
      p ( $str_sql_insert ) if $module_trace == 1 ; 

      # proper authentication implementation src:
      # http://stackoverflow.com/a/19980156/65706
      $objLogger->doLogDebugMsg ( $debug_msg ) ; 
     
      my $dbh = DBI->connect("DBI:Pg:dbname=$db_name", "", "" , {
                 'RaiseError'          => 1
               , 'ShowErrorStatement'  => 1
               , 'PrintError'          => 1
               , 'AutoCommit'          => 1
               , 'pg_utf8_strings'     => 1
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
  

      $objLogger->doLogDebugMsg ( "STOP print sql_hash " ) ;    
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
	  
      $str_sql_insert .= ' TRUNCATE TABLE ' . "$table" . '; ' ; 
      
      my $dmhsr            = {} ; 
      my $update_time      = q{} ; 

      my $objDbReadersFactory = 'IssueTracker::App::Db::In::DbReadersFactory'->new( \$appConfig , $self ) ; 
      my $objDbReader 		= $objDbReadersFactory->doInstantiate ( 'postgre' );
      ( $ret , $msg , $dmhsr ) = $objDbReader->doSelectTablesColumnList ( $table ) ; 
      return  ( $ret , $msg , undef ) unless $ret == 0 ; 
      # debug p($dmhsr); 
		foreach my $key ( sort(keys( %{$sql_hash} ) ) ) {
         my $row_hash = $sql_hash->{ $key } ; 
         
         p ( $row_hash ) if $module_trace > 1 ; 
         my $debug_msg        = 'STOP print row_hash ' ; 
         $objLogger->doLogDebugMsg ( $debug_msg ) if $module_trace > 1 ; 

		   foreach my $key ( sort(keys( %{$dmhsr} ) ) ) {
            $str_col_list .= ' , ' . $key ; 
            my $value = 'null' ; 
            unless ( $key eq 'update_time' ) {
               $value     = $row_hash->{ $key } || 'null' ; 
               $value     =~ s|\\|\\\\|g ;
               $value     =~ s|\'|\\\'|g ;
               $value     =~ s/'/''/g if ( $value ) ; 
            } else {
               $value     = $update_time ; 
            }
            $str_val_list .= ' , \'' . $value . '\'' if defined $value ; 
            $str_val_list .= ' , NULL' unless defined $value ; 
         }

         # p ( $str_col_list ) ; 
         # p ( $str_val_list ) ; 
         next unless ( $str_col_list ) ; 
         next unless ( $str_val_list ) ; 
 
         $str_col_list = substr ( $str_col_list , 3 ) ; 
         $str_val_list = substr ( $str_val_list , 3 ) ; 

         $str_sql_insert .= 'INSERT INTO ' . "$table" . ' '  ; 
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
               , 'PrintError'          => 1
               , 'AutoCommit'          => 1
               , 'pg_utf8_strings'     => 1
         } );
      } or $ret = 2  ;

      if ( $ret == 2 ) {
         $msg = DBI->errstr || 'null dbi-errstr' ;
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
	# runs the insert sql by passed data part 
	# by convention is assumed that the first column is unique and update could 
	# be performed on it ... should there be duplicates the update should fail
	# -----------------------------------------------------------------------------
	sub doInsertDbTablesWithHsr2 {

		my $self 			   = shift ; 
		my $hsr2 		      = shift ; 
      binmode(STDIN,  ':utf8');
      binmode(STDOUT, ':utf8');
      binmode(STDERR, ':utf8');
		my $ret 				   = 1 ; 
		my $msg 				   = ' failed to connect during insert to db !!! ' ; 
		my $debug_msg 		   = ' failed to connect during insert to db !!! ' ; 
      my $sth              = {} ;    # this is the statement handle
      my $dbh              = {} ;    # this is the database handle
      my $str_sql          = q{} ;   # this is the sql string to use for the query
      my $rv               = 0 ;     # apperantly insert ok returns rv = 1 !!! 
      
      my $hs_headers       = {} ; 
      my $update_time      = q{} ; 
      my $objTimer         = 'IssueTracker::App::Utils::Timer'->new( $appConfig->{ 'TimeFormat' } );
		$update_time         = $objTimer->GetHumanReadableTime();
      
      my $dmhsr            = {} ; 

      my $objDbReadersFactory = 'IssueTracker::App::Db::In::DbReadersFactory'->new( \$appConfig , $self ) ; 
      my $objDbReader 		= $objDbReadersFactory->doInstantiate ( 'postgre' );

      # obs this does not support ordered primary key tables first order yet !!!
      foreach my $table ( keys %$hsr2 ) { 

         ( $ret , $msg , $hs_headers ) = $objDbReader->doSelectTablesColumnList ( $table ) ; 
         return  ( $ret , $msg , undef ) unless $ret == 0 ; 

         #debug p($hs_headers ) ; 

         my $hs_table = $hsr2->{ $table } ; 
     
         eval { 
            $dbh = DBI->connect("dbi:Pg:dbname=$db_name", "", "" , {
                 'RaiseError'          => 1
               , 'ShowErrorStatement'  => 1
               , 'PrintError'          => 1
               , 'AutoCommit'          => 1
               , 'pg_utf8_strings'     => 1
            } ); 
         } or $ret = 2  ;
         
         if ( $ret == 2 ) {
            $msg = DBI->errstr;
            $objLogger->doLogErrorMsg ( $msg ) ; 
            return ( $ret , $msg ) ; 
         } else {
            $msg = 'connect OK' ; 
            $objLogger->doLogDebugMsg ( $msg ) ; 
         }

         my $sql_str          = '' ; 
         my $sql_str_insrt    = "INSERT INTO $table " ; 
         $sql_str_insrt      .= '(' ; 

         foreach my $col_num ( sort ( keys %{$hs_headers} )) {
            my $column_name = $hs_headers->{ $col_num }->{ 'attname' }; 
            $sql_str_insrt .= " $column_name " . ' , ' ; 
         } 
         
         for (1..3) { chop ( $sql_str_insrt) } ; 
         $sql_str_insrt	.= ')' ; 

         foreach my $row_num ( sort ( keys %$hs_table ) ) { 

            next if $row_num == 0 ; 
            
            my $hs_row = $hs_table->{ $row_num } ; 
            my $data_str = q{} ; 
            p($hs_row);
            foreach my $col_num ( sort ( keys ( %$hs_headers ) ) ) {
               my $column_name = $hs_headers->{ $col_num }->{ 'attname' }; 
               my $cell_value = $hs_row ->{ $column_name } ; 
               if ( !defined ( $cell_value ) or $cell_value eq 'NULL' 
                     or $cell_value eq 'null' or $cell_value eq "'NULL'" ) {

                  unless ( $column_name eq 'update_time' ) {
                     $cell_value = 'NULL'  
                  } 
                  else {
                     $cell_value = "'" . $update_time . "'" if ( $column_name eq 'update_time' ) ; 
                  }

                  $data_str .= "$cell_value" . " , " ; 
               } else { 
                  $cell_value =~ s|\\|\\\\|g ; 
                  # replace the ' chars with \'
                  $cell_value 		=~ s|\'|\'\'|g ; 
                  $data_str .= "'" . "$cell_value" . "' , " ; 
               }
            }
            #eof foreach col_num
            
            # remove the " , " at the end 
            for (1..3) { chop ( $data_str ) } ; 
            
            $sql_str .= $sql_str_insrt ;  
            $sql_str	.=  " VALUES (" . "$data_str" . ') ; ' . "\n" ; 


         } 
         #eof foreach row
           	
				$sql_str = "TRUNCATE TABLE $table ; $sql_str " ; 	 
            $objLogger->doLogDebugMsg ( "sql_str : $sql_str " ) ; 

         # Action !!! 
         $msg = " DBI upsert error on table: $table: " . $msg  ; $ret = 1 ; 
         eval { 
            $rv = $dbh->do($sql_str) ; 
         } or return ( $ret , $msg ) ; 



         if ( $rv == 1 ) { 
            $msg = "upsert OK for table $table" ;          
            $objLogger->doLogInfoMsg ( $msg ) ; 
            $ret = 0 ; 
         }

      } 
      #eof foreach table
		
      $msg = 'upsert OK for all tables' ; 
		return ( $ret , $msg ) ; 
	}
	#eof sub doInsertDbTablesWithHsr2
	
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

		# print "PostgreWriter::doInitialize appConfig : " . p($appConfig );
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
