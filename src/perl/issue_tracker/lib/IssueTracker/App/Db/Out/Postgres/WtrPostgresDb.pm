package IssueTracker::App::Db::Out::Postgres::WtrPostgresDb ; 

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


   our $module_trace                            = 1 ; 
   our $IsUnitTest                              = 0 ; 
	our $appConfig 										= {} ; 
	our $objLogger 										= {} ; 
	our $objModel                                = {} ; 
   our $rdbms_type                              = 'postgres' ; 

	our $db                        = q{} ; 
	our $postgres_db_host 										   = q{} ; 
	our $postgres_db_port 										   = q{} ;
	our $postgres_db_user 							   = q{} ; 
	our $postgres_db_user_pw	 					   = q{} ; 
	our $web_host 											= q{} ; 
   our @tables                                  = ( 'daily_issues' );
   our $objController                           = () ; 
   

   sub doDeleteItemById {

		my $self 				= shift ; 
      my $objModel       = ${ shift @_ } ; 
      my $table            = shift ; 
      my $ret              = 0 ; 
      my $msg              = '' ; 
   
      my $id               = $objModel->get('delete.web-action.id' ) ; 

      my $dbh              = {} ;         # this is the database handle
      my $sth              = {} ;         # the statement handle
      my $str_sql          = q{} ;        # this is the sql string to use for the query
      
      if ( defined $objModel->get('postgres_db_name') ) {
		   $db = $objModel->get('postgres_db_name');
      }
      
      ( $ret , $msg , $dbh ) = $self->doConnectToDb ( $db ) ; 
      return ( $ret , $msg ) unless $ret == 0 ; 


      my $objRdrDbsFactory = 'IssueTracker::App::Db::In::RdrDbsFactory'->new( \$appConfig , \$objModel ) ; 
      my $objRdrDb            = $objRdrDbsFactory->doSpawn("$rdbms_type");

      if ( $objRdrDb->table_exists ( $db , $table ) == 0  ) {
         $ret = 400 ; 
         $msg = ' the table ' . $table . ' does not exist in the ' . $db . ' database '  ; 
         return ( $ret , $msg ) ; 
      }


      $str_sql = " 
      DELETE FROM $table WHERE id = '$id'
      " ; 
      eval {
         $sth = $dbh->prepare($str_sql);  
         #debug rint "start WtrPostgresDb.pm : \n $str_sql \n stop WtrPostgresDb.pm" ; 

         $sth->execute() or print STDERR "$DBI::errstr" ; 
      } or $ret = 500 ; # Internal Server error

      binmode(STDOUT, ':utf8');

      unless ( defined ( $DBI::errstr ) ) {
         $msg = 'DELETE OK ' ; 
         $ret = 0 ; 
      } else {
         $objLogger->doLogErrorMsg ( $DBI::errstr ) ; 
         $msg = "$DBI::errstr" ; 
         if ( $msg =~ m/some strange/ ){
            $ret = 409 ; 
         } else {
            $ret = 400 ; 
         }
      }

      return ( $ret , $msg ) ; 
   }


   sub doInsertByItemId {
   
		my $self 				= shift ; 
      my $table            = shift ; 
      my $ret              = 0 ; 
      my $msg              = '' ; 
   
      my $id               = $objModel->get('create.web-action.id' ) ; 

      my $dbh              = {} ;         # this is the database handle
      my $sth              = {} ;         # the statement handle
      my $str_sql          = q{} ;        # this is the sql string to use for the query
      
      if ( defined $objModel->get('postgres_db_name') ) {
		   $db = $objModel->get('postgres_db_name');
      }
      
      ( $ret , $msg , $dbh ) = $self->doConnectToDb ( $db ) ; 
      return ( $ret , $msg ) unless $ret == 0 ; 


      my $objRdrDbsFactory = 'IssueTracker::App::Db::In::RdrDbsFactory'->new( \$appConfig , \$objModel ) ; 
      my $objRdrDb            = $objRdrDbsFactory->doSpawn("$rdbms_type");

      if ( $objRdrDb->table_exists ( $db , $table ) == 0  ) {
         $ret = 400 ; 
         $msg = ' the table ' . $table . ' does not exist in the ' . $db . ' database '  ; 
         return ( $ret , $msg ) ; 
      }

      # this basically restricts the application from creating no more than 100 new items per
      # minute IF there are ongoing requests, which FOR NOW should suffice ...
      no warnings 'exiting' ; 
      for ( my $trialNum = 0 ; $trialNum < 100 ; $trialNum++ ) { 
         $id = $id + $trialNum ; 
         $str_sql = " 
         INSERT INTO  $table ( id ) VALUES ( '$id' );
         " ; 
         eval {
            $sth = $dbh->prepare($str_sql);  
            # debug rint "start WtrPostgresDb.pm : \n $str_sql \n stop WtrPostgresDb.pm" ; 
            $sth->execute() ;
            last ; 
         } or next ; 
      } 
      use warnings 'exiting' ; 

      binmode(STDOUT, ':utf8');

      unless ( defined ( $DBI::errstr ) ) {
         $msg = 'CREATE OK ' ; 
         $ret = 0 ; 
         return ( $ret , $msg ) ; 
      } else {
         $objLogger->doLogErrorMsg ( $DBI::errstr ) ; 
         $msg = "$DBI::errstr" ; 
         if ( $msg =~ m/duplicate key value violates unique constraint/ ){
            $ret = 409 ; 
         } else {
            $ret = 400 ; 
         }
      }
      return ( $ret , $msg ) ; 
   }


   sub doUpdateItemBySingleCol {

		my $self 				= shift ; 
      my $objModel         = ${ shift @_ } ; 
      my $table            = shift ; 
      my $ret              = 0 ; 
      my $msg              = '' ; 
   
      my $col_name         = $objModel->get('update.web-action.col_name' ) ; 
      my $id               = $objModel->get('update.web-action.id' ) ; 
      my $col_value        = $objModel->get('update.web-action.col_value'  ) ; 

      my $dbh              = {} ;         # this is the database handle
      my $sth              = {} ;         # the statement handle
      my $str_sql          = q{} ;        # this is the sql string to use for the query
      
      if ( defined $objModel->get('postgres_db_name') ) {
		   $db = $objModel->get('postgres_db_name');
      }
      
      ( $ret , $msg , $dbh ) = $self->doConnectToDb ( $db ) ; 
      return ( $ret , $msg ) unless $ret == 0 ; 


      my $objRdrDbsFactory = 'IssueTracker::App::Db::In::RdrDbsFactory'->new( \$appConfig , \$objModel ) ; 
      my $objRdrDb            = $objRdrDbsFactory->doSpawn("$rdbms_type");

      if ( $objRdrDb->table_exists ( $db , $table ) == 0  ) {
         $ret = 400 ; 
         $msg = ' the table ' . $table . ' does not exist in the ' . $db . ' database '  ; 
         return ( $ret , $msg ) ; 
      }

      if ( $objModel->doChkIfColumnExists( $db , $table , $col_name ) == 0 ) {
         $ret = 400 ; 
         $msg = "the $col_name column does not exist" ; 
         return ( $ret , $msg ) ; 
      }

      $col_value 		=~ s|\'|\'\'|g ; 
      # clear any possible winblows carriage returns
      $col_value     =~ s|\r\n|\n|g if ( $col_value ) ; 
      $col_value = "'" . $col_value . "'" unless ( $col_value eq 'null' ) ; 

      $str_sql = " 
      UPDATE  $table
         SET $col_name = $col_value
         WHERE id='$id'     
      ;
      " ; 
      eval {
         $sth = $dbh->prepare($str_sql);  
         #debug rint "start WtrPostgresDb.pm : \n $str_sql \n stop WtrPostgresDb.pm" ; 

         $sth->execute() or print STDERR "$DBI::errstr" ; 
      } or $ret = 500 ; # Internal Server error

      binmode(STDOUT, ':utf8');

      unless ( defined ( $DBI::errstr ) ) {
         $msg = 'UPDATE OK ' ; 
         $ret = 0 ; 
      } else {
         $objLogger->doLogErrorMsg ( $DBI::errstr ) ; 
         $msg = "$DBI::errstr" ; 
         $ret = 1 ; 
      }

      return ( $ret , $msg ) ; 
   }
   
   #
   # -----------------------------------------------------------------------------
   # open the database handle if possible, if not return proper error msgs
   # ( $ret , $msg , $dbh ) = $self->doConnectToDb ( $db ) ; 
   # -----------------------------------------------------------------------------
   sub doConnectToDb {
      my $self = shift ; 
      my $db = shift ; 
   
      my $ret = 1 ; 
      my $msg = q{} ; 
      my $dbh = q{} ; 

      eval { 
         $dbh = DBI->connect("dbi:Pg:dbname=$db", "", "" , {
                    'RaiseError'          => 1
                  , 'ShowErrorStatement'  => 1
                  , 'PrintError'          => 1
                  , 'AutoCommit'          => 1
                  , 'pg_utf8_strings'     => 1
         } ) 
      };

      if ($@) {
         $ret = 2 ; 
         $msg = 'cannot connect to the "' . $db . '" database: ' . DBI->errstr ; 
         return ( $ret , $msg , undef ) ; 
      }

      $ret = 0 ; $msg = "" ; 
      return ( $ret , $msg , $dbh ) ; 
   }

	#
   # ------------------------------------------------------
	#  input: hash ref of hash refs containing the issues 
	#  file data  and meta data 
   # ------------------------------------------------------
	sub doHsr2ToDb {

		my $self 				= shift ; 
		my $hsr2 			   = shift ; 	# the hash ref of hash refs  aka hs r on power 2
      my $table            = shift ; 

      my $ret              = 1 ; 
      my $msg              = 'unknown error while sql insert ' ; 		
      my $str_sql_insert   = q{} ; 
      my $str_col_list     = q{} ; 
      my $str_val_list     = q{} ; 
      my $error_msg        = q{} ; 

      my $objRdrDbsFactory = 'IssueTracker::App::Db::In::RdrDbsFactory'->new( \$appConfig , $self ) ; 
      my $objRdrDb            = $objRdrDbsFactory->doSpawn("$rdbms_type");
		
      my $objTimer         = 'IssueTracker::App::Utils::Timer'->new( $appConfig->{ 'TimeFormat' } );
		my $update_time      = $objTimer->GetHumanReadableTime();
      
      my $dmhsr            = {} ; 

      ( $ret , $msg , $dmhsr ) = $objRdrDb->doSelectTablesColumnList ( $table ) ; 
      return  ( $ret , $msg , undef ) unless $ret == 0 ; 

      # debug p($dmhsr); 
      # sleep 6 ; 
      
      my $do_trucate_tables = $ENV{ 'do_truncate_tables' } || 0 ; 
      if ( $do_trucate_tables == 1 ) { 
         $str_sql_insert .= "TRUNCATE TABLE $table ;" ; 
      }

	 
      #p ( $hsr2 ) ; 
      
      my $debug_msg        = 'START doInsertSqlHashData' ; 
      $objLogger->doLogDebugMsg ( $debug_msg ) ; 
 
		foreach my $key ( sort(keys( %{$hsr2} ) ) ) {
         my $row_hash = $hsr2->{ $key } ; 

		   foreach my $key ( sort(keys( %{$dmhsr} ) ) ) {
            next if $key eq 'guid' ; 
            $str_col_list .= ' , ' . $key ; 

            my $value = 'null' ; 
            unless ( $key eq 'update_time' ) {
               $value     = $row_hash->{ $key } || 'null' ; 
               # $value =~ s|\\|\\\\|g ;
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
      
      croak ( $str_sql_insert ) ; 
      p ( $str_sql_insert ) if $module_trace == 1 ; 

      # proper authentication implementation src:
      # http://stackoverflow.com/a/19980156/65706
      $objLogger->doLogDebugMsg ( $debug_msg ) ; 
     
      my $dbh = DBI->connect("DBI:Pg:dbname=$db", "", "" , {
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
      my $update_time      = q{} ; 

      my $objRdrDbsFactory = 'IssueTracker::App::Db::In::RdrDbsFactory'->new( \$appConfig , $self ) ; 
      my $objRdrDb            = $objRdrDbsFactory->doSpawn("$rdbms_type");

      ( $ret , $msg , $dmhsr ) = $objRdrDb->doSelectTablesColumnList ( $table ) ; 
      return  ( $ret , $msg , undef ) unless $ret == 0 ; 

		foreach my $key ( sort(keys( %{$sql_hash} ) ) ) {

         my $row_hash = $sql_hash->{ $key } ; 
		   foreach my $k ( sort(keys( %{$dmhsr} ) ) ) {

            my $col = $dmhsr->{ $k }->{ 'attname' } ; 
            next if $col eq 'guid' ; 
            next if $col eq 'update_time' ; 

            $str_col_list .= ' , ' . $col ; 
            my $value = 'null' ; 
            unless ( $key eq 'update_time' ) {
               $value     = $row_hash->{ $col } ; 

               unless ( defined $value ) { 
                  $str_val_list .= ' , NULL' ; 
                  next ; 
               }
               # $value     =~ s|\\|\\\\|g ;
               $value     =~ s|\'|\\\'|g ;
               $value     =~ s/'/''/g if ( $value ) ; 
               $value     =~ s|\r\n|\n|g if ( $value ) ; 
            } else {
               $value     = $update_time ; 
            }
            $str_val_list .= ' , \'' . $value . '\''  ; 
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
      
      p ( $str_sql_insert ) ; 

      # proper authentication implementation src:
      # http://stackoverflow.com/a/19980156/65706
      $debug_msg .= "\n postgres_db_name: $db \n postgres_db_host: $postgres_db_host " ; 
      $debug_msg .= "\n postgres_db_user: $postgres_db_user \n postgres_db_user_pw $postgres_db_user_pw \n" ; 
      $objLogger->doLogDebugMsg ( $debug_msg ) if $module_trace == 1 ; 


      eval {
         $dbh = DBI->connect("dbi:Pg:dbname=$db", "", "" , {
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


	#
	# -----------------------------------------------------------------------------
	# runs the insert sql by passed data part 
	# by convention is assumed that the first column is unique and update could 
	# be performed on it ... should there be duplicates the update should fail
	# -----------------------------------------------------------------------------
	sub doUpsertTable {

		my $self 			   = shift ; 
      my $objModel       = ${ shift @_ } ; 
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
      my $str_sql          = {} ;   # this is the sql string to use for the query
      my $rv               = 0 ;     # apperantly insert ok returns rv = 1 !!! 
      
      my $hs_headers       = {} ; 
      my $update_time      = q{} ; # must have the default value now() in db
      
      my $dmhsr            = {} ; 

      my $objRdrDbsFactory = 'IssueTracker::App::Db::In::RdrDbsFactory'->new( \$appConfig , \$objModel , $self ) ; 
      my $objRdrDb         = $objRdrDbsFactory->doSpawn("$rdbms_type");

      $objLogger->doLogDebugMsg ( "upsert start for : $table" );

      ( $ret , $msg , $hs_headers ) = $objRdrDb->doSelectTablesColumnList ( $table ) ; 
      return  ( $ret , $msg , undef ) unless $ret == 0 ; 

      # debug p($hs_headers ) ; 
      # print "WtrPostgresDb.pm : $table 336 \n " ; 
  
      ( $ret , $msg , $dbh ) = $self->doConnectToDb ( $db ) ; 
      return ( $ret , $msg ) unless $ret == 0 ;       

      my $sql_str          = '' ; 
      my $sql_str_insrt    = "INSERT INTO $table " ; 
      $sql_str_insrt      .= '(' ; 

      foreach my $col_num ( sort ( keys %{$hs_headers} )) {
         my $column_name = $hs_headers->{ $col_num }->{ 'attname' }; 
         # next if $column_name eq 'update_time' ; 
            # if the xls does not contain the guid's do just insert
         $sql_str_insrt .= " $column_name " . ' , '  ; 
      } 
    

      for (1..3) { chop ( $sql_str_insrt) } ; 
      $sql_str_insrt	.= ')' ; 

      # debug p $hsr2 ; 
      # debug p $sql_str_insrt ; 
      my $expected_amount_of_inserted_rows = keys %$hsr2; 

      my $objTimer         = 'IssueTracker::App::Utils::Timer'->new( $appConfig->{ 'TimeFormat' } );
      $update_time      = $objTimer->GetHumanReadableTime();
      foreach my $row_num ( sort ( keys %$hsr2) ) { 
         next if $row_num == 0 ; 

         my $hs_row = $hsr2->{ $row_num } ; 
         my $data_str = '' ; 

         # because obviously postgre prefers lc in col names by default on Ubuntu
         my %row_h = %$hs_row ; 
         %row_h = map { lc $_ => $row_h{$_} } keys %row_h;
         $hs_row = \%row_h ; 

         # debug p($hs_row) ; 
         # p $hs_headers ; 

         foreach my $col_num ( sort ( keys ( %$hs_headers ) ) ) {

            my $column_name = $hs_headers->{ $col_num }->{ 'attname' }; 
            # if the xls does not have the table column ( ie guid )
            #next unless exists $hsr2->{ 0 }->{ $column_name } ; 

            my $cell_value = $hs_row ->{ $column_name } ; 
            $cell_value = $update_time if $column_name eq 'update_time' ; 
            
            # if the xls does not contain the guid's do just insert
            # note that even cells with 1 space are considered for nulls !!!
            # this is simply because of Shift + arrow works on 1 space
            if ( !defined ( $cell_value ) or $cell_value eq 'NULL' 
                  or $cell_value eq 'null' or $cell_value eq "'NULL'" 
                  or $cell_value eq ' ' ) {  

               $cell_value = 'NULL'   ; 
               $data_str .= "$cell_value" . " , " ; 

            } else { 
               # $cell_value =~ s|\\|\\\\|g ; 
               # replace the ' chars with \'
               $cell_value 		=~ s|\'|\'\'|g ; 
               $cell_value     =~ s|\r\n|\n|g if ( $cell_value ) ; 
               $data_str .= "'" . "$cell_value" . "' , " ; 
            }
         }
         #eof foreach col_num
         
         # remove the " , " at the end 
         for (1..3) { chop ( $data_str ) } ; 
         
         $sql_str .= $sql_str_insrt ;  
         $sql_str	.=  " VALUES (" . "$data_str" . ') ' ; 

         # if the xls has guid column do upsert
         if ( $hs_row->{ 'guid' } ) {

            $sql_str	.=  "\n ON CONFLICT ( guid ) \n" ; 
            $sql_str	.=  " DO UPDATE SET \n" ; 
         
            # how-to upsert: https://stackoverflow.com/a/36799500/65706
            # INSERT INTO category_gallery (
            #  category_id, gallery_id, create_date, create_by_user_id
            #  ) VALUES ($1, $2, $3, $4)
            #  ON CONFLICT (category_id, gallery_id)
            #  DO UPDATE SET
            #    last_modified_date = EXCLUDED.create_date,
            #    last_modified_by_user_id = EXCLUDED.create_by_user_id ;

            foreach my $col_num ( sort ( keys %{$hs_headers} )) {
               my $column_name = $hs_headers->{ $col_num }->{ 'attname' }; 
               next if $column_name eq 'update_time' ; 
               # next if $column_name eq 'id' ; # id's are unique !!!
               $sql_str .= " $column_name " . '= EXCLUDED.' . $column_name . ' , ' ; 
            } 
            # remove the " , " at the end 
            for (1..3) { chop ( $sql_str ) } ; 
         }
         $sql_str .= '; ' . "\n" ; 

         # debug 
         print "WtrPostgresDb.pm : 669 \n " ; 
         # debug 
         print "sql_str $sql_str \n" ; 
      } 
      #eof foreach row
       

      my $do_trucate_tables = $ENV{ 'do_truncate_tables' } || 0 ; 
      if ( $do_trucate_tables == 1 ) { 
         $sql_str = "TRUNCATE TABLE $table ; $sql_str " ; 
      }
      # debug $objLogger->doLogDebugMsg ( "sql_str : $sql_str " ) ; 

      $msg = " DBI upsert error on table: $table: " . $msg  ; $ret = 1 ; 
      eval { 
         $rv = $dbh->do($sql_str) ; 
      } or return ( $ret , $msg ) ; 

      my $actual_amount_of_inserted_rows = undef ; 
      if ( $rv == 1 ) { 
         $str_sql = 'SELECT COUNT(*) FROM ' . $table ; 
         eval { 
            $sth = $dbh->prepare($str_sql);  
            $sth->execute();
            $actual_amount_of_inserted_rows = $sth->fetchrow_array() ; 
            print "\actual_amount_of_inserted_rows: $actual_amount_of_inserted_rows \n" ; 
            print "expected_amount_of_inserted_rows: $expected_amount_of_inserted_rows \n" ; 
            sleep 2 ; 
         } or return ( $ret , $msg ) ; 

         if ( $actual_amount_of_inserted_rows == $expected_amount_of_inserted_rows - 1) { 
            $msg = "upsert OK for table $table" ;          
            $objLogger->doLogInfoMsg ( $msg ) ; 
            $ret = 0 ; 
         }
         return ( $ret , $msg ) unless $ret == 0 ; 
      }

      $msg = 'upsert OK for all table' ; 
		return ( $ret , $msg ) ; 
	}


	#
	# -----------------------------------------------------------------------------
	# runs the insert sql by passed data part 
	# by convention is assumed that the first column is unique and update could 
	# be performed on it ... should there be duplicates the update should fail
	# -----------------------------------------------------------------------------
	sub doUpsertTables {

		my $self 			   = shift ; 
      my $objModel       = ${ shift @_ } ; 
		my $hsr3 		      = $objModel->get( 'hsr3' ) ; 
      my @tables = @{ $_[0] } ; 

      binmode(STDIN,  ':utf8');
      binmode(STDOUT, ':utf8');
      binmode(STDERR, ':utf8');
		my $ret 				   = 1 ; 
		my $msg 				   = ' failed to connect during insert to db !!! ' ; 
		my $debug_msg 		   = ' failed to connect during insert to db !!! ' ; 

      return ( $ret , $msg , undef ) unless $hsr3 ; 
      return ( $ret , $msg , undef ) unless @tables ; 

      my $sth              = {} ;    # this is the statement handle
      my $dbh              = {} ;    # this is the database handle
      my $str_sql          = q{} ;   # this is the sql string to use for the query
      my $rv               = 0 ;     # apperantly insert ok returns rv = 1 !!! 
      
      my $hs_headers       = {} ; 
      my $update_time      = q{} ; # must have the default value now() in db
      
      my $dmhsr            = {} ; 

      my $objRdrDbsFactory = 'IssueTracker::App::Db::In::RdrDbsFactory'->new( \$appConfig , \$objModel , $self ) ; 
      my $objRdrDb         = $objRdrDbsFactory->doSpawn("$rdbms_type");

      # obs this does not support ordered primary key tables first order yet !!!
      foreach my $table ( keys %$hsr3 ) { 

         $objLogger->doLogDebugMsg ( "doUpsertTables table: $table" );
         # load ONLY the tables defined to load
         next unless grep( /^$table$/, @tables ) ; 

         if ( $objRdrDb->table_exists ( $db , $table ) == 0  ) {
            $ret = 400 ; 
            $msg = ' the table ' . $table . ' does not exist in the ' . $db . ' database '  ; 
            return ( $ret , $msg , undef ) ; 
         }

         ( $ret , $msg , $hs_headers ) = $objRdrDb->doSelectTablesColumnList ( $table ) ; 
         return  ( $ret , $msg , undef ) unless $ret == 0 ; 


         my $hs_table = $hsr3->{ $table } ; 
         #debug p $hs_headers ;  
         #debug p $hs_table->{ 0 } ; 
         #debug p($hs_headers ) ; 
         ( $ret , $msg , $dbh ) = $self->doConnectToDb ( $db ) ; 
         return ( $ret , $msg ) unless $ret == 0 ;       

         my $sql_str          = '' ; 
         my $sql_str_insrt    = "INSERT INTO $table " ; 
         $sql_str_insrt      .= '(' ; 

         foreach my $col_num ( sort ( keys %{$hs_headers} )) {
            my $column_name = $hs_headers->{ $col_num }->{ 'attname' }; 
            # next if $column_name eq 'update_time' ; 
               # if the xls does not contain the guid's do just insert
            $sql_str_insrt .= " $column_name " . ' , ' 
               if exists $hs_table->{ 0 }->{ $column_name } ; 
         } 
         
         for (1..3) { chop ( $sql_str_insrt) } ; 
         $sql_str_insrt	.= ')' ; 

         my $objTimer         = 'IssueTracker::App::Utils::Timer'->new( $appConfig->{ 'TimeFormat' } );
		   my $update_time      = $objTimer->GetHumanReadableTime();
         foreach my $row_num ( sort ( keys %$hs_table ) ) { 

            next if $row_num == 0 ; 
            
            my $hs_row = $hs_table->{ $row_num } ; 
            my $data_str = q{} ; 

            # because obviously postgre prefers lc in col names by default on Ubuntu
            my %row_h = %$hs_row ; 
            %row_h = map { lc $_ => $row_h{$_} } keys %row_h;
            $hs_row = \%row_h ; 
            # debug p($hs_row) ;

            foreach my $col_num ( sort ( keys ( %$hs_headers ) ) ) {

               my $column_name = $hs_headers->{ $col_num }->{ 'attname' }; 
               # if the xls does not have the table column ( ie guid )
               next unless exists $hs_table->{ 0 }->{ $column_name } ; 

               my $cell_value = $hs_row ->{ $column_name } ; 
               $cell_value = $update_time if $column_name eq 'update_time' ; 
               
               # if the xls does not contain the guid's do just insert
               # note that even cells with 1 space are considered for nulls !!!
               # this is simply because of Shift + arrow works on 1 space
               if ( !defined ( $cell_value ) or $cell_value eq 'NULL' 
                     or $cell_value eq 'null' or $cell_value eq "'NULL'" 
                     or $cell_value eq ' ' ) {  

                  $cell_value = 'NULL'   ; 
                  $data_str .= "$cell_value" . " , " ; 

               } else { 
                  # $cell_value =~ s|\\|\\\\|g ; 
                  # replace the ' chars with \'
                  $cell_value 		=~ s|\'|\'\'|g ; 
                  # clear any possible winblows carriage returns
                  $cell_value     =~ s|\r\n|\n|g if ( $cell_value ) ; 
                  $data_str .= "'" . "$cell_value" . "' , " ; 
               }
            }
            #eof foreach col_num
            
            # remove the " , " at the end 
            for (1..3) { chop ( $data_str ) } ; 
            
            $sql_str .= $sql_str_insrt ;  
            $sql_str	.=  " VALUES (" . "$data_str" . ') ' ; 

            # if the xls has guid column do upsert
            if ( $hs_table->{0}->{ 'guid' } ) {

               $sql_str	.=  "\n ON CONFLICT ( guid ) \n" ; 
               $sql_str	.=  " DO UPDATE SET \n" ; 

               foreach my $col_num ( sort ( keys %{$hs_headers} )) {
                  my $column_name = $hs_headers->{ $col_num }->{ 'attname' }; 
                  next if $column_name eq 'update_time' ; 
                  $sql_str .= " $column_name " . '= EXCLUDED.' . $column_name . ' , ' ; 
               } 
               # remove the " , " at the end 
               for (1..3) { chop ( $sql_str ) } ; 
            }
            $sql_str .= '; ' . "\n" ; 

         } 
         #eof foreach row
          

         my $do_trucate_tables = $ENV{ 'do_truncate_tables' } || 0 ; 
         if ( $do_trucate_tables == 1 ) { 
            $sql_str = "TRUNCATE TABLE $table ; $sql_str " ; 
         }
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


   #
	# -----------------------------------------------------------------------------
	# the constructor 
	# -----------------------------------------------------------------------------
	sub new {

		my $invocant 	= shift ;    
		$appConfig     = ${ shift @_ } || { 'foo' => 'bar' ,} ; 
		$objModel      = ${ shift @_ } || croak 'objModel not passed in WtrPostgresDb !!!' ; 
      $objController = shift ;  
		my $class      = ref ( $invocant ) || $invocant ; 
		my $self       = {};        # Anonymous hash reference holds instance attributes
		bless( $self, $class );    # Say: $self is a $class
      $self = $self->doInitialize() ; 

		return $self;
	}  


   #
	# --------------------------------------------------------
	# intializes this object 
	# --------------------------------------------------------
   sub doInitialize {
      my $self = shift ; 

      %$self = (
           appConfig => $appConfig
      );

		$db 			               = $ENV{ 'postgres_db_name' } || $appConfig->{'postgres_db_name'}        || 'prd_pgsql_runner' ; 
		$postgres_db_host 			         = $ENV{ 'postgres_db_host' } || $appConfig->{'postgres_db_host'} 		|| 'localhost' ;
		$postgres_db_port 			         = $ENV{ 'postgres_db_port' } || $appConfig->{'postgres_db_port'} 		|| '13306' ; 
		$postgres_db_user 			= $ENV{ 'postgres_db_user' } || $appConfig->{'postgres_db_user'} 		|| 'ysg' ; 
		$postgres_db_user_pw 		= $ENV{ 'postgres_db_user_pw' } || $appConfig->{'postgres_db_user_pw'} 	|| 'no_pass_provided!!!' ; 
      
	   $objLogger 			= 'IssueTracker::App::Utils::Logger'->new( \$appConfig ) ;

      return $self ; 
	}	
   


1;


__END__
