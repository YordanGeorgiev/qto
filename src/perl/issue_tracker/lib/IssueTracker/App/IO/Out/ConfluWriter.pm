package IssueTracker::App::IO::Out::ConfluWriter ; 

   use strict ; use warnings ; use utf8 ; 

   require Exporter; 
   use AutoLoader ; 
   use Encode qw( encode_utf8 is_utf8 );
   use POSIX qw(strftime);
   use Data::Printer ; 
   use Carp ; 
   use IssueTracker::App::Utils::IO::FileHandler ; 
	use IssueTracker::App::Utils::Logger ;
   use IssueTracker::App::Utils::Timer ; 
   use IssueTracker::App::IO::Out::UrlWriter ; 
  
   our $module_trace       = 0 ; 
   our $IsUnitTest         = 0 ; 
   our $appConfig          = {} ; 
   our $objLogger          = {} ; 
   our $objFileHandler     = {} ; 
   our $ProductInstanceDir = {} ; 


   #
   # ------------------------------------------------------
   # ConfluWriter
   # builds and xls file into the xls dir 
   # from the passed hash ref of hashs refs by using the calling
   # sql script as a source for the xls file path to produce
   # src: http://search.cpan.org/~jmcnamara/Excel-Writer-XLSX/lib/Excel/Writer/XLSX.pm
   # ------------------------------------------------------
   sub doBuildConfluTableFromHashRef {

      my $self             = shift ; 
      my $hsr_meta         = shift ; 
      my $hsr              = shift ; 
      my $table            = shift ; 
      my $str_table			= '<table class="wrapped fixed-table"><colgroup>' ; 
      my $msg              = 'unknown error during conversion to conflu table format ' ; 
      #debug ok p($hsr ) if $module_trace == 1 ; 
      my $default_col_to_sort_by = 'seq' ;  
      my $flg_found_default_col_to_sort_by = 0 ; 
      # print the headers  
      foreach my $colid ( sort ( keys (  %{$hsr_meta->{ 'ColumnNames'}} ) ) ) {

         my $col_name     = $hsr_meta->{'ColumnNames'}->{ $colid }->{ 'attname' } ; 
         my $col_width    = $hsr_meta->{'ColumnNames'}->{ $colid }->{ 'attlen' } ; 
         my $col_px_width = $col_width / 10 || 20 ; 

         $hsr_meta->{'ColumnWidths'}->{ $colid } = length ( $hsr_meta->{ 'ColumnNames'}->{ $colid } ) ; 
         $str_table .= '<col style="width: ' . $col_px_width . 'px;" />' ; 
         $flg_found_default_col_to_sort_by++ if ( $col_name eq 'seq' ) ; 
      }
      $str_table			.= '</colgroup>' ; 
      $str_table			.= '<tbody>' ; 


      my $rowid = 0 ; 
      
      $default_col_to_sort_by = 'seqid' if $flg_found_default_col_to_sort_by == 0 ; 


      foreach my $guid ( 
         sort { $hsr->{$a}->{ $default_col_to_sort_by } <=> $hsr->{$b}->{ $default_col_to_sort_by } } keys (%$hsr)
         )  {
      # foreach my $rowid ( sort ( keys ( %$hsr ) ) ) {
         $str_table			.= '<tr>' ; 


         my $hsr_row = $hsr->{ "$guid" } ; 
         $rowid = $rowid+1 ; 


         foreach my $colid ( sort ( keys ( %{$hsr_meta->{'ColumnNames'}} ) ) ) {
            $str_table			.= '<td>' ; 
            my $col_name     = $hsr_meta->{'ColumnNames'}->{ $colid }->{ 'attname' } ; 
       
            my $cell_length = length ( $hsr_row->{ $col_name } ) || 10 ; 
            $hsr_meta->{ 'ColumnWidths' }->{ $colid } = $cell_length || 10 ; 
            my $cell_val   = ' ' ; 
            #define the max width 
            if ( $hsr_meta->{ 'ColumnWidths' }->{ $colid } < $cell_length ) {
               $hsr_meta->{ 'ColumnWidths' }->{ $colid } = $cell_length ;                
            }
            if ( 
                  defined ( $hsr_row ) 
               and defined ( $hsr_row->{ $col_name } ) 
               and $hsr_row->{ $col_name } ne 'NULL' ) {
               # p( $hsr_row );
               $cell_val = $hsr_row->{ $col_name } || ' ' ; 
            }
            $str_table        .= $cell_val ; 
            $str_table			.= '</td>' ; 
         }
         $str_table			.= '</tr>' ;
         
      } 
      #eof foreach row 
      #
      
      my $issue_tracker_proj = $ENV{'issue_tracker_project'} ; 
      my $home_dir = $ENV{'HOME'} ; 
      # steeel your session vars from the Chrome F12 , network tools
      my $cookie_file =  "$home_dir/.conflu/.cookie." . $issue_tracker_proj  ; 
  
      unless ( -f $cookie_file ) { 
         $msg = 'did not find a cookie file for the issue tracker project: ' . $issue_tracker_proj ; 
         return ( 1 , $msg ) ; 
      }

      my $url = $ENV { 'url' } ; 
      unless ( $url ) { 
         $msg = 'undefined url !!! export url=https://confluence.some.com' ; 
         return ( 1 , $msg ) ; 
      }

      $str_table			.= '</tbody>' ; 
#      print "\n START str_table \n\n" ; 
#      p $str_table ; 
#      print "\n STOP  str_table \n\n" ; 
#      sleep 10 ; 

# ' . $str_table . ' \
$str_table = '<p>foobar</p>' ; 
		my $str_page = '
		{
			   "type": "page"
			 , "title": "NPS SERVICE THOR TO ARTIFACTORY MIGRATION CHECKLIST"
			 , "body": {
				  "storage": {
						"value": "' . $str_table . '"
						, "representation": "storage"
				  }
			 }
		 , "version":{  
				"number": 11
		 }
		}' ; 
		$str_page =~ s/\n//gm ; 
		$str_page =~ s/\r//gm ; 
		my $cookies = $objFileHandler->doReadFileReturnString ( $cookie_file ) ; 
		my $headers = { 
			'Content-Type' 		=> 'application/json'
		,	'Cookie' 				=> $cookies		
		,	'Connection' 			=> 'keep-alive'
		,	'User-Agent' 			=> 'curl/7.47.0'
		,	'Accept' 				=> 'application/json'
		 } ; 
      my $objUrlWriter = 'IssueTracker::App::IO::Out::UrlWriter'->new ( \$appConfig ) ; 
      my ( $ret , $response_code , $response_body , $response_content )  = () ; 
      ( $ret , $response_code , $response_body , $response_content ) 
            = $objUrlWriter->doRunURL( 'PUT' , $headers , $cookies , $url , $str_page );
      
      return ( $ret , $msg ) ; 
   }
   #eof sub doBuildConfluTableFromHashRef

 
   # 
	# -----------------------------------------------------------------------------
	# the constructor 
	# -----------------------------------------------------------------------------
	sub new {

		my $class = shift;    # Class name is in the first parameter
		$appConfig = ${ shift @_ } || { 'foo' => 'bar' ,} ; 
		my $self = {};        # Anonymous hash reference holds instance attributes
		bless( $self, $class );    # Say: $self is a $class
      $self = $self->doInitialize();
		return $self;
	}  
	#eof const

   #
	# --------------------------------------------------------
	# intializes this object 
	# --------------------------------------------------------
   sub doInitialize {
      my $self          = shift ; 

      %$self = (
           appConfig => $appConfig
       );

      #debug print "ConfluWriter::doInitialize appConfig : " . p($appConfig );
      $ProductInstanceDir   = $appConfig->{ 'ProductInstanceDir' } ; 

	   $objFileHandler   = 'IssueTracker::App::Utils::IO::FileHandler'->new ( \$appConfig ) ; 
	   $objLogger 			= 'IssueTracker::App::Utils::Logger'->new( \$appConfig ) ;

      return $self ; 
	}	
	#eof sub doInitialize




1;


__END__
