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
   # get ALL the table data into hash ref of hash refs 
   # -----------------------------------------------------------------------------
   sub doSelectTableIntoHashRef {

      my $self             = shift ; 
      my $table            = shift || 'daily_issue' ;  # the table to get the data from  
      
      my $msg              = q{} ;         
      my $ret              = 1 ;          # this is the return value from this method 
      my $debug_msg        = q{} ; 
      my $hsr              = {} ;         # this is hash ref of hash refs to populate with
      my $mhsr             = {} ;         # this is meta hash describing the data hash ^^
      my $sth              = {} ;         # this is the statement handle
      my $dbh              = {} ;         # this is the database handle
      my $str_sql          = q{} ;        # this is the sql string to use for the query

# ordinal_position | table_name  |  column_name   |     data_type     | is_nullable
#------------------+-------------+----------------+-------------------+-------------
#                1 | daily_issue | daily_issue_id | integer           | NO
#                2 | daily_issue | level          | integer           | YES
#                3 | daily_issue | prio           | integer           | YES
#                4 | daily_issue | status         | character varying | NO
#                5 | daily_issue | category       | character varying | NO
#                6 | daily_issue | name           | character varying | NO
#                7 | daily_issue | description    | character varying | YES
#                8 | daily_issue | start_time     | text              | YES
#                9 | daily_issue | stop_time      | text              | YES
#               10 | daily_issue | run_date       | date              | YES

      $mhsr->{'ColumnNames'}-> { 0 } = "$table" . '_id' ;
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
              " . "$table" . "_id
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

      $hsr = $sth->fetchall_hashref( $table . '_id' ) ; 
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

		# print "PostgreReader::doInitialize appConfig : " . p($appConfig );
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
