package IssueTracker::App::Db::In::Postgres::RdrPostgresDb ; 

   use strict ; use warnings ; use utf8 ; 

   require Exporter; 
   use AutoLoader ; 
	use Encode qw( encode_utf8 is_utf8 );
   use POSIX qw(strftime);
	use Carp ; 
   use DBI ; 
	use Data::Printer ; 

   use Scalar::Util qw /looks_like_number/ ; 
   use IssueTracker::App::Utils::Logger ; 
   use IssueTracker::App::Mdl::Model ; 
   use IssueTracker::App::Db::In::Postgres::MojoPgWrapper ; 

   our $module_trace                            = 0 ;  
   our $IsUnitTest                              = 0 ; 
	our $appConfig 										= {} ; 
	our $objLogger 										= {} ; 
	our $objModel                                = {} ; 
	our $db                        					= q{} ; 
	our $postgres_db_host 										   = q{} ; 
	our $postgres_db_port 										   = q{} ;
	our $postgres_db_user 							   = q{} ; 
	our $postgres_db_user_pw	 					   = q{} ; 
	our $web_host 											= q{} ; 

   sub doGlobalSrchIntoHashRef {

      my $self = shift ; 
		$objModel      = ${ shift @_ } || croak 'objModel not passed in RdrPostgresDb !!!' ; 
      if ( defined $objModel->get('postgres_db_name') ) {
		   $db = $objModel->get('postgres_db_name');
      }
      my $qry  = $objModel->get('query.web-action.for');
      
      my $ret = 1 ; 
      my $msg = 'unknown error has occured during global search ' ; 
      my $dbh = {} ; 
      my $sth = {} ; 
      my $hsr2 = {} ; 

      ( $ret , $msg , $dbh ) = $self->doConnectToDb ( $db ) ; 
      return ( $ret , $msg ) unless $ret == 0 ; 

      # debug pr $appConfig->{ $db . '.meta' }  ; 

      $objModel->doSetDbTablesList($db ) unless exists $appConfig->{"$db" . '.meta.tables-list'} ; 
      my @tables = @{ $appConfig->{"$db" . '.meta.tables-list'} } ; 
      my $str_sql = 'SELECT guid as guid, id as id, item as item, name as name, description as description' ; 
      $str_sql .= ', count(*) OVER () as rows_count FROM ( ' ;
      foreach my $table ( @tables ) {
         if ( $objModel->doChkIfColumnExists ( $db , $table , 'name' ) == 1
               && $objModel->doChkIfColumnExists ( $db , $table , 'description' ) == 1 ) {

            $str_sql .= " SELECT guid ,id , '" . "$table" . "' as item, name , description FROM $table \n" ; 
            $str_sql .= " WHERE 1 = 1 AND ( name like '%" . "$qry" . "%' or description like '%" . "$qry" . "%') UNION ALL \n" ; 
         }
      }
	   for (1..11) { chop ( $str_sql ) } ;
      $str_sql .= ' ) a ' ; 
      my $limit = $objModel->get('query.web-action.pg-size' ) || 7 ; 
      my $page_num = $objModel->get('query.web-action.pg-num' ) || 1 ; 
      my $offset = ( $page_num -1 ) || 0 ; # get default page is 1

      $offset = $limit*$offset ; 
      $offset = 0 if ( $offset < 0 ) ; 
      $str_sql .= " LIMIT $limit OFFSET $offset ;" ; 
      
      # debug rint $str_sql ;  

      $ret = 0 ; 
      eval { 
         $msg = "" ; 
         $sth = $dbh->prepare($str_sql);  
         $sth->execute() or $ret = 400 ; 
         $msg = DBI->errstr if $ret  == 400 ; 
         die "$msg" unless $ret == 0 ; 
         $hsr2 = $sth->fetchall_hashref( 'guid' ) or $ret = 400 ; # some error 
         $msg = DBI->errstr if $ret  == 400 ; 
         die "$msg" unless $ret == 0 ; 
         $objModel->set('hsr2' , $hsr2 );
      };
      if ( $@ ) { 
         my $tmsg = "$@" ; 
         $objLogger->doLogErrorMsg ( "$msg" ) ;
         $msg = "failed to get data :: $tmsg" unless $ret == 404 ; 
         return ( $ret , $msg , "" ) ; 
      };

      $dbh->disconnect();
      binmode(STDOUT, ':utf8');

      unless ( keys %{$hsr2}) {
         $msg = ' no data for this search request !!! ' ;
         $ret = 204 ;
         return ( $ret , $msg , undef ) ; 
      }

      $ret = 0 ; 
      return ( $ret , $msg , $hsr2 ) ; 
   }


   sub doBuildLikeClause {

      my $self    = shift ; 
      my $db      = shift ; 
      my $table   = shift ; 

		my $sql     = '' ; 
		my $ret     = 400 ; 
		my $msg     = ' the following column: %s does not exist ' ; 

      my $ref_like_names    = $objModel->get('select.web-action.like-by' );
      my $ref_like_values   = $objModel->get('select.web-action.like-val' );

      return ( 0 , "" , "")  unless ( defined ( $ref_like_names) ); 
      return ( 0 , "" , "")  unless ( defined ( $ref_like_values) ); 

      if ( @$ref_like_names and @$ref_like_values  ) {
			
         $sql = ' AND (' ; 

         for ( my $i = 0 ; $i < scalar ( @$ref_like_names ) ; $i++ ) {
				my ( $like_name , $like_value ) = () ; 
            $like_name = $ref_like_names->["$i"] ;
            $like_value = $ref_like_values->["$i"] ;

        
            my $col_exists = $objModel->doChkIfColumnExists ( $db , $table , $like_name ) ; 
      	   return ( 400 , "the $like_name column does not exist" , "") unless ( $col_exists ) ; 
            
            # if the like value is a number
            $like_name = "CAST( $like_name AS TEXT)" if $like_value =~ /\d{1,100}/g ; 

            my @like_values_list = split (',' , $like_value ) ;
            my $str = '' ;
            foreach my $item ( @like_values_list ) {
               $str .= " $like_name LIKE '%" . $item . "%' OR " ;
            }

            if ( defined ( $like_value ) and defined ( $like_name ) ) {
               $sql .= "$str "
            } else {
			      for (1..3) { chop ( $str ) } ;
            }
         }
			for (1..4) { chop ( $sql ) } ;
		   $sql .= ') ' ; 

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
   
   sub doBuildWhereClauseByBranchId {

      my $self             = shift ; 
      my $db               = shift ; 
      my $table            = shift ; 

      my $bid           = $objModel->get( 'hselect.web-action.bid' ) || 0 ; 
      my $seq           = $objModel->get( 'hselect.web-action.seq' ) || undef ; 

      my $where_clause_bid = '' , 
		my $ret              = 400 ; 
		my $msg              = ' the url parameter branch-id - bid should be a number !!! ' ; 

      my $branch_id = $objModel->get('view.web-action.bid') || 0 ; 

      unless ( looks_like_number $branch_id ) {
         return ( $ret , $msg , undef );
		} else {
         $where_clause_bid = " AND parent.id = '$branch_id' " ; 
			# simply no withing attributes nor values are provided return => to proceed with the select 
      	return ( 0 , "" , $where_clause_bid ) ;
		}
   } 


   sub doBuildWhereClauseByWith {

      my $self    = shift ; 
      my $db      = shift ; 
      my $table   = shift ; 
      my $isHrchy = shift || 0 ; 

		my $sql     = '' ; 
		my $ret     = 400 ; 
		my $msg     = ' the following column: %s does not exist ' ; 

      my $cols = $objModel->get('select.web-action.with-cols') ; 
      my $ops = $objModel->get('select.web-action.with-ops') ; 
      my $vals = $objModel->get('select.web-action.with-vals') ;
      
      return ( 0 , "" , "")  unless ( defined ( $cols) ); 
      return ( 0 , "" , "")  unless ( defined ( $ops ) ); 
      return ( 0 , "" , "")  unless ( defined ( $vals ) ); 

      # debug rint "from RdrPostgresDb.pm 120 \@$cols @$cols \n" ; 
      # debug rint "from RdrPostgresDb.pm \@$ops @$ops \n" ; 
      # debug rint "from RdrPostgresDb.pm \@$vals @$vals \n" ; 

      if ( @$cols and @$ops and @$vals) {
         
         for ( my $i = 0 ; $i < scalar ( @$cols ) ; $i++ ) {
            $sql .= ' AND ' ; 
				my ( $col , $op, $val ) = () ; 
            $col = $cols->["$i"] ;
            $op = $ops->["$i"] ;
            $val = $vals->["$i"] ; 
        
            my $col_exists = $objModel->doChkIfColumnExists ( $db , $table , $col ) ; 
      	   return ( 400 , "the $col column does not exist" , "") unless ( $col_exists ) ; 
            my $nodeMayBe = '' ; 
            $nodeMayBe = 'dyn_sql.' if $isHrchy == 1 ;
				$sql .= " $nodeMayBe$col $op '$val'" unless ( $op eq 'in' );
            my $list = $val ; 
            $list =~ s/,/','/g  ; 
				$sql .= " $nodeMayBe$col $op ('$list')" if ( $op eq 'in' );
         }
      	return ( 0 , "" , $sql) ;
      } elsif ( @$cols or @$vals or @$ops )  {

			# if either the with names or the with values are null than the withing url is mall-formed
			$msg = 'mall-formed url params for filtering with - valid syntax is with=<<attribute>>-<<operator>>-<<value>>' ; 
      	return ( 400 , "$msg" , "") ; 
		} else {

			# simply no withing attributes nor values are provided return => to proceed with the select 
      	return ( 0 , "" , "") ;
		}
   } 

   
   sub doBuildWhereClauseByFltr {

      my $self    = shift ; 
      my $db      = shift ; 
      my $table   = shift ; 

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
        
            my $col_exists = $objModel->doChkIfColumnExists ( $db , $table , $filter_name ) ; 
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

         # debug rint "from RdrPostgresDb.pm 186 sql : $sql \n" ; 

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
		   $db = $objModel->get('postgres_db_name');
      }
      
      ( $ret , $msg , $dbh ) = $self->doConnectToDb ( $db ) ; 
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
      $debug_msg .= "\n postgres_db_name: $db \n postgres_db_host: $postgres_db_host " ; 
      $debug_msg .= "\n postgres_db_user: $postgres_db_user \n postgres_db_user_pw $postgres_db_user_pw \n" ; 
      # $objLogger->doLogDebugMsg ( $debug_msg ) ; 
      
      # src: http://www.easysoft.com/developer/languages/perl/dbd_odbc_tutorial_part_2.html
      $sth = $dbh->prepare($str_sql);  
      # debug rint "$str_sql \n stop RdrPostgresDb.pm" ; 

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
		   $db = $objModel->get('postgres_db_name');
      }
      
      ( $ret , $msg , $dbh ) = $self->doConnectToDb ( $db ) ; 
      return ( $ret , $msg ) unless $ret == 0 ; 

      $str_sql = " 
         select ROW_NUMBER () OVER (ORDER BY datname ) as row_id, datname from pg_database;
      " ; 
      
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

      ($ret, $msg, $hsr2) = $self->doSelectTablesList(\$objModel);
      return $table_exists unless $ret == 0 ; 


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

      $str_sql = " SELECT * FROM $table 
         WHERE 1=1
         AND guid = '" . $guid . "'
         ;
      " ; 

      ( $ret , $msg , $dbh ) = $self->doConnectToDb ( $db ) ; 
      return ( $ret , $msg ) unless $ret == 0 ; 
      
      $sth = $dbh->prepare($str_sql);  

      $sth->execute() or $objLogger->error ( "$DBI::errstr" ) ;

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

      return ( $ret , $msg , $hsr ) ; 	
   }


   #
   # -----------------------------------------------------------------------------
   # load the project database meta data. must work for all the tables and colum 
   # regardless on wether or not the custom meta data in meta_tables and meta_columns
   # tables are defined !!!
   # -----------------------------------------------------------------------------
   sub doLoadProjDbMeta {

      my $self             = shift ; 
      my $db               = shift ; 
      
      my $msg              = q{} ;         
      my $ret              = () ;          # this is the return value from this method 
      my $debug_msg        = q{} ; 
      my $mhsr2            = {} ;         # this is meta hash describing the data hash ^^
      my $sth              = {} ;         # this is the statement handle
      my $dbh              = {} ;         # this is the database handle
      my $str_sql          = q{} ;        # this is the sql string to use for the query

      ( $ret , $msg , $dbh ) = $self->doConnectToDb ( $db ) ; 
      return ( $ret , $msg ) unless $ret == 0 ; 

		$str_sql = "
         SELECT DISTINCT
             ROW_NUMBER () OVER (ORDER BY pgc.relname , a.attnum) as rowid
             , pgc.relname as table_name 
             , a.attnum as attribute_number
             , a.attname as attribute_name
             , format_type(a.atttypid, a.atttypmod) as data_type
             , a.atttypmod as char_max_length
             , a.attnotnull as not_null
             , com.description as comment
             , coalesce(i.indisprimary,false) as is_primary_key
             , def.adsrc as default_value
             , meta_columns.skip_in_list as skip_in_list
             , meta_columns.width as width
         FROM pg_attribute a 
         JOIN pg_class pgc ON pgc.oid = a.attrelid
         LEFT JOIN pg_index i ON 
             (pgc.oid = i.indrelid AND i.indkey[0] = a.attnum)
         LEFT JOIN pg_description com on 
             (pgc.oid = com.objoid AND a.attnum = com.objsubid)
         LEFT JOIN pg_attrdef def ON 
             (a.attrelid = def.adrelid AND a.attnum = def.adnum)
         LEFT JOIN pg_catalog.pg_namespace n ON n.oid = pgc.relnamespace
         LEFT JOIN meta_columns ON 
            ( meta_columns.name = a.attname AND meta_columns.table_name = pgc.relname ) 
         WHERE 1=1 
            AND pgc.relkind IN ('r','')
             AND n.nspname <> 'pg_catalog'
             AND n.nspname <> 'information_schema'
             AND n.nspname !~ '^pg_toast'

         AND a.attnum > 0 AND pgc.oid = a.attrelid
         AND pg_table_is_visible(pgc.oid)
         AND NOT a.attisdropped
         ORDER BY rowid
         ;      
         " ; 
      # debug rint "RdrPostgresDb.pm :: doLoadProjDbMetaData $str_sql \n STOP RdrPostgresDb.pm :: doLoadProjDbMetaData" ;   
      
      eval { 
         $sth = $dbh->prepare($str_sql);  
         $sth->execute() ; 
         $mhsr2 = $sth->fetchall_hashref( 'rowid' ) ; 
         # debug rint "RdrPostgresDb.pm :: doLoadProjDbMetaData \n" ;
         # debug pr $mhsr2 ; 
         # debug rint "STOP RdrPostgresDb.pm :: doLoadProjDbMetaData" ;   
      };
      if ( $@ or !scalar(%$mhsr2)) { 
         $msg = " failed to get the project database: " . $db . " meta data ! " ; 
         $msg .= $DBI::errstr ; 
         $ret = 1 ; 
         return ( $ret , $msg , undef ) ; 
      };

         binmode(STDOUT, ':utf8');
         $ret = 0 ; 
         $dbh->disconnect();
         return ( $ret , $msg , $mhsr2 ) ; 	
   }


   #
   # -----------------------------------------------------------------------------
   # get the columns meta data of a table into hash ref of hash refs 
   # -----------------------------------------------------------------------------
   sub doSelectTablesColumnList {

      my $self          = shift ; 
      my $table         = shift || croak ' table provided !!!' ; 
      
      if ( defined $objModel->get('postgres_db_name') ) {
		   $db = $objModel->get('postgres_db_name');
      }
      my $msg              = q{} ;         
      my $ret              = () ;          # this is the return value from this method 
      my $debug_msg        = q{} ; 
      my $mhsr2            = {} ;         # this is meta hash describing the data hash ^^
      my $sth              = {} ;         # this is the statement handle
      my $dbh              = {} ;         # this is the database handle
      my $str_sql          = q{} ;        # this is the sql string to use for the query

      ( $ret , $msg , $dbh ) = $self->doConnectToDb ( $db ) ; 
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
      # debug rint "SQL: $str_sql \n STOP RdrPostgresDb.pm" ;   
      # chk: https://stackoverflow.com/a/451454/65706 
      eval { 
         $sth = $dbh->prepare($str_sql);  
         $sth->execute() ; 
         $mhsr2 = $sth->fetchall_hashref( 'attnum' ) ; 
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
   # -  ----------------------------------------------------------------------------
   # get ALL the table data into hash ref of hash refs 
   # -----------------------------------------------------------------------------
   sub doSearchConfigurationEntries {

      my $self             = shift ; 
      my $db          = shift || 'ysg_issues' ; # the default db
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
   # ( $ret , $msg , $dbh ) = $self->doConnectToDb ( $db ) ; 
   # -----------------------------------------------------------------------------
   sub doConnectToDb {

      my $self = shift ; 
      my $db   = shift || 'non_accessible_db'  ;

      my $ret  = 400 ; 
      my $msg = 'cannot connect to the "' . $db . '" database: '; 
      my $dbh  = undef ;

      $dbh = DBI->connect("dbi:Pg:dbname=$db", "", "" , {
                 'RaiseError'          => 0 # otherwise it dies !!!
               , 'ShowErrorStatement'  => 1
               , 'PrintError'          => 1
               , 'AutoCommit'          => 1
               , 'pg_utf8_strings'     => 1
      }) ; 
      
      if ( defined $dbh  ) {
         $ret = 0 ; $msg = "" ; 
      } else {
         $msg .= DBI->errstr ; 
      }

      return ( $ret , $msg , $dbh ) ; 
   }


   sub getColumnsToSelect {

      my $self          = shift ; 
      my $table         =  shift  ; 
      my $cols          =  shift  ; 
      my $ret           = 1 ; 
      my $msg           = 'unknown error while retrieving the content of the ' . $table . ' table' ; 

      
      my $columns_to_select = 'guid,id,' . join(',' , reverse @$cols) ; 

      if ( defined ( $objModel->get('select.web-action.pick') ) ) {
         $columns_to_select = " guid,id" ;
         my $lst_columns_to_select = $objModel->get('select.web-action.pick'); 
         my @cols = split (',' , $lst_columns_to_select ) ;
         foreach my $col ( @cols ) { 
            my $col_exists = $objModel->doChkIfColumnExists ( $db , $table , $col );
      	   return ( 400 , "the $col column does not exist" , "") unless ( $col_exists ) ; 
            $columns_to_select .= " , $col" ; 
         }
      }
      
      if ( defined ( $objModel->get('select.web-action.hide') ) ) {
         my $lst_columns_to_hide = $objModel->get('select.web-action.hide'); 
         my @cols = split (',' , $lst_columns_to_hide ) ;
         foreach my $col ( @cols ) { 
            $columns_to_select =~ s/,$col//g;
            my $col_exists = $objModel->doChkIfColumnExists ( $db , $table , $col );
      	   return ( 404 , "the $col column does not exist" , "") unless ( $col_exists ) ; 
         }
      }
      
      $ret = 0 ; $msg = '' ; 
      return ( $ret , $msg , $columns_to_select) ; 
   }

   sub doSetColToOrderByDesc {

      my $self          = shift ; 
      my $objModel      = ${shift @_ } ; 
      my $table         =  shift  ; 
      my $cols          =  shift  ; 
      my $ret           = 1 ; 
      my $msg           = 'unknown error while retrieving the content of the ' . $table . ' table' ; 

      my $columns_to_order_by_desc = undef ; 
      if ( defined ( $objModel->get('select.web-action.od') ) ) {
         $columns_to_order_by_desc = $objModel->get('select.web-action.od'); 
         my @cols = split (',' , $columns_to_order_by_desc ) ;
         foreach my $col ( @cols ) { 
            my $col_exists = $objModel->doChkIfColumnExists ( $db , $table , $col ) ; 
      	   return ( 400 , "the $col column does not exist" , "") unless ( $col_exists ) ; 
         }
      }
      $ret = 0 ; 
      return ( $ret , $msg , $columns_to_order_by_desc );
   }

   sub doSetColToOrderByAsc {

      my $self          = shift ; 
      my $objModel      = ${shift @_ } ; 
      my $table         =  shift  ; 
      my $cols          =  shift  ; 
      my $ret           = 1 ; 
      my $msg           = 'unknown error while retrieving the content of the ' . $table . ' table' ; 

      my $columns_to_order_by_asc = undef ; 
      if ( defined ( $objModel->get('select.web-action.oa') ) ) {
         $columns_to_order_by_asc = $objModel->get('select.web-action.oa'); 
         my @cols = split (',' , $columns_to_order_by_asc ) ;
         foreach my $col ( @cols ) { 
            my $col_exists = $objModel->doChkIfColumnExists ( $db , $table , $col ); 
      	   return ( 400 , "the $col column does not exist" , "") unless ( $col_exists ) ; 
         }
      }
      $ret = 0 ; 
      return ( $ret , $msg , $columns_to_order_by_asc );
   }

   #
   # -----------------------------------------------------------------------------
   # get ALL the table data into hash ref of hash refs 
   # -----------------------------------------------------------------------------
   sub doSelect {

      my $self                   = shift ; 
      my $db                     = shift || croak 'no db passed !!!' ;  
      my $table                  = shift || croak 'no table passed !!!' ; 
      my $ret                    = 1 ; 
      my $msg                    = 'unknown error while retrieving the content of the ' . $table . ' table' ; 
      my $dbh                    = {} ;         # this is the database handle

      ( $ret , $msg , $dbh ) = $self->doConnectToDb ( $db ) ; 
      return ( $ret , $msg ) unless $ret == 0 ; 


      if ( $self->table_exists ( $db , $table ) == 0  ) {
         $ret = 400 ; 
         $msg = ' the table ' . $table . ' does not exist in the ' . $db . ' database '  ; 
         return ( $ret , $msg ) ; 
      }

      my $debug_msg        = q{} ; 
      my $hsr2             = {} ;         # this is hash ref of hash refs to populate with
      my $sth              = {} ;         # this is the statement handle
      my $cols             = () ;         # the array ref of columns
      my $str_sql          = q{} ;        # this is the sql string to use for the query
      my $columns_to_select= '' ; 
      my $columns_to_order_by_asc   = '' ; 
      my $columns_to_order_by_desc  = '' ; 

      ( $ret , $msg , $cols ) = $objModel->doGetItemsDefaultPickCols ( $appConfig , $db , $table ) ; 
      return ( 400 , $msg , undef ) unless ( $ret == 0 );

      ($ret , $msg , $columns_to_select ) = $self->getColumnsToSelect($table,$cols);
      return ( 400 , $msg , undef ) unless ( $ret == 0 );

      ($ret , $msg , $columns_to_order_by_asc ) = $self->doSetColToOrderByAsc(\$objModel,$table,$cols);
      return ( 400 , $msg , undef ) unless ( $ret == 0 );
      
      ($ret , $msg , $columns_to_order_by_desc ) = $self->doSetColToOrderByDesc(\$objModel,$table,$cols);
      return ( 400 , $msg , undef ) unless ( $ret == 0 );
     
      $str_sql = " 
         SELECT 
         $columns_to_select , count(*) OVER () as rows_count
         FROM $table 
         WHERE 1=1 " ; 
      
      my $like_clause = '' ; 
		( $ret , $msg , $like_clause ) = $self->doBuildLikeClause ( $db , $table  ) ; 
		
      return ( $ret , $msg ) unless $ret == 0 ; 
		$str_sql .= $like_clause if $like_clause ; 
		
      my $where_clause_fltr = '' ; 
		( $ret , $msg , $where_clause_fltr ) = $self->doBuildWhereClauseByFltr ( $db , $table ) ; 
		return ( $ret , $msg ) unless $ret == 0 ; 
		$str_sql .= $where_clause_fltr if $where_clause_fltr ; 
      
      my $where_clause_with = '' ; 
		( $ret , $msg , $where_clause_with ) = $self->doBuildWhereClauseByWith ( $db , $table , 0) ; 
		return ( $ret , $msg ) unless $ret == 0 ; 
		$str_sql .= $where_clause_with if $where_clause_with ; 

      my $order_by = 'ORDER BY' ; 
      if ( defined $columns_to_order_by_asc ) {
         $str_sql .= " $order_by " ; 
         foreach my $col ( split /,/ , $columns_to_order_by_asc ){
            $str_sql .= " $col," ; 
         }
         chop($str_sql); $str_sql .= " ASC" ; 
      }
      $order_by = ' , ' if ( $str_sql =~ m/ORDER BY/g ) ; 
      if ( defined $columns_to_order_by_desc ) {
         $str_sql .= " $order_by " ; 
         foreach my $col ( split /,/ , $columns_to_order_by_desc ){
            $str_sql .= "$col," ; 
         }
         chop($str_sql); $str_sql .= " DESC " ; 
      }

      my $limit = $objModel->get('select.web-action.pg-size' ) || 7 ; 
      my $page_num = $objModel->get('select.web-action.pg-num' ) || 1 ; 
      my $offset = ( $page_num -1 ) || 0 ; # get default page is 1
      
      $offset = $limit*$offset ; 
      $offset = 0 if ( $offset < 0 ) ; 
      $str_sql .= " LIMIT $limit OFFSET $offset " ; 

      # debug rint "$str_sql \n" . 'vim +914 `find . -name RdrPostgresDb.pm`' . "\n" ; 

      $ret = 0 ; 
      eval { 
         $msg = "" ; 
         $sth = $dbh->prepare($str_sql);  
         $sth->execute() or $ret = 400 ; 
         # :jump it-180919115859 
         $msg = DBI->errstr if $ret  == 400 ; 
         die "$msg" unless $ret == 0 ; 
         $hsr2 = $sth->fetchall_hashref( 'guid' ) or $ret = 400 ; # some error 
         $msg = DBI->errstr if $ret  == 400 ; 
         die "$msg" unless $ret == 0 ; 
         $objModel->set('hsr2' , $hsr2 );
         $objModel->set($db . '.dat.' . $table , $hsr2 ); # wip: 181114145604
      };
      if ( $@ ) { 
         my $tmsg = "$@" ; 
         $objLogger->doLogErrorMsg ( "$msg" ) ;
         $msg = "failed to get $table table data :: $tmsg" unless $ret == 404 ; 
         return ( $ret , $msg , "" ) ; 
      };

      $dbh->disconnect();
         unless ( keys %{$hsr2}) {
            $msg = ' no data for this search request !!! ' ;
            $objLogger->doLogWarningMsg ( $msg ) ; 
            $ret = 204 ;
         }
      binmode(STDOUT, ':utf8');
      return ( $ret , $msg , $hsr2 ) ; 	

   }

	
	sub new {
		my $invocant   = shift ;    
		$appConfig     = ${ shift @_ } || croak 'appConfig not passed in RdrPostgresDb !!!' ; 
		$objModel      = ${ shift @_ } || croak 'objModel not passed in RdrPostgresDb !!!' ; 
		my $class      = ref ( $invocant ) || $invocant ; 
		my $self       = {} ; bless( $self, $class );    # Say: $self is a $class
      $self          = $self->doInit() ; 
		return $self;
	}  
	
   sub doInit {
      my $self = shift ; 

      %$self = (
           appConfig => $appConfig
      );
		
		$db                  = $ENV{ 'postgres_db_name' } || $appConfig->{'postgres_db_name'}     || 'prd_ysg_issues' ; 
		$postgres_db_host    = $ENV{ 'postgres_db_host' } || $appConfig->{'postgres_db_host'} 		|| 'localhost' ;
		$postgres_db_port    = $ENV{ 'postgres_db_port' } || $appConfig->{'postgres_db_port'} 		|| '13306' ; 
		$postgres_db_user 	= $ENV{ 'postgres_db_user' } || $appConfig->{'postgres_db_user'} 		|| 'ysg' ; 
		$postgres_db_user_pw = $ENV{ 'postgres_db_user_pw' } || $appConfig->{'postgres_db_user_pw'} 	|| 'no_pass_provided!!!' ; 

	   $objLogger 			   = 'IssueTracker::App::Utils::Logger'->new( \$appConfig ) ;

      return $self ; 
	}	
   

	sub doInitPg {
      
     	my $self 			= shift ;  
		my $pg            = {} ; 

		$ENV{'DBI_TRACE'} = 1 ; 
      $ENV{'DBI_TRACE'} = 15 ; 
      $ENV{'DBI_TRACE'} ='SQL' ; 
      
		$pg = 'IssueTracker::App::Db::In::Postgres::MojoPgWrapper'->new (\$appConfig, \$objModel ) ; 
      $pg = $pg->options( {
              'RaiseError'          => 1
            , 'ShowErrorStatement'  => 1
            , 'PrintError'          => 1
            , 'AutoCommit'          => 1
            , 'pg_utf8_strings'     => 1
         } );
		return $pg ; 
	}

   sub doHSelectBranch {

      my $self          = shift ; 
      my $db            = shift || croak 'no db passed !!!' ; 
      my $table         = shift || croak 'no table passed !!!' ; 
      my $bid           = $objModel->get( 'hselect.web-action.bid' ) || 0 ; 
      my $seq           = $objModel->get( 'hselect.web-action.seq' ) || undef ; 
   
      my $rv            = 1  ;
      my $ret           = 1 ; 
      my $msg           = 'unknown error occured in RdrPostgresDb::doHSelectBranch' ; 
      my $pg            = {} ; 
      my $sql           = {} ; 
      my $hsr2          = {} ; 
      my $where_clause_with = '' ; 
      my $like_clause = '' ; 
      my $where_clause_bid = '' ; 

		$pg = $self->doInitPg();

      my $cols             = () ;         # the array ref of columns
      my $columns_to_select = '' ;
      my @default_pick_cols = ('guid', 'id', 'seq', 'level', 'name', 'description' , 'src' );
      my @musthave_pick_cols = ('guid', 'id', 'seq', 'level', 'name' ); # no view-doc without those !!!
      ($ret , $msg , $columns_to_select ) = $self->getColumnsToSelect($table,\@default_pick_cols);
      return ( 400 , $msg , undef ) unless ( $ret == 0 );
      foreach my $musthave_pick_col ( @musthave_pick_cols ) {
         $columns_to_select = "$columns_to_select , $musthave_pick_col"
            unless ( $columns_to_select =~ m/$musthave_pick_col/g );
      }

		( $ret , $msg , $where_clause_with ) = $self->doBuildWhereClauseByWith ( $db , $table , 1) ; 
		return ( $ret , $msg ) unless $ret == 0 ; 
      if ( $where_clause_with ) {
         $where_clause_with =~ s/$table/parent/g ; 
         $where_clause_with =~ s/AND //g ; 
         $where_clause_with = "AND (dyn_sql.id = $bid OR $where_clause_with)";
      }
		

      ( $ret , $msg , $where_clause_bid ) = $self->doBuildWhereClauseByBranchId ( $db , $table ) ; 
		return ( $ret , $msg ) unless $ret == 0 ; 
      
      my $limit = $objModel->get('select.web-action.pg-size' ) || 1000 ;
      my $page_num = $objModel->get('select.web-action.pg-num' ) || 1 ; 
      my $offset = ( $page_num -1 ) || 0 ; # get default page is 1
      
      $offset = $limit*$offset ; 
      $offset = 0 if ( $offset < 0 ) ; 


      eval {
			$sql = " 
				SELECT $columns_to_select FROM ( 
               SELECT node.* FROM $table AS node, $table AS parent 
               WHERE 1=1 AND node.lft 
               BETWEEN parent.lft AND parent.rgt
               $where_clause_bid
               )  AS dyn_sql 
				WHERE 1=1 
            $where_clause_with
				ORDER BY seq
            LIMIT $limit OFFSET $offset
			" ; 
         $hsr2 = $pg->db->query("$sql")->hashes ; 

         # r $hsr2 ; 
      };
      if ( $@ ) {
         $rv               = 404 ; 
         $msg              = DBI->errstr ; 
         $objLogger->doLogErrorMsg ( $msg ) ;
         return ( $rv , $msg ) ; 
      }

      $rv               = 200 ; 
      $msg              = '' ; 
      return ( $rv , $msg , $hsr2 ) ; 
   }

1;

__END__
