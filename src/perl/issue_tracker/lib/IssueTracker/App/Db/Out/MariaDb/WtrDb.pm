package IssueTracker::App::Db::Out::MariaDb::WtrDb ;

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

	our $postgres_db_name                                 = q{} ; 
	our $db_host 										   = q{} ; 
	our $db_port 										   = q{} ;
	our $postgres_db_user 											= q{} ; 
	our $postgres_db_user_pw	 									= q{} ; 
	our $web_host 											= q{} ; 
   our @tables                                  = ( 'daily_issues' );
   our $objController                           = () ; 


   sub doLoadNestedSetTable {

		my $self 			   = shift ; 
		my $hsr2 		      = shift ; 
      my @tables = @{ $_[0] } ; 

      # debug p($hsr2) ; 
      foreach my $guid ( sort { $hsr2->{$a}->{ 'seq' } <=> $hsr2->{$b}->{ 'seq' } } keys (%$hsr2))  {
         my $hsr_row = $hsr2->{ "$guid" } ; 
         p ( $hsr_row ) ; 
         # get the hs
         # sort by seq_id
         # set prev_seq_id , set prev_level
         # for each hs row get id , seq_id , curr_level
         # if curr_level < prev_level => doAddToParentWithNoChilden
         # if curr_level = prev_level => doAddToParentWithChilden
         # if curr_level > prev_level => doAddToParentWithChilden
         # seq_id++ ;
      }

      return 1 ; 
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
      my $term             = shift || 'daily' ; 

      my $ret              = 1 ; 
      my $msg              = 'unknown error while sql insert ' ; 		
      my $str_sql_insert   = q{} ; 
      my $str_col_list     = q{} ; 
      my $str_val_list     = q{} ; 
      my $error_msg        = q{} ; 

      my $objRdrDbsFactory = 'IssueTracker::App::Db::In::RdrDbsFactory'->new( \$appConfig , $self ) ; 
      my $objRdrDb 		= $objRdrDbsFactory->doInstantiate ( 'postgre' );
		
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

	 
      p ( $hsr2 ) ; 
      
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
      
      p ( $str_sql_insert ) ; 

      # proper authentication implementation src:
      # http://stackoverflow.com/a/19980156/65706
      $objLogger->doLogDebugMsg ( $debug_msg ) ; 
     
      my $dbh = DBI->connect("DBI:Pg:dbname=$postgres_db_name", "", "" , {
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
      my $objRdrDb 		= $objRdrDbsFactory->doInstantiate ( 'postgre' );
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
      $debug_msg .= "\n postgres_db_name: $postgres_db_name \n db_host: $db_host " ; 
      $debug_msg .= "\n postgres_db_user: $postgres_db_user \n postgres_db_user_pw $postgres_db_user_pw \n" ; 
      $objLogger->doLogDebugMsg ( $debug_msg ) if $module_trace == 1 ; 


      eval {
         $dbh = DBI->connect("dbi:Pg:dbname=$postgres_db_name", "", "" , {
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
	sub doUpsertTables {

		my $self 			   = shift ; 
      my $objMdlHsrs       = ${ shift @_ } ; 
		my $hsr2 		      = $objMdlHsrs->get('hsr2' ); 
      my @tables = @{ $_[0] } ; 

      binmode(STDIN,  ':utf8');
      binmode(STDOUT, ':utf8');
      binmode(STDERR, ':utf8');
		my $ret 				   = 1 ; 
		my $msg 				   = ' failed to connect during insert to db !!! ' ; 
		my $debug_msg 		   = ' failed to connect during insert to db !!! ' ; 

      return ( $ret , $msg , undef ) unless $hsr2 ; 
      return ( $ret , $msg , undef ) unless @tables ; 

      my $sth              = {} ;    # this is the statement handle
      my $dbh              = {} ;    # this is the database handle
      my $str_sql          = q{} ;   # this is the sql string to use for the query
      my $rv               = 0 ;     # apperantly insert ok returns rv = 1 !!! 
      
      my $hs_headers       = {} ; 
      my $update_time      = q{} ; # must have the default value now() in db
      
      my $dmhsr            = {} ; 

      my $objRdrDbsFactory = 'IssueTracker::App::Db::In::RdrDbsFactory'->new( \$appConfig , $self ) ; 
      my $objRdrDb 		= $objRdrDbsFactory->doInstantiate ( 'postgre' );

      # obs this does not support ordered primary key tables first order yet !!!
      foreach my $table ( keys %$hsr2 ) { 

         $objLogger->doLogDebugMsg ( "doUpsertTables table: $table" );
         next unless grep( /^$table$/, @tables ) ; 

         # load ONLY the tables defined to load

         ( $ret , $msg , $hs_headers ) = $objRdrDb->doSelectTablesColumnList ( $table ) ; 
         return  ( $ret , $msg , undef ) unless $ret == 0 ; 


         my $hs_table = $hsr2->{ $table } ; 
         #p $hs_headers ;  
         # p $hs_table->{ 0 } ; 
         #debug p($hs_headers ) ; 
     
         eval { 
            $dbh = DBI->connect("dbi:Pg:dbname=$postgres_db_name", "", "" , {
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
            p($hs_row) ; 

            foreach my $col_num ( sort ( keys ( %$hs_headers ) ) ) {

               my $column_name = $hs_headers->{ $col_num }->{ 'attname' }; 
               # if the xls does not have the table column ( ie guid )
               next unless exists $hs_table->{ 0 }->{ $column_name } ; 

               my $cell_value = $hs_row ->{ $column_name } ; 
               $cell_value = $update_time if $column_name eq 'update_time' ; 
               
               # if the xls does not contain the guid's do just insert
               if ( !defined ( $cell_value ) or $cell_value eq 'NULL' 
                     or $cell_value eq 'null' or $cell_value eq "'NULL'" ) {

                  $cell_value = 'NULL'   ; 
                  $data_str .= "$cell_value" . " , " ; 

               } else { 
                  # $cell_value =~ s|\\|\\\\|g ; 
                  # replace the ' chars with \'
                  $cell_value 		=~ s|\'|\'\'|g ; 
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
	#eof sub doUpsertTables


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
		
		$postgres_db_name 			= $ENV{ 'postgres_db_name' } || $appConfig->{'postgres_db_name'}        || 'prd_pgsql_runner' ; 
		$db_host 			= $ENV{ 'db_host' } || $$appConfig->{'db_host'} 		|| 'localhost' ;
		$db_port 			= $ENV{ 'db_port' } || $$appConfig->{'db_port'} 		|| '13306' ; 
		$postgres_db_user 			= $ENV{ 'postgres_db_user' } || $$appConfig->{'postgres_db_user'} 		|| 'ysg' ; 
		$postgres_db_user_pw 		= $ENV{ 'postgres_db_user_pw' } || $appConfig->{'postgres_db_user_pw'} 	|| 'no_pass_provided!!!' ; 
      
	   $objLogger 			= 'IssueTracker::App::Utils::Logger'->new( \$appConfig ) ;

      return $self ; 
	}	
	#eof sub doInitialize
   


1;


__END__
