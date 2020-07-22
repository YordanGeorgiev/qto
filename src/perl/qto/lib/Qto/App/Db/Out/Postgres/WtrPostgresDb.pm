package Qto::App::Db::Out::Postgres::WtrPostgresDb ; 

   use strict ; use warnings ; use utf8 ; 

   require Exporter; 
   use AutoLoader ; 
	use Encode qw( encode_utf8 is_utf8 );
   use POSIX qw(strftime);
   use DBI ; 
	use Data::Printer ; 
	use Carp ; 

   use Qto::App::Utils::Logger ; 
   use Qto::App::Db::In::RdrDbsFcry ; 
   use Qto::App::Utils::Timer ; 
   use Qto::App::Mdl::Model ;


   our $module_trace                            = 1 ; 
   our $IsUnitTest                              = 0 ; 
	our $config 										   = {} ; 
	our $objLogger 										= {} ; 
	our $objModel                                = {} ; 
   our $rdbms_type                              = 'postgres' ; 

	our $db                                      = q{} ; 
	our $postgres_db_host 								= q{} ; 
	our $postgres_db_port 								= q{} ;
	our $postgres_db_user 							   = q{} ; 
	our $postgres_db_user_pw	 					   = q{} ; 
	our $postgres_db_useradmin 				      = q{} ; 
	our $postgres_db_useradmin_pw	 				   = q{} ; 
	our $web_host 											= q{} ; 
   our @tables                                  = ( 'daily_issues' );
   our $objController                           = () ; 
   

   sub doTruncateTable {

		my $self 				= shift ; 
      my $objModel         = ${ shift @_ } ; 
      my $db               = shift ; 
      my $table            = shift ; 
      my $ret              = 0 ; 
      my $msg              = '' ; 
      my $dbh              = {} ;         # this is the database handle
      my $sth              = {} ;         # the statement handle
      my $str_sql          = q{} ;        # this is the sql string to use for the query
     
      ( $ret , $msg , $dbh ) = $self->doConnectToDbAsAdminUser ( $db ) ; 
      return ( $ret , $msg ) unless $ret == 0 ; 

      my $objRdrDbsFcry = 'Qto::App::Db::In::RdrDbsFcry'->new( \$config , \$objModel ) ; 
      my $objRdrDb            = $objRdrDbsFcry->doSpawn("$rdbms_type");

      if ( $objRdrDb->table_exists( $db , $table ) == 0  ) {
         $ret = 400 ; 
         $msg = ' the table ' . $table . ' does not exist in the ' . $db . ' database '  ; 
         return ( $ret , $msg ) ; 
      }

      $str_sql = "TRUNCATE $table " ; 
      eval {
         $sth = $dbh->prepare($str_sql);  
         $sth->execute() or print STDERR "$DBI::errstr" ; 
      } or $ret = 500 ; # Internal Server error

      binmode(STDOUT, ':utf8');

      unless ( defined ( $DBI::errstr ) ) {
         $msg = '' ; 
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


   sub doDeleteById {

		my $self 				= shift ; 
      my $db               = shift ; 
      my $table            = shift ; 
      my $id               = shift ; 
      my $ret              = 0 ; 
      my $msg              = '' ; 
   
      my $dbh              = {} ;         # this is the database handle
      my $sth              = {} ;         # the statement handle
      my $str_sql          = q{} ;        # this is the sql string to use for the query
      
      ( $ret , $msg , $dbh ) = $self->doConnectToDbAsAppUser ( $db ) ; 
      return ( $ret , $msg ) unless $ret == 0 ; 


      my $objRdrDbsFcry = 'Qto::App::Db::In::RdrDbsFcry'->new( \$config , \$objModel ) ; 
      my $objRdrDb            = $objRdrDbsFcry->doSpawn("$rdbms_type");

      if ( $objRdrDb->table_exists( $db , $table ) == 0  ) {
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


   sub doHiDeleteRow {
   
		my $self 					= shift ; 
      my $db               	= shift ; 
      my $table            	= shift ; 
      my $origin_id           = shift ; 

      my $ret              	= 0 ; 
      my $res              	= undef ;  # the result from FOUND in the func
      my $msg              	= '' ; 
      my $dbh              	= {} ; # this is the database handle
      my $hsr              	= {} ; # the hash reference keeping the data
      my $sth              	= {} ; # the statement handle
      my $str_sql         	 	= '' ; # this is the sql string to use for the query
      
      ( $ret , $msg , $dbh ) 	= $self->doConnectToDbAsAppUser ( $db ) ; 
      return ( $ret , $msg ) unless $ret == 0 ; 
      
      my $objRdrDbsFcry 		= 'Qto::App::Db::In::RdrDbsFcry'->new( \$config , \$objModel ) ; 
      my $objRdrDb            = $objRdrDbsFcry->doSpawn("$rdbms_type");

      if ( $objRdrDb->table_exists( $db , $table ) == 0  ) {
         $ret = 400 ; 
         $msg = ' the table ' . $table . ' does not exist in the ' . $db . ' database '  ; 
         return ( $ret , $msg ) ; 
      }

      eval {
         no warnings 'exiting' ; 
         $str_sql = 'DO $$
         ' . " 
            DECLARE originSeq bigint;
            DECLARE tgtSeq bigint DEFAULT 1;
            DECLARE tgtLvl bigint DEFAULT 1;
            DECLARE originLvl bigint;
            DECLARE originRgt bigint DEFAULT 2;
            DECLARE originLft bigint DEFAULT 1;
            DECLARE parentRgt bigint DEFAULT 2;
            DECLARE parentLft bigint DEFAULT 1;
            DECLARE siblingRgt bigint;
            DECLARE parentLvl int DEFAULT 0;
            DECLARE newLft bigint;
            DECLARE newRgt bigint;
            DECLARE mayBeSiblingLvl bigint;
            DECLARE mayBeNxtSeq bigint;
            DECLARE widthRgtLft bigint;
            DECLARE rgtMinus bigint;
            DECLARE lftMinus bigint;
            DECLARE delCount bigint;

            BEGIN
               originSeq := (SELECT seq from $table WHERE 1=1 AND id=$origin_id);
               originLft := (SELECT lft from $table WHERE 1=1 AND id=$origin_id);
               originRgt := (SELECT rgt from $table WHERE 1=1 AND id=$origin_id);

               widthRgtLft := (originRgt - originLft + 1);
               rgtMinus := (originRgt - widthRgtLft);
               lftMinus := (originLft - widthRgtLft);
               tgtSeq := (originSeq - 1);
               delCount := (SELECT COUNT(*) FROM $table WHERE lft BETWEEN originLft AND originRgt);

               DELETE FROM $table WHERE lft BETWEEN originLft AND originRgt;
               UPDATE $table SET rgt = rgt - widthRgtLft WHERE rgt > originRgt;
               UPDATE $table SET lft = lft - widthRgtLft WHERE lft > originLft;
               UPDATE $table SET seq = seq - delCount where seq > originSeq;
         " . '
         END ; $$ ';
               # DELETE FROM $table WHERE lft <= originLft AND rgt <= originRgt ;
               # DELETE FROM $table WHERE id=$origin_id ;
         #debug p $str_sql ; 
         #rint "\nWtrPostgresDb delte by id \n";
         #
         $sth = $dbh->prepare($str_sql);  
         $sth->execute() ;
         use warnings 'exiting' ; 
      };
      binmode(STDOUT, ':utf8');

      unless ( defined ( $DBI::errstr ) ) {
         $msg = '' ; 
         $ret = 200 ;
      } else {
         $objLogger->doLogErrorMsg ( $DBI::errstr ) ; 
         $msg = "$DBI::errstr" ; 
      }
			
	
		$dbh->disconnect ;
      return ( $ret , $msg , $hsr) ; 
   }
  
 
   sub doHiInsertRow {
   
		my $self 					= shift ; 
      my $db               	= shift ; 
      my $table            	= shift ; 
      my $origin_id           = shift ; 
      my $level_alpha         = shift ;

      my $ret              	= 0 ; 
      my $res              	= undef ;  # the result from FOUND in the func
      my $msg              	= '' ; 
      my $dbh              	= {} ;         # this is the database handle
      my $hsr              	= {} ;         # the hash reference keeping the data
      my $sth              	= {} ;         # the statement handle
      my $str_sql         	 	= q{} ;        # this is the sql string to use for the query
      
      ( $ret , $msg , $dbh ) 	= $self->doConnectToDbAsAppUser ( $db ) ; 
      return ( $ret , $msg ) unless $ret == 0 ; 
      
      my $objRdrDbsFcry 		= 'Qto::App::Db::In::RdrDbsFcry'->new( \$config , \$objModel ) ; 
      my $objRdrDb            = $objRdrDbsFcry->doSpawn("$rdbms_type");

      if ( $objModel->doChkIfTableExists( $db , $table ) == 0  ) {
         $ret = 400 ; 
         $msg = ' the table ' . $table . ' does not exist in the ' . $db . ' database '  ; 
         return ( $ret , $msg ) ; 
      }

      eval {
         no warnings 'exiting' ; 
         $level_alpha='+ ' . "$level_alpha" if $level_alpha >= 0 ;
         $str_sql = 'DO $$
         ' . " 
            DECLARE originSeq bigint;
            DECLARE tgtSeq bigint DEFAULT 1;
            DECLARE tgtLvl bigint DEFAULT 1;
            DECLARE level_alpha bigint DEFAULT 0;
            DECLARE originLvl bigint;
            DECLARE originRgt bigint DEFAULT 2;
            DECLARE originLft bigint DEFAULT 1;
            DECLARE parentRgt bigint DEFAULT 2;
            DECLARE parentLft bigint DEFAULT 1;
            DECLARE siblingRgt bigint;
            DECLARE parentLvl int DEFAULT 0;
            DECLARE newLft bigint;
            DECLARE newRgt bigint;
            DECLARE mayBeSiblingLvl bigint;
            DECLARE mayBeNxtSeq bigint;

            BEGIN
               originSeq := (SELECT seq from $table WHERE 1=1 AND id=$origin_id);
               originLvl := (SELECT level from $table WHERE id=$origin_id);
               tgtSeq := (originSeq+1);
               IF originSeq = 1 THEN 
                  parentLvl := (0);
                  parentRgt := (0);
               ELSE 
                  tgtLvl := (originLvl$level_alpha);
                  parentLvl := (tgtLvl-1);
               END IF;

               parentRgt := (SELECT max(rgt) from $table WHERE 1=1 AND level=parentLvl and seq <= originSeq );
               parentLft := (SELECT max(lft) from $table WHERE 1=1 AND level=parentLvl and seq <= originSeq );
               originRgt := (SELECT rgt from $table WHERE id = $origin_id);
               originLft := (SELECT lft from $table WHERE id = $origin_id);
               mayBeSiblingLvl := (SELECT max(level) from $table WHERE 1=1 AND seq = tgtSeq AND level=tgtLvl);
               UPDATE $table set seq=(seq+1) WHERE seq >= tgtSeq;
               mayBeNxtSeq := (SELECT seq from $table WHERE 1=1 AND seq = tgtSeq);

               CASE
                  WHEN originLvl < tgtLvl THEN 
                     UPDATE $table set lft=(lft+2) WHERE seq > tgtSeq ;
                     UPDATE $table set rgt=(rgt+2) WHERE rgt > originLft;
                     INSERT INTO $table (level, seq, lft, rgt) VALUES (tgtLvl, tgtSeq, parentLft+1, parentLft+2);
                  WHEN originLvl = tgtLvl THEN 
                     UPDATE $table set rgt=(rgt+2) WHERE rgt >= parentRgt AND level <= parentLvl;
                     UPDATE $table set lft=(lft+2) WHERE seq >= tgtSeq ;
                     INSERT INTO $table (level, seq, lft, rgt) VALUES (tgtLvl, tgtSeq, originRgt+1, originRgt+2);
                  WHEN originLvl > tgtLvl THEN 
                     IF mayBeNxtSeq is NULL THEN 
                        siblingRgt := (SELECT max(rgt) from $table WHERE 1=1 AND level=tgtLvl and seq <= originSeq );
                        UPDATE $table set rgt=(rgt+2) WHERE rgt >= parentRgt AND level <= parentLvl;
                        INSERT INTO $table (level, seq, lft, rgt) VALUES (tgtLvl, tgtSeq, siblingRgt+1, siblingRgt+2);
                     ELSE 
                        siblingRgt := (SELECT max(rgt) from $table WHERE 1=1 AND level=tgtLvl and seq <= originSeq );
                        UPDATE $table set rgt=(rgt+2) WHERE rgt >= parentRgt AND level <= parentLvl;
                        INSERT INTO $table (level, seq, lft, rgt) VALUES (tgtLvl, tgtSeq, siblingRgt+1, siblingRgt+2);
                        UPDATE $table set lft=(lft+2) WHERE lft >= tgtLvl ;
                     END IF;
                  ELSE
                     INSERT INTO logs (id,name, description) values (cast (to_char((current_timestamp + interval '1' second), 
                        'YYMMDDHH12MISSMSUS') as numeric(25)),'originLvl: ', cast(originLvl as char)) ;
                     INSERT INTO logs (id,name, description) values (cast (to_char((current_timestamp + interval '2' second), 
                        'YYMMDDHH12MISSMSUS') as numeric(25)),'tgtLvl: ', cast(tgtLvl as char)) ;
                     INSERT INTO logs (id,name, description) values (cast (to_char((current_timestamp + interval '3' second), 
                        'YYMMDDHH12MISSMSUS') as numeric(25)),'MSG: ', 'broken hierachy in table $table') ;
               END CASE;
         " . '
         END ; $$ ';
         # debug rint "$str_sql"; 
         
         $sth = $dbh->prepare($str_sql);  
         $sth->execute() ;
         use warnings 'exiting' ; 
      };
      binmode(STDOUT, ':utf8');

      unless ( defined ( $DBI::errstr ) ) {
         $msg = '' ; 
         $ret = 200 ;
      } else {
         $objLogger->doLogErrorMsg ( $DBI::errstr ) ; 
         $msg = "$DBI::errstr" ; 
      }
			
	
		$dbh->disconnect ;
      return ( $ret , $msg , $hsr) ; 
   }

   
   sub doInsertMyByItemId {
   
		my $self 				= shift ; 
      my $db               = shift ; 
      my $table            = shift ; 
      my $who              = shift ; 
      my $ret              = 0 ; 
      my $msg              = '' ; 
   
      my $id               = $objModel->get('create.web-action.id' ) ; 

      my $dbh              = {} ;         # this is the database handle
      my $sth              = {} ;         # the statement handle
      my $str_sql          = q{} ;        # this is the sql string to use for the query
   
      if ( defined $objModel->get('postgres_db_name') ) {
		   $db = $objModel->get('postgres_db_name');
      }
      
      ( $ret , $msg , $dbh ) = $self->doConnectToDbAsAppUser ( $db ) ; 
      return ( $ret , $msg ) unless $ret == 0 ; 


      my $objRdrDbsFcry = 'Qto::App::Db::In::RdrDbsFcry'->new( \$config , \$objModel ) ; 
      my $objRdrDb            = $objRdrDbsFcry->doSpawn("$rdbms_type");

      if ( $objModel->doChkIfTableExists( $db , $table ) == 0  ) {
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
         INSERT INTO  $table ( id , app_users_guid) VALUES ( '$id' , (SELECT guid from app_users where email='$who'));
         " ; 
         eval {
            # rint "start WtrPostgresDb.pm : \n $str_sql \n stop WtrPostgresDb.pm" ; 
            $sth = $dbh->prepare($str_sql);  
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

   sub doInsertByItemId {
   
		my $self 				= shift ; 
      my $db               = shift ; 
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
      
      ( $ret , $msg , $dbh ) = $self->doConnectToDbAsAppUser ( $db ) ; 
      return ( $ret , $msg ) unless $ret == 0 ; 


      my $objRdrDbsFcry = 'Qto::App::Db::In::RdrDbsFcry'->new( \$config , \$objModel ) ; 
      my $objRdrDb            = $objRdrDbsFcry->doSpawn("$rdbms_type");

      if ( $objModel->doChkIfTableExists( $db , $table ) == 0  ) {
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
            # rint "start WtrPostgresDb.pm : \n $str_sql \n stop WtrPostgresDb.pm" ; 
            $sth = $dbh->prepare($str_sql);  
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


   sub doUpdateItemBySingleColToDb {

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
      
      ( $ret , $msg , $dbh ) = $self->doConnectToDbAsAppUser ( $db ) ; 
      return ( $ret , $msg ) unless $ret == 0 ; 


      my $objRdrDbsFcry = 'Qto::App::Db::In::RdrDbsFcry'->new( \$config , \$objModel ) ; 
      my $objRdrDb            = $objRdrDbsFcry->doSpawn("$rdbms_type");

      if ( $objModel->doChkIfTableExists( $db , $table ) == 0  ) {
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
      $col_value     =~ s|\r\n|\n|g if ( $col_value ) ; # clear any possible winblows carriage returns
      $col_value = "'" . $col_value . "'" unless ( $col_value eq 'null' ) ; 

      $str_sql = " 
      UPDATE  $table
         SET $col_name = $col_value
         WHERE id='$id'     
      ;
      " ; 
     
      # debug 'vim +212 `find . -name WtrPostgresDb.pm` str_sql: ' . "\n" . $str_sql ; 
      # debug rint 'vim +212 `find . -name WtrPostgresDb.pm` str_sql: STOP '  ; 

      eval {
         $sth = $dbh->prepare($str_sql);  
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
   # ( $ret , $msg , $dbh ) = $self->doConnectToDbAsAppUser ( $db ) ; 
   # -----------------------------------------------------------------------------
   sub doConnectToDbAsAppUser {
      my $self = shift ; 
      my $db = shift ; 
   
      my $ret = 1 ; 
      my $msg = q{} ; 
      my $dbh = q{} ; 
      eval {
         $dbh = DBI->connect("dbi:Pg:dbname=$db;host=$postgres_db_host;port=$postgres_db_port", 
                  "$postgres_db_user", "$postgres_db_user_pw" , {
                    'RaiseError'          => 0 # otherwise it dies !!!
                  , 'ShowErrorStatement'  => 1
                  , 'PrintError'          => 1
                  , 'AutoCommit'          => 1
                  , 'pg_utf8_strings'     => 1
         }) ; 
      };

      if ( defined $dbh  ) {
         $ret = 0 ; $msg = "" ; 
      } else {
         $ret = 400 ; 
         $msg .= DBI->errstr ; 
         return ( $ret , $msg , $dbh ) ; 
      }

      if ($@) {
         $ret = 400 ; 
         $msg = 'cannot connect to the "' . $db . '" database: ' . DBI->errstr ; 
         print "$msg !!! \n" ; 
         return ( $ret , $msg , undef ) ; 
      }

      $ret = 0 ; $msg = "" ; 
      return ( $ret , $msg , $dbh ) ; 
   }
   #
   # -----------------------------------------------------------------------------
   # open the database handle if possible, if not return proper error msgs
   # ( $ret , $msg , $dbh ) = $self->doConnectToDbAsAppUser ( $db ) ; 
   # -----------------------------------------------------------------------------
   sub doConnectToDbAsAdminUser {
      my $self = shift ; 
      my $db = shift ; 
   
      my $ret = 1 ; 
      my $msg = q{} ; 
      my $dbh = q{} ; 

      eval { 
		$postgres_db_useradmin 			= $ENV{ 'postgres_db_useradmin' }     || $config->{'postgres_db_useradmin'} ;
		$postgres_db_useradmin_pw 		= $ENV{ 'postgres_db_useradmin_pw' }  || $config->{'postgres_db_useradmin_pw'} 
         || 'no_pass_provided!!!' ; 
         $dbh = DBI->connect("dbi:Pg:dbname=$db;host=$postgres_db_host;port=$postgres_db_port", "$postgres_db_user", "$postgres_db_user_pw" , {
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
      my $dbh              = {} ; 
      my $msg              = 'unknown error while sql insert ' ; 		
      my $str_sql_insert   = q{} ; 
      my $str_col_list     = q{} ; 
      my $str_val_list     = q{} ; 
      my $error_msg        = q{} ; 

      my $objRdrDbsFcry = 'Qto::App::Db::In::RdrDbsFcry'->new( \$config , $self ) ; 
      my $objRdrDb            = $objRdrDbsFcry->doSpawn("$rdbms_type");
		
      my $objTimer         = 'Qto::App::Utils::Timer'->new( $config->{'env'}->{'log'}->{ 'TimeFormat' } );
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
     
      ( $ret , $msg , $dbh ) = $self->doConnectToDbAsAppUser ( $db ) ; 
      
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
      my $objTimer         = 'Qto::App::Utils::Timer'->new( $config->{'env'}->{'log'}->{ 'TimeFormat' } );
		my $update_time      = $objTimer->GetHumanReadableTime();

      my $objRdrDbsFcry = 'Qto::App::Db::In::RdrDbsFcry'->new( \$config , $self ) ; 
      my $objRdrDb            = $objRdrDbsFcry->doSpawn("$rdbms_type");

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
         ( $ret , $msg , $dbh ) = $self->doConnectToDbAsAppUser ( $db ) ; 
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
      my $objTimer         = 'Qto::App::Utils::Timer'->new( $config->{'env'}->{'log'}->{ 'TimeFormat' } );
		my $update_time      = $objTimer->GetHumanReadableTime();
      
      my $dmhsr            = {} ; 

      my $objRdrDbsFcry = 'Qto::App::Db::In::RdrDbsFcry'->new( \$config , \$objModel , $self ) ; 
      my $objRdrDb         = $objRdrDbsFcry->doSpawn("$rdbms_type");

      $objLogger->doLogDebugMsg ( "start upsert for : db: $db table $table" );

      ( $ret , $msg , $hs_headers ) = $objRdrDb->doSelectTablesColumnList ( $table ) ; 
      return  ( $ret , $msg , undef ) unless $ret == 0 ; 

      # debug p($hs_headers ) ; 
      # debug rint "WtrPostgresDb.pm : $table 336 \n " ; 
  
      ( $ret , $msg , $dbh ) = $self->doConnectToDbAsAdminUser ( $db ) ; 
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

      # debug $hsr2 ; 
      # debug $sql_str_insrt ; 
      my $expected_amount_of_inserted_rows = keys %$hsr2; 

      $update_time      = $objTimer->GetHumanReadableTime();
      foreach my $row_num ( sort ( keys %$hsr2) ) { 
         next if $row_num == 0 ; 

         my $hs_row = $hsr2->{ $row_num } ; 
         my $data_str = '' ; 

         # because obviously postgre prefers lc in col names by default on Ubuntu
         my %row_h = %$hs_row ; 
         %row_h = map { lc $_ => $row_h{$_} } keys %row_h;
         $hs_row = \%row_h ; 

         # debug $hs_row ; 
         # debug $hs_headers ; 

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

         # debug rint "WtrPostgresDb.pm : 669 \n " ; 
         # debug rint "sql_str $sql_str \n" ; 
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
            print STDOUT "\actual_amount_of_inserted_rows: $actual_amount_of_inserted_rows \n" ; 
            print STDOUT "expected_amount_of_inserted_rows: $expected_amount_of_inserted_rows \n" ; 
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
	
  
  sub doUpsertSingleTable {

		my $self 			   = shift ; 
      my $objModel         = ${ shift @_ } ; 
		my $hsr3 		      = $objModel->get( 'hsr3' ) ; 
      my @tables           = @{ $_[0] } ; 

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
      my $objTimer         = 'Qto::App::Utils::Timer'->new( $config->{'env'}->{'log'}->{ 'TimeFormat' } );
		my $update_time      = $objTimer->GetHumanReadableTime();
      my $dmhsr            = {} ; 
      $db = $objModel->get('postgres_db_name');
      my $objRdrDbsFcry    = 'Qto::App::Db::In::RdrDbsFcry'->new( \$config , \$objModel , $self ) ; 
      my $objRdrDb         = $objRdrDbsFcry->doSpawn("$rdbms_type");
      
      binmode(STDIN,  ':utf8');
      binmode(STDOUT, ':utf8');
      binmode(STDERR, ':utf8');

      # obs this does not support ordered primary key tables first order yet !!!
      foreach my $table ( keys %$hsr3 ) { 

         my $hs_table = $hsr3->{ $table } ; 
         print "hs_table $hs_table \n" ;
         ( $ret , $msg , $dbh ) = $self->doConnectToDbAsAppUser ( $db ) ; 
         return ( $ret , $msg ) unless $ret == 0 ;       

         my $sql_str          = '' ; 
         my $sql_str_insrt    = "INSERT INTO process ( process_category, name , description)" ; 
         foreach my $row_num ( sort ( keys %$hs_table ) ) { 
            next if $row_num == 0 ; 
            
            my $hs_row = $hs_table->{ $row_num } ; 
            my $data_str = q{} ; 
            my $category = $table ;
            my $cell_value = (values%{$hs_row})[0] ;
            my $name = (split(/:/,$cell_value))[0] . ':';
            
            # if the xls does not contain the guid's do just insert
            # note that even cells with 1 space are considered for nulls !!!
            # this is simply because of Shift + arrow works on 1 space
            if ( !defined ( $cell_value ) or $cell_value eq 'NULL' 
                  or $cell_value eq 'null' or $cell_value eq "'NULL'" 
                  or $cell_value eq ' ' ) {  
               $cell_value = 'NULL'   ; 
            } else { 
               # $cell_value =~ s|\\|\\\\|g ; 
               # replace the ' chars with \'
               $cell_value 		=~ s|\'|\'\'|g ; 
               # clear any possible winblows carriage returns
               $cell_value     =~ s|\r\n|\n|g if ( $cell_value ) ; 
            }
            $data_str .= "'" . "$category" . "' , '" . $name . "' , '" . $cell_value . "' .  " ; 
            
            # remove the " , " at the end 
            for (1..3) { chop ( $data_str ) } ; 
            
            $sql_str .= $sql_str_insrt ;  
            $sql_str	.=  " VALUES (" . "$data_str" . ');' ; 

         }  # eof row
          

         my $do_trucate_tables = $ENV{ 'do_truncate_tables' } || 0 ; 
         if ( $do_trucate_tables == 1 ) { 
            $sql_str = "TRUNCATE TABLE $table ; $sql_str " ; 
         }
         
         p $sql_str ; 

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
	# runs the insert sql by passed data part 
	# by convention is assumed that the first column is unique and update could 
	# be performed on it ... should there be duplicates the update should fail
	# -----------------------------------------------------------------------------
	sub doUpsertTables {

		my $self 			   = shift ; 
      my $objModel         = ${ shift @_ } ; 
		my $hsr3 		      = $objModel->get( 'hsr3' ) ; 
      my @tables           = @{ $_[0] } ; 

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
      my $objTimer         = 'Qto::App::Utils::Timer'->new( $config->{'env'}->{'log'}->{ 'TimeFormat' } );
		my $update_time      = $objTimer->GetHumanReadableTime();
      my $dmhsr            = {} ; 
      $db = $objModel->get('postgres_db_name');
      my $objRdrDbsFcry    = 'Qto::App::Db::In::RdrDbsFcry'->new( \$config , \$objModel , $self ) ; 
      my $objRdrDb         = $objRdrDbsFcry->doSpawn("$rdbms_type");
      
      binmode(STDIN,  ':utf8');
      binmode(STDOUT, ':utf8');
      binmode(STDERR, ':utf8');

      # obs this does not support ordered primary key tables first order yet !!!
      foreach my $table ( keys %$hsr3 ) { 

         $objLogger->doLogDebugMsg ( "doUpsertTables table: $table" );
         # load ONLY the tables defined to load
         next unless grep( /^$table$/, @tables )  ; 

         if ( $objModel->doChkIfTableExists( $db , $table ) == 0  ) {
            $ret = 400 ; 
            $msg = ' the table ' . $table . ' does not exist in the ' . $db . ' database '  ; 
            return ( $ret , $msg , undef ) ; 
         }

         ( $ret , $msg , $hs_headers ) = $objRdrDb->doSelectTablesColumnList ( $table ) ; 
         return  ( $ret , $msg , undef ) unless $ret == 0 ; 


         my $hs_table = $hsr3->{ $table } ; 
         #debug $hs_headers ;  
         #debug $hs_table->{0} ; 
         #debug $hs_headers  ; 
         ( $ret , $msg , $dbh ) = $self->doConnectToDbAsAppUser ( $db ) ; 
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

         my $objTimer         = 'Qto::App::Utils::Timer'->new( $config->{'env'}->{'log'}->{ 'TimeFormat' } );
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


	sub new {
		my $invocant 	= shift ;    
		$config        = ${ shift @_ } || { 'foo' => 'bar' ,} ; 
		$objModel      = ${ shift @_ } || croak 'objModel not passed in WtrPostgresDb !!!' ; 
      $objController = shift ;  
		my $class      = ref ( $invocant ) || $invocant ; 
		my $self       = {};  bless( $self, $class );  
      $self          = $self->doInit() ; 

		return $self;
	}  


   sub doInit {
      my $self = shift ; 

      %$self = (
           config => $config
      );
      my $db_config = $config->{'env'}->{'db'} ; 

		$db 			               = $db_config->{'postgres_db_name'}    || croak " db not set !!!" ; 
		$postgres_db_host 			= $db_config->{'postgres_db_host'}    || croak "postgres_db_host not set !!!" ; 
		$postgres_db_port 			= $db_config->{'postgres_db_port'}    || croak "postgres_db_port not set !!!"  ; 
		$postgres_db_useradmin 	   = $db_config->{'postgres_db_useradmin'}    || croak 'no admin postgres user' ; 
		$postgres_db_useradmin_pw  = $db_config->{'postgres_db_useradmin_pw'} || croak 'no_pass_provided!!!' ; 
		$postgres_db_user 			= $db_config->{'postgres_db_user'}    || croak " no postgres_db_user !!!" ;  
		$postgres_db_user_pw 		= $db_config->{'postgres_db_user_pw'} || croak " no postgres_db_user_pw !!!!" ;
      
	   $objLogger 			         = 'Qto::App::Utils::Logger'->new( \$config ) ;

      return $self ; 
	}	
   


1;


__END__
