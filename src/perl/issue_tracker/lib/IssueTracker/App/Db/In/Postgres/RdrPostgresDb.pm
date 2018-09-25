package IssueTracker::App::Db::In::Postgres::RdrPostgresDb ; 

   use strict ; use warnings ; use utf8 ; 

   require Exporter; 
   use AutoLoader ; 
	use Encode qw( encode_utf8 is_utf8 );
   use POSIX qw(strftime);
	use Carp ; 
   use DBI ; 
	use Data::Printer ; 

   use IssueTracker::App::Utils::Logger ; 
   use IssueTracker::App::Mdl::Model ; 

   our $module_trace                            = 0 ;  
   our $IsUnitTest                              = 0 ; 
	our $appConfig 										= {} ; 
	our $objLogger 										= {} ; 
	our $objModel                                = {} ; 
	our $postgres_db_name                        = q{} ; 
	our $db_host 										   = q{} ; 
	our $db_port 										   = q{} ;
	our $postgres_db_user 							   = q{} ; 
	our $postgres_db_user_pw	 					   = q{} ; 
	our $web_host 											= q{} ; 

   sub doCheckIfColExists {

      my $self = shift ; 
      my $table = shift ; 
      my $col  = shift ; 
      my $ret  = 1 ; 
      my $msg = '' ; 
      my $dmhsr = {} ; 

      ( $ret , $msg , $dmhsr ) = $self->doSelectTablesColumnList ( $table ) ; 
      return 0 unless $ret == 0 ; 

      my $mhsr = {} ; 
      foreach my $key ( sort ( keys %$dmhsr ) ) {
         $mhsr->{'ColumnNames'}-> { $key } = $dmhsr->{ $key } ; 
      }
      my $cols = $mhsr->{ 'ColumnNames' } ; 

      foreach my $key ( keys %$cols ) {
         my $row = $cols->{ $key } ; 
         return 1 if $row->{ 'attname' } eq $col; 
      }
      return 0 ; 
   }


   sub doCheckIfColumnExists {

      my $self = shift ; 
      my $cols = shift ; 
      my $col  = shift ; 

      foreach my $key1 ( keys %$cols ) {
         my $row = $cols->{ $key1 } ; 
         return 1 if $row->{ 'attname' } eq $col; 
      }
      return 0 ; 
   }


   sub doBuildLikeClause {

      my $self = shift ; 
      my $cols = shift ; 
		my $sql = '' ; 
		my $ret = 400 ; 
		my $msg = ' the following column: %s does not exist ' ; 

      my $ref_like_names    = $objModel->get('select.web-action.like-by' );
      my $ref_like_values   = $objModel->get('select.web-action.like-val' );

      return ( 0 , "" , "")  unless ( defined ( $ref_like_names) ); 
      return ( 0 , "" , "")  unless ( defined ( $ref_like_values) ); 

      if ( @$ref_like_names and @$ref_like_values  ) {
			
         $sql = ' AND ' ; 

         for ( my $i = 0 ; $i < scalar ( @$ref_like_names ) ; $i++ ) {
				my ( $like_name , $like_value ) = () ; 
            $like_name = $ref_like_names->["$i"] ;
            $like_value = $ref_like_values->["$i"] ;

        
            my $col_exists = $self->doCheckIfColumnExists ( $cols->{'ColumnNames'} , $like_name ) ; 
      	   return ( 400 , "the $like_name column does not exist" , "") unless ( $col_exists ) ; 
            
            # if the like value is a number
            $like_name = "CAST( $like_name AS TEXT)" if $like_value =~ /\d{1,100}/g ; 

            my @like_values_list = split (',' , $like_value ) ;
            my $str = '' ;
            foreach my $item ( @like_values_list ) {
               $str .= "( $like_name LIKE '%" . $item . "%' ) OR " ;
            }
			   for (1..3) { chop ( $str ) } ;

            $sql .= "$str "
               if ( defined ( $like_value ) and defined ( $like_name ) );
				$sql .= ' AND ' ; 
         }

			for (1..4) { chop ( $sql) } ;
			return ( 0 , "" , $sql ) ; 

      } elsif ( @$ref_like_names or @$ref_like_values )  {
			# if either the like names or the like values are null than the likeing url is mall-formed
			$msg = 'mall-formed url params for the like operator - valid syntax is ?like-by=<<attribute>>&like-val=<<like-value>>' ; 
      	return ( 400 , "$msg" , "") ; 
		} else {
			# simply no likeing attributes nor values are provided return 
			# to proceed with the select 
      	return ( 0 , "" , "") ;
		}

   } 


   sub doBuildWhereClauseByWith {

      my $self    = shift ; 
      my $mshr    = shift ; 
		my $sql     = '' ; 
		my $ret     = 400 ; 
		my $msg     = ' the following column: %s does not exist ' ; 

      my $cols = $objModel->get('select.web-action.with-cols') ; 
      my $ops = $objModel->get('select.web-action.with-ops') ; 
      my $vals = $objModel->get('select.web-action.with-vals') ;
      
      return ( 0 , "" , "")  unless ( defined ( $cols) ); 
      return ( 0 , "" , "")  unless ( defined ( $ops ) ); 
      return ( 0 , "" , "")  unless ( defined ( $vals ) ); 

      # debug print "from RdrPostgresDb.pm 120 \@$cols @$cols \n" ; 
      # debug print "from RdrPostgresDb.pm \@$ops @$ops \n" ; 
      # debug print "from RdrPostgresDb.pm \@$vals @$vals \n" ; 
      #
      if ( @$cols and @$ops and @$vals) {
         
         for ( my $i = 0 ; $i < scalar ( @$cols ) ; $i++ ) {
            $sql .= ' AND ' ; 
				my ( $col , $op, $val ) = () ; 
            $col = $cols->["$i"] ;
            $op = $ops->["$i"] ;
            $val = $vals->["$i"] || "" ; 
        
            my $col_exists = $self->doCheckIfColumnExists ( $mshr->{'ColumnNames'} , $col ) ; 
      	   return ( 400 , "the $col column does not exist" , "") unless ( $col_exists ) ; 
				$sql .= " $col $op '$val'" ; 
         }
         # debug print "from RdrPostgresDb.pm 134 sql : $sql \n" ; 
      	return ( 0 , "" , $sql) ;
      } elsif ( @$cols or @$vals or @$ops )  {

			# if either the with names or the with values are null than the withing url is mall-formed
			$msg = 'mall-formed url params for filtering with - valid syntax is ?fltr-by=<<attribute>>&fltr-val=<<with-value>>' ; 
      	return ( 400 , "$msg" , "") ; 
		} else {

			# simply no withing attributes nor values are provided return => to proceed with the select 
      	return ( 0 , "" , "") ;
		}
   } 

   
   sub doBuildWhereClauseByFltr {

      my $self    = shift ; 
      my $cols    = shift ; 
		my $sql     = '' ; 
		my $ret     = 400 ; 
		my $msg     = ' the following column: %s does not exist ' ; 

      my $ref_filter_names    = $objModel->get('select.web-action.fltr-by' );
      my $ref_filter_values   = $objModel->get('select.web-action.fltr-val' );
      
      return ( 0 , "" , "")  unless ( defined ( $ref_filter_names) ); 
      return ( 0 , "" , "")  unless ( defined ( $ref_filter_values) ); 

      if ( @$ref_filter_names and @$ref_filter_values  ) {

			$sql = ' AND ' ; 

         for ( my $i = 0 ; $i < scalar ( @$ref_filter_names ) ; $i++ ) {
				my ( $filter_name , $filter_value ) = () ; 
            $filter_name = $ref_filter_names->["$i"] ;
            $filter_value = $ref_filter_values->["$i"] ;
        
            my $col_exists = $self->doCheckIfColumnExists ( $cols->{'ColumnNames'} , $filter_name ) ; 
      	   return ( 400 , "the $filter_name column does not exist" , "") unless ( $col_exists ) ; 

            my @filter_values_list = split (',' , $filter_value ) ;
            my $str = '(' ;
            foreach my $item ( @filter_values_list ) {
               $str .= " '" . $item . "' ," ;
            }
            chop ( $str ) ; $str .= ') ' ;

            $sql .= "$filter_name  in $str "
               if ( defined ( $filter_value ) and defined ( $filter_name ) );
				$sql .= ' AND ' ; 
         }

         # debug print "from RdrPostgresDb.pm 186 sql : $sql \n" ; 

			for (1..4) { chop ( $sql) } ;
			return ( 0 , "" , $sql ) ; 

      } elsif ( @$ref_filter_names or @$ref_filter_values )  {

			# if either the filter names or the filter values are null than the filtering url is mall-formed
			$msg = 'mall-formed url params for filtering - valid syntax is ?fltr-by=<<attribute>>&fltr-val=<<filter-value>>' ; 
      	return ( 400 , "$msg" , "") ; 
		} else {

			# simply no filtering attributes nor values are provided return 
			# to proceed with the select  ( = not an error !!! ) 
      	return ( 0 , "" , "") ;
		}

   } 

 
   sub doSelectTablesList {

      my $self             = shift ; 
      my $objModel         = ${shift @_ } ; 

      my $msg              = q{} ;         
      my $ret              = 1 ;          # this is the return value from this method 
      my $debug_msg        = q{} ; 
      my $hsr              = {} ;         # this is meta hash describing the data hash ^^
      my $sth              = {} ;         # this is the statement handle
      my $dbh              = {} ;         # this is the database handle
      my $str_sql          = q{} ;        # this is the sql string to use for the query
      
      if ( defined $objModel->get('postgres_db_name') ) {
		   $postgres_db_name = $objModel->get('postgres_db_name');
      }
      
      ( $ret , $msg , $dbh ) = $self->doConnectToDb ( $postgres_db_name ) ; 
      return ( $ret , $msg ) unless $ret == 0 ; 

      $str_sql = " 
      SELECT  
           ROW_NUMBER () OVER (ORDER BY table_name) as row_id
         , table_name 
         , table_schema 
      FROM information_schema.tables  
      WHERE 1=1 
      AND table_type = 'BASE TABLE' 
      AND table_schema = 'public' 
      ORDER BY table_name
      ;
      " ; 

      # authentication src: http://stackoverflow.com/a/19980156/65706
      $debug_msg .= "\n postgres_db_name: $postgres_db_name \n db_host: $db_host " ; 
      $debug_msg .= "\n postgres_db_user: $postgres_db_user \n postgres_db_user_pw $postgres_db_user_pw \n" ; 
      # $objLogger->doLogDebugMsg ( $debug_msg ) ; 
      
      # src: http://www.easysoft.com/developer/languages/perl/dbd_odbc_tutorial_part_2.html
      $sth = $dbh->prepare($str_sql);  
      # debug print "$str_sql \n stop RdrPostgresDb.pm" ; 

      $sth->execute()
            or $objLogger->error ( "$DBI::errstr" ) ;

      $hsr = $sth->fetchall_hashref( 'row_id' ) ; 
      
      $objModel->set('hsr2' , $hsr);
      binmode(STDOUT, ':utf8');

      $msg = DBI->errstr ; 

      unless ( defined ( $msg ) ) {
         $msg = 'SELECT tables-list OK ' ; 
         $ret = 0 ; 
      } else {
         $objLogger->doLogErrorMsg ( $msg ) ; 
      }

      $appConfig->{ "$postgres_db_name".'.tables-list'} = $hsr ;
      return ( $ret , $msg , $hsr ) ; 	
   }

   sub doSelectDatabasesList {

      my $self             = shift ; 
      my $objModel         = ${shift @_ } ; 

      my $msg              = q{} ;         
      my $ret              = 1 ;          # this is the return value from this method 
      my $debug_msg        = q{} ; 
      my $hsr              = {} ;         # this is meta hash describing the data hash ^^
      my $sth              = {} ;         # this is the statement handle
      my $dbh              = {} ;         # this is the database handle
      my $str_sql          = q{} ;        # this is the sql string to use for the query
      
      if ( defined $objModel->get('postgres_db_name') ) {
		   $postgres_db_name = $objModel->get('postgres_db_name');
      }
      
      ( $ret , $msg , $dbh ) = $self->doConnectToDb ( $postgres_db_name ) ; 
      return ( $ret , $msg ) unless $ret == 0 ; 

      $str_sql = " 
         select ROW_NUMBER () OVER (ORDER BY datname ) as row_id, datname from pg_database;
      " ; 

      # authentication src: http://stackoverflow.com/a/19980156/65706
      $debug_msg .= "\n postgres_db_name: $postgres_db_name \n db_host: $db_host " ; 
      $debug_msg .= "\n postgres_db_user: $postgres_db_user \n postgres_db_user_pw $postgres_db_user_pw \n" ; 
      # $objLogger->doLogDebugMsg ( $debug_msg ) ; 
      
      $sth = $dbh->prepare($str_sql);  

      $sth->execute()
            or $objLogger->error ( "$DBI::errstr" ) ;

      $hsr = $sth->fetchall_hashref( 'row_id' ) ; 

      $objModel->set('hsr2' , $hsr);

      binmode(STDOUT, ':utf8');

      $msg = DBI->errstr ; 

      unless ( defined ( $msg ) ) {
         $msg = 'SELECT databases-list OK ' ; 
         $ret = 0 ; 
      } else {
         $objLogger->doLogErrorMsg ( $msg ) ; 
      }

      $appConfig->{ "databases-list"} = $hsr ;
      return ( $ret , $msg , $hsr ) ; 	
   }


   sub table_exists {

      my $self       = shift ; 
      my $db         = shift ; 
      my $table      = shift ; 
      my $ret        = 1 ; 

      my $table_exists = 0 ; 
      my $hsr2 = {} ; 
      my $msg  = () ; 

      unless ( defined ( $appConfig->{"$db" . '.tables-list'} ) ) {
         ($ret, $msg) = $self->doSelectTablesList(\$objModel);
         return 0 unless $ret == 0 ; 
         $hsr2 = $objModel->get('hsr2');
         return $table_exists unless $ret == 0 ; 
      } 

      $hsr2 = $appConfig->{"$db" . '.tables-list'} ; 

      for my $key ( keys %$hsr2 ) {
         my $table_name = $hsr2->{ $key }->{'table_name'} ; 
         if ( $table eq $table_name ) {
            $table_exists = 1 ; 
            $msg = ' the table exists ' ; 
            return $table_exists ; 
         }
      }
      return $table_exists ; 
   }

   #
   # -----------------------------------------------------------------------------
   # retrieve the single row from db by guid
   # -----------------------------------------------------------------------------
   sub doSelectItemByGuid {

      my $self             = shift ; 
      my $db               = shift ; 
      my $table            = shift || croak 'table not passed !!!' ; 
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
      $debug_msg .= "\n postgres_db_name: $postgres_db_name \n db_host: $db_host " ; 
      $debug_msg .= "\n postgres_db_user: $postgres_db_user \n postgres_db_user_pw $postgres_db_user_pw \n" ; 
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
      $objLogger->doLogDebugMsg ( $msg ) ; 

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


   #
   # -----------------------------------------------------------------------------
   # get the columns meta data of a table into hash ref of hash refs 
   # -----------------------------------------------------------------------------
   sub doSelectTablesColumnList {

      my $self          = shift ; 
      my $table         = shift || croak ' table provided !!!' ; 
      
      if ( defined $objModel->get('postgres_db_name') ) {
		   $postgres_db_name = $objModel->get('postgres_db_name');
      }
      my $msg              = q{} ;         
      my $ret              = () ;          # this is the return value from this method 
      my $debug_msg        = q{} ; 
      my $mhsr2             = {} ;         # this is meta hash describing the data hash ^^
      my $sth              = {} ;         # this is the statement handle
      my $dbh              = {} ;         # this is the database handle
      my $str_sql          = q{} ;        # this is the sql string to use for the query

      ( $ret , $msg , $dbh ) = $self->doConnectToDb ( $postgres_db_name ) ; 
      return ( $ret , $msg ) unless $ret == 0 ; 
		$str_sql = "
			SELECT a.attnum, a.attname, a.attlen ,
					 pg_catalog.format_type(a.atttypid, a.atttypmod),
					 a.attnotnull 
			FROM pg_attribute a
			  JOIN pg_class t on a.attrelid = t.oid
			  JOIN pg_namespace s on t.relnamespace = s.oid
			WHERE 1=1
				AND a.attnum > 0 
				AND NOT a.attisdropped
				AND t.relname = '" . lc($table) . "' 
				AND s.nspname = 'public' 
			ORDER BY t.relname , a.attnum
			;
		" ; 
      # debug 
      # print "SQL: $str_sql \n STOP RdrPostgresDb.pm" ;   
      
      # chk: https://stackoverflow.com/a/451454/65706 
      eval { 
         $sth = $dbh->prepare($str_sql);  
         $sth->execute() ; 
         $mhsr2 = $sth->fetchall_hashref( 'attnum' ) ; 
         # debug p $mhsr2 ; 
      };
      if ( $@ or !scalar(%$mhsr2)) { 
         # $objLogger->doLogErrorMsg ( "$DBI::errstr" ) ;
         $msg = "failed to get $table table meta data -  " ; 
         $msg .= "most probably the table does not exist " ; 
         $ret = 1 ; 
         return ( $ret , $msg , "" ) ; 
      };

         binmode(STDOUT, ':utf8');
         $objModel->set('hs_headers' , $mhsr2 ) ; 
         $ret = 0 ; 
         return ( $ret , $msg , $mhsr2 ) ; 	

   }


   #
   # -----------------------------------------------------------------------------
   # get ALL the table data into hash ref of hash refs 
   # -----------------------------------------------------------------------------
   sub doSearchConfigurationEntries {

      my $self             = shift ; 
      my $postgres_db_name          = shift || 'ysg_issues' ; # the default db
      my $table            = shift || 'confs' ;  # the table to get the data from  
      my $query_str        = shift || '*' ;  # the table to get the data from  
   
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

     
      $dbh = DBI->connect("dbi:Pg:dbname=$postgres_db_name", "", "" , {
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
      
      binmode(STDOUT, ':utf8');
      while ( my $row = $sth->fetchrow_hashref ){
          my %hash = %$row ;
          #debug say "UTF8 flag is turned on in the STRING $key" if is_utf8( $hash{$key} );
          push @query_output, $row
          #debug if is_utf8( $hash{$key} );
      } 
      
		$msg = DBI->errstr ; 

      unless ( defined ( $msg ) ) {
         $msg = 'SELECT OK for table: ' . "$table" ; 
         $ret = 0 ; 
      } else {
         $objLogger->doLogErrorMsg ( $msg ) ; 
      }

      $dbh->disconnect();
      
      $debug_msg        = 'doInsertSqlHashData ret ' . $ret ; 
      $objLogger->doLogDebugMsg ( $debug_msg ) ; 

      return ( $ret , $msg , \@query_output ) ; 	
   
	}

   #
   # -----------------------------------------------------------------------------
   # open the database handle if possible, if not return proper error msgs
   # ( $ret , $msg , $dbh ) = $self->doConnectToDb ( $postgres_db_name ) ; 
   # -----------------------------------------------------------------------------
   sub doConnectToDb {
      my $self = shift ; 
      my $postgres_db_name = shift ; 
   
      my $ret = 1 ; 
      my $msg = q{} ; 
      my $dbh = q{} ; 

      eval { 
         $dbh = DBI->connect("dbi:Pg:dbname=$postgres_db_name", "", "" , {
                    'RaiseError'          => 1
                  , 'ShowErrorStatement'  => 1
                  , 'PrintError'          => 1
                  , 'AutoCommit'          => 1
                  , 'pg_utf8_strings'     => 1
         } ) 
      };

      if ($@) {
         $ret = 2 ; 
         $msg = 'cannot connect to the "' . $postgres_db_name . '" database: ' . DBI->errstr ; 
         return ( $ret , $msg , undef ) ; 
      }

      $ret = 0 ; $msg = "" ; 
      return ( $ret , $msg , $dbh ) ; 
   }


   #
   # -----------------------------------------------------------------------------
   # get ALL the table data into hash ref of hash refs 
   # -----------------------------------------------------------------------------
   sub doSelectTableIntoHashRef {

      my $self                   = shift ; 
      my $objModel               = ${shift @_ } ; 
      my $table                  = shift || croak 'no table passed !!!' ; 
      my $filter_by_attributes   = shift ; 
      my $ret                    = 1 ; 
      my $msg                    = 'unknown error while retrieving the content of the ' . $table . ' table' ; 
      my $dbh              = {} ;         # this is the database handle

      if ( defined $objModel->get('postgres_db_name') ) {
		   $postgres_db_name = $objModel->get('postgres_db_name');
      }
     
      ( $ret , $msg , $dbh ) = $self->doConnectToDb ( $postgres_db_name ) ; 
      return ( $ret , $msg ) unless $ret == 0 ; 

      if ( $self->table_exists ( $postgres_db_name , $table ) == 0  ) {
         $ret = 400 ; 
         $msg = ' the table ' . $table . ' does not exist in the ' . $postgres_db_name . ' database '  ; 
         return ( $ret , $msg ) ; 
      }

      my $debug_msg        = q{} ; 
      my $hsr2             = {} ;         # this is hash ref of hash refs to populate with
      my $mhsr             = {} ;         # this is meta hash describing the data hash ^^
      my $dmhsr            = {} ;        # this is meta hash describing the data hash ^^
      my $sth              = {} ;         # this is the statement handle
      my $str_sql          = q{} ;        # this is the sql string to use for the query


      ( $ret , $msg , $dmhsr ) = $self->doSelectTablesColumnList ( $table ) ; 

      return  ( $ret , $msg , undef ) unless $ret == 0 ; 

      foreach my $key ( sort ( keys %$dmhsr ) ) {
         $mhsr->{'ColumnNames'}-> { $key } = $dmhsr->{ $key } ; 
      }
      
      $objModel->set('hsr_meta' , $mhsr );

      my $columns_to_select = "*" ; 
      if ( defined ( $objModel->get('select.web-action.pick') ) ) {
         $columns_to_select = " guid,id" ;
         my $lst_columns_to_select = $objModel->get('select.web-action.pick'); 
         my @cols = split (',' , $lst_columns_to_select ) ;
         foreach my $col ( @cols ) { 
            my $col_exists = $self->doCheckIfColumnExists ( $mhsr->{'ColumnNames'} , $col ) ; 
      	   return ( 400 , "the $col column does not exist" , "") unless ( $col_exists ) ; 
            $columns_to_select .= " , $col" ; 
         }
      }
      
      my $columns_to_order_by_asc = undef ; 
      if ( defined ( $objModel->get('select.web-action.oa') ) ) {
         $columns_to_order_by_asc = $objModel->get('select.web-action.oa'); 
         my @cols = split (',' , $columns_to_order_by_asc ) ;
         foreach my $col ( @cols ) { 
            my $col_exists = $self->doCheckIfColumnExists ( $mhsr->{'ColumnNames'} , $col ) ; 
      	   return ( 400 , "the $col column does not exist" , "") unless ( $col_exists ) ; 
         }
      }
      
      my $columns_to_order_by_desc = undef ; 
      if ( defined ( $objModel->get('select.web-action.od') ) ) {
         $columns_to_order_by_desc = $objModel->get('select.web-action.od'); 
         my @cols = split (',' , $columns_to_order_by_desc ) ;
         foreach my $col ( @cols ) { 
            my $col_exists = $self->doCheckIfColumnExists ( $mhsr->{'ColumnNames'} , $col ) ; 
      	   return ( 400 , "the $col column does not exist" , "") unless ( $col_exists ) ; 
         }
      }
     
      $str_sql = " 
         SELECT 
         $columns_to_select , count(*) OVER () as rows_count
         FROM $table 
         WHERE 1=1 " ; 
      $str_sql .= $filter_by_attributes . " " if $filter_by_attributes ; 
      
      my $like_clause = '' ; 
		( $ret , $msg , $like_clause ) = $self->doBuildLikeClause ( $mhsr ) ; 
		
      return ( $ret , $msg ) unless $ret == 0 ; 
		$str_sql .= $like_clause if $like_clause ; 
		
      my $where_clause_fltr = '' ; 
		( $ret , $msg , $where_clause_fltr ) = $self->doBuildWhereClauseByFltr ( $mhsr ) ; 

		return ( $ret , $msg ) unless $ret == 0 ; 
		$str_sql .= $where_clause_fltr if $where_clause_fltr ; 
      
      my $where_clause_with = '' ; 
		( $ret , $msg , $where_clause_with ) = $self->doBuildWhereClauseByWith ( $mhsr ) ; 

		return ( $ret , $msg ) unless $ret == 0 ; 
		$str_sql .= $where_clause_with if $where_clause_with ; 

      # not all items have the prio attribute
      $str_sql .= " ORDER BY " . $columns_to_order_by_asc . " ASC " if defined $columns_to_order_by_asc ; 
      $str_sql .= " ORDER BY " . $columns_to_order_by_desc . " DESC " if defined $columns_to_order_by_desc ; 
      
      if ( $str_sql =~ m/ ORDER BY /g ) {
         $str_sql .= ", id ASC " unless ( $str_sql =~ m/ORDER BY id / );
      } else {
         $str_sql .= " ORDER BY id ASC " ;
      }

      my $limit = $objModel->get('select.web-action.page-size' ) || 5 ; 
      my $page_num = $objModel->get('select.web-action.page-num' ) || 1 ; 
      my $offset = ( $page_num -1 ) || 0 ; # get default page is 1

      $offset = $limit*$offset ; 
      $offset = 0 if ( $offset < 0 ) ; 
      $str_sql .= " LIMIT $limit OFFSET $offset " ; 
      
      # debug print "from RdrPostgresDb.pm 678 : $str_sql \n" ; 

      eval { 
         $sth = $dbh->prepare($str_sql);  
         $sth->execute() or $msg = DBI->errstr ; 
         $hsr2 = $sth->fetchall_hashref( 'guid' ) ; 
         $objModel->set('hsr2' , $hsr2 );
      };
      if ( $@ or !scalar(%$hsr2)) { 
         my $tmsg = $@ ; 
         $objLogger->doLogErrorMsg ( "$msg" ) ;
         $msg = "failed to get $table table data :: $tmsg" ; 
         $ret = 400 ; 
         return ( $ret , $msg , "" ) ; 
      };

      return ( $ret , $msg ) ; 	
      binmode(STDOUT, ':utf8');

   }

	
	sub new {

		my $invocant 			= shift ;    
		$appConfig     = ${ shift @_ } || croak 'appConfig not passed in RdrPostgresDb !!!' ; 
		$objModel      = ${ shift @_ } || croak 'objModel not passed in RdrPostgresDb !!!' ; 
		my $class      = ref ( $invocant ) || $invocant ; 
		my $self       = {} ; bless( $self, $class );    # Say: $self is a $class
      $self = $self->doInitialize() ; 
		return $self;
	}  
	
   sub doInitialize {
      my $self = shift ; 

      %$self = (
           appConfig => $appConfig
      );
		
		$postgres_db_name    = $ENV{ 'postgres_db_name' } || $appConfig->{'postgres_db_name'}     || 'prd_ysg_issues' ; 
		$db_host 			   = $ENV{ 'db_host' } || $appConfig->{'db_host'} 		|| 'localhost' ;
		$db_port 			   = $ENV{ 'db_port' } || $appConfig->{'db_port'} 		|| '13306' ; 
		$postgres_db_user 	= $ENV{ 'postgres_db_user' } || $appConfig->{'postgres_db_user'} 		|| 'ysg' ; 
		$postgres_db_user_pw = $ENV{ 'postgres_db_user_pw' } || $appConfig->{'postgres_db_user_pw'} 	|| 'no_pass_provided!!!' ; 
      
	   $objLogger 			   = 'IssueTracker::App::Utils::Logger'->new( \$appConfig ) ;

      return $self ; 
	}	
   


1;

__END__
